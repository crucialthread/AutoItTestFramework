; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFrameworkUninstallerTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for TestFrameworkUninstaller.au3.
;                  Uses Stubs.au3 to intercept all AutoIt built-in calls so no real GUI
;                  is created, no files are deleted, and no registry entries are touched.
; ===============================================================================================================================

Global $__UNINSTALLER_TEST_MODE = True

#include "..\src\core\TestFramework.au3"
#include "..\src\core\Stubs.au3"
#include "..\src\installer\TestFrameworkUninstaller.au3"

; ===============================================================================================================================
; Tests - __ReadInstallRecord
; ===============================================================================================================================

Func _TestReadInstallRecord_Success()
    _TestFmkHeader("Test: __ReadInstallRecord() - reads paths from registry")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "C:\AutoIt3\Include\Vendor")
    _SetStubReturn("RegRead", 2, "C:\AutoIt3\TestFramework")

    Local $bResult = __ReadInstallRecord()

    _TestFmkAssert($bResult = True, "Returns True when registry found", $bResult, True)
    _TestFmkAssert($g_sIncludePath = "C:\AutoIt3\Include\Vendor", _
        "IncludePath populated from registry", $g_sIncludePath, "C:\AutoIt3\Include\Vendor")
    _TestFmkAssert($g_sChmPath = "C:\AutoIt3\TestFramework", _
        "ChmPath populated from registry", $g_sChmPath, "C:\AutoIt3\TestFramework")
EndFunc

Func _TestReadInstallRecord_MissingRegistry()
    _TestFmkHeader("Test: __ReadInstallRecord() - returns False when registry missing")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")

    Local $bResult = __ReadInstallRecord()

    _TestFmkAssert($bResult = False, "Returns False when registry missing", $bResult, False)
EndFunc

; ===============================================================================================================================
; Tests - __RemoveIncludeRegistry
; ===============================================================================================================================

Func _TestRemoveIncludeRegistry_OnlyOurPath()
    _TestFmkHeader("Test: __RemoveIncludeRegistry() - deletes value when only our path remains")

    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\AutoIt3\Include\Vendor")

    __RemoveIncludeRegistry()

    _TestFmkAssert($g_StubCalls["RegDelete"].count = 1, "Deletes registry value", $g_StubCalls["RegDelete"].count, 1)
    _TestFmkAssert(Not MapExists($g_StubCalls, "RegWrite"), "Does not rewrite", MapExists($g_StubCalls, "RegWrite"), False)
EndFunc

Func _TestRemoveIncludeRegistry_OtherPathsPresent()
    _TestFmkHeader("Test: __RemoveIncludeRegistry() - preserves other paths")

    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    _SetStubReturn("RegRead", 1, "C:\OtherLib;C:\AutoIt3\Include\Vendor")

    __RemoveIncludeRegistry()

    _TestFmkAssert($g_StubCalls["RegWrite"].count = 1, "Rewrites registry with remaining paths", $g_StubCalls["RegWrite"].count, 1)
    _TestFmkAssert($g_StubCalls["RegWrite"][1]["vValue"] = "C:\OtherLib", _
        "Remaining path preserved", $g_StubCalls["RegWrite"][1]["vValue"], "C:\OtherLib")
EndFunc

Func _TestRemoveIncludeRegistry_RegistryMissing()
    _TestFmkHeader("Test: __RemoveIncludeRegistry() - does nothing when registry missing")

    _ResetStubs()
    _SetStubReturn("RegRead", 1, "__ERROR__")

    __RemoveIncludeRegistry()

    _TestFmkAssert(Not MapExists($g_StubCalls, "RegDelete"), "Does nothing when registry missing", MapExists($g_StubCalls, "RegDelete"), False)
    _TestFmkAssert(Not MapExists($g_StubCalls, "RegWrite"), "Does not write when registry missing", MapExists($g_StubCalls, "RegWrite"), False)
EndFunc

; ===============================================================================================================================
; Tests - __RemoveFolderIfEmpty
; ===============================================================================================================================

Func _TestRemoveFolderIfEmpty_FolderNotExist()
    _TestFmkHeader("Test: __RemoveFolderIfEmpty() - does nothing when folder does not exist")

    _ResetStubs()
    _SetStubReturn("FileExists", 1, False)

    __RemoveFolderIfEmpty("C:\AutoIt3\Include\Vendor")

    _TestFmkAssert(Not MapExists($g_StubCalls, "DirRemove"), "Does not remove when folder missing", MapExists($g_StubCalls, "DirRemove"), False)
EndFunc

