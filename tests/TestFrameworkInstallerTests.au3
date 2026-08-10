; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFrameworkInstallerTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for TestFrameworkInstaller.au3.
;                  Uses Stubs.au3 to intercept all AutoIt built-in calls so no real GUI
;                  is created, no files are written, and no registry entries are touched.
;                  FileInstall is stubbed via the testable wrapper registered by the
;                  installer through _Tstbl_Implement_FileInstall(), so literal FileInstall
;                  calls stay visible to Aut2Exe for embedding while remaining stubbable.
;                  Wizard flow tests drive the event loop by stubbing GUIGetMsg to return
;                  scripted button events. Exit is stubbed to break the loop without
;                  terminating the test run.
; ===============================================================================================================================
Global $__INSTALLER_TEST_MODE = True
#include "..\src\core\TestFramework.au3"
#include "..\src\core\StubConstants.au3"
#include "..\src\installer\TestFrameworkInstaller.au3"

; ===============================================================================================================================
; Tests - __DetectPaths
; ===============================================================================================================================
Func _TestDetectPaths_FromWOWRegistry()
    _TestFmkHeader("Test: __DetectPaths() - reads from WOW registry key")
    _SetStubReturn("RegRead", 1, "C:\AutoIt3")
    __DetectPaths()
    _TestFmkAssert($g_sIncludePath = "C:\AutoIt3\Include\Vendor", _
        "IncludePath built from WOW registry", $g_sIncludePath, "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\AutoIt3\TestFramework", _
        "ChmPath built from WOW registry", $g_sChmPath, "C:\AutoIt3\TestFramework")
EndFunc

Func _TestDetectPaths_FallsBackToNormalRegistry()
    _TestFmkHeader("Test: __DetectPaths() - falls back to normal registry key when WOW missing")
    _SetStubReturn("RegRead", 1, $STUB_ERROR)
    _SetStubReturn("RegRead", 2, "C:\CustomAutoIt")
    __DetectPaths()
    _TestFmkAssert($g_sIncludePath = "C:\CustomAutoIt\Include\Vendor", _
        "IncludePath built from normal registry", $g_sIncludePath, "C:\CustomAutoIt\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\CustomAutoIt\TestFramework", _
        "ChmPath built from normal registry", $g_sChmPath, "C:\CustomAutoIt\TestFramework")
EndFunc

Func _TestDetectPaths_FallsBackToDefault()
    _TestFmkHeader("Test: __DetectPaths() - falls back to default when registry missing")
    _SetStubReturn("RegRead", 1, $STUB_ERROR)
    _SetStubReturn("RegRead", 2, $STUB_ERROR)
    __DetectPaths()
    _TestFmkAssert($g_sIncludePath = "C:\Program Files (x86)\AutoIt3\Include\Vendor", _
        "IncludePath defaults when registry missing", $g_sIncludePath, "C:\Program Files (x86)\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\Program Files (x86)\AutoIt3\TestFramework", _
        "ChmPath defaults when registry missing", $g_sChmPath, "C:\Program Files (x86)\AutoIt3\TestFramework")
EndFunc

; ===============================================================================================================================
; Tests - __CheckExistingInstall
; ===============================================================================================================================
Func _TestCheckExistingInstall_FreshInstall()
    _TestFmkHeader("Test: __CheckExistingInstall() - fresh install when registry missing")
    _SetStubReturn("RegRead", 1, $STUB_ERROR)
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = False, "Fresh install detected", $g_bIsUpgrade, False)
EndFunc

Func _TestCheckExistingInstall_EmptyVersionIsFresh()
    _TestFmkHeader("Test: __CheckExistingInstall() - empty version string is fresh install")
    _SetStubReturn("RegRead", 1, "")
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = False, "Empty version treated as fresh install", $g_bIsUpgrade, False)
EndFunc

Func _TestCheckExistingInstall_Upgrade()
    _TestFmkHeader("Test: __CheckExistingInstall() - upgrade detected")
    _SetStubReturn("RegRead", 1, $INSTALLER_VERSION)
    _SetStubReturn("RegRead", 2, $STUB_ERROR)
    _SetStubReturn("RegRead", 3, $STUB_ERROR)
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = True, "Upgrade detected", $g_bIsUpgrade, True)
EndFunc

