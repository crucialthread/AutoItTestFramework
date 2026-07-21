; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFrameworkInstallerTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for TestFrameworkInstaller.au3.
;                  Uses Stubs.au3 to intercept all AutoIt built-in calls so no real GUI
;                  is created, no files are written, and no registry entries are touched.
;                  FileInstall is stubbed via $g_hFn_FileInstall which points to __FileInstall
;                  (a wrapper function) rather than FileInstall directly. This allows stubbing
;                  while keeping literal FileInstall calls visible to Aut2Exe for embedding.
; ===============================================================================================================================

Global $__INSTALLER_TEST_MODE = True

#include "..\src\core\TestFramework.au3"
#include "..\src\core\Stubs.au3"
#include "..\src\installer\TestFrameworkInstaller.au3"

; ===============================================================================================================================
; FileInstall stub - wired after installer include so $g_hFn_FileInstall exists
; ===============================================================================================================================

Func _Stub_FileInstall($sSrc, $sDest, $iFlag)
    __StubInitType("FileInstall")
    Local $iIdx = $g_StubCalls["FileInstall"].count + 1
    Local $oCall[]
    $oCall["sSrc"]  = $sSrc
    $oCall["sDest"] = $sDest
    $g_StubCalls["FileInstall"][$iIdx] = $oCall
    $g_StubCalls["FileInstall"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileInstall"], $iIdx) ? $g_StubReturns["FileInstall"][$iIdx] : True
    Return $bReturn
EndFunc

$g_hFn_FileInstall = _Stub_FileInstall

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

Func _TestDetectPaths_FallsBackToDefault()
    _TestFmkHeader("Test: __DetectPaths() - falls back to default when registry missing")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")
    _SetStubReturn("RegRead", 2, "__ERROR__")

    __DetectPaths()

    _TestFmkAssert($g_sIncludePath = "C:\Program Files (x86)\AutoIt3\Include\Vendor", _
        "IncludePath defaults when registry missing", $g_sIncludePath, "C:\Program Files (x86)\AutoIt3\Include\Vendor")
EndFunc

; ===============================================================================================================================
; Tests - __CheckExistingInstall
; ===============================================================================================================================

Func _TestCheckExistingInstall_FreshInstall()
    _TestFmkHeader("Test: __CheckExistingInstall() - fresh install")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")

    __CheckExistingInstall()

    _TestFmkAssert($g_bIsUpgrade = False, "Fresh install detected", $g_bIsUpgrade, False)
EndFunc

Func _TestCheckExistingInstall_Upgrade()
    _TestFmkHeader("Test: __CheckExistingInstall() - upgrade detected")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "0.0.1")

    __CheckExistingInstall()

    _TestFmkAssert($g_bIsUpgrade = True, "Upgrade detected", $g_bIsUpgrade, True)
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
    _TestFmkAssert($g_StubCalls["RegWrite"][1]["vValue"] = "C:\AutoIt3\Include\Vendor", _
        "Writes correct path", $g_StubCalls["RegWrite"][1]["vValue"], "C:\AutoIt3\Include\Vendor")
EndFunc

Func _TestWriteIncludeRegistry_AppendsToExisting()
    _TestFmkHeader("Test: __WriteIncludeRegistry() - appends to existing paths")

    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\OtherLib")

    __WriteIncludeRegistry()

    _TestFmkAssert($g_StubCalls["RegWrite"][1]["vValue"] = "C:\OtherLib;C:\AutoIt3\Include\Vendor", _
        "Appends with semicolon", $g_StubCalls["RegWrite"][1]["vValue"], "C:\OtherLib;C:\AutoIt3\Include\Vendor")
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
; Tests - __RunInstall
; ===============================================================================================================================

Func _TestRunInstall_CreatesFolders()
    _TestFmkHeader("Test: __RunInstall() - creates install folders")

    _ResetStubs()
    $g_hFn_FileInstall = _Stub_FileInstall
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"

    __RunInstall(1, 2)

    _TestFmkAssert($g_StubCalls["DirCreate"].count = 2, "Creates two folders", $g_StubCalls["DirCreate"].count, 2)
    _TestFmkAssert($g_StubCalls["DirCreate"][1]["sPath"] = "C:\AutoIt3\Include\Vendor", _
        "Creates include folder", $g_StubCalls["DirCreate"][1]["sPath"], "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_StubCalls["DirCreate"][2]["sPath"] = "C:\AutoIt3\TestFramework", _
        "Creates CHM folder", $g_StubCalls["DirCreate"][2]["sPath"], "C:\AutoIt3\TestFramework")
EndFunc

