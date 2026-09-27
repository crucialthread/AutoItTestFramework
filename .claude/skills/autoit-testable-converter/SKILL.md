---
name: autoit-testable-converter
description: Converts existing AutoIt scripts to use _Tstbl_* testable wrappers from Testable.au3, making them compatible with AutoIt Test Framework so their built-in calls can be stubbed in tests. Use when the user wants to make an AutoIt script testable, convert raw built-in calls to testable wrappers, or prepare an existing script for unit testing with the test framework.
---

# AutoIt Testable Converter Skill

Converts existing AutoIt scripts to use the `_Tstbl_*` wrapper pattern from `Testable.au3`,
replacing raw AutoIt built-in calls with testable equivalents that can be stubbed in unit
tests written with AutoIt Test Framework.

This skill exists because adopting AutoIt Test Framework on an existing codebase means every
script that calls AutoIt built-ins with side effects (dialogs, file system, registry, GUI,
shell, etc.) must be converted before tests can stub those calls. This skill handles that
conversion — mechanically and completely.

## How to approach the task

Follow these steps in order every time:

1. **Read the entire source file first.** Do not start converting before this is done.
2. **Audit the file** — identify every raw built-in call that has a `_Tstbl_*` equivalent,
   note which structural changes are needed (include, entry point guard, `#RequireAdmin`),
   and identify any `FileInstall` calls.
3. **Report the audit** — show the user what was found and what will change.
4. **In interactive mode**: end the report with a clear prompt asking whether to apply.
   In approved mode: proceed directly to conversion after the audit.
5. **Apply the changes** — replace every detected call, add the include and guard, handle
   `FileInstall`, replace `#RequireAdmin` if present.
6. **Produce a summary** of every change made.

Never skip the audit step, even in approved mode — the summary must reflect what actually
changed.

## Modes

### Interactive mode (default)

Audit the file and produce a structured report:

- Which raw built-in calls were found and on which lines
- Which structural changes are needed (`#include <Testable.au3>`, entry point guard,
  `#RequireAdmin` replacement)
- Whether any `FileInstall` calls were found and how they will be handled
- A count of total changes that would be applied

End every interactive mode report with: **"Apply these changes?"** — a clear yes/no prompt.
Do not apply anything until the user confirms.

### Approved mode

Skip the confirmation prompt and apply all changes immediately after the audit. Approved
mode is active when any of the following are true:

- The user says "apply the changes", "convert the file", "go ahead", "approved mode", or
  similar
- The task context contains explicit permission such as "you have permission to modify
  files" or "apply all changes"
- The skill is invoked with `AUTOIT_CONVERTER_APPROVED=true`
- The orchestrating agent (e.g. autoit-testframework skill) has set approved mode

### Suggest mode

Produce an annotated version showing proposed changes inline as comments, without modifying
the original file. Suggest mode is active when the user says "show me what would change",
"show the diff", "show suggestions", or similar without granting approval to apply.

```autoit
; SUGGEST: replace with _Tstbl_MsgBox(...)
MsgBox($MB_OK, "Title", "Text")
```

## Output

**In interactive mode and suggest mode:** produce the report or annotated diff in chat.
Do not write or modify any file until the user confirms.

**In approved mode (or after the user confirms in interactive mode):** overwrite the
original file in place with the converted version, then produce a summary in chat:

- File modified
- Number of built-in calls replaced, by category
- Whether `#include <Testable.au3>` was added
- Whether the entry point guard was added
- Whether `#RequireAdmin` was replaced
- Whether a `__FileInstall` wrapper was generated

## What to detect and convert

### Built-in calls with _Tstbl_* equivalents

Replace each raw call with its `_Tstbl_*` equivalent. Parameters are identical — only the
function name changes.

**Dialogs:**
`MsgBox` → `_Tstbl_MsgBox`
`InputBox` → `_Tstbl_InputBox`
`FileOpenDialog` → `_Tstbl_FileOpenDialog`
`FileSaveDialog` → `_Tstbl_FileSaveDialog`
`FileSelectFolder` → `_Tstbl_FileSelectFolder`