Func _TestRemoveFolderIfEmpty_EmptyFolder()
    _TestFmkHeader("Test: __RemoveFolderIfEmpty() - removes empty folder")

    _ResetStubs()
    _SetStubReturn("FileExists", 1, True)

    __RemoveFolderIfEmpty("C:\AutoIt3\Include\Vendor")

    _TestFmkAssert($g_StubCalls["DirRemove"].count = 1, "Removes empty folder", $g_StubCalls["DirRemove"].count, 1)
    _TestFmkAssert($g_StubCalls["DirRemove"][1]["sPath"] = "C:\AutoIt3\Include\Vendor", _
        "Removes correct folder", $g_StubCalls["DirRemove"][1]["sPath"], "C:\AutoIt3\Include\Vendor")
EndFunc

; ===============================================================================================================================
; Tests - __RunUninstall
; ===============================================================================================================================

Func _TestRunUninstall_DeletesFiles()
    _TestFmkHeader("Test: __RunUninstall() - deletes all installed files")

    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"

    __RunUninstall(1, 2)

    ; Total: 1 TestFramework + 15 Testable + 16 Stubs + 1 chm + 1 uninstaller = 34
    _TestFmkAssert($g_StubCalls["FileDelete"].count = 34, "Deletes 34 files total", $g_StubCalls["FileDelete"].count, 34)

    ; TestFramework.au3
    _TestFmkAssert($g_StubCalls["FileDelete"][1]["sPath"]  = "C:\AutoIt3\Include\Vendor\TestFramework.au3",         "Deletes TestFramework.au3",         $g_StubCalls["FileDelete"][1]["sPath"],  "C:\AutoIt3\Include\Vendor\TestFramework.au3")

    ; Testable library
    _TestFmkAssert($g_StubCalls["FileDelete"][2]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable.au3",              "Deletes Testable.au3",              $g_StubCalls["FileDelete"][2]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][3]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_Clipboard.au3",    "Deletes Testable_Clipboard.au3",    $g_StubCalls["FileDelete"][3]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][4]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_Dialogs.au3",      "Deletes Testable_Dialogs.au3",      $g_StubCalls["FileDelete"][4]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][5]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_FileSystem.au3",   "Deletes Testable_FileSystem.au3",   $g_StubCalls["FileDelete"][5]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][6]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_GUI.au3",          "Deletes Testable_GUI.au3",          $g_StubCalls["FileDelete"][6]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][7]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_Ini.au3",          "Deletes Testable_Ini.au3",          $g_StubCalls["FileDelete"][7]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][8]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_Input.au3",        "Deletes Testable_Input.au3",        $g_StubCalls["FileDelete"][8]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_Input.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][9]["sPath"]  = "C:\AutoIt3\Include\Vendor\Testable_Network.au3",      "Deletes Testable_Network.au3",      $g_StubCalls["FileDelete"][9]["sPath"],  "C:\AutoIt3\Include\Vendor\Testable_Network.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][10]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Process.au3",      "Deletes Testable_Process.au3",      $g_StubCalls["FileDelete"][10]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Process.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][11]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Registry.au3",     "Deletes Testable_Registry.au3",     $g_StubCalls["FileDelete"][11]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][12]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Sound.au3",        "Deletes Testable_Sound.au3",        $g_StubCalls["FileDelete"][12]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][13]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Splash.au3",       "Deletes Testable_Splash.au3",       $g_StubCalls["FileDelete"][13]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][14]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_System.au3",       "Deletes Testable_System.au3",       $g_StubCalls["FileDelete"][14]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_System.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][15]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Tray.au3",         "Deletes Testable_Tray.au3",         $g_StubCalls["FileDelete"][15]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][16]["sPath"] = "C:\AutoIt3\Include\Vendor\Testable_Window.au3",       "Deletes Testable_Window.au3",       $g_StubCalls["FileDelete"][16]["sPath"], "C:\AutoIt3\Include\Vendor\Testable_Window.au3")

    ; Stubs library
    _TestFmkAssert($g_StubCalls["FileDelete"][17]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs.au3",                 "Deletes Stubs.au3",                 $g_StubCalls["FileDelete"][17]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][18]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Core.au3",            "Deletes Stubs_Core.au3",            $g_StubCalls["FileDelete"][18]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Core.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][19]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Clipboard.au3",       "Deletes Stubs_Clipboard.au3",       $g_StubCalls["FileDelete"][19]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Clipboard.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][20]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Dialogs.au3",         "Deletes Stubs_Dialogs.au3",         $g_StubCalls["FileDelete"][20]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Dialogs.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][21]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_FileSystem.au3",      "Deletes Stubs_FileSystem.au3",      $g_StubCalls["FileDelete"][21]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_FileSystem.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][22]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_GUI.au3",             "Deletes Stubs_GUI.au3",             $g_StubCalls["FileDelete"][22]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_GUI.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][23]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Ini.au3",             "Deletes Stubs_Ini.au3",             $g_StubCalls["FileDelete"][23]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Ini.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][24]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Input.au3",           "Deletes Stubs_Input.au3",           $g_StubCalls["FileDelete"][24]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Input.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][25]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Network.au3",         "Deletes Stubs_Network.au3",         $g_StubCalls["FileDelete"][25]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Network.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][26]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Process.au3",         "Deletes Stubs_Process.au3",         $g_StubCalls["FileDelete"][26]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Process.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][27]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Registry.au3",        "Deletes Stubs_Registry.au3",        $g_StubCalls["FileDelete"][27]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Registry.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][28]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Sound.au3",           "Deletes Stubs_Sound.au3",           $g_StubCalls["FileDelete"][28]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Sound.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][29]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Splash.au3",          "Deletes Stubs_Splash.au3",          $g_StubCalls["FileDelete"][29]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Splash.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][30]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_System.au3",          "Deletes Stubs_System.au3",          $g_StubCalls["FileDelete"][30]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_System.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][31]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Tray.au3",            "Deletes Stubs_Tray.au3",            $g_StubCalls["FileDelete"][31]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Tray.au3")
    _TestFmkAssert($g_StubCalls["FileDelete"][32]["sPath"] = "C:\AutoIt3\Include\Vendor\Stubs_Window.au3",          "Deletes Stubs_Window.au3",          $g_StubCalls["FileDelete"][32]["sPath"], "C:\AutoIt3\Include\Vendor\Stubs_Window.au3")

    ; CHM and uninstaller
    _TestFmkAssert($g_StubCalls["FileDelete"][33]["sPath"] = "C:\AutoIt3\TestFramework\TestFramework.chm",          "Deletes TestFramework.chm",         $g_StubCalls["FileDelete"][33]["sPath"], "C:\AutoIt3\TestFramework\TestFramework.chm")
    _TestFmkAssert($g_StubCalls["FileDelete"][34]["sPath"] = "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe", "Deletes uninstaller exe",          $g_StubCalls["FileDelete"][34]["sPath"], "C:\AutoIt3\TestFramework\TestFrameworkUninstaller.exe")
