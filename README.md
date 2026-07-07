# TestFramework.au3 for AutoIt

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

Choose one of the following options. Option 3 is the recommended approach for most users. Option 4 is recommended if your project is using Git.

> **Finding your AutoIt installation folder:** if you are unsure where AutoIt is installed, right-click the AutoIt3.exe shortcut or file and select "Properties" - the folder shown in the "Start in" or "Target" field is your AutoIt installation folder.

### Option 1 - Local project folder

Copy `TestFramework.au3` into the same folder as your project and reference it with a relative path:

```autoit
#include "TestFramework.au3"
```

This is the simplest option but means you need a separate copy for each project.

### Option 2 - AutoIt include folder

Copy `TestFramework.au3` to the `Include` subfolder inside your AutoIt installation folder and reference it with the angle-bracket form:

```autoit
#include <TestFramework.au3>
```

This makes it available to any project on your machine. The downside is that third-party files sit alongside AutoIt's own standard library files, which can get messy over time.

### Option 3 - Vendor subfolder (recommended)

This approach keeps third-party libraries organized separately from AutoIt's own files while still making them available globally with the angle-bracket form.

Considering AutoIt is installed on the default `C:\Program Files (x86)\AutoIt3`, follow the steps below. If you installed AutoIt in a different location, replace `C:\Program Files (x86)\AutoIt3` with your actual installation folder path wherever it appears.

**Step 1 - Create a `Vendor` subfolder inside the AutoIt `Include` folder:**

```
C:\Program Files (x86)\AutoIt3\Include\Vendor\
```

> **Note:** the default AutoIt installation folder is usually `C:\Program Files (x86)\AutoIt3`, so the full path would typically be `C:\Program Files (x86)\AutoIt3\Include\Vendor\`. Your path may differ if you installed AutoIt in a custom location.

**Step 2 - Copy `TestFramework.au3` into it:**

```
C:\Program Files (x86)\AutoIt3\Include\Vendor\TestFramework.au3
```

**Step 3 - Register the folder with AutoIt via the registry:**

Open `regedit.exe` and navigate to:

```
HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt
```

Create a new `REG_SZ` (string) value named `Include` with the following value data:

```
C:\Program Files (x86)\AutoIt3\Include\Vendor
```

If the `Include` value already exists (for example, if you have other vendor libraries registered), append the new path to the existing value separated by a semicolon:

```
C:\ExistingPath\SomeLib;C:\Program Files (x86)\AutoIt3\Include\Vendor
```

This is the mechanism documented in the official AutoIt documentation for extending the include search path beyond the standard locations.

**Step 4 - Reference it from any project:**

```autoit
#include <TestFramework.au3>
```

### Option 4 - Git submodule (recommended for Git projects)

If your project is a Git repository, you can add TestFramework.au3 as a submodule directly from the `dist` branch. This gives you exactly one file (`TestFramework.au3`) with no extra content from the development repo, and lets you pin to a specific version and update deliberately when you are ready.

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

## Usage

See the [documentation](https://crucialthread.github.io/AutoItTestFramework/) for the full function reference and a complete worked example.

## API

| Function | Description |
|---|---|
| `_TestFmkHeader($sTitle)` | Prints a labeled section header to identify a group of tests. |
| `_TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)` | Evaluates a condition and records pass or fail. |
| `_TestFmkRun($fTest, $bCumulative)` | Runs a test function and accumulates its result into a cumulative boolean. |
| `_TestFmkSummary()` | Prints the final Total/Passed/Failed summary block. |

## Requirements

- AutoIt 3.3.18.0 or later
- SciTE4AutoIt3 (for colored console output)

## License

MIT
