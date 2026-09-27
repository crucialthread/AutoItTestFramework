#include-once

#include "..\..\src\core\TestFramework.au3"
#include "..\..\src\core\StubConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableFileInstallTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for Testable_FileInstall.au3.
;                  Tests the FileInstall testable wrapper, dummy detection, implementation
;                  flag, and the stub guard that prevents overwriting the stub pointer.
; ===============================================================================================================================
Local Const $TSTBL_FILE_INSTALL_TESTS = "TestableFileInstallTests.au3"

; ===============================================================================================================================
; Test helpers
; ===============================================================================================================================
; A valid custom FileInstall implementation for use in tests
Func __TestFileInstall($sSource, $sDest, $iFlag)
    Return 1
EndFunc

Func __ResetFileInstall()
    $g_bFileInstallImplemented = False
    $g_hFn_FileInstall         = __Tstbl_Dummy_FileInstall
EndFunc

; ===============================================================================================================================
; Tests - __Tstbl_IsFileInstallDummy
; ===============================================================================================================================
Func _TestIsFileInstallDummy_TrueByDefault()
    _TestFmkHeader("Test: __Tstbl_IsFileInstallDummy() - returns True when pointer is dummy")

    __ResetFileInstall()

    _TestFmkAssert(__Tstbl_IsFileInstallDummy() = True, "Returns True when dummy wired", __Tstbl_IsFileInstallDummy(), True, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestIsFileInstallDummy_FalseWhenImplemented()
    _TestFmkHeader("Test: __Tstbl_IsFileInstallDummy() - returns False when implementation registered")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(__TestFileInstall)

    _TestFmkAssert(__Tstbl_IsFileInstallDummy() = False, "Returns False when implemented", __Tstbl_IsFileInstallDummy(), False, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __Tstbl_IsFileInstallImplemented
; ===============================================================================================================================
Func _TestIsFileInstallImplemented_FalseByDefault()
    _TestFmkHeader("Test: __Tstbl_IsFileInstallImplemented() - returns False by default")

    __ResetFileInstall()
	Local $bImplemented = __Tstbl_IsFileInstallImplemented()

    _TestFmkAssert($bImplemented = False, "Returns False by default", $bImplemented, False, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestIsFileInstallImplemented_TrueAfterImplement()
    _TestFmkHeader("Test: __Tstbl_IsFileInstallImplemented() - returns True after valid implementation registered")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(__TestFileInstall)
	Local $bImplemented = __Tstbl_IsFileInstallImplemented()

    _TestFmkAssert($bImplemented = True, "Returns True after implement", $bImplemented, True, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _Tstbl_Implement_FileInstall
; ===============================================================================================================================
Func _TestImplementFileInstall_SetsFlag()
    _TestFmkHeader("Test: _Tstbl_Implement_FileInstall() - sets implemented flag when valid function provided")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(__TestFileInstall)

    _TestFmkAssert($g_bFileInstallImplemented = True, "Flag set to True", $g_bFileInstallImplemented, True, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestImplementFileInstall_ClearsFlagWhenInvalid()
    _TestFmkHeader("Test: _Tstbl_Implement_FileInstall() - clears flag when invalid function provided")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(0)

    _TestFmkAssert($g_bFileInstallImplemented = False, "Flag stays False", $g_bFileInstallImplemented, False, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestImplementFileInstall_SetsPointer()
    _TestFmkHeader("Test: _Tstbl_Implement_FileInstall() - sets pointer to provided function")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(__TestFileInstall)
	Local $sFuncName = FuncName($g_hFn_FileInstall)

    _TestFmkAssert($sFuncName = "__TestFileInstall", "Pointer set to custom function", $sFuncName, "__TestFileInstall", $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestImplementFileInstall_FallsBackToDummyWhenInvalid()
    _TestFmkHeader("Test: _Tstbl_Implement_FileInstall() - falls back to dummy when invalid function provided")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(0)
	Local $bIsDummy = __Tstbl_IsFileInstallDummy()

    _TestFmkAssert($bIsDummy = True, "Pointer falls back to dummy", $bIsDummy, True, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestImplementFileInstall_DoesNotOverwriteStub()
    _TestFmkHeader("Test: _Tstbl_Implement_FileInstall() - does not overwrite stub pointer")

    __ResetFileInstall()
    $g_hFn_FileInstall = __Stub_FileInstall
    _Tstbl_Implement_FileInstall(__TestFileInstall)
	Local $sFuncName = FuncName($g_hFn_FileInstall)

    _TestFmkAssert($sFuncName = "__Stub_FileInstall", "Stub pointer not overwritten", $sFuncName, "__Stub_FileInstall", $TSTBL_FILE_INSTALL_TESTS)
    _TestFmkAssert($g_bFileInstallImplemented = True, "Flag still set", $g_bFileInstallImplemented, True, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _Tstbl_FileInstall
; ===============================================================================================================================
Func _TestTstblFileInstall_ReturnsErrorWhenDummy()
    _TestFmkHeader("Test: _Tstbl_FileInstall() - returns SetError(1,0,Null) when dummy wired")

    __ResetFileInstall()
    Local $vResult = _Tstbl_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)
    Local $iErr = @error

    _TestFmkAssert($iErr = 1, "Sets @error = 1", $iErr, 1, $TSTBL_FILE_INSTALL_TESTS)
    _TestFmkAssert($vResult = Null, "Returns Null", $vResult, Null, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

Func _TestTstblFileInstall_CallsImplementationWhenRegistered()
    _TestFmkHeader("Test: _Tstbl_FileInstall() - calls implementation when registered")

    __ResetFileInstall()
    _Tstbl_Implement_FileInstall(__TestFileInstall)
    Local $vResult = _Tstbl_FileInstall("path\to\file.au3", "C:\dest\file.au3", 1)

    _TestFmkAssert($vResult = 1, "Returns implementation result", $vResult, 1, $TSTBL_FILE_INSTALL_TESTS)
EndFunc

; ===============================================================================================================================
; Run tests
; ===============================================================================================================================
Func __RunTestableFileInstallTest_Tstbl_IsFileInstallDummy(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestIsFileInstallDummy_TrueByDefault,        $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestIsFileInstallDummy_FalseWhenImplemented, $bAllPassed)
EndFunc

Func __RunTestableFileInstallTest_Tstbl_IsFileInstallImplemented(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestIsFileInstallImplemented_FalseByDefault,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestIsFileInstallImplemented_TrueAfterImplement, $bAllPassed)
EndFunc

Func __RunTestableFileInstallTest_Tstbl_ImplementFileInstall(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestImplementFileInstall_SetsFlag,                    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestImplementFileInstall_ClearsFlagWhenInvalid,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestImplementFileInstall_SetsPointer,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestImplementFileInstall_FallsBackToDummyWhenInvalid, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestImplementFileInstall_DoesNotOverwriteStub,        $bAllPassed)
EndFunc

Func __RunTestableFileInstallTest_Tstbl_FileInstall(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestTstblFileInstall_ReturnsErrorWhenDummy,             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestTstblFileInstall_CallsImplementationWhenRegistered, $bAllPassed)
EndFunc

Func _RunTestableFileInstallTests($bWriteSummary = True)
    Local $bAllPassed = True
	__RunTestableFileInstallTest_Tstbl_IsFileInstallDummy($bAllPassed)
	__RunTestableFileInstallTest_Tstbl_IsFileInstallImplemented($bAllPassed)
	__RunTestableFileInstallTest_Tstbl_ImplementFileInstall($bAllPassed)
	__RunTestableFileInstallTest_Tstbl_FileInstall($bAllPassed)
    If $bWriteSummary Then _TestFmkSummary()
    Return $bAllPassed
EndFunc
_TestFmkRunAllTests(_RunTestableFileInstallTests, $TSTBL_FILE_INSTALL_TESTS)

