---
name: autoit-testframework
description: Generates complete, ready-to-run AutoIt unit test files using AutoIt Test Framework (`TestFramework.au3`). Use when the user wants to write, generate, or add tests for any AutoIt script or function, develop using TDD or BDD, or audit an existing project for test coverage. Works from any input - source files, descriptions, BDD specs, or project folders. Also handles scripts that require user interaction or affect program flow (dialogs, file system, registry, GUI, shell) using the Testable/Stubs pattern.
---

# AutoIt Test Framework Skill

Generates complete, ready-to-run AutoIt unit test files using AutoIt Test Framework
(`TestFramework.au3`), and implements the code under test when needed. Works from any input
the developer has available, in any combination. Also supports testing scripts that require
user interaction or return values that affect program flow (dialogs, file system, registry,
GUI, shell, etc.) through the Testable.au3 and Stubs.au3 libraries.

## Path selection - read this first

Scan the source code for calls to built-ins (dialogs, file system, registry, GUI, shell,
etc.) from the testable list. Then pick the path:

- **No testable built-ins found** → standard path only (`TestFramework.au3`)
- **Testable built-ins found** → standard path + Testable/Stubs (`TestFramework.au3` +
  `Testable.au3` + `Stubs.au3`)

The Testable/Stubs pattern builds on top of the standard path - it does not replace it.

## Core principle

Read whatever is available. Figure out what exists and what needs to be created. Produce the
most complete, immediately runnable output possible from whatever input is provided. The
developer should never need to declare which "mode" they are in - the skill adapts to the
situation automatically.

## Input - what to look for

Before generating anything, survey what is available:

- **Chat description** - a human (or AI agent) describing what a function should do
- **Source files** - existing `.au3` files with functions to test or extend
- **Project folder** - a whole project to audit and generate test coverage for
- **BDD/spec files** - Gherkin `.feature` files, design docs, README files, API specs,
or any document describing expected behavior
- **Partial code** - stubs, incomplete implementations, or draft functions
- **Any combination** of the above

Read all available inputs before deciding what to generate. If a project folder is provided,
scan all `.au3` files to understand scope before writing a single line of output.

When reading source files, check whether the code calls AutoIt built-ins like `MsgBox`,
`FileExists`, `FileDelete`, `RegRead`, `GUICreate`, `GUIGetMsg`, `ShellExecute`, etc. If it
does and it already uses `_Tstbl_*` wrappers, use the Testable/Stubs pattern. If it uses raw
built-ins and the user wants them testable, check whether the `autoit-testable-converter`
skill is available:

- In Claude Code: check whether `.claude/skills/autoit-testable-converter/SKILL.md` or
  `~/.claude/skills/autoit-testable-converter/SKILL.md` exists
- In Chat/Cowork: check whether the `autoit-testable-converter` skill description is present
  in context, which means the user has it installed

If the converter skill is available, invoke it to audit and optionally convert the script
before proceeding with test generation. If it is not available:

- **Claude Code:** try fetching the skill directly from
  `https://raw.githubusercontent.com/crucialthread/AutoItTestFramework/main/.claude/skills/autoit-testable-converter/SKILL.md`
  and apply it inline if the fetch succeeds. If the fetch fails, advise the user that the
  `autoit-testable-converter` skill is available at that URL and can be installed locally,
  then ask whether to proceed with test generation anyway.
- **Chat/Cowork:** advise the user that the `autoit-testable-converter` skill is available
  and can be installed, then ask whether to proceed with test generation anyway.

## Output - what to produce

Based on what is available, produce the right combination of:

### Always produce: a complete test file

- Named after the source file or described function (e.g. `MyLib.au3` -> `MyLibTests.au3`)
- `#include <TestFramework.au3>` at the top (or `#include "TestFramework.au3"` if local)
- `#include` for the file under test
- One test function per public function or logical behavior group
- All test functions wired into `_RunAllTests` with the cumulative `$bAllPassed` pattern
- `_TestFmkSummary()` at the end
- Ready to run with Go/F5 in SciTE immediately