EndFunc

Func _TestRunUninstall_DeletesRegistryKeys()
    _TestFmkHeader("Test: __RunUninstall() - deletes registry keys")

    _ResetStubs()
    $g_sIncludePath = "C:\AutoIt3\Include\Vendor"
    $g_sChmPath     = "C:\AutoIt3\TestFramework"
    _SetStubReturn("RegRead", 1, "__ERROR__")

    __RunUninstall(1, 2)

    _TestFmkAssert($g_StubCalls["RegDelete"].count >= 2, "Deletes at least 2 registry keys", $g_StubCalls["RegDelete"].count, ">=2")
    _TestFmkAssert($g_StubCalls["RegDelete"][1]["sKeyname"] = $REG_INSTALL_KEY, _
        "Deletes install key", $g_StubCalls["RegDelete"][1]["sKeyname"], $REG_INSTALL_KEY)
    _TestFmkAssert($g_StubCalls["RegDelete"][2]["sKeyname"] = $REG_UNINSTALL_KEY, _
        "Deletes uninstall key", $g_StubCalls["RegDelete"][2]["sKeyname"], $REG_UNINSTALL_KEY)
EndFunc

Func _TestRunUninstall_CancelConfirmation()
    _TestFmkHeader("Test: cancel confirmation MsgBox is called")

    _ResetStubs()
    _SetStubReturn("MsgBox", 1, $IDNO)

    Local $iResult = _Tstbl_MsgBox($MB_YESNO + $MB_ICONQUESTION, $UNINSTALLER_TITLE, _
        "Are you sure you want to cancel the uninstallation?")

    _TestFmkAssert($g_StubCalls["MsgBox"].count = 1, "MsgBox called on cancel", $g_StubCalls["MsgBox"].count, 1)
    _TestFmkAssert($iResult = $IDNO, "MsgBox returns controlled stub value", $iResult, $IDNO)
EndFunc

; ===============================================================================================================================
; Run all tests
; ===============================================================================================================================

Func _RunAllTests()
    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(_TestReadInstallRecord_Success,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestReadInstallRecord_MissingRegistry,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRemoveIncludeRegistry_OnlyOurPath,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRemoveIncludeRegistry_OtherPathsPresent, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRemoveIncludeRegistry_RegistryMissing,   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRemoveFolderIfEmpty_FolderNotExist,      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRemoveFolderIfEmpty_EmptyFolder,         $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunUninstall_DeletesFiles,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunUninstall_DeletesRegistryKeys,        $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestRunUninstall_CancelConfirmation,         $bAllPassed)
    _TestFmkSummary()
    Return $bAllPassed
EndFunc

_RunAllTests()