Func _TestCheckExistingInstall_UpgradeOverridesPaths()
    _TestFmkHeader("Test: __CheckExistingInstall() - existing paths override detected paths")
    $g_sIncludePath = "C:\Detected\Include\Vendor"
    $g_sChmPath     = "C:\Detected\TestFramework"
    _SetStubReturn("RegRead",    1, $INSTALLER_VERSION)
    _SetStubReturn("RegRead",    2, "C:\Existing\Include\Vendor")
    _SetStubReturn("RegRead",    3, "C:\Existing\TestFramework")
    _SetStubReturn("FileExists", 1, True)
    _SetStubReturn("FileExists", 2, True)
    __CheckExistingInstall()
    _TestFmkAssert($g_sIncludePath = "C:\Existing\Include\Vendor", _
        "IncludePath overridden by existing", $g_sIncludePath, "C:\Existing\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\Existing\TestFramework", _
        "ChmPath overridden by existing", $g_sChmPath, "C:\Existing\TestFramework")
EndFunc

Func _TestCheckExistingInstall_UpgradeKeepsPathsWhenExistingMissing()
    _TestFmkHeader("Test: __CheckExistingInstall() - keeps detected paths when existing folders missing")
    $g_sIncludePath = "C:\Detected\Include\Vendor"
    $g_sChmPath     = "C:\Detected\TestFramework"
    _SetStubReturn("RegRead",    1, $INSTALLER_VERSION)
    _SetStubReturn("RegRead",    2, "C:\Existing\Include\Vendor")
    _SetStubReturn("RegRead",    3, "C:\Existing\TestFramework")
    _SetStubReturn("FileExists", 1, False)
    _SetStubReturn("FileExists", 2, False)
    __CheckExistingInstall()
    _TestFmkAssert($g_sIncludePath = "C:\Detected\Include\Vendor", _
        "IncludePath kept when existing missing", $g_sIncludePath, "C:\Detected\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\Detected\TestFramework", _
        "ChmPath kept when existing missing", $g_sChmPath, "C:\Detected\TestFramework")
EndFunc

; ===============================================================================================================================
; Tests - __WriteIncludeRegistry
; ===============================================================================================================================
Func _TestWriteIncludeRegistry_EmptyExisting()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - writes path when no existing value")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "")
    __WriteIncludeRegistry()
    _TestFmkAssert(_StubCallCount("RegWrite") = 1, "Writes one registry entry", _StubCallCount("RegWrite"), 1)
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_Value) = "C:\AutoIt3\Include\Vendor", _
        "Writes correct path", _StubCall("RegWrite", $_1st, $Param_Value), "C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_ErrorTreatedAsEmpty()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - RegRead error treated as empty")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, $STUB_ERROR)
    __WriteIncludeRegistry()
    _TestFmkAssert(_StubCallCount("RegWrite") = 1, "Writes one registry entry on error", _StubCallCount("RegWrite"), 1)
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_Value) = "C:\AutoIt3\Include\Vendor", _
        "Writes correct path on error", _StubCall("RegWrite", $_1st, $Param_Value), "C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_AppendsToExisting()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - appends to existing paths")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\OtherLib")
    __WriteIncludeRegistry()
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_Value) = "C:\OtherLib;C:\AutoIt3\Include\Vendor", _
        "Appends with semicolon", _StubCall("RegWrite", $_1st, $Param_Value), "C:\OtherLib;C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_SkipsIfAlreadyRegistered()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - skips when already registered")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\AutoIt3\Include\Vendor")
    __WriteIncludeRegistry()
    _TestFmkAssert(_StubCallCount("RegWrite") = 0, "Does not write when already registered", _StubCallCount("RegWrite"), 0)
EndFunc

