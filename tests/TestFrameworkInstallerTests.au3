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
#include "..\src\core\Stubs.au3"
#include "..\src\installer\TestFrameworkInstaller.au3"

; ===============================================================================================================================
; Tests - __DetectPaths
; ===============================================================================================================================
Func _TestDetectPaths_FromWOWRegistry()
    _TestFmkHeader("Test: __DetectPaths() - reads from WOW registry key")
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "C:\AutoIt3")
    __DetectPaths()
    _TestFmkAssert($g_sIncludePath = "C:\AutoIt3\Include\Vendor", _
        "IncludePath built from WOW registry", $g_sIncludePath, "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\AutoIt3\TestFramework", _
        "ChmPath built from WOW registry", $g_sChmPath, "C:\AutoIt3\TestFramework")
EndFunc

Func _TestDetectPaths_FallsBackToNormalRegistry()
    _TestFmkHeader("Test: __DetectPaths() - falls back to normal registry key when WOW missing")
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")
    _SetStubReturn("RegRead", 2, "C:\CustomAutoIt")
    __DetectPaths()
    _TestFmkAssert($g_sIncludePath = "C:\CustomAutoIt\Include\Vendor", _
        "IncludePath built from normal registry", $g_sIncludePath, "C:\CustomAutoIt\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\CustomAutoIt\TestFramework", _
        "ChmPath built from normal registry", $g_sChmPath, "C:\CustomAutoIt\TestFramework")
EndFunc

Func _TestDetectPaths_FallsBackToDefault()
    _TestFmkHeader("Test: __DetectPaths() - falls back to default when registry missing")
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")
    _SetStubReturn("RegRead", 2, "__ERROR__")
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
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = False, "Fresh install detected", $g_bIsUpgrade, False)
EndFunc

Func _TestCheckExistingInstall_EmptyVersionIsFresh()
    _TestFmkHeader("Test: __CheckExistingInstall() - empty version string is fresh install")
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "")
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = False, "Empty version treated as fresh install", $g_bIsUpgrade, False)
EndFunc

Func _TestCheckExistingInstall_Upgrade()
    _TestFmkHeader("Test: __CheckExistingInstall() - upgrade detected")
    _ResetStubs()
    _SetStubReturn("RegRead", 1, "0.0.1")
    _SetStubReturn("RegRead", 2, "__ERROR__")
    _SetStubReturn("RegRead", 3, "__ERROR__")
    __CheckExistingInstall()
    _TestFmkAssert($g_bIsUpgrade = True, "Upgrade detected", $g_bIsUpgrade, True)
EndFunc

Func _TestCheckExistingInstall_UpgradeOverridesPaths()
    _TestFmkHeader("Test: __CheckExistingInstall() - existing paths override detected paths")
    _ResetStubs()
    $g_sIncludePath = "C:\Detected\Include\Vendor"
    $g_sChmPath     = "C:\Detected\TestFramework"
    _SetStubReturn("RegRead", 1, "0.0.1")
    _SetStubReturn("RegRead", 2, "C:\Existing\Include\Vendor")
    _SetStubReturn("RegRead", 3, "C:\Existing\TestFramework")
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
    _ResetStubs()
    $g_sIncludePath = "C:\Detected\Include\Vendor"
    $g_sChmPath     = "C:\Detected\TestFramework"
    _SetStubReturn("RegRead", 1, "0.0.1")
    _SetStubReturn("RegRead", 2, "C:\Existing\Include\Vendor")
    _SetStubReturn("RegRead", 3, "C:\Existing\TestFramework")
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
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "")
    __WriteIncludeRegistry()
    _TestFmkAssert($g_StubCalls["RegWrite"].count = 1, "Writes one registry entry", $g_StubCalls["RegWrite"].count, 1)
    _TestFmkAssert($g_StubCalls["RegWrite"][1].vValue = "C:\AutoIt3\Include\Vendor", _
        "Writes correct path", $g_StubCalls["RegWrite"][1].vValue, "C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_ErrorTreatedAsEmpty()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - RegRead error treated as empty")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "__ERROR__")
    __WriteIncludeRegistry()
    _TestFmkAssert($g_StubCalls["RegWrite"].count = 1, "Writes one registry entry on error", $g_StubCalls["RegWrite"].count, 1)
    _TestFmkAssert($g_StubCalls["RegWrite"][1].vValue = "C:\AutoIt3\Include\Vendor", _
        "Writes correct path on error", $g_StubCalls["RegWrite"][1].vValue, "C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_AppendsToExisting()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - appends to existing paths")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\OtherLib")
    __WriteIncludeRegistry()
    _TestFmkAssert($g_StubCalls["RegWrite"][1].vValue = "C:\OtherLib;C:\AutoIt3\Include\Vendor", _
        "Appends with semicolon", $g_StubCalls["RegWrite"][1].vValue, "C:\OtherLib;C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_SkipsIfAlreadyRegistered()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - skips when already registered")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\AutoIt3\Include\Vendor")
    __WriteIncludeRegistry()
    _TestFmkAssert(Not MapExists($g_StubCalls, "RegWrite"), "Does not write when already registered", MapExists($g_StubCalls, "RegWrite"), False)