Func _TestRunInstall_InstallsAllFiles()
    _TestFmkHeader("Test: __RunInstall() - installs all expected files")

    _ResetStubs()
    $g_hFn_FileInstall = _Stub_FileInstall
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"

    __RunInstall(1, 2)

    ; Total: 1 TestFramework + 15 Testable + 16 Stubs + 1 chm + 1 uninstaller = 34
    _TestFmkAssert($g_StubCalls["FileInstall"].count = 34, "Installs 34 files total", $g_StubCalls["FileInstall"].count, 34)

    ; TestFramework.au3
    _TestFmkAssert($g_StubCalls["FileInstall"][1]["sSrc"]  = "..\core\TestFramework.au3", "Installs TestFramework.au3 src", $g_StubCalls["FileInstall"][1]["sSrc"], "..\core\TestFramework.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][1]["sDest"] = "C:\AutoIt3\Include\Vendor\TestFramework.au3", "Installs TestFramework.au3 dest", $g_StubCalls["FileInstall"][1]["sDest"], "C:\AutoIt3\Include\Vendor\TestFramework.au3")

    ; Testable library
    _TestFmkAssert($g_StubCalls["FileInstall"][2]["sSrc"]  = "..\core\Testable.au3",             "Installs Testable.au3",             $g_StubCalls["FileInstall"][2]["sSrc"],  "..\core\Testable.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][3]["sSrc"]  = "..\core\Testable_Clipboard.au3",   "Installs Testable_Clipboard.au3",   $g_StubCalls["FileInstall"][3]["sSrc"],  "..\core\Testable_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][4]["sSrc"]  = "..\core\Testable_Dialogs.au3",     "Installs Testable_Dialogs.au3",     $g_StubCalls["FileInstall"][4]["sSrc"],  "..\core\Testable_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][5]["sSrc"]  = "..\core\Testable_FileSystem.au3",  "Installs Testable_FileSystem.au3",  $g_StubCalls["FileInstall"][5]["sSrc"],  "..\core\Testable_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][6]["sSrc"]  = "..\core\Testable_GUI.au3",         "Installs Testable_GUI.au3",         $g_StubCalls["FileInstall"][6]["sSrc"],  "..\core\Testable_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][7]["sSrc"]  = "..\core\Testable_Ini.au3",         "Installs Testable_Ini.au3",         $g_StubCalls["FileInstall"][7]["sSrc"],  "..\core\Testable_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][8]["sSrc"]  = "..\core\Testable_Input.au3",       "Installs Testable_Input.au3",       $g_StubCalls["FileInstall"][8]["sSrc"],  "..\core\Testable_Input.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][9]["sSrc"]  = "..\core\Testable_Network.au3",     "Installs Testable_Network.au3",     $g_StubCalls["FileInstall"][9]["sSrc"],  "..\core\Testable_Network.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][10]["sSrc"] = "..\core\Testable_Process.au3",     "Installs Testable_Process.au3",     $g_StubCalls["FileInstall"][10]["sSrc"], "..\core\Testable_Process.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][11]["sSrc"] = "..\core\Testable_Registry.au3",    "Installs Testable_Registry.au3",    $g_StubCalls["FileInstall"][11]["sSrc"], "..\core\Testable_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][12]["sSrc"] = "..\core\Testable_Sound.au3",       "Installs Testable_Sound.au3",       $g_StubCalls["FileInstall"][12]["sSrc"], "..\core\Testable_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][13]["sSrc"] = "..\core\Testable_Splash.au3",      "Installs Testable_Splash.au3",      $g_StubCalls["FileInstall"][13]["sSrc"], "..\core\Testable_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][14]["sSrc"] = "..\core\Testable_System.au3",      "Installs Testable_System.au3",      $g_StubCalls["FileInstall"][14]["sSrc"], "..\core\Testable_System.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][15]["sSrc"] = "..\core\Testable_Tray.au3",        "Installs Testable_Tray.au3",        $g_StubCalls["FileInstall"][15]["sSrc"], "..\core\Testable_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][16]["sSrc"] = "..\core\Testable_Window.au3",      "Installs Testable_Window.au3",      $g_StubCalls["FileInstall"][16]["sSrc"], "..\core\Testable_Window.au3")

    ; Stubs library
    _TestFmkAssert($g_StubCalls["FileInstall"][17]["sSrc"] = "..\core\Stubs.au3",           "Installs Stubs.au3",           $g_StubCalls["FileInstall"][17]["sSrc"], "..\core\Stubs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][18]["sSrc"] = "..\core\Stubs_Core.au3",      "Installs Stubs_Core.au3",      $g_StubCalls["FileInstall"][18]["sSrc"], "..\core\Stubs_Core.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][19]["sSrc"] = "..\core\Stubs_Clipboard.au3", "Installs Stubs_Clipboard.au3", $g_StubCalls["FileInstall"][19]["sSrc"], "..\core\Stubs_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][20]["sSrc"] = "..\core\Stubs_Dialogs.au3",   "Installs Stubs_Dialogs.au3",   $g_StubCalls["FileInstall"][20]["sSrc"], "..\core\Stubs_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][21]["sSrc"] = "..\core\Stubs_FileSystem.au3", "Installs Stubs_FileSystem.au3", $g_StubCalls["FileInstall"][21]["sSrc"], "..\core\Stubs_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][22]["sSrc"] = "..\core\Stubs_GUI.au3",       "Installs Stubs_GUI.au3",       $g_StubCalls["FileInstall"][22]["sSrc"], "..\core\Stubs_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][23]["sSrc"] = "..\core\Stubs_Ini.au3",       "Installs Stubs_Ini.au3",       $g_StubCalls["FileInstall"][23]["sSrc"], "..\core\Stubs_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][24]["sSrc"] = "..\core\Stubs_Input.au3",     "Installs Stubs_Input.au3",     $g_StubCalls["FileInstall"][24]["sSrc"], "..\core\Stubs_Input.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][25]["sSrc"] = "..\core\Stubs_Network.au3",   "Installs Stubs_Network.au3",   $g_StubCalls["FileInstall"][25]["sSrc"], "..\core\Stubs_Network.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][26]["sSrc"] = "..\core\Stubs_Process.au3",   "Installs Stubs_Process.au3",   $g_StubCalls["FileInstall"][26]["sSrc"], "..\core\Stubs_Process.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][27]["sSrc"] = "..\core\Stubs_Registry.au3",  "Installs Stubs_Registry.au3",  $g_StubCalls["FileInstall"][27]["sSrc"], "..\core\Stubs_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][28]["sSrc"] = "..\core\Stubs_Sound.au3",     "Installs Stubs_Sound.au3",     $g_StubCalls["FileInstall"][28]["sSrc"], "..\core\Stubs_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][29]["sSrc"] = "..\core\Stubs_Splash.au3",    "Installs Stubs_Splash.au3",    $g_StubCalls["FileInstall"][29]["sSrc"], "..\core\Stubs_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][30]["sSrc"] = "..\core\Stubs_System.au3",    "Installs Stubs_System.au3",    $g_StubCalls["FileInstall"][30]["sSrc"], "..\core\Stubs_System.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][31]["sSrc"] = "..\core\Stubs_Tray.au3",      "Installs Stubs_Tray.au3",      $g_StubCalls["FileInstall"][31]["sSrc"], "..\core\Stubs_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileInstall"][32]["sSrc"] = "..\core\Stubs_Window.au3",    "Installs Stubs_Window.au3",    $g_StubCalls["FileInstall"][32]["sSrc"], "..\core\Stubs_Window.au3")

    ; CHM and uninstaller
    _TestFmkAssert($g_StubCalls["FileInstall"][33]["sSrc"]  = "..\..\chm\TestFramework.chm",              "Installs TestFramework.chm src",           $g_StubCalls["FileInstall"][33]["sSrc"],  "..\..\chm\TestFramework.chm")
    _TestFmkAssert($g_StubCalls["FileInstall"][33]["sDest"] = "C:\AutoIt3\TestFramework\TestFramework.chm", "Installs TestFramework.chm dest",         $g_StubCalls["FileInstall"][33]["sDest"], "C:\AutoIt3\TestFramework\TestFramework.chm")
    _TestFmkAssert($g_StubCalls["FileInstall"][34]["sSrc"]  = "..\..\.out\TestFrameworkUninstaller.exe",   "Installs TestFrameworkUninstaller.exe src", $g_StubCalls["FileInstall"][34]["sSrc"],  "..\..\.out\TestFrameworkUninstaller.exe")
    _TestFmkAssert($g_StubCalls["FileInstall"][34]["sDest"] = "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe", "Installs TestFrameworkUninstaller.exe dest", $g_StubCalls["FileInstall"][34]["sDest"], "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe")