; ===============================================================================================================================
; Tests - __WriteInstallRegistry
; ===============================================================================================================================
Func _TestWriteInstallRegistry_WritesAllKeys()
    _TestFmkHeader("Test: __WriteInstallRegistry() - writes version and paths")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __WriteInstallRegistry()
    _TestFmkAssert(_StubCallCount("RegWrite") = 3, "Writes three registry entries", _StubCallCount("RegWrite"), 3)
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_ValueName) = "Version", "Writes Version key", _StubCall("RegWrite", $_1st, $Param_ValueName), "Version")
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_Value) = $INSTALLER_VERSION, "Version value correct", _StubCall("RegWrite", $_1st, $Param_Value), $INSTALLER_VERSION)
    _TestFmkAssert(_StubCall("RegWrite", $_2nd, $Param_ValueName) = "IncludePath", "Writes IncludePath key", _StubCall("RegWrite", $_2nd, $Param_ValueName), "IncludePath")
    _TestFmkAssert(_StubCall("RegWrite", $_2nd, $Param_Value) = "C:\AutoIt3\Include\Vendor", "IncludePath value correct", _StubCall("RegWrite", $_2nd, $Param_Value), "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert(_StubCall("RegWrite", $_3rd, $Param_ValueName) = "ChmPath", "Writes ChmPath key", _StubCall("RegWrite", $_3rd, $Param_ValueName), "ChmPath")
    _TestFmkAssert(_StubCall("RegWrite", $_3rd, $Param_Value) = "C:\AutoIt3\TestFramework", "ChmPath value correct", _StubCall("RegWrite", $_3rd, $Param_Value), "C:\AutoIt3\TestFramework")
EndFunc

; ===============================================================================================================================
; Tests - __WriteUninstallRegistry
; ===============================================================================================================================
Func _TestWriteUninstallRegistry_WritesAllKeys()
    _TestFmkHeader("Test: __WriteUninstallRegistry() - writes all uninstall keys")
    $g_sChmPath = "C:\AutoIt3\TestFramework"
    __WriteUninstallRegistry()
    _TestFmkAssert(_StubCallCount("RegWrite") = 5, "Writes five registry entries", _StubCallCount("RegWrite"), 5)
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_ValueName) = "DisplayName", "Writes DisplayName key", _StubCall("RegWrite", $_1st, $Param_ValueName), "DisplayName")
    _TestFmkAssert(_StubCall("RegWrite", $_1st, $Param_Value) = "AutoIt Test Framework", "DisplayName value correct", _StubCall("RegWrite", $_1st, $Param_Value), "AutoIt Test Framework")
    _TestFmkAssert(_StubCall("RegWrite", $_2nd, $Param_ValueName) = "DisplayVersion", "Writes DisplayVersion key", _StubCall("RegWrite", $_2nd, $Param_ValueName), "DisplayVersion")
    _TestFmkAssert(_StubCall("RegWrite", $_2nd, $Param_Value) = $INSTALLER_VERSION, "DisplayVersion value correct", _StubCall("RegWrite", $_2nd, $Param_Value), $INSTALLER_VERSION)
    _TestFmkAssert(_StubCall("RegWrite", $_3rd, $Param_ValueName) = "Publisher", "Writes Publisher key", _StubCall("RegWrite", $_3rd, $Param_ValueName), "Publisher")
    _TestFmkAssert(_StubCall("RegWrite", $_4th, $Param_ValueName) = "UninstallString", "Writes UninstallString key", _StubCall("RegWrite", $_4th, $Param_ValueName), "UninstallString")
    _TestFmkAssert(_StubCall("RegWrite", $_4th, $Param_Value) = '"C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe"', _
        "UninstallString is quoted path", _StubCall("RegWrite", $_4th, $Param_Value), '"C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe"')
    _TestFmkAssert(_StubCall("RegWrite", $_5th, $Param_ValueName) = "NoModify", "Writes NoModify key", _StubCall("RegWrite", $_5th, $Param_ValueName), "NoModify")
    _TestFmkAssert(_StubCall("RegWrite", $_5th, $Param_Value) = 1, "NoModify value correct", _StubCall("RegWrite", $_5th, $Param_Value), 1)
EndFunc

; ===============================================================================================================================
; Tests - __RunInstall
; ===============================================================================================================================
Func _TestRunInstall_CreatesFolders()
    _TestFmkHeader("Test: __RunInstall() - creates install folders")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __RunInstall(1, 2)
    _TestFmkAssert(_StubCallCount("DirCreate") = 2, "Creates two folders", _StubCallCount("DirCreate"), 2)
    _TestFmkAssert(_StubCall("DirCreate", $_1st, $Param_Path) = "C:\AutoIt3\Include\Vendor", _
        "Creates include folder", _StubCall("DirCreate", $_1st, $Param_Path), "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert(_StubCall("DirCreate", $_2nd, $Param_Path) = "C:\AutoIt3\TestFramework", _
        "Creates CHM folder", _StubCall("DirCreate", $_2nd, $Param_Path), "C:\AutoIt3\TestFramework")