EndFunc

; ===============================================================================================================================
; Tests - __WriteInstallRegistry
; ===============================================================================================================================
Func _TestWriteInstallRegistry_WritesAllKeys()
    _TestFmkHeader("Test: __WriteInstallRegistry() - writes version and paths")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __WriteInstallRegistry()
    _TestFmkAssert($g_StubCalls["RegWrite"].count = 3, "Writes three registry entries", $g_StubCalls["RegWrite"].count, 3)
    _TestFmkAssert($g_StubCalls["RegWrite"][1].sValuename = "Version", "Writes Version key", $g_StubCalls["RegWrite"][1].sValuename, "Version")
    _TestFmkAssert($g_StubCalls["RegWrite"][1].vValue = "0.0.1", "Version value correct", $g_StubCalls["RegWrite"][1].vValue, "0.0.1")
    _TestFmkAssert($g_StubCalls["RegWrite"][2].sValuename = "IncludePath", "Writes IncludePath key", $g_StubCalls["RegWrite"][2].sValuename, "IncludePath")
    _TestFmkAssert($g_StubCalls["RegWrite"][2].vValue = "C:\AutoIt3\Include\Vendor", "IncludePath value correct", $g_StubCalls["RegWrite"][2].vValue, "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_StubCalls["RegWrite"][3].sValuename = "ChmPath", "Writes ChmPath key", $g_StubCalls["RegWrite"][3].sValuename, "ChmPath")
    _TestFmkAssert($g_StubCalls["RegWrite"][3].vValue = "C:\AutoIt3\TestFramework", "ChmPath value correct", $g_StubCalls["RegWrite"][3].vValue, "C:\AutoIt3\TestFramework")
EndFunc

; ===============================================================================================================================
; Tests - __WriteUninstallRegistry
; ===============================================================================================================================
Func _TestWriteUninstallRegistry_WritesAllKeys()
    _TestFmkHeader("Test: __WriteUninstallRegistry() - writes all uninstall keys")
    _ResetStubs()
    $g_sChmPath = "C:\AutoIt3\TestFramework"
    __WriteUninstallRegistry()
    _TestFmkAssert($g_StubCalls["RegWrite"].count = 5, "Writes five registry entries", $g_StubCalls["RegWrite"].count, 5)
    _TestFmkAssert($g_StubCalls["RegWrite"][1].sValuename = "DisplayName", "Writes DisplayName key", $g_StubCalls["RegWrite"][1].sValuename, "DisplayName")
    _TestFmkAssert($g_StubCalls["RegWrite"][1].vValue = "AutoIt Test Framework", "DisplayName value correct", $g_StubCalls["RegWrite"][1].vValue, "AutoIt Test Framework")
    _TestFmkAssert($g_StubCalls["RegWrite"][2].sValuename = "DisplayVersion", "Writes DisplayVersion key", $g_StubCalls["RegWrite"][2].sValuename, "DisplayVersion")
    _TestFmkAssert($g_StubCalls["RegWrite"][2].vValue = "0.0.1", "DisplayVersion value correct", $g_StubCalls["RegWrite"][2].vValue, "0.0.1")
    _TestFmkAssert($g_StubCalls["RegWrite"][3].sValuename = "Publisher", "Writes Publisher key", $g_StubCalls["RegWrite"][3].sValuename, "Publisher")
    _TestFmkAssert($g_StubCalls["RegWrite"][4].sValuename = "UninstallString", "Writes UninstallString key", $g_StubCalls["RegWrite"][4].sValuename, "UninstallString")
    _TestFmkAssert($g_StubCalls["RegWrite"][4].vValue = '"C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe"', _
        "UninstallString is quoted path", $g_StubCalls["RegWrite"][4].vValue, '"C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe"')
    _TestFmkAssert($g_StubCalls["RegWrite"][5].sValuename = "NoModify", "Writes NoModify key", $g_StubCalls["RegWrite"][5].sValuename, "NoModify")
    _TestFmkAssert($g_StubCalls["RegWrite"][5].vValue = 1, "NoModify value correct", $g_StubCalls["RegWrite"][5].vValue, 1)
EndFunc

; ===============================================================================================================================
; Tests - __RunInstall
; ===============================================================================================================================
Func _TestRunInstall_CreatesFolders()
    _TestFmkHeader("Test: __RunInstall() - creates install folders")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __RunInstall(1, 2)
    _TestFmkAssert($g_StubCalls["DirCreate"].count = 2, "Creates two folders", $g_StubCalls["DirCreate"].count, 2)
    _TestFmkAssert($g_StubCalls["DirCreate"][1].sPath = "C:\AutoIt3\Include\Vendor", _
        "Creates include folder", $g_StubCalls["DirCreate"][1].sPath, "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_StubCalls["DirCreate"][2].sPath = "C:\AutoIt3\TestFramework", _
        "Creates CHM folder", $g_StubCalls["DirCreate"][2].sPath, "C:\AutoIt3\TestFramework")
EndFunc

Func _TestRunInstall_InstallsAllFiles()
    _TestFmkHeader("Test: __RunInstall() - installs all expected files")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    __RunInstall(1, 2)
    ; Total: 1 TestFramework + 16 Testable + 17 Stubs + 1 chm + 1 uninstaller = 36
    _TestFmkAssert($g_StubCalls["FileInstall"].count = 36, "Installs 36 files total", $g_StubCalls["FileInstall"].count, 36)
    ; TestFramework.au3
    _TestFmkAssert($g_StubCalls["FileInstall"][1].sSource  = "..\core\TestFramework.au3", "Installs TestFramework.au3 source", $g_StubCalls["FileInstall"][1].sSource, "..\core\TestFramework.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][1].sDest = "C:\AutoIt3\Include\Vendor\TestFramework.au3", "Installs TestFramework.au3 dest", $g_StubCalls["FileInstall"][1].sDest, "C:\AutoIt3\Include\Vendor\TestFramework.au3")
    ; Testable library
    _TestFmkAssert($g_StubCalls["FileInstall"][2].sSource  = "..\core\Testable.au3",             "Installs Testable.au3",             $g_StubCalls["FileInstall"][2].sSource,  "..\core\Testable.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][3].sSource  = "..\core\Testable_Clipboard.au3",   "Installs Testable_Clipboard.au3",   $g_StubCalls["FileInstall"][3].sSource,  "..\core\Testable_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][4].sSource  = "..\core\Testable_Dialogs.au3",     "Installs Testable_Dialogs.au3",     $g_StubCalls["FileInstall"][4].sSource,  "..\core\Testable_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][5].sSource  = "..\core\Testable_FileInstall.au3", "Installs Testable_FileInstall.au3", $g_StubCalls["FileInstall"][5].sSource,  "..\core\Testable_FileInstall.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][6].sSource  = "..\core\Testable_FileSystem.au3",  "Installs Testable_FileSystem.au3",  $g_StubCalls["FileInstall"][6].sSource,  "..\core\Testable_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][7].sSource  = "..\core\Testable_GUI.au3",         "Installs Testable_GUI.au3",         $g_StubCalls["FileInstall"][7].sSource,  "..\core\Testable_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][8].sSource  = "..\core\Testable_Ini.au3",         "Installs Testable_Ini.au3",         $g_StubCalls["FileInstall"][8].sSource,  "..\core\Testable_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][9].sSource  = "..\core\Testable_Input.au3",       "Installs Testable_Input.au3",       $g_StubCalls["FileInstall"][9].sSource,  "..\core\Testable_Input.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][10].sSource = "..\core\Testable_Network.au3",     "Installs Testable_Network.au3",     $g_StubCalls["FileInstall"][10].sSource, "..\core\Testable_Network.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][11].sSource = "..\core\Testable_Process.au3",     "Installs Testable_Process.au3",     $g_StubCalls["FileInstall"][11].sSource, "..\core\Testable_Process.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][12].sSource = "..\core\Testable_Registry.au3",    "Installs Testable_Registry.au3",    $g_StubCalls["FileInstall"][12].sSource, "..\core\Testable_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][13].sSource = "..\core\Testable_Sound.au3",       "Installs Testable_Sound.au3",       $g_StubCalls["FileInstall"][13].sSource, "..\core\Testable_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][14].sSource = "..\core\Testable_Splash.au3",      "Installs Testable_Splash.au3",      $g_StubCalls["FileInstall"][14].sSource, "..\core\Testable_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][15].sSource = "..\core\Testable_System.au3",      "Installs Testable_System.au3",      $g_StubCalls["FileInstall"][15].sSource, "..\core\Testable_System.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][16].sSource = "..\core\Testable_Tray.au3",        "Installs Testable_Tray.au3",        $g_StubCalls["FileInstall"][16].sSource, "..\core\Testable_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][17].sSource = "..\core\Testable_Window.au3",      "Installs Testable_Window.au3",      $g_StubCalls["FileInstall"][17].sSource, "..\core\Testable_Window.au3")
    ; Stubs library
    _TestFmkAssert($g_StubCalls["FileInstall"][18].sSource = "..\core\Stubs.au3",             "Installs Stubs.au3",             $g_StubCalls["FileInstall"][18].sSource, "..\core\Stubs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][19].sSource = "..\core\Stubs_Core.au3",        "Installs Stubs_Core.au3",        $g_StubCalls["FileInstall"][19].sSource, "..\core\Stubs_Core.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][20].sSource = "..\core\Stubs_Clipboard.au3",   "Installs Stubs_Clipboard.au3",   $g_StubCalls["FileInstall"][20].sSource, "..\core\Stubs_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][21].sSource = "..\core\Stubs_Dialogs.au3",     "Installs Stubs_Dialogs.au3",     $g_StubCalls["FileInstall"][21].sSource, "..\core\Stubs_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][22].sSource = "..\core\Stubs_FileInstall.au3", "Installs Stubs_FileInstall.au3", $g_StubCalls["FileInstall"][22].sSource, "..\core\Stubs_FileInstall.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][23].sSource = "..\core\Stubs_FileSystem.au3",  "Installs Stubs_FileSystem.au3",  $g_StubCalls["FileInstall"][23].sSource, "..\core\Stubs_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][24].sSource = "..\core\Stubs_GUI.au3",         "Installs Stubs_GUI.au3",         $g_StubCalls["FileInstall"][24].sSource, "..\core\Stubs_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][25].sSource = "..\core\Stubs_Ini.au3",         "Installs Stubs_Ini.au3",         $g_StubCalls["FileInstall"][25].sSource, "..\core\Stubs_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][26].sSource = "..\core\Stubs_Input.au3",       "Installs Stubs_Input.au3",       $g_StubCalls["FileInstall"][26].sSource, "..\core\Stubs_Input.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][27].sSource = "..\core\Stubs_Network.au3",     "Installs Stubs_Network.au3",     $g_StubCalls["FileInstall"][27].sSource, "..\core\Stubs_Network.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][28].sSource = "..\core\Stubs_Process.au3",     "Installs Stubs_Process.au3",     $g_StubCalls["FileInstall"][28].sSource, "..\core\Stubs_Process.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][29].sSource = "..\core\Stubs_Registry.au3",    "Installs Stubs_Registry.au3",    $g_StubCalls["FileInstall"][29].sSource, "..\core\Stubs_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][30].sSource = "..\core\Stubs_Sound.au3",       "Installs Stubs_Sound.au3",       $g_StubCalls["FileInstall"][30].sSource, "..\core\Stubs_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][31].sSource = "..\core\Stubs_Splash.au3",      "Installs Stubs_Splash.au3",      $g_StubCalls["FileInstall"][31].sSource, "..\core\Stubs_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][32].sSource = "..\core\Stubs_System.au3",      "Installs Stubs_System.au3",      $g_StubCalls["FileInstall"][32].sSource, "..\core\Stubs_System.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][33].sSource = "..\core\Stubs_Tray.au3",        "Installs Stubs_Tray.au3",        $g_StubCalls["FileInstall"][33].sSource, "..\core\Stubs_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][34].sSource = "..\core\Stubs_Window.au3",      "Installs Stubs_Window.au3",      $g_StubCalls["FileInstall"][34].sSource, "..\core\Stubs_Window.au3")
    ; CHM and uninstaller
    _TestFmkAssert($g_StubCalls["FileInstall"][35].sSource = "..\..\chm\TestFramework.chm", "Installs TestFramework.chm src", $g_StubCalls["FileInstall"][35].sSource, "..\..\chm\TestFramework.chm")
    _TestFmkAssert($g_StubCalls["FileInstall"][35].sDest = "C:\AutoIt3\TestFramework\TestFramework.chm", "Installs TestFramework.chm dest", $g_StubCalls["FileInstall"][35].sDest, "C:\AutoIt3\TestFramework\TestFramework.chm")
    _TestFmkAssert($g_StubCalls["FileInstall"][36].sSource = "..\..\.out\TestFrameworkUninstaller.exe", "Installs TestFrameworkUninstaller.exe src", $g_StubCalls["FileInstall"][36].sSource, "..\..\.out\TestFrameworkUninstaller.exe")
    _TestFmkAssert($g_StubCalls["FileInstall"][36].sDest = "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe", "Installs TestFrameworkUninstaller.exe dest", $g_StubCalls["FileInstall"][36].sDest, "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe")
