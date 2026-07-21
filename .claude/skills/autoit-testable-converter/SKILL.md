---
name: autoit-testable-converter
description: Audits, suggests, or converts AutoIt scripts to use _Tstbl_* testable wrappers from Testable.au3, making them compatible with the AutoIt Test Framework testable/stubs pattern. Use this skill when the user wants to make an AutoIt script testable, convert raw AutoIt built-in calls to testable wrappers, refactor a script for unit testing, or migrate existing code to use Testable.au3. Also used automatically by the autoit-testframework skill when it detects raw built-in calls in code the user wants to test. Triggers on phrases like "make this testable", "convert to testable", "refactor for testing", "migrate to testable wrappers", "I want to add tests to this script", or when an existing .au3 file is shared and contains raw calls to built-ins that require user interaction or return values that affect program flow (MsgBox, FileExists, FileDelete, RegRead, GUICreate, ShellExecute, etc.).
---

# AutoIt Testable Converter Skill

Audits AutoIt scripts for raw built-in calls that require user interaction or return values
that affect program flow, and converts them to use the Testable.au3 wrapper pattern, making
the script compatible with the AutoIt Test Framework testable/stubs pattern.

## Core principle

Never modify files without explicit user permission. Default to audit or suggest mode unless
the user explicitly asks to apply changes. When in convert mode, show a clear summary of
every change made.

## Modes

### Interactive mode (default)

Report what was found without changing anything. Produce a structured report:

- Which raw built-in calls were found and on which lines
- Which have a `_Tstbl_*` equivalent available
- Whether `#include <Testable.au3>` is already present
- Whether the entry point guard (`If Not IsDeclared(...)`) is already present
- Whether `#RequireAdmin` is present and should be replaced with `#pragma compile`
- A summary of what would change if approved mode were run

Always end the report with a clear prompt asking whether the user wants to apply the changes,
or how to enable approved mode for autonomous use.

### Approved mode

Apply all changes - both modifying existing files and creating new files - without stopping
to ask for per-action confirmation. The user has already granted blanket permission for the
session upfront.

Approved mode is active when any of the following are true:

- The user explicitly says something like "apply the changes", "convert the file",
  "go ahead and make the changes", "approved mode", or similar in the conversation
- The task description or agent instruction contains explicit permission such as
  "you have permission to modify files", "apply all changes", or similar
- The skill is invoked with an environment variable or agent flag such as
  `AUTOIT_CONVERTER_APPROVED=true`
- The orchestrating agent has set approved mode in the task context

When converting in approved mode, always produce a summary of every change applied:
- Files modified
- Files created
- Number of built-in calls replaced
- Whether `#include <Testable.au3>` was added
- Whether the entry point guard was added
- Whether `#pragma compile` replaced `#RequireAdmin`

### Suggest mode

Produce an annotated version of the file showing proposed changes inline as comments,
without modifying the original:

```autoit
; SUGGEST: replace with _Tstbl_MsgBox(...)
MsgBox($MB_OK, "Title", "Text")
```

Or produce a before/after diff showing exactly what would change. Suggest mode is useful
when the user wants to review changes before committing to approved mode.

## What to detect and convert

### Built-in calls with _Tstbl_* equivalents

Scan for raw calls to any of the following and replace with the `_Tstbl_*` equivalent.
The wrapper accepts exactly the same parameters - only the function name changes.

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

### Additional changes to apply

Beyond replacing built-in calls, also apply these structural changes:

**Add `#include <Testable.au3>`** if not already present, after any existing AutoIt
standard library includes and before the first function declaration.

**Add the entry point guard** if the script has a top-level entry point call (e.g. `_Main()`
or a direct call at script level). The guard allows test files to include the script without
executing it:

```autoit
If Not IsDeclared("__SCRIPTNAME_TEST_MODE") Then
    _Main()
EndIf
```

Name the sentinel after the script filename in uppercase, e.g. for `MyInstaller.au3` use
`$__MYINSTALLER_TEST_MODE`.

**Replace `#RequireAdmin`** with `#pragma compile(ExecLevel, requireAdministrator)` if
present. `#RequireAdmin` triggers a UAC prompt at interpreted runtime which breaks test
execution; the pragma applies only to the compiled exe.

### What NOT to convert

- `FileInstall` - requires special handling. See the FileInstall Special Case in the
  AutoIt Test Framework documentation. Flag it in the audit report but do not attempt
  to convert it automatically.
- Calls that are already using `_Tstbl_*` wrappers - skip these.
- Calls inside comments - skip these.
- String literals that happen to contain built-in names - skip these.

## Rules

- Default to interactive mode unless approved mode is explicitly active.
- Never convert `FileInstall` - always flag it and direct the user to the documentation.
- Always preserve the original logic, parameters, and return value handling exactly.
  The only change is the function name prefix.
- In interactive mode, always end with a clear prompt asking whether the user wants to
  apply the changes or enable approved mode.
- When called by the autoit-testframework skill, return the audit result so the main skill
  can decide whether to prompt the user before proceeding with test generation.
- In approved mode, proceed with all changes without per-action confirmation, then produce
  a full summary of everything that was changed.