EndFunc

Func _TestRunInstall_InstallsAllFiles()
    _TestFmkHeader("Test: __RunInstall() - installs all expected files")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __RunInstall(1, 2)
    ; Total: 1 TestFramework + 16 Testable + 17 Stubs + 1 chm + 1 uninstaller = 36
    _TestFmkAssert(_StubCallCount("FileInstall") = 36, "Installs 36 files total", _StubCallCount("FileInstall"), 36)
    ; TestFramework.au3
    _TestFmkAssert(_StubCall("FileInstall", 1,  $Param_Source) = "..\core\TestFramework.au3", "Installs TestFramework.au3 source", _StubCall("FileInstall", $_1st, $Param_Source), "..\core\TestFramework.au3")
    _TestFmkAssert(_StubCall("FileInstall", 1,  $Param_Dest)   = "C:\AutoIt3\Include\Vendor\TestFramework.au3", "Installs TestFramework.au3 dest", _StubCall("FileInstall", $_1st, $Param_Dest), "C:\AutoIt3\Include\Vendor\TestFramework.au3")
    ; Testable library
    _TestFmkAssert(_StubCall("FileInstall", 2,  $Param_Source) = "..\core\Testable.au3",             "Installs Testable.au3",             _StubCall("FileInstall", 2,  $Param_Source), "..\core\Testable.au3")
    _TestFmkAssert(_StubCall("FileInstall", 3,  $Param_Source) = "..\core\Testable_Clipboard.au3",   "Installs Testable_Clipboard.au3",   _StubCall("FileInstall", 3,  $Param_Source), "..\core\Testable_Clipboard.au3")
    _TestFmkAssert(_StubCall("FileInstall", 4,  $Param_Source) = "..\core\Testable_Dialogs.au3",     "Installs Testable_Dialogs.au3",     _StubCall("FileInstall", 4,  $Param_Source), "..\core\Testable_Dialogs.au3")
    _TestFmkAssert(_StubCall("FileInstall", 5,  $Param_Source) = "..\core\Testable_FileInstall.au3", "Installs Testable_FileInstall.au3", _StubCall("FileInstall", 5,  $Param_Source), "..\core\Testable_FileInstall.au3")
    _TestFmkAssert(_StubCall("FileInstall", 6,  $Param_Source) = "..\core\Testable_FileSystem.au3",  "Installs Testable_FileSystem.au3",  _StubCall("FileInstall", 6,  $Param_Source), "..\core\Testable_FileSystem.au3")
    _TestFmkAssert(_StubCall("FileInstall", 7,  $Param_Source) = "..\core\Testable_GUI.au3",         "Installs Testable_GUI.au3",         _StubCall("FileInstall", 7,  $Param_Source), "..\core\Testable_GUI.au3")
    _TestFmkAssert(_StubCall("FileInstall", 8,  $Param_Source) = "..\core\Testable_Ini.au3",         "Installs Testable_Ini.au3",         _StubCall("FileInstall", 8,  $Param_Source), "..\core\Testable_Ini.au3")
    _TestFmkAssert(_StubCall("FileInstall", 9,  $Param_Source) = "..\core\Testable_Input.au3",       "Installs Testable_Input.au3",       _StubCall("FileInstall", 9,  $Param_Source), "..\core\Testable_Input.au3")
    _TestFmkAssert(_StubCall("FileInstall", 10, $Param_Source) = "..\core\Testable_Network.au3",     "Installs Testable_Network.au3",     _StubCall("FileInstall", 10, $Param_Source), "..\core\Testable_Network.au3")
    _TestFmkAssert(_StubCall("FileInstall", 11, $Param_Source) = "..\core\Testable_Process.au3",     "Installs Testable_Process.au3",     _StubCall("FileInstall", 11, $Param_Source), "..\core\Testable_Process.au3")
    _TestFmkAssert(_StubCall("FileInstall", 12, $Param_Source) = "..\core\Testable_Registry.au3",    "Installs Testable_Registry.au3",    _StubCall("FileInstall", 12, $Param_Source), "..\core\Testable_Registry.au3")
    _TestFmkAssert(_StubCall("FileInstall", 13, $Param_Source) = "..\core\Testable_Sound.au3",       "Installs Testable_Sound.au3",       _StubCall("FileInstall", 13, $Param_Source), "..\core\Testable_Sound.au3")
    _TestFmkAssert(_StubCall("FileInstall", 14, $Param_Source) = "..\core\Testable_Splash.au3",      "Installs Testable_Splash.au3",      _StubCall("FileInstall", 14, $Param_Source), "..\core\Testable_Splash.au3")
    _TestFmkAssert(_StubCall("FileInstall", 15, $Param_Source) = "..\core\Testable_System.au3",      "Installs Testable_System.au3",      _StubCall("FileInstall", 15, $Param_Source), "..\core\Testable_System.au3")
    _TestFmkAssert(_StubCall("FileInstall", 16, $Param_Source) = "..\core\Testable_Tray.au3",        "Installs Testable_Tray.au3",        _StubCall("FileInstall", 16, $Param_Source), "..\core\Testable_Tray.au3")
    _TestFmkAssert(_StubCall("FileInstall", 17, $Param_Source) = "..\core\Testable_Window.au3",      "Installs Testable_Window.au3",      _StubCall("FileInstall", 17, $Param_Source), "..\core\Testable_Window.au3")
    ; Stubs library
    _TestFmkAssert(_StubCall("FileInstall", 18, $Param_Source) = "..\core\Stubs.au3",             "Installs Stubs.au3",             _StubCall("FileInstall", 18, $Param_Source), "..\core\Stubs.au3")
    _TestFmkAssert(_StubCall("FileInstall", 19, $Param_Source) = "..\core\Stubs_Core.au3",        "Installs Stubs_Core.au3",        _StubCall("FileInstall", 19, $Param_Source), "..\core\Stubs_Core.au3")
    _TestFmkAssert(_StubCall("FileInstall", 20, $Param_Source) = "..\core\Stubs_Clipboard.au3",   "Installs Stubs_Clipboard.au3",   _StubCall("FileInstall", 20, $Param_Source), "..\core\Stubs_Clipboard.au3")
    _TestFmkAssert(_StubCall("FileInstall", 21, $Param_Source) = "..\core\Stubs_Dialogs.au3",     "Installs Stubs_Dialogs.au3",     _StubCall("FileInstall", 21, $Param_Source), "..\core\Stubs_Dialogs.au3")
    _TestFmkAssert(_StubCall("FileInstall", 22, $Param_Source) = "..\core\Stubs_FileInstall.au3", "Installs Stubs_FileInstall.au3", _StubCall("FileInstall", 22, $Param_Source), "..\core\Stubs_FileInstall.au3")
    _TestFmkAssert(_StubCall("FileInstall", 23, $Param_Source) = "..\core\Stubs_FileSystem.au3",  "Installs Stubs_FileSystem.au3",  _StubCall("FileInstall", 23, $Param_Source), "..\core\Stubs_FileSystem.au3")
    _TestFmkAssert(_StubCall("FileInstall", 24, $Param_Source) = "..\core\Stubs_GUI.au3",         "Installs Stubs_GUI.au3",         _StubCall("FileInstall", 24, $Param_Source), "..\core\Stubs_GUI.au3")
    _TestFmkAssert(_StubCall("FileInstall", 25, $Param_Source) = "..\core\Stubs_Ini.au3",         "Installs Stubs_Ini.au3",         _StubCall("FileInstall", 25, $Param_Source), "..\core\Stubs_Ini.au3")
    _TestFmkAssert(_StubCall("FileInstall", 26, $Param_Source) = "..\core\Stubs_Input.au3",       "Installs Stubs_Input.au3",       _StubCall("FileInstall", 26, $Param_Source), "..\core\Stubs_Input.au3")
    _TestFmkAssert(_StubCall("FileInstall", 27, $Param_Source) = "..\core\Stubs_Network.au3",     "Installs Stubs_Network.au3",     _StubCall("FileInstall", 27, $Param_Source), "..\core\Stubs_Network.au3")
    _TestFmkAssert(_StubCall("FileInstall", 28, $Param_Source) = "..\core\Stubs_Process.au3",     "Installs Stubs_Process.au3",     _StubCall("FileInstall", 28, $Param_Source), "..\core\Stubs_Process.au3")
    _TestFmkAssert(_StubCall("FileInstall", 29, $Param_Source) = "..\core\Stubs_Registry.au3",    "Installs Stubs_Registry.au3",    _StubCall("FileInstall", 29, $Param_Source), "..\core\Stubs_Registry.au3")
    _TestFmkAssert(_StubCall("FileInstall", 30, $Param_Source) = "..\core\Stubs_Sound.au3",       "Installs Stubs_Sound.au3",       _StubCall("FileInstall", 30, $Param_Source), "..\core\Stubs_Sound.au3")
    _TestFmkAssert(_StubCall("FileInstall", 31, $Param_Source) = "..\core\Stubs_Splash.au3",      "Installs Stubs_Splash.au3",      _StubCall("FileInstall", 31, $Param_Source), "..\core\Stubs_Splash.au3")
    _TestFmkAssert(_StubCall("FileInstall", 32, $Param_Source) = "..\core\Stubs_System.au3",      "Installs Stubs_System.au3",      _StubCall("FileInstall", 32, $Param_Source), "..\core\Stubs_System.au3")
    _TestFmkAssert(_StubCall("FileInstall", 33, $Param_Source) = "..\core\Stubs_Tray.au3",        "Installs Stubs_Tray.au3",        _StubCall("FileInstall", 33, $Param_Source), "..\core\Stubs_Tray.au3")
    _TestFmkAssert(_StubCall("FileInstall", 34, $Param_Source) = "..\core\Stubs_Window.au3",      "Installs Stubs_Window.au3",      _StubCall("FileInstall", 34, $Param_Source), "..\core\Stubs_Window.au3")
    ; CHM and uninstaller
    _TestFmkAssert(_StubCall("FileInstall", 35, $Param_Source) = "..\..\chm\TestFramework.chm", "Installs TestFramework.chm src", _StubCall("FileInstall", 35, $Param_Source), "..\..\chm\TestFramework.chm")
    _TestFmkAssert(_StubCall("FileInstall", 35, $Param_Dest)   = "C:\AutoIt3\TestFramework\TestFramework.chm", "Installs TestFramework.chm dest", _StubCall("FileInstall", 35, $Param_Dest), "C:\AutoIt3\TestFramework\TestFramework.chm")
    _TestFmkAssert(_StubCall("FileInstall", 36, $Param_Source) = "..\..\.out\TestFrameworkUninstaller.exe", "Installs TestFrameworkUninstaller.exe src", _StubCall("FileInstall", 36, $Param_Source), "..\..\.out\TestFrameworkUninstaller.exe")
    _TestFmkAssert(_StubCall("FileInstall", 36, $Param_Dest)   = "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe", "Installs TestFrameworkUninstaller.exe dest", _StubCall("FileInstall", 36, $Param_Dest), "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe")