EndFunc

Func _TestRunInstall_WritesAllRegistryEntries()
    _TestFmkHeader("Test: __RunInstall() - writes all registry entries")
    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    _SetStubReturn("RegRead", 1, "")
    __RunInstall(1, 2)
    ; 1 include + 3 install + 5 uninstall = 9 registry writes
    _TestFmkAssert($g_StubCalls["RegWrite"].count = 9, "Writes nine registry entries total", $g_StubCalls["RegWrite"].count, 9)
EndFunc

; ===============================================================================================================================
; Tests - __RunWizard
; ===============================================================================================================================
; Control IDs configured via _SetStubReturn so the event loop Switch matches correctly:
;   GUICtrlCreateLabel  3 = HeaderSub  (ID 20)
;   GUICtrlCreateButton 1 = Cancel     (ID 10)
;   GUICtrlCreateButton 2 = Back       (ID 11)
;   GUICtrlCreateButton 3 = Next       (ID 12)
;   GUICtrlCreateButton 4 = Browse     (ID 13)
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
    For $i = 1 To $g_StubCalls["GUICtrlSetData"].count
        If $g_StubCalls["GUICtrlSetData"][$i].idCtrl = $ID_HEADER_SUB Then
            $iFound += 1
            If $iFound = $iCallIdx Then Return $g_StubCalls["GUICtrlSetData"][$i].vData
        EndIf
    Next
    Return ""
