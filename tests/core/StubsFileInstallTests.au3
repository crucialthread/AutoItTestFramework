#include-once

#include "..\..\src\core\TestFramework.au3"
#include "..\..\src\core\StubConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsFileInstallTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for Stubs_FileInstall.au3.
;                  Tests the FileInstall stub behavior when implementation is not registered
;                  and when it is registered.
; ===============================================================================================================================
Local Const $STUBS_FILE_INST_TESTS = "StubsFileInstallTests.au3"

; ===============================================================================================================================
; Test helpers
; ===============================================================================================================================
Func __StubsResetFileInstall()
    $g_bFileInstallImplemented = False
    $g_hFn_FileInstall         = __Stub_FileInstall
EndFunc

Func __StubsTestFileInstall($sSource, $sDest, $iFlag)
    Return 1
EndFunc

; ===============================================================================================================================
; Tests - __Stub_FileInstall
; ===============================================================================================================================
Func _TestStubFileInstall_ReturnsErrorWhenNotImplemented()
    _TestFmkHeader("Test: __Stub_FileInstall() - returns SetError(1,0,Null) when not implemented")

    __StubsResetFileInstall()

    Local $vResult = __Stub_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)
    Local $iErr = @error

    _TestFmkAssert($iErr = 1, "Sets @error = 1", $iErr, 1, $STUBS_FILE_INST_TESTS)
    _TestFmkAssert($vResult = Null, "Returns Null", $vResult, Null, $STUBS_FILE_INST_TESTS)
    _TestFmkAssert(_StubCallCount("FileInstall") = 0, "Call not recorded", _StubCallCount("FileInstall"), 0, $STUBS_FILE_INST_TESTS)
EndFunc

Func _TestStubFileInstall_RecordsCallWhenImplemented()
    _TestFmkHeader("Test: __Stub_FileInstall() - records call when implementation registered")

    __StubsResetFileInstall()
    _Tstbl_Implement_FileInstall(__StubsTestFileInstall)

    __Stub_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)

	Local $iStubCount = _StubCallCount("FileInstall")
	Local $vSource    = _StubCall("FileInstall", $_1st, $Param_Source)
	Local $vDest      = _StubCall("FileInstall", $_1st, $Param_Dest)
	Local $vFlag      = _StubCall("FileInstall", $_1st, $Param_Flag)

    _TestFmkAssert($iStubCount = 1, "Call recorded", $iStubCount, 1, $STUBS_FILE_INST_TESTS)
    _TestFmkAssert($vSource = "path\to\file.au3", "Source recorded", $vSource, "path\to\file.au3", $STUBS_FILE_INST_TESTS)
    _TestFmkAssert($vDest   = "C:\dest\file.au3", "Dest recorded",   $vDest,   "C:\dest\file.au3", $STUBS_FILE_INST_TESTS)
    _TestFmkAssert($vFlag   = 1,                  "Flag recorded",   $vFlag,   1, 				   $STUBS_FILE_INST_TESTS)
EndFunc

Func _TestStubFileInstall_ReturnsConfiguredValue()
    _TestFmkHeader("Test: __Stub_FileInstall() - returns configured stub return value")

    __StubsResetFileInstall()
    _Tstbl_Implement_FileInstall(__StubsTestFileInstall)
    _SetStubReturn("FileInstall", 1, 0)

    Local $vResult = __Stub_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)

    _TestFmkAssert($vResult = 0, "Returns configured value", $vResult, 0, $STUBS_FILE_INST_TESTS)
EndFunc

Func _TestStubFileInstall_StubErrorTriggersError()
    _TestFmkHeader("Test: __Stub_FileInstall() - $STUB_ERROR triggers @error")

    __StubsResetFileInstall()
    _Tstbl_Implement_FileInstall(__StubsTestFileInstall)
    _SetStubReturn("FileInstall", 1, $STUB_ERROR)

    Local $vResult = __Stub_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)
    Local $iErr = @error

    _TestFmkAssert($iErr = 1, "Sets @error = 1", $iErr, 1, $STUBS_FILE_INST_TESTS)
    _TestFmkAssert($vResult = "", "Returns empty string", $vResult, "", $STUBS_FILE_INST_TESTS)
EndFunc

; ===============================================================================================================================
; Run tests
; ===============================================================================================================================
Func __RunStubsFileInstallTest_Stub_FileInstall(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestStubFileInstall_ReturnsErrorWhenNotImplemented, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubFileInstall_RecordsCallWhenImplemented,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubFileInstall_ReturnsConfiguredValue,         $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubFileInstall_StubErrorTriggersError,         $bAllPassed)
EndFunc

Func _RunStubsFileInstallTests($bWriteSummary = True)
    Local $bAllPassed = True
	__RunStubsFileInstallTest_Stub_FileInstall($bAllPassed)
    If $bWriteSummary Then _TestFmkSummary()
    Return $bAllPassed
EndFunc
_TestFmkRunAllTests(_RunStubsFileInstallTests, $STUBS_FILE_INST_TESTS)