### When code does not exist yet: also produce stubs

When generating tests for functions that do not exist yet (TDD/vibe code scenarios), also
generate a matching stub file so the tests are runnable from the first moment:

```autoit
; Stub - replace with real implementation
Func _MyFunc($sInput)
    Return ""
EndFunc
```

The stub file lets the tests run immediately (all red/failing), which is the correct starting
point for TDD. The developer (or Claude Code continuing the task) then implements each
function until all tests go green.

### When asked to implement: also produce the implementation

In vibe code or full TDD scenarios where the developer wants Claude to do everything, do not
stop at tests and stubs. After generating the tests, implement the functions to make them
pass. Verify the logic of each implementation against the test cases before writing it.

## TestFramework.au3 API

```autoit
; Prints a labeled section header to identify a group of related tests
; $sColor is optional - default is $TFW_COLOR_ORANGE
_TestFmkHeader($sTitle [, $sColor = $TFW_COLOR_ORANGE])

; Evaluates a condition and records pass or fail
; ALWAYS pass $vActual and $vExpected - never omit them
_TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)

; Runs a test function by reference and accumulates its result
; Pass $bAllPassed as the second argument to chain results across tests
_TestFmkRun($fTest [, $bCumulative = True])

; Prints the final Total/Passed/Failed summary block
; Call once at the end of _RunAllTests(), never inside individual test functions
_TestFmkSummary()
```

## Standard path

The standard path uses `TestFramework.au3` only. Use this when the script under test does
not call any built-ins that require user interaction or return values that affect program flow.

```autoit
#include <TestFramework.au3>
#include "SourceFile.au3"

; ===========================================================================
; Tests - FunctionName
; ===========================================================================

Func _TestFunctionName()
    _TestFmkHeader("Test: FunctionName()")

    ; Happy path
    Local $sResult = FunctionName("valid input")
    _TestFmkAssert($sResult = "expected output", "Returns expected output for valid input", $sResult, "expected output")

    ; Edge case
    Local $sEmpty = FunctionName("")
    _TestFmkAssert($sEmpty = "", "Returns empty string for empty input", $sEmpty, "(empty)")

    ; Error path - capture @error immediately
    FunctionName(0)
    Local $iErr = @error
    _TestFmkAssert($iErr = 1, "Sets @error = 1 for invalid input", $iErr, "1")
EndFunc

; ===========================================================================
; Run all tests
; ===========================================================================

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestFunctionName, $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_RunAllTests()
```

## Testable/Stubs pattern

Use this pattern when the script under test calls AutoIt built-ins that require user
interaction or return values that affect program flow (dialogs, file system, registry,
GUI, shell, etc.). This pattern builds on top of the standard path - it does not replace it.

### When to use it

Use the Testable/Stubs pattern when:
- The script calls `MsgBox`, `InputBox`, or any dialog function
- The script calls `FileExists`, `FileDelete`, `FileCopy`, `RegRead`, `RegWrite`, etc.
- The script creates a GUI with `GUICreate` / `GUIGetMsg`
- The script calls `ShellExecute`, `Run`, or similar
- Any built-in that would actually execute during a test run and requires user interaction
  or return values that affect program flow

### Script code structure

In the script under test, use `_Tstbl_*` wrappers instead of AutoIt built-ins directly,
and guard the entry point with a test mode sentinel:

```autoit
#include <Testable.au3>

; Guard the entry point so tests can include this file without executing it
If Not IsDeclared("__MY_SCRIPT_TEST_MODE") Then
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

### Test file structure with stubs

```autoit
Global $__MY_SCRIPT_TEST_MODE = True
#include <TestFramework.au3>
#include <Stubs.au3>
#include "MyScript.au3"