EndFunc

; ===============================================================================================================================
; Tests - Next button
; ===============================================================================================================================
Func _TestWizard_NextFromPage1GoesToPage2()
    _TestFmkHeader("Test: __RunWizard() - Next from page 1 goes to page 2")
    _ResetStubs()
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
    _ResetStubs()
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
    _ResetStubs()
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
    _ResetStubs()
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
    _ResetStubs()
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
    _ResetStubs()
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg",        1, $ID_BTN_NEXT)
    _SetStubReturn("GUIGetMsg",        2, $ID_BTN_BROWSE)
    _SetStubReturn("FileSelectFolder", 1, "C:\NewPath")
    _SetStubReturn("GUIGetMsg",        3, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",           1, $IDYES)
    __RunWizard()
    Local $bFound = False
    For $i = 1 To $g_StubCalls["GUICtrlSetData"].count
        If $g_StubCalls["GUICtrlSetData"][$i].idCtrl = $ID_FOLDER_INPUT And _
           $g_StubCalls["GUICtrlSetData"][$i].vData  = "C:\NewPath" Then
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
    _ResetStubs()
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_CANCEL)
    _SetStubReturn("MsgBox",    1, $IDYES)
    __RunWizard()
    _TestFmkAssert($g_StubCalls["GUIDelete"].count = 1, "GUIDelete called on confirmed cancel", $g_StubCalls["GUIDelete"].count, 1)
