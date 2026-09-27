---
name: autoit-testframework
description: Generates complete, ready-to-run AutoIt unit test files using AutoIt Test Framework. Use for any request to write, generate, or add tests to AutoIt code — from a single function to a whole project. Covers TDD, BDD, regression, and spec-driven workflows. Handles the Testable/Stubs pattern automatically when the script calls AutoIt built-ins.
---

# AutoIt Test Framework Skill

Generates complete, ready-to-run AutoIt unit test files using AutoIt Test Framework
(`TestFramework.au3`), and implements the code under test when needed. Works from any input
the developer has available, in any combination. Also supports testing scripts that call
AutoIt built-ins with side effects (dialogs, file system, registry, GUI, shell, etc.)
through Testing with Testable Wrappers and Stubs using `Testable.au3`.

## How to approach the task

Follow these steps in order every time:

1. **Read all available input first** — source files, descriptions, specs, project folders.
   Do not write a single line of test code before this is done.
2. **Map every code path** — for each function, identify every branch, every `Return`,
   every `SetError` path, every condition driven by a parameter or stub return value.
   Each distinct path becomes one or more test assertions.
3. **Decide which pattern applies** (see Path selection below).
4. **Write test functions** — one per function under test, or one per scenario when a
   function has multiple distinct behaviors worth separating. Write all test functions
   before writing `_RunAllTests`.
5. **Write `_RunAllTests` last** — wire all test functions in using `_TestFmkRun`, add
   `_TestFmkSummary()`, and end with `_TestFmkRunAllTests(_RunAllTests)`.
6. **Add the output file header** comment block at the top of the generated file.

Never jump to writing tests from a surface-level read. The quality of the output depends
entirely on how thoroughly step 1 and 2 are done.

## Path selection

When source code is available, scan it for calls to AutoIt built-ins with side effects:
dialogs (`MsgBox`, `InputBox`), file system (`FileExists`, `FileDelete`, `FileCopy`),
registry (`RegRead`, `RegWrite`, `RegDelete`), GUI (`GUICreate`, `GUIGetMsg`), shell
(`ShellExecute`, `Run`), and similar.

- **No testable built-ins found, or no source available** → Basic Test Structure only
- **Testable built-ins found** → Basic Test Structure + Testing with Testable Wrappers and Stubs

When no source is available (TDD or description-only), default to the Basic Test Structure
unless the description explicitly mentions any of the above categories.

Testing with Testable Wrappers and Stubs builds on top of the Basic Test Structure — it
does not replace it.

If source files use raw AutoIt built-ins instead of `_Tstbl_*` wrappers and the
Testable/Stubs pattern is needed, the conversion is handled by the
`autoit-testable-converter` skill. Check whether it is available:

- **Claude Code:** check for `.claude/skills/autoit-testable-converter/SKILL.md` or
  `~/.claude/skills/autoit-testable-converter/SKILL.md`. If not found, try fetching it
  from `https://raw.githubusercontent.com/crucialthread/AutoItTestFramework/main/.claude/skills/autoit-testable-converter/SKILL.md`
  and apply it inline. If the fetch fails, advise the user and ask whether to proceed
  with test generation anyway.
- **Chat/Cowork:** check whether the `autoit-testable-converter` skill is listed in
  context. If not, advise the user it is available and ask whether to proceed anyway.

## Output - what to produce

### Always produce: a complete test file

- Named after the source file or described function (e.g. `MyLib.au3` → `MyLibTests.au3`)
- `#include <TestFramework.au3>` at the top (or `#include "TestFramework.au3"` if local)
- `#include` for the file under test
- One test function per public function or per distinct scenario when behaviors differ
- All test functions wired into `_RunAllTests` with the cumulative `$bAllPassed` pattern
- `_TestFmkSummary()` at the end of `_RunAllTests`
- `_TestFmkRunAllTests(_RunAllTests)` as the entry point
- Output file header comment block at the top
- Ready to run with Go/F5 in SciTE immediately

### When code does not exist yet: also produce placeholder implementations

When generating tests for functions that do not exist yet, also produce a matching file
with placeholder implementations so the tests compile and run immediately (all failing —
the correct TDD starting point). Placeholders must be syntactically valid and return a
type-appropriate default (`False`, `0`, `""`) based on what the tests assert against.

## TestFramework.au3 API