EndFunc

Func _TestRunInstall_ReturnsFalseOnError()
    _TestFmkHeader("Test: __RunInstall() - returns False when an operation fails")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    _SetStubReturn("DirCreate", 1, $STUB_ERROR)
    Local $bResult = __RunInstall(1, 2)
    _TestFmkAssert($bResult = False, "Returns False on install error", $bResult, False)
EndFunc

Func _TestRunInstall_WritesAllRegistryEntries()
    _TestFmkHeader("Test: __RunInstall() - writes all registry entries")
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    _SetStubReturn("RegRead", 1, "")
    __RunInstall(1, 2)
    ; 1 include + 3 install + 5 uninstall = 9 registry writes
    _TestFmkAssert(_StubCallCount("RegWrite") = 9, "Writes nine registry entries total", _StubCallCount("RegWrite"), 9)
EndFunc

; ===============================================================================================================================
; Tests - __RunWizard
; ===============================================================================================================================
; Control IDs configured via _SetStubReturn so the event loop Switch matches correctly:
;   GUICtrlCreateLabel  3 = HeaderSub   (ID 20)
;   GUICtrlCreateButton 1 = Cancel      (ID 10)
;   GUICtrlCreateButton 2 = Back        (ID 11)
;   GUICtrlCreateButton 3 = Next        (ID 12)
;   GUICtrlCreateButton 4 = Browse      (ID 13)
;   GUICtrlCreateInput  1 = FolderInput (ID 30)
Global Const $ID_HEADER_SUB   = 20
Global Const $ID_BTN_CANCEL   = 10
Global Const $ID_BTN_BACK     = 11
Global Const $ID_BTN_NEXT     = 12
Global Const $ID_BTN_BROWSE   = 13
Global Const $ID_FOLDER_INPUT = 30

