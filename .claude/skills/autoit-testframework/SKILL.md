---
name: autoit-testframework
description: Generates AutoIt unit test files using TestFramework.au3. Use this skill
  whenever the user wants to write, generate, or create tests for AutoIt code, create a
  test suite, test an AutoIt function or script, verify AutoIt code behavior, or develop
  using TDD or BDD. Also use this skill when the user points at an existing AutoIt project
  and wants test coverage added, or when they describe a function they want built and tested.
  Triggers on phrases like "write tests for", "create test file", "unit test this", "test my
  AutoIt function", "add tests to my project", "build this using TDD", "generate tests first",
  or when the user shares a .au3 file and asks to test it. Works from any specification input
  - a chat message, a source file, a whole project folder, BDD feature files, design docs,
  structured requirements from another AI agent, or any combination of these. Always produces
  complete, ready-to-run output with no placeholders.
---

# AutoIt TestFramework.au3 Skill

Generates complete, ready-to-run AutoIt unit test files using TestFramework.au3, and
implements the code under test when needed. Works from any input the developer has available,
in any combination.

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

## Standard test file structure

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

## BDD/spec input handling

When the input includes BDD feature files (Gherkin) or any structured specification,
map scenario steps directly to test cases:

- "Given [precondition]" - set up the input value
- "When [action]" - call the function
- "Then [outcome]" - `_TestFmkAssert` on the result
- "And [additional outcome]" - additional `_TestFmkAssert` calls

Each Gherkin Scenario maps to one or more `_TestFmkAssert` calls within a test function.
Each Feature maps to one test function. Preserve the Scenario names as assertion descriptions
so the test output is traceable back to the spec.

## Project audit mode

When pointed at a project folder:

1. Scan all `.au3` files and list all public functions found
2. Check for existing test files to understand what is already covered
3. Identify untested functions
4. Generate a test file per source file (or one combined test file for small projects)
5. Add a comment at the top of each generated test file noting which functions are covered
   and which were already tested (if any existing tests were found)

## Output file header

Always add a comment block at the top of generated test files indicating what generated them
and from what input, so the developer understands the context when reading the file later:

```autoit
; Generated by Claude using the autoit-testframework skill
; Source: <source file or description>
; Coverage: <list of functions covered>
; Mode: <Regression | TDD | Vibe Code | Spec-driven>
```