```autoit
; Prints a labeled section header — also resets stubs automatically (pass False to suppress)
_TestFmkHeader($sTitle, $bResetStubs = True)

; Evaluates a condition and records pass or fail
; ALWAYS pass $vActual and $vExpected - never omit them
_TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)

; Runs a test function by reference and accumulates its result into a cumulative boolean
; ALWAYS pass $bNothingFailed as the second argument to chain results across test functions
_TestFmkRun($hFuncTest, $bNothingFailed)

; Prints the final Total/Passed/Failed summary block
; Call once at the end of _RunAllTests(), never inside individual test functions
_TestFmkSummary()

; Prints a separator line of repeated characters to visually divide output
_TestFmkSeparator($iLength = 80, $sChar = "-")

; Enables or disables silent mode - suppresses pass results and headers, leaving only failures and the summary
_TestFmk_SetSilentMode($bSilent = False)

; Runs the test suite only when the script is executed directly, not when included in a combined script
; Use as the entry point instead of a bare _RunAllTests() call
_TestFmkRunAllTests($hRunnerFunction)
```

## Basic Test Structure

Use when the script under test does not call any built-ins with side effects.

```autoit
#include <TestFramework.au3>
#include "SourceFile.au3"

Func _TestFunctionName()
    _TestFmkHeader("Test: FunctionName()")

    ; Capture the result before asserting - never call the function inside _TestFmkAssert
    Local $sResult = FunctionName("hello world")
    _TestFmkAssert($sResult = "HELLO WORLD", "Converts to uppercase", $sResult, "HELLO WORLD")

    Local $sEmpty = FunctionName("")
    _TestFmkAssert($sEmpty = "", "Returns empty string for empty input", $sEmpty, "")

    FunctionName(0)
    Local $iErr = @error
    _TestFmkAssert($iErr = 1, "Sets @error = 1 for invalid input type", $iErr, 1)
EndFunc

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestFunctionName, $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_TestFmkRunAllTests(_RunAllTests)
```

## Testing with Testable Wrappers and Stubs

Use when the script under test calls AutoIt built-ins with side effects. Builds on top of
the Basic Test Structure — it does not replace it.

### Script code structure

Guard the entry point with the `$__TFW_TEST_MODE` sentinel so test files can include the
script without executing it:

```autoit
#include <Testable.au3>

If Not IsDeclared("__TFW_TEST_MODE") Then
    _Main()
EndIf

Func _Main()
    MyFunction("C:\temp\myfile.txt")
EndFunc

Func MyFunction($sPath)
    If Not _Tstbl_FileExists($sPath) Then
        _Tstbl_MsgBox($MB_OK + $MB_ICONERROR, "Error", "File not found.")
        Return False
    EndIf
    Local $iResult = _Tstbl_MsgBox($MB_YESNO, "Confirm", "Delete " & $sPath & "?")
    If $iResult = $IDYES Then
        _Tstbl_FileDelete($sPath)
        Return True
    EndIf
    Return False
EndFunc
```

### Test file structure

`$__TFW_TEST_MODE` is declared automatically by `TestFramework.au3` — never declare it
manually. `_ResetStubs()` is called automatically by `_TestFmkHeader` — never call it
manually.

```autoit
#include <TestFramework.au3>
#include "MyScript.au3"

Func _TestMyFunction_FileNotFound()
    _TestFmkHeader("Test: MyFunction() - file not found")

    _SetStubReturn("FileExists", $_1st, False)

    Local $bResult = MyFunction("C:\temp\myfile.txt")

    _TestFmkAssert($bResult = False, "Returns False when file not found", $bResult, False)
    _TestFmkAssert(_StubCallCount("MsgBox") = 1, "Shows error MsgBox", _StubCallCount("MsgBox"), 1)
    _TestFmkAssert(_StubCallCount("FileDelete") = 0, "FileDelete not called", _StubCallCount("FileDelete"), 0)
EndFunc

Func _TestMyFunction_UserConfirms()
    _TestFmkHeader("Test: MyFunction() - user confirms deletion")

    _SetStubReturn("FileExists", $_1st, True)
    _SetStubReturn("MsgBox", $_1st, $IDYES)

    Local $bResult = MyFunction("C:\temp\myfile.txt")
    Local $sDeleted = _GetStubCall("FileDelete", $_1st, $Param_Filename)

    _TestFmkAssert($bResult = True, "Returns True when user confirms", $bResult, True)
    _TestFmkAssert(_StubCallCount("FileDelete") = 1, "FileDelete called once", _StubCallCount("FileDelete"), 1)
    _TestFmkAssert($sDeleted = "C:\temp\myfile.txt", "Correct file deleted", $sDeleted, "C:\temp\myfile.txt")
EndFunc

Func _TestMyFunction_UserCancels()
    _TestFmkHeader("Test: MyFunction() - user cancels")

    _SetStubReturn("FileExists", $_1st, True)
    _SetStubReturn("MsgBox", $_1st, $IDNO)

    Local $bResult = MyFunction("C:\temp\myfile.txt")

    _TestFmkAssert($bResult = False, "Returns False when user cancels", $bResult, False)
    _TestFmkAssert(_StubCallCount("FileDelete") = 0, "FileDelete not called", _StubCallCount("FileDelete"), 0)
EndFunc

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestMyFunction_FileNotFound, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestMyFunction_UserConfirms,  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestMyFunction_UserCancels,   $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_TestFmkRunAllTests(_RunAllTests)
```