Func __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlCreateLabel",  3, $ID_HEADER_SUB)
    _SetStubReturn("GUICtrlCreateButton", 1, $ID_BTN_CANCEL)
    _SetStubReturn("GUICtrlCreateButton", 2, $ID_BTN_BACK)
    _SetStubReturn("GUICtrlCreateButton", 3, $ID_BTN_NEXT)
    _SetStubReturn("GUICtrlCreateButton", 4, $ID_BTN_BROWSE)
    _SetStubReturn("GUICtrlCreateInput",  1, $ID_FOLDER_INPUT)
EndFunc

Func __GetHeaderSubData($iCallIdx)
    Local $iFound = 0
    For $i = 1 To _StubCallCount("GUICtrlSetData")
        If _StubCall("GUICtrlSetData", $i, $Param_ControlId) = $ID_HEADER_SUB Then
            $iFound += 1
            If $iFound = $iCallIdx Then Return _StubCall("GUICtrlSetData", $i, $Param_Data)
        EndIf
    Next
    Return ""
EndFunc

; ===============================================================================================================================
; Tests - Next button
; ====================
Func _TestWizard_NextFromPage1GoesToPage2()
    _TestFmkHeader("Test: __RunWizard() - Next from page 1 goes to page 2")
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg", 2, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    1, $IDYES)
    __RunWizard()
    _TestFmkAssert(__GetHeaderSubData(2) = "Choose install folder", _
        "Header shows page 2", __GetHeaderSubData(2), "Choose install folder")