**File System:**
`FileExists` → `_Tstbl_FileExists`
`FileDelete` → `_Tstbl_FileDelete`
`FileCopy` → `_Tstbl_FileCopy`
`FileMove` → `_Tstbl_FileMove`
`FileGetAttrib` → `_Tstbl_FileGetAttrib`
`FileGetSize` → `_Tstbl_FileGetSize`
`FileGetTime` → `_Tstbl_FileGetTime`
`FileGetVersion` → `_Tstbl_FileGetVersion`
`FileRead` → `_Tstbl_FileRead`
`FileWrite` → `_Tstbl_FileWrite`
`FileOpen` → `_Tstbl_FileOpen`
`FileClose` → `_Tstbl_FileClose`
`FileReadLine` → `_Tstbl_FileReadLine`
`FileWriteLine` → `_Tstbl_FileWriteLine`
`FileReadToArray` → `_Tstbl_FileReadToArray`
`FileCreateShortcut` → `_Tstbl_FileCreateShortcut`
`FileSetAttrib` → `_Tstbl_FileSetAttrib`
`FileSetTime` → `_Tstbl_FileSetTime`
`DirCreate` → `_Tstbl_DirCreate`
`DirRemove` → `_Tstbl_DirRemove`
`DirCopy` → `_Tstbl_DirCopy`
`DirMove` → `_Tstbl_DirMove`
`DirGetSize` → `_Tstbl_DirGetSize`

**INI Files:**
`IniRead` → `_Tstbl_IniRead`
`IniWrite` → `_Tstbl_IniWrite`
`IniDelete` → `_Tstbl_IniDelete`
`IniReadSection` → `_Tstbl_IniReadSection`
`IniReadSectionNames` → `_Tstbl_IniReadSectionNames`
`IniWriteSection` → `_Tstbl_IniWriteSection`
`IniRenameSection` → `_Tstbl_IniRenameSection`

**Registry:**
`RegRead` → `_Tstbl_RegRead`
`RegWrite` → `_Tstbl_RegWrite`
`RegDelete` → `_Tstbl_RegDelete`
`RegEnumKey` → `_Tstbl_RegEnumKey`
`RegEnumVal` → `_Tstbl_RegEnumVal`

**Shell and Process:**
`ShellExecute` → `_Tstbl_ShellExecute`
`ShellExecuteWait` → `_Tstbl_ShellExecuteWait`
`Run` → `_Tstbl_Run`
`RunWait` → `_Tstbl_RunWait`
`ProcessExists` → `_Tstbl_ProcessExists`
`ProcessClose` → `_Tstbl_ProcessClose`
`ProcessWait` → `_Tstbl_ProcessWait`
`ProcessWaitClose` → `_Tstbl_ProcessWaitClose`
`ProcessList` → `_Tstbl_ProcessList`
`StdoutRead` → `_Tstbl_StdoutRead`
`StderrRead` → `_Tstbl_StderrRead`
`StdinWrite` → `_Tstbl_StdinWrite`