Func _TestMyFunction_FileNotFound()
    _TestFmkHeader("Test: MyFunction() - file not found")

    _ResetStubs()
    _SetStubReturn("FileExists", 1, False)

    Local $bResult = MyFunction("C:\temp\myfile.txt")

    _TestFmkAssert($bResult = False, "Returns False when file not found", $bResult, False)
    _TestFmkAssert($g_StubCalls["MsgBox"].count = 1, "Shows error MsgBox", $g_StubCalls["MsgBox"].count, 1)
    _TestFmkAssert(Not MapExists($g_StubCalls, "FileDelete"), "FileDelete not called", MapExists($g_StubCalls, "FileDelete"), False)
EndFunc

Func _TestMyFunction_UserConfirms()
    _TestFmkHeader("Test: MyFunction() - user confirms")

    _ResetStubs()
    _SetStubReturn("FileExists", 1, True)
    _SetStubReturn("MsgBox", 1, $IDYES)

    Local $bResult = MyFunction("C:\temp\myfile.txt")

    _TestFmkAssert($bResult = True, "Returns True when confirmed", $bResult, True)
    _TestFmkAssert($g_StubCalls["FileDelete"].count = 1, "FileDelete called once", $g_StubCalls["FileDelete"].count, 1)
    _TestFmkAssert($g_StubCalls["FileDelete"][1]["sPath"] = "C:\temp\myfile.txt", _
        "Correct file deleted", $g_StubCalls["FileDelete"][1]["sPath"], "C:\temp\myfile.txt")
EndFunc

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestMyFunction_FileNotFound, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestMyFunction_UserConfirms,  $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_RunAllTests()
```

### Stubs API

```autoit
; Clear all recorded calls and configured returns between tests
_ResetStubs()

; Pre-configure what a stub returns for the Nth call (1-based)
; Call before running the code under test
_SetStubReturn("TypeName", iIdx, vValue)