Note: the example above covers all three branches of `MyFunction` — file not found, user
confirms, user cancels. Every branch visible in the source must have a test.

## Stubs API

```autoit
; Pre-configure what a stub returns for the Nth call (1-based)
; Call after _TestFmkHeader, before running the code under test
; Pass $STUB_ERROR as vValue to simulate the stub setting @error = 1
_SetStubReturn("TypeName", $iIdx, $vValue)

; Returns how many times a stub type was called
_StubCallCount("TypeName")

; Returns the value of a recorded parameter from the Nth call
; Use $Param_* constants for parameter names and $_1st/$_2nd/... for call indexes
_GetStubCall("TypeName", $iIdx, $Param_ParamName)
```

## Stub type names and recorded parameters

Common stub types and the `$Param_*` constants to use with `_GetStubCall()`:

| Type | Parameter constants |
| --- | --- |
| `"MsgBox"` | `$Param_Flag`, `$Param_Title`, `$Param_Text` |
| `"FileExists"` | `$Param_Path` |
| `"FileDelete"` | `$Param_Filename` |
| `"FileCopy"` | `$Param_Source`, `$Param_Dest` |
| `"FileMove"` | `$Param_Source`, `$Param_Dest` |
| `"DirCreate"` | `$Param_Path` |
| `"DirRemove"` | `$Param_Path` |
| `"RegRead"` | `$Param_Keyname`, `$Param_Valuename` |
| `"RegWrite"` | `$Param_Keyname`, `$Param_Valuename`, `$Param_Keytype`, `$Param_Value` |
| `"RegDelete"` | `$Param_Keyname`, `$Param_Valuename` |
| `"FileInstall"` | `$Param_Source`, `$Param_Dest` |
| `"ShellExecute"` | `$Param_Filename`, `$Param_Parameters` |
| `"GUICreate"` | `$Param_Title` |
| `"GUIGetMsg"` | (none) |
| `"GUICtrlSetData"` | `$Param_Controlid`, `$Param_Data` |
| `"GUICtrlRead"` | `$Param_Controlid` |

See the full list at https://crucialthread.github.io/AutoItTestFramework/stubs.htm

### FileInstall special case

`FileInstall` cannot be routed through a function pointer like other testable wrappers.
The script must define a custom wrapper function (typically `__FileInstall`) with a
Select/Case block containing all literal `FileInstall` calls, register it via
`_Tstbl_Implement_FileInstall(__FileInstall)` at script level, and call
`_Tstbl_FileInstall(...)` instead of `FileInstall(...)` directly.

When generating tests for a script that uses `FileInstall`:

- If the script has raw `FileInstall()` calls without the pattern, invoke the
  `autoit-testable-converter` skill to handle the conversion before generating tests.
- If the pattern is already in place, verify the three elements above are present before
  generating test assertions.
- Access recorded calls via `_GetStubCall("FileInstall", $_1st, $Param_Source)` and
  `_GetStubCall("FileInstall", $_1st, $Param_Dest)`.

### Simulating @error with stubs

For stubs that support it (e.g. `RegRead`), pass `$STUB_ERROR` as the return value to
simulate the stub setting `@error = 1`:

```autoit
_SetStubReturn("RegRead", $_1st, $STUB_ERROR)

Local $sValue = _Tstbl_RegRead("HKLM\Software\MyApp", "Version")
Local $iErr = @error
_TestFmkAssert($iErr = 1, "Sets @error when key not found", $iErr, 1)
```