EndFunc

Func _TestWizard_NextFromPage2GoesToPage3()
    _TestFmkHeader("Test: __RunWizard() - Next from page 2 goes to page 3")
    __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",      1, $IDYES)
    __RunWizard()
    _TestFmkAssert(__GetHeaderSubData(3) = "Ready to install", _
        "Header shows page 3", __GetHeaderSubData(3), "Ready to install")
EndFunc

Func _TestWizard_NextFromPage2UpdatesIncludePath()
    _TestFmkHeader("Test: __RunWizard() - Next from page 2 reads folder input into g_sIncludePath")
    __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlRead", 1, "C:\CustomPath\Include")
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",      1, $IDYES)
    __RunWizard()
    _TestFmkAssert($g_sIncludePath = "C:\CustomPath\Include", _
        "IncludePath updated from folder input", $g_sIncludePath, "C:\CustomPath\Include")
EndFunc

; ===============================================================================================================================
; Tests - Back button
; ===============================================================================================================================
Func _TestWizard_BackFromPage2GoesToPage1()
    _TestFmkHeader("Test: __RunWizard() - Back from page 2 goes to page 1")
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg", 2, $ID_BTN_BACK)
    _SetStubReturn("GUIGetMsg", 3, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    1, $IDYES)
    __RunWizard()
    _TestFmkAssert(__GetHeaderSubData(3) = "Welcome to AutoIt Test Framework Setup", _
        "Header shows page 1 after back", __GetHeaderSubData(3), "Welcome to AutoIt Test Framework Setup")
EndFunc

