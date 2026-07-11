# AutoIt Test Framework

A simple, lightweight unit test framework for AutoIt. Provides colored console output, pass/fail tracking, and cumulative test result accumulation with zero dependencies beyond AutoIt itself.

## Features

- Colored console output in SciTE's output pane for at-a-glance readability
- Actual vs. expected value display on failure
- Cumulative pass/fail tracking across multiple test functions
- Final summary block showing total, passed, and failed counts
- Zero dependencies - no additional `#include` required

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

> **Windows security warning:** Windows may show a SmartScreen warning when running the installer for the first time since it is not digitally signed. This is expected for open source tools distributed outside the Microsoft Store. You can proceed in one of two ways:
> - Click **More info** then **Run anyway** on the SmartScreen dialog
> - Right-click the downloaded `.exe` > **Properties** > check **Unblock** at the bottom > click OK, then run it normally
>
> If you prefer not to run the installer, you can install manually by downloading `TestFramework.au3` directly from the release and following Option 2 below.

Download the latest release from the [releases page](https://github.com/crucialthread/AutoItTestFramework/releases) and run the installer. It copies `TestFramework.au3` to your AutoIt Vendor include folder and configures the registry automatically, making it available from any project via:

```autoit
#include <TestFramework.au3>
```

The installer also includes the documentation (`TestFramework.chm`) and an uninstaller registered in Add/Remove Programs.

> **Note:** the installer requires administrator rights to write to the AutoIt installation folder.

### Option 2 - Local project folder

Download `TestFramework.au3` from the [releases page](https://github.com/crucialthread/AutoItTestFramework/releases) and copy it into your project folder, then reference it with a relative path:

```autoit
#include "TestFramework.au3"
```

This is the simplest option but means you need a separate copy for each project.

### Option 3 - Git submodule (recommended for Git projects)

If your project is a Git repository, you can add AutoIt Test Framework as a submodule directly from the `dist` branch. This gives you exactly one file (`TestFramework.au3`) with no extra content from the development repo, and lets you pin to a specific version and update deliberately when you are ready.

**Step 1 - Add the submodule:**

```bash
git submodule add -b dist https://github.com/crucialthread/AutoItTestFramework lib/TestFramework
git submodule update --init
```

**Step 2 - Reference it from your test files:**

```autoit
#include "lib/TestFramework/TestFramework.au3"
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

If you have AutoIt Test Framework installed globally (via the installer) and are working on a Git project that also includes it as a submodule, you will get duplicate declaration errors at runtime. This happens because AutoIt sees two copies of the same file from different paths.

To resolve this, uninstall the global installation via Add/Remove Programs and use the submodule reference (`#include "lib/TestFramework/TestFramework.au3"`) for that project. Then install it locally as described in Option 2, and any other scripts that previously used `#include <TestFramework.au3>` will need to be updated to reference the file directly.

## Usage

See the [documentation](https://crucialthread.github.io/AutoItTestFramework/) for the full function reference and a complete worked example.

## API

| Function | Description |
|---|---|
| `_TestFmkHeader($sTitle)` | Prints a labeled section header to identify a group of tests. |
| `_TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)` | Evaluates a condition and records pass or fail. |
| `_TestFmkRun($fTest, $bCumulative)` | Runs a test function and accumulates its result into a cumulative boolean. |
| `_TestFmkSummary()` | Prints the final Total/Passed/Failed summary block. |

## Claude Code Skill

This repository includes a Claude Code skill that helps you generate AutoIt unit tests using AutoIt Test Framework. If you want to use it in your own project, copy `.claude/skills/autoit-testframework/SKILL.md` from this repository into your own project's `.claude/skills/autoit-testframework/` folder and Claude Code will pick it up automatically.

It can generate complete, ready-to-run test files from:

- A plain language description of what a function should do
- An existing `.au3` source file or project folder
- BDD/Gherkin feature files or any other specification format
- A mix of any of the above

It also supports TDD workflows - generating tests first alongside function stubs, then implementing the code to make the tests pass, all in one flow.

The skill lives at `.claude/skills/autoit-testframework/SKILL.md`.

## Requirements

- AutoIt 3.3.18.0 or later
- SciTE4AutoIt3 (for colored console output)

## License

MIT