**GUI:**
`GUICreate` → `_Tstbl_GUICreate`
`GUIDelete` → `_Tstbl_GUIDelete`
`GUISetState` → `_Tstbl_GUISetState`
`GUISetBkColor` → `_Tstbl_GUISetBkColor`
`GUISetFont` → `_Tstbl_GUISetFont`
`GUIGetMsg` → `_Tstbl_GUIGetMsg`
`GUISwitch` → `_Tstbl_GUISwitch`
`GUICtrlCreateLabel` → `_Tstbl_GUICtrlCreateLabel`
`GUICtrlCreateButton` → `_Tstbl_GUICtrlCreateButton`
`GUICtrlCreateInput` → `_Tstbl_GUICtrlCreateInput`
`GUICtrlCreateEdit` → `_Tstbl_GUICtrlCreateEdit`
`GUICtrlCreateCheckbox` → `_Tstbl_GUICtrlCreateCheckbox`
`GUICtrlCreateRadio` → `_Tstbl_GUICtrlCreateRadio`
`GUICtrlCreateCombo` → `_Tstbl_GUICtrlCreateCombo`
`GUICtrlCreateList` → `_Tstbl_GUICtrlCreateList`
`GUICtrlCreateListView` → `_Tstbl_GUICtrlCreateListView`
`GUICtrlCreateListViewItem` → `_Tstbl_GUICtrlCreateListViewItem`
`GUICtrlCreateTreeView` → `_Tstbl_GUICtrlCreateTreeView`
`GUICtrlCreateTreeViewItem` → `_Tstbl_GUICtrlCreateTreeViewItem`
`GUICtrlCreateProgress` → `_Tstbl_GUICtrlCreateProgress`
`GUICtrlCreateTab` → `_Tstbl_GUICtrlCreateTab`
`GUICtrlCreateTabItem` → `_Tstbl_GUICtrlCreateTabItem`
`GUICtrlCreateDate` → `_Tstbl_GUICtrlCreateDate`
`GUICtrlCreateUpdown` → `_Tstbl_GUICtrlCreateUpdown`
`GUICtrlCreateGroup` → `_Tstbl_GUICtrlCreateGroup`
`GUICtrlCreateMenu` → `_Tstbl_GUICtrlCreateMenu`
`GUICtrlCreateMenuItem` → `_Tstbl_GUICtrlCreateMenuItem`
`GUICtrlCreateSlider` → `_Tstbl_GUICtrlCreateSlider`
`GUICtrlCreatePic` → `_Tstbl_GUICtrlCreatePic`
`GUICtrlSetState` → `_Tstbl_GUICtrlSetState`
`GUICtrlGetState` → `_Tstbl_GUICtrlGetState`
`GUICtrlSetData` → `_Tstbl_GUICtrlSetData`
`GUICtrlRead` → `_Tstbl_GUICtrlRead`
`GUICtrlDelete` → `_Tstbl_GUICtrlDelete`
`GUICtrlSetFont` → `_Tstbl_GUICtrlSetFont`
`GUICtrlSetColor` → `_Tstbl_GUICtrlSetColor`
`GUICtrlSetBkColor` → `_Tstbl_GUICtrlSetBkColor`
`GUICtrlSetPos` → `_Tstbl_GUICtrlSetPos`
`GUICtrlSetTip` → `_Tstbl_GUICtrlSetTip`

**Network:**
`InetGet` → `_Tstbl_InetGet`
`InetRead` → `_Tstbl_InetRead`
`InetClose` → `_Tstbl_InetClose`
`InetGetSize` → `_Tstbl_InetGetSize`
`Ping` → `_Tstbl_Ping`

**System:**
`Sleep` → `_Tstbl_Sleep`
`Shutdown` → `_Tstbl_Shutdown`
`IsAdmin` → `_Tstbl_IsAdmin`
`EnvGet` → `_Tstbl_EnvGet`
`EnvSet` → `_Tstbl_EnvSet`
`DriveGetDrive` → `_Tstbl_DriveGetDrive`
`DriveGetFileSystem` → `_Tstbl_DriveGetFileSystem`
`DriveSpaceFree` → `_Tstbl_DriveSpaceFree`
`DriveSpaceTotal` → `_Tstbl_DriveSpaceTotal`
`DriveStatus` → `_Tstbl_DriveStatus`
`DriveGetLabel` → `_Tstbl_DriveGetLabel`
`DriveGetType` → `_Tstbl_DriveGetType`
`ConsoleWrite` → `_Tstbl_ConsoleWrite`
`ConsoleWriteError` → `_Tstbl_ConsoleWriteError`

**Clipboard:**
`ClipGet` → `_Tstbl_ClipGet`
`ClipPut` → `_Tstbl_ClipPut`

**Input:**
`Send` → `_Tstbl_Send`
`MouseClick` → `_Tstbl_MouseClick`
`MouseMove` → `_Tstbl_MouseMove`
`MouseGetPos` → `_Tstbl_MouseGetPos`
`ControlClick` → `_Tstbl_ControlClick`
`ControlSetText` → `_Tstbl_ControlSetText`
`ControlGetText` → `_Tstbl_ControlGetText`
`ControlSend` → `_Tstbl_ControlSend`
`ControlFocus` → `_Tstbl_ControlFocus`

**Window Management:**
`WinExists` → `_Tstbl_WinExists`
`WinActive` → `_Tstbl_WinActive`
`WinActivate` → `_Tstbl_WinActivate`
`WinWait` → `_Tstbl_WinWait`
`WinWaitActive` → `_Tstbl_WinWaitActive`
`WinWaitClose` → `_Tstbl_WinWaitClose`
`WinClose` → `_Tstbl_WinClose`
`WinKill` → `_Tstbl_WinKill`
`WinGetText` → `_Tstbl_WinGetText`
`WinGetTitle` → `_Tstbl_WinGetTitle`
`WinGetState` → `_Tstbl_WinGetState`
`WinSetState` → `_Tstbl_WinSetState`
`WinSetTitle` → `_Tstbl_WinSetTitle`
`WinMove` → `_Tstbl_WinMove`
`WinGetPos` → `_Tstbl_WinGetPos`