Func _TestWizard_BackFromPage3GoesToPage2()
    _TestFmkHeader("Test: __RunWizard() - Back from page 3 goes to page 2")
    __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_BACK)
    _SetStubReturn("GUIGetMsg",   4, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",      1, $IDYES)
    __RunWizard()
    _TestFmkAssert(__GetHeaderSubData(4) = "Choose install folder", _
        "Header shows page 2 after back", __GetHeaderSubData(4), "Choose install folder")
EndFunc

; ===============================================================================================================================
; Tests - Browse button
; ===============================================================================================================================
Func _TestWizard_BrowseUpdatesInputField()
    _TestFmkHeader("Test: __RunWizard() - Browse button updates folder input")
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg",        1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",        2, $ID_BTN_BROWSE)
    _SetStubReturn("FileSelectFolder", 1, "C:\NewPath")
    _SetStubReturn("GUIGetMsg",        3, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",           1, $IDYES)
    __RunWizard()
    Local $bFound = False
    For $i = 1 To _StubCallCount("GUICtrlSetData")
        If _StubCall("GUICtrlSetData", $i, $Param_ControlId) = $ID_FOLDER_INPUT And _
           _StubCall("GUICtrlSetData", $i, $Param_Data) = "C:\NewPath" Then
            $bFound = True
            ExitLoop
        EndIf
    Next
    _TestFmkAssert($bFound, "Folder input updated with selected path", $bFound, True)
EndFunc

; ===============================================================================================================================
; Tests - Cancel Installation
; ===============================================================================================================================
Func _TestWizard_CancelConfirmed_ClosesWizard()
    _TestFmkHeader("Test: __RunWizard() - Cancel confirmed closes the wizard")
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    1, $IDYES)
    __RunWizard()
    _TestFmkAssert(_StubCallCount("GUIDelete") = 1, "GUIDelete called on confirmed cancel", _StubCallCount("GUIDelete"), 1)
EndFunc

Func _TestWizard_CancelDeclined_KeepsWizardOpen()
    _TestFmkHeader("Test: __RunWizard() - Cancel declined keeps wizard open")
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    1, $IDNO)
    _SetStubReturn("GUIGetMsg", 2, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    2, $IDYES)
    __RunWizard()
    _TestFmkAssert(_StubCallCount("MsgBox") = 2, "MsgBox shown twice", _StubCallCount("MsgBox"), 2)
    _TestFmkAssert(_StubCallCount("GUIDelete") = 1, "GUIDelete called only on second cancel", _StubCallCount("GUIDelete"), 1)
EndFunc

Func _TestWizard_CancelOnPage4DoesNothing()
    _TestFmkHeader("Test: __RunWizard() - Cancel on page 4 does nothing")
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("GUICtrlRead", 2, $GUI_UNCHECKED)
    _SetStubReturn("RegRead",     1, "")
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   4, $ID_BTN_CANCEL)
    _SetStubReturn("GUIGetMsg",   5, $ID_BTN_NEXT)
    __RunWizard()
    _TestFmkAssert(_StubCallCount("MsgBox") = 0, "No MsgBox shown on page 4/5 cancel", _StubCallCount("MsgBox"), 0)
EndFunc

Func _TestWizard_InstallFailureShowsErrorMessage()
    _TestFmkHeader("Test: __RunWizard() - shows error message when install fails")
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("MsgBox",      1, $IDOK)
    _SetStubReturn("GUICtrlRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("DirCreate",   1, $STUB_ERROR)
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_NEXT)
    __RunWizard()
    _TestFmkAssert(_StubCallCount("MsgBox") = 1, "Error MsgBox shown", _StubCallCount("MsgBox"), 1)
    _TestFmkAssert(_StubCallCount("GUIDelete") = 1, "GUIDelete called after failure", _StubCallCount("GUIDelete"), 1)
EndFunc

; ===============================================================================================================================
; Run all tests
; ===============================================================================================================================
Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FromWOWRegistry,                              $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FallsBackToNormalRegistry,                    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FallsBackToDefault,                           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_FreshInstall,                        $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_EmptyVersionIsFresh,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_Upgrade,                             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_UpgradeOverridesPaths,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_UpgradeKeepsPathsWhenExistingMissing,$bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_EmptyExisting,                       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_ErrorTreatedAsEmpty,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_AppendsToExisting,                   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_SkipsIfAlreadyRegistered,            $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteInstallRegistry_WritesAllKeys,                       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteUninstallRegistry_WritesAllKeys,                     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_CreatesFolders,                                $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_InstallsAllFiles,                              $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_ReturnsFalseOnError,                           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_WritesAllRegistryEntries,                      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage1GoesToPage2,                          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage2GoesToPage3,                          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage2UpdatesIncludePath,                   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BackFromPage2GoesToPage1,                          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BackFromPage3GoesToPage2,                          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BrowseUpdatesInputField,                           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelConfirmed_ClosesWizard,                      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelDeclined_KeepsWizardOpen,                    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelOnPage4DoesNothing,                          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_InstallFailureShowsErrorMessage,                   $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc
_RunAllTests()
