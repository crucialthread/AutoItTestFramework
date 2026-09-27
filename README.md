# AutoIt Test Framework

A lightweight unit test framework for AutoIt. Write and run unit tests for any AutoIt script with results printed directly to SciTE's console output pane, or from the command line as part of an automated workflow.

Provides cumulative pass/fail tracking and detailed failure output with actual/expected values, file name, and line number. Includes testable wrappers and stubs for testing code that calls AutoIt built-ins (dialogs, file system, registry, GUI, and more) without those operations executing during tests.

See the full [documentation](https://crucialthread.github.io/AutoItTestFramework/) for more details.

## Features

- Testable wrappers and stubs for testing code that calls AutoIt built-ins (dialogs, file system, registry, GUI) without those operations executing during tests
- Every test always runs regardless of earlier failures, giving you a complete picture of the suite in one run
- Detailed failure output showing actual and expected values, file name, and line number
- Color-coded pass/fail output in SciTE's console pane for at-a-glance readability
- Final summary block showing total, passed, and failed counts
- Silent mode that suppresses pass results and headers, leaving only failures and the summary
- Each test file runs independently or as part of a combined script that includes all test files
- Command line support with exit code reporting for build pipeline integration
- Zero external dependencies

## Quick Example

```autoit
#include <TestFramework.au3>

Func _TestAdd()
    _TestFmkHeader("Test: Add()")
    _TestFmkAssert(Add(1, 2) = 3,   "Add(1, 2) returns 3",   Add(1, 2),   "3")
    _TestFmkAssert(Add(-1, 1) = 0,  "Add(-1, 1) returns 0",  Add(-1, 1),  "0")
    _TestFmkAssert(Add(0, 0) = 0,   "Add(0, 0) returns 0",   Add(0, 0),   "0")
EndFunc

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestAdd, $bAllPassed)
    _TestFmkSummary()
EndFunc

_RunAllTests()
```

## Installation

### Option 1 - Installer (recommended)

Download the latest installer from the [releases page](https://github.com/crucialthread/AutoItTestFramework/releases) and run it. It copies `TestFramework.au3`, `Testable.au3`, `Stubs.au3`, and all `Testable_*.au3` and `Stubs_*.au3` category files to your AutoIt Vendor include folder and configures the registry automatically, making them available from any project via:

```autoit
#include <TestFramework.au3>
#include <Testable.au3>
```

The installer also includes the documentation (`TestFramework.chm`) and an uninstaller registered in Add/Remove Programs.

> **Note:** the installer requires administrator rights to write to the AutoIt installation folder.

> ⚠️ **Windows security warning:** Windows may show a SmartScreen warning when running the installer for the first time since it is not digitally signed. This is expected for open source tools distributed outside the Microsoft Store. You can proceed in one of two ways:
> - Click **More info** then **Run anyway** on the SmartScreen dialog
> - Right-click the downloaded `.exe` > **Properties** > check **Unblock** at the bottom > click OK, then run it normally
>
> If you prefer not to run the installer, you can install manually by downloading and extracting the source code zip from the releases page, copying the files from `src/core/` into your project folder, and following Option 2 below.

### Option 2 - Local project folder

Download and extract the source code zip from the [releases page](https://github.com/crucialthread/AutoItTestFramework/releases), copy all files from `src/core/` into your project folder, and reference them with a relative path:

```autoit
#include "TestFramework.au3"
#include "Testable.au3"
```

This is the simplest option but means you need a separate copy for each project (or you can keep them in a shared folder from where all your projects reference them).

### Option 3 - Git submodule (recommended for Git projects)

If your project is a Git repository, you can add AutoIt Test Framework as a submodule directly from the `dist` branch. This gives you `TestFramework.au3`, `Testable.au3`, `Stubs.au3`, and all category files with no extra content from the development repo, and lets you pin to a specific version and update deliberately when you are ready.

**Step 1 - Add the submodule:**

```bash
git submodule add -b dist https://github.com/crucialthread/AutoItTestFramework lib/TestFramework
git submodule update --init
```

**Step 2 - Reference it from your files:**

```autoit
#include "lib/TestFramework/TestFramework.au3"
#include "lib/TestFramework/Testable.au3"
```

**Cloning a project that already uses the submodule:**

```bash
git clone --recurse-submodules https://github.com/youruser/YourProject
```

Or if you already cloned without it:

```bash
git submodule update --init
```

**Updating to a newer version when ready:**

```bash
git submodule update --remote lib/TestFramework
git add lib/TestFramework
git commit -m "Update TestFramework to latest"
```

## Troubleshooting

### Conflict between global installation and Git submodule

If you have AutoIt Test Framework installed globally (via the installer) and are working on a Git project that also includes it as a submodule, you will get duplicate declaration errors at runtime. This happens because AutoIt sees two copies of the same files from different paths.

To resolve this, uninstall the global installation via Add/Remove Programs and use the submodule references for that project. Then install it locally as described in Option 2, and any other scripts that previously used the angle-bracket form will need to be updated to reference the files directly.

## Usage

See the [documentation](https://crucialthread.github.io/AutoItTestFramework/) for the full function reference, testable wrappers, stubs reference, and complete worked examples.

## API

### TestFramework.au3

| Function | Description |
|---|---|
| `_TestFmkHeader($sTitle)` | Prints a labeled section header to identify a group of tests. |
| `_TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)` | Evaluates a condition and records pass or fail. |
| `_TestFmkRun($hFuncTest, $bNothingFailed)` | Runs a test function and accumulates its result into a cumulative boolean. |
| `_TestFmkSummary()` | Prints the final Total/Passed/Failed summary block. |
| `_TestFmkSeparator($iLength, $sChar)` | Prints a separator line of repeated characters to visually divide output. |
| `_TestFmk_SetSilentMode($bSilent)` | Enables or disables silent mode, which suppresses pass results and header output. |
| `_TestFmkRunAllTests($hFuncSuite)` | Runs the test suite function only when the script is executed directly, not when included. |

### Testable.au3

Include in script code. Replace direct AutoIt built-in calls with `_Tstbl_*` wrapper equivalents so tests can intercept them via stubs without those operations actually executing.

**Example:**
```autoit
#include <Testable.au3>

Func DeleteFile($sPath)
    If Not _Tstbl_FileExists($sPath) Then Return False
    _Tstbl_FileDelete($sPath)
    Return True
EndFunc
```

Covers dialogs, file system, INI, registry, shell, process, GUI, network, system, clipboard, input, window management, splash, sound, and tray functions.

### Stubs.au3

`Stubs.au3` provides stub implementations for all `_Tstbl_*` wrappers. Each stub serves two purposes:

- **Call recording** — every call is recorded with its parameters so tests can verify that the correct functions were called with the correct arguments using `_GetStubCall()`, and how many times via `_StubCallCount()`.
- **Return control** — tests can pre-configure what a stub returns for each call via `_SetStubReturn()`, allowing tests to drive the code under test down specific branches.

| Function | Description |
|---|---|
| `_ResetStubs()` | Clears all recorded calls and configured return values. Call between tests. |
| `_SetStubReturn($sType, $iIdx, $vValue)` | Pre-configures the return value for the Nth call of a stub type. |
| `_StubCallCount($sType)` | Returns the number of times a stub type was called. |
| `_GetStubCall($sType, $iIdx)` | Returns the recorded call map for the Nth call of a stub type. |

### StubConstants.au3

Optional constants for use in test files. Provides named call index constants (`$_1st`, `$_2nd`, `$_3rd`, ...) for use with `_SetStubReturn()`, `_StubCall()`, and `_GetStubCall()`, and named parameter key constants (`$Param_Path`, `$Param_Dest`, `$Param_Title`, ...) for accessing recorded stub call arguments without raw strings or numbers.

## AI Claude Skills

This repository includes two AI Claude skills for AutoIt Test Framework.

### autoit-testframework

Generates complete, ready-to-run AutoIt unit test files. Works from any input - source files, descriptions, BDD specs, or project folders. Also handles the Testable/Stubs pattern automatically when the script requires user interaction or return values that affect program flow.

### autoit-testable-converter

Audits, suggests, or converts AutoIt scripts to use `_Tstbl_*` testable wrappers, making them compatible with the Testable/Stubs pattern. Supports interactive mode (audit and suggest) and approved mode for autonomous AI agent workflows.

### Claude Code - Manual Installation (Recommended)

Copy the skill folders to your skills directory:

- **Windows:** `%USERPROFILE%\.claude\skills\`
  (the `.claude` folder is hidden - enable hidden items in Explorer or paste the path directly into the address bar)
- **macOS/Linux:** `~/.claude/skills/`

Claude Code picks up any skill folder placed there automatically.

### Install Via Claude Desktop UI

Download the `SKILL.md` file for each skill from this repository, then go to Settings, select Skills from the left menu, click Add at the top right, and choose Upload a Skill. Select the downloaded `SKILL.md` file.

- `autoit-testframework`: `.claude/skills/autoit-testframework/SKILL.md`
- `autoit-testable-converter`: `.claude/skills/autoit-testable-converter/SKILL.md`

### Usage

Once installed, just describe what you need:

- *"Write tests for this AutoIt script"* - generates tests from existing code
- *"Create a test file for a function that validates email addresses"* - generates tests and stubs from a description
- *"Add test coverage to this project"* - scans the project and generates a full test suite
- *"Build this using TDD"* - generates tests first, then implements the code to make them pass
- *"Make this script testable"* - audits and converts raw built-in calls to `_Tstbl_*` wrappers

## Requirements

- AutoIt 3.3.18.0 or later
- SciTE4AutoIt3 (for colored console output)

## License

MIT