**Splash and Progress:**
`SplashTextOn` → `_Tstbl_SplashTextOn`
`SplashImageOn` → `_Tstbl_SplashImageOn`
`SplashOff` → `_Tstbl_SplashOff`
`ProgressOn` → `_Tstbl_ProgressOn`
`ProgressSet` → `_Tstbl_ProgressSet`
`ProgressOff` → `_Tstbl_ProgressOff`

**Sound:**
`SoundPlay` → `_Tstbl_SoundPlay`

**Tray:**
`TrayTip` → `_Tstbl_TrayTip`
`TrayGetMsg` → `_Tstbl_TrayGetMsg`
`TrayCreateItem` → `_Tstbl_TrayCreateItem`
`TrayCreateMenu` → `_Tstbl_TrayCreateMenu`
`TrayItemSetState` → `_Tstbl_TrayItemSetState`
`TrayItemSetText` → `_Tstbl_TrayItemSetText`
`TrayItemGetState` → `_Tstbl_TrayItemGetState`
`TrayItemGetText` → `_Tstbl_TrayItemGetText`

### Structural changes

**Add `#include <Testable.au3>`** if not already present. Place it after any existing
AutoIt standard library includes (`#include <...>`) and before the first function
declaration.

**Add the entry point guard** if the script has a top-level entry point call (`_Main()` or
any direct call at script level). The guard prevents test files from executing the script
when they include it:

```autoit
If Not IsDeclared("__TFW_TEST_MODE") Then
    _Main()
EndIf
```

Use `$__TFW_TEST_MODE` as the sentinel — this is the same variable declared automatically
by `TestFramework.au3`, so including a test file in the same suite just works with no
additional setup.

**Replace `#RequireAdmin`** with `#pragma compile(ExecLevel, requireAdministrator)` if
present. `#RequireAdmin` triggers a UAC prompt at interpreted runtime which breaks test
execution; the pragma applies only to the compiled exe.

### FileInstall — special handling required

`FileInstall` requires a wrapper pattern because AutoIt requires its first argument to be a
literal string at compile time — it cannot be passed through a function pointer like other
built-ins.

When `FileInstall(...)` calls are found:

1. Collect all literal source paths from every `FileInstall()` call in the script.
2. Generate a `__FileInstall` wrapper function with a `Select` block where each `Case`
   matches one source path and calls `FileInstall()` with that literal:

```autoit
Func __FileInstall($sSource, $sDest, $iFlag)
    Select
        Case $sSource = "path\to\file1.dat"
            FileInstall("path\to\file1.dat", $sDest, $iFlag)
        Case $sSource = "path\to\file2.dat"
            FileInstall("path\to\file2.dat", $sDest, $iFlag)
    EndSelect
EndFunc
```

3. Add `_Tstbl_Implement_FileInstall(__FileInstall)` at script level immediately after the
   `__FileInstall` function definition.
4. Replace all `FileInstall(...)` calls in the script body with `_Tstbl_FileInstall(...)`.

Include a clear explanation in the audit report so the user understands why this pattern
was generated.

### What to skip

- Calls inside comments
- Built-in names appearing inside string literals
- `FileInstall` is NOT skipped — it is always converted using the wrapper pattern above

## Rules — never break these

- Always read the entire file before starting. Never convert based on a partial read.
- Always preserve the original logic, parameters, and return value handling exactly.
  The only change to built-in calls is the function name.
- Default to interactive mode. Never modify files without confirmation unless approved
  mode is explicitly active.
- Always use `$__TFW_TEST_MODE` as the entry point guard sentinel — never a per-file name.
- Always convert `FileInstall` using the wrapper pattern. Never leave raw `FileInstall()`
  calls in a converted script.
- When called by the autoit-testframework skill, return the audit result so that skill can
  decide whether to prompt the user before proceeding with test generation.
- In approved mode, apply all changes and produce the full summary — never partial.
