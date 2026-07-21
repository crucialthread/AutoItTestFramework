# AutoIt Test Framework

A simple, lightweight unit test framework for AutoIt. Provides colored console output, pass/fail tracking, and cumulative test result accumulation. Includes `Testable.au3` and `Stubs.au3` for testing scripts that require user interaction or return values that affect program flow (dialogs, file system, registry, GUI, shell, etc.).

See the full [documentation](https://crucialthread.github.io/AutoItTestFramework/) for more details.

## Features

- Colored console output in SciTE's output pane for at-a-glance readability
- Actual vs. expected value display on failure
- Cumulative pass/fail tracking across multiple test functions
- Final summary block showing total, passed, and failed counts
- Testable wrappers and stubs - `Testable.au3` and `Stubs.au3` provide a pattern to test scripts that require user interaction or return values that affect program flow, without those operations actually executing during tests
- Zero dependencies - no additional `#include` required beyond the framework itself

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
#include <Stubs.au3>
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
#include "Stubs.au3"
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
#include "lib/TestFramework/Stubs.au3"
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
| `_TestFmkRun($fTest, $bCumulative)` | Runs a test function and accumulates its result into a cumulative boolean. |
| `_TestFmkSummary()` | Prints the final Total/Passed/Failed summary block. |

### Testable.au3

Include in script code. Provides `_Tstbl_*` wrappers for AutoIt built-ins so calls can be intercepted by stubs in tests. Covers dialogs, file system, INI, registry, shell, process, GUI, network, system, clipboard, input, window management, splash, sound, and tray functions.

### Stubs.au3

Include in test files. Automatically rewires all `_Tstbl_*` wrappers to stubs that record calls and return controlled values.

| Function / Variable | Description |
|---|---|
| `_ResetStubs()` | Clears all recorded calls and configured return values. Call between tests. |
| `_SetStubReturn($sType, $iIdx, $vValue)` | Pre-configures the return value for the Nth call of a stub type. |
| `$g_StubCalls["TypeName"]` | Map of recorded calls keyed by 1-based index, with a `.count` property. |
| `$g_StubReturns["TypeName"]` | Map of pre-configured return values keyed by 1-based call index. |

## AI Claude Skills

This repository includes two AI Claude skills for AutoIt Test Framework.

### autoit-testframework

Generates complete, ready-to-run AutoIt unit test files. Works from any input - source files, descriptions, BDD specs, or project folders. Also handles the Testable/Stubs pattern automatically when the script requires user interaction or return values that affect program flow.

### autoit-testable-converter

Audits, suggests, or converts AutoIt scripts to use `_Tstbl_*` testable wrappers, making them compatible with the Testable/Stubs pattern. Supports interactive mode (audit and suggest) and approved mode for autonomous AI agent workflows.

### Install Via Claude Desktop UI

Download the `SKILL.md` file for each skill from this repository, then go to Settings, select Skills from the left menu, click Add at the top right, and choose Upload a Skill. Select the downloaded `SKILL.md` file. The skill becomes available in both Claude Code and Cowork automatically.

- `autoit-testframework`: `.claude/skills/autoit-testframework/SKILL.md`
- `autoit-testable-converter`: `.claude/skills/autoit-testable-converter/SKILL.md`

### Manual Installation

Copy the skill folders to your skills directory:

- **Windows:** `%USERPROFILE%\.claude\skills\`
  (the `.claude` folder is hidden - enable hidden items in Explorer or paste the path directly into the address bar)
- **macOS/Linux:** `~/.claude/skills/`

The skills become available in both Claude Code and Cowork automatically.

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