EndFunc

Func _TestRunInstall_WritesRegistry()
    _TestFmkHeader("Test: __RunInstall() - writes registry entries")

    _ResetStubs()
    $g_hFn_FileInstall = _Stub_FileInstall
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"

    __RunInstall(1, 2)

    _TestFmkAssert($g_StubCalls["RegWrite"].count >= 3, "Writes at least 3 registry entries", $g_StubCalls["RegWrite"].count, ">=3")
EndFunc

Func _TestRunInstall_CancelConfirmation()
    _TestFmkHeader("Test: cancel confirmation MsgBox is called")

    _ResetStubs()
    _SetStubReturn("MsgBox", 1, $IDNO)

    Local $iResult = _Tstbl_MsgBox($MB_YESNO + $MB_ICONQUESTION, $INSTALLER_TITLE, _
        "Are you sure you want to cancel the installation?")

    _TestFmkAssert($g_StubCalls["MsgBox"].count = 1, "MsgBox called on cancel", $g_StubCalls["MsgBox"].count, 1)
    _TestFmkAssert($iResult = $IDNO, "MsgBox returns controlled stub value", $iResult, $IDNO)
EndFunc

; ===============================================================================================================================
; Run all tests
; ===============================================================================================================================

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FromWOWRegistry,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDetectPaths_FallsBackToDefault,             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_FreshInstall,          $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCheckExistingInstall_Upgrade,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_EmptyExisting,         $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_AppendsToExisting,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestWriteIncludeRegistry_SkipsIfAlreadyRegistered, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_CreatesFolders,                  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_InstallsAllFiles,                $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_WritesRegistry,                  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunInstall_CancelConfirmation,              $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_RunAllTests()