Always capture `@error` into a local variable immediately after the call — any subsequent
function call resets it.

## Rules - never break these

**Assertions:**
- ALWAYS pass `$vActual` and `$vExpected` to every `_TestFmkAssert` call. Never omit them.
- ALWAYS capture the result of the function under test into a local variable before
  asserting — never call the function directly inside `_TestFmkAssert`, as it evaluates
  the expression twice and can consume extra stub returns or cause unexpected side effects.
- Use realistic, meaningful test values. Never use placeholders like `"value1"` or
  `"expected"`.
- Always test both the success path and every failure/error path for any function that
  uses `SetError`.

**@error capture:**
- ALWAYS capture `@error` into a local variable immediately after the call being tested,
  before any other function call resets it.
- Correct: `Local $iErr = @error` then `_TestFmkAssert($iErr = 1, ...)`
- Wrong: `_TestFmkAssert(@error = 1, ...)` — `@error` is already 0 by the time this runs.

**Test structure:**
- ALWAYS use `_TestFmkRun` in `_RunAllTests` — never call test functions directly.
- ALWAYS use `_TestFmkRunAllTests(_RunAllTests)` as the entry point — never a bare
  `_RunAllTests()` call.
- Name test functions `_Test<FunctionName>` or `_Test<FunctionName>_<Scenario>` for
  multiple scenarios covering the same function.
- One `_TestFmkHeader` call per test function, at the top.

**Testable/Stubs rules:**
- `$__TFW_TEST_MODE` is declared automatically by `TestFramework.au3` — never declare
  it manually in test files.
- `_ResetStubs()` is called automatically by `_TestFmkHeader` — never call it manually.
- ALWAYS call `_SetStubReturn()` after `_TestFmkHeader` and before running the code under
  test, never after.
- Use `$_1st`, `$_2nd`, ... constants for call indexes — never raw integers.
- Use `$Param_*` constants for parameter names in `_GetStubCall()` — never raw strings.
- Use `_StubCallCount("TypeName")` to check call counts — never access `$g_StubCalls`
  directly.
- Use `_GetStubCall("TypeName", $iIdx, $Param_Name)` to access recorded parameters —
  never access `$g_StubCalls` directly.
- To assert a stub was never called:
  `_TestFmkAssert(_StubCallCount("TypeName") = 0, "TypeName not called", _StubCallCount("TypeName"), 0)`

## Test cases to always consider

For every function, map its code paths and cover:

- Typical/happy path with realistic input values
- Every branch driven by a parameter value or stub return
- Empty string, zero, or null inputs where relevant
- Boundary values (off-by-one for index-based functions, min/max for numeric ranges)
- The `Default` keyword where parameters are optional
- Every `SetError` or `Return SetError(...)` path visible in the code or spec
- Case sensitivity for string comparisons where relevant
- Behavior when called inside a `_Try()` block if the function is designed for use with
  TryCatch.au3

## BDD/spec input handling

When the input includes BDD feature files (Gherkin) or any structured specification,
map scenario steps directly to test cases:

- "Given [precondition]" - set up the input value or stub returns
- "When [action]" - call the function
- "Then [outcome]" - `_TestFmkAssert` on the result or stub call data
- "And [additional outcome]" - additional `_TestFmkAssert` calls

Each Gherkin Scenario maps to one or more `_TestFmkAssert` calls within a test function.
Each Feature maps to one test function. Preserve the Scenario names as assertion
descriptions so the test output is traceable back to the spec.

## Project audit mode

When pointed at a project folder:

1. Scan all `.au3` files and list all public functions found
2. Check for existing test files to understand what is already covered
3. Identify untested functions
4. If raw AutoIt built-ins are found instead of `_Tstbl_*` wrappers, follow the
   `autoit-testable-converter` detection and handoff flow from the Path selection section
5. Generate a test file per source file (or one combined test file for small projects)
6. Add a comment at the top of each generated test file noting which functions are covered
   and which were already tested

## Output file header

Always add a comment block at the top of generated test files:

```autoit
; Generated by Claude using the autoit-testframework skill
; Source: <source file or description>
; Coverage: <list of functions covered>
; Mode: <Regression | TDD | Spec-driven>
; Pattern: <Basic Test Structure | Testing with Testable Wrappers and Stubs>
```