; Recorded calls - populated automatically by stubs during test run
; $g_StubCalls["TypeName"].count     - how many times the stub was called
; $g_StubCalls["TypeName"][N]["prop"] - argument passed on the Nth call
```

### Stub type names and recorded properties

Common stub types and the properties they record:

| Type | Recorded properties |
| --- | --- |
| `"MsgBox"` | `iFlag`, `sTitle`, `sText` |
| `"FileExists"` | `sPath` |
| `"FileDelete"` | `sPath` |
| `"FileCopy"` | `sSource`, `sDest` |
| `"FileMove"` | `sSource`, `sDest` |
| `"DirCreate"` | `sPath` |
| `"DirRemove"` | `sPath` |
| `"RegRead"` | `sKeyname`, `sValuename` |
| `"RegWrite"` | `sKeyname`, `sValuename`, `sType`, `vValue` |
| `"RegDelete"` | `sKeyname`, `sValuename` |
| `"ShellExecute"` | `sFilename`, `sParams` |
| `"GUICreate"` | `sTitle` |
| `"GUIGetMsg"` | (none) |
| `"GUICtrlSetData"` | `idCtrl`, `vData` |
| `"GUICtrlRead"` | `idCtrl` |

See the full list at https://crucialthread.github.io/AutoItTestFramework/stubs.htm

### Simulating @error with stubs

For stubs that support it (e.g. `RegRead`), pass `"__ERROR__"` to simulate a function
setting `@error = 1`:

```autoit
_SetStubReturn("RegRead", 1, "__ERROR__")
```

## Rules - never break these

**Assertions:**

- ALWAYS pass `$vActual` and `$vExpected` to every `_TestFmkAssert` call. Never omit them.
- Use realistic, meaningful test values. Never use placeholders like `"value1"`, `0`, or
`"expected"`.
- Always test both the success path and the failure/error path for any function that uses
`SetError`.

**@error capture:**

- ALWAYS capture `@error` into a local variable immediately after the call being tested,
before any other function call (including `_TestFmkAssert` itself) resets it.
- Correct: `Local $iErr = @error` then `_TestFmkAssert($iErr = 1, ...)`
- Wrong: `_TestFmkAssert(@error = 1, ...)` - @error is already 0 by the time this runs

**Test structure:**

- ALWAYS use `_TestFmkRun` in `_RunAllTests` - never call test functions directly.
- Name test functions `_Test<FunctionName>` or `_Test<FunctionName>_<Scenario>` for multiple
groups covering the same function.
- One `_TestFmkHeader` call per test function, at the top.

**TDD stubs:**

- When generating stubs for functions that do not exist yet, the stub MUST be syntactically
valid AutoIt so the test file compiles and runs immediately (all failing, as expected for
TDD red phase).
- Never generate a test that calls a function that has no stub. The test file must always
be runnable.

**Testable/Stubs rules:**

- ALWAYS declare `Global $__SCRIPT_TEST_MODE = True` before all includes in test files.
- ALWAYS call `_ResetStubs()` at the start of each test function.
- ALWAYS call `_SetStubReturn()` before running the code under test, never after.
- Stub call indexes are 1-based. First call is index 1, second is index 2, and so on.
- To assert a stub was never called, use `Not MapExists($g_StubCalls, "TypeName")` - never
check `.count = 0` directly since if a stub was never called the map entry does not exist
and accessing `.count` causes a runtime error.
- Do NOT use `_StubCall()` or `_StubCallCount()` - these do not exist. Access stub data
directly via `$g_StubCalls["TypeName"].count` and `$g_StubCalls["TypeName"][N]["prop"]`.

## Test cases to always consider

For every function, think through:

- Typical/happy path with realistic input values
- Empty string, zero, or null inputs where relevant
- Boundary values (off-by-one for index-based functions, min/max for numeric ranges)
- The `Default` keyword where parameters are optional
- Every `SetError` or `Return SetError(...)` path visible in the code or spec
- Case sensitivity for string comparisons where relevant
- Behavior when called inside a `_Try()` block if the function is designed for use with
TryCatch.au3
- For scripts using stubs: all branches driven by stub return values (user confirms/cancels,
file exists/not found, registry found/missing, etc.)

## BDD/spec input handling

When the input includes BDD feature files (Gherkin) or any structured specification,
map scenario steps directly to test cases:

- "Given [precondition]" - set up the input value or stub returns
- "When [action]" - call the function
- "Then [outcome]" - `_TestFmkAssert` on the result or stub call data
- "And [additional outcome]" - additional `_TestFmkAssert` calls

Each Gherkin Scenario maps to one or more `_TestFmkAssert` calls within a test function.
Each Feature maps to one test function. Preserve the Scenario names as assertion descriptions
so the test output is traceable back to the spec.

## Project audit mode

When pointed at a project folder:

1. Scan all `.au3` files and list all public functions found
2. Check for existing test files to understand what is already covered
3. Identify untested functions
4. Check whether scripts use raw AutoIt built-ins or `_Tstbl_*` wrappers. If raw built-ins
   are found, check whether the `autoit-testable-converter` skill is available (see Input
   section above for how to detect this in Claude Code vs Chat/Cowork). If available, invoke
   it to audit and optionally convert before generating tests. If not available, follow the
   same fallback flow described in the Input section.
5. Generate a test file per source file (or one combined test file for small projects)
6. Add a comment at the top of each generated test file noting which functions are covered
   and which were already tested (if any existing tests were found)

## Output file header

Always add a comment block at the top of generated test files indicating what generated them
and from what input, so the developer understands the context when reading the file later:

```autoit
; Generated by Claude using the autoit-testframework skill
; Source: <source file or description>
; Coverage: <list of functions covered>
; Mode: <Regression | TDD | Vibe Code | Spec-driven>
; Pattern: <Standard path | Standard path + Testable/Stubs>
```