EndFunc

Func _TestWizard_CancelDeclined_KeepsWizardOpen()
    _TestFmkHeader("Test: __RunWizard() - Cancel declined keeps wizard open")
    _ResetStubs()
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUIGetMsg", 1, $ID_BTN_CANCEL)  ; click Cancel
    _SetStubReturn("MsgBox",    1, $IDNO)            ; decline
    _SetStubReturn("GUIGetMsg", 2, $ID_BTN_CANCEL)  ; click Cancel again
    _SetStubReturn("MsgBox",    2, $IDYES)           ; confirm this time
    __RunWizard()
    _TestFmkAssert($g_StubCalls["MsgBox"].count = 2, "MsgBox shown twice", $g_StubCalls["MsgBox"].count, 2)
    _TestFmkAssert($g_StubCalls["GUIDelete"].count = 1, "GUIDelete called only on second cancel", $g_StubCalls["GUIDelete"].count, 1)
EndFunc

Func _TestWizard_CancelOnPage4DoesNothing()
    _TestFmkHeader("Test: __RunWizard() - Cancel on page 4 does nothing")
    _ResetStubs()
    $g_bIsUpgrade = False
    __SetupWizardControlIDs()
    _SetStubReturn("GUICtrlRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("GUICtrlRead", 2, $GUI_UNCHECKED)  ; open docs checkbox unchecked
    _SetStubReturn("RegRead",     1, "")
    _SetStubReturn("GUIGetMsg",   1, $ID_BTN_NEXT)    ; page 1 -> 2
    _SetStubReturn("GUIGetMsg",   2, $ID_BTN_NEXT)    ; page 2 -> 3
    _SetStubReturn("GUIGetMsg",   3, $ID_BTN_NEXT)    ; page 3 -> 4 (runs install) -> 5
    _SetStubReturn("GUIGetMsg",   4, $ID_BTN_CANCEL)  ; cancel on page 5 - does nothing
    _SetStubReturn("GUIGetMsg",   5, $ID_BTN_NEXT)    ; Finish - exits loop
    __RunWizard()
    _TestFmkAssert(Not MapExists($g_StubCalls, "MsgBox"), "No MsgBox shown on page 4/5 cancel", MapExists($g_StubCalls, "MsgBox"), False)
EndFunc

; ===============================================================================================================================
; Run all tests
; ===============================================================================================================================
Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FromWOWRegistry,                    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FallsBackToNormalRegistry,          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FallsBackToDefault,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_FreshInstall,              $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_EmptyVersionIsFresh,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_Upgrade,                   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_UpgradeOverridesPaths,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_UpgradeKeepsPathsWhenExistingMissing, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_EmptyExisting,             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_ErrorTreatedAsEmpty,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_AppendsToExisting,         $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_SkipsIfAlreadyRegistered,  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteInstallRegistry_WritesAllKeys,             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteUninstallRegistry_WritesAllKeys,           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_CreatesFolders,                      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_InstallsAllFiles,                    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_WritesAllRegistryEntries,            $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage1GoesToPage2,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage2GoesToPage3,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_NextFromPage2UpdatesIncludePath,        $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BackFromPage2GoesToPage1,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BackFromPage3GoesToPage2,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_BrowseUpdatesInputField,                $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelConfirmed_ClosesWizard,           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelDeclined_KeepsWizardOpen,         $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWizard_CancelOnPage4DoesNothing,               $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc
_RunAllTests()
