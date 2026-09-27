#include-once

#include "..\..\src\core\TestFramework.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFrameworkTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for TestFramework.au3.
;                  Tests core assertion, header, run, separator, silent mode, and summary functions.
;                  Uses direct access to internal counters to verify behavior
;                  without relying on the functions under test to report themselves.
; ===============================================================================================================================
Local Const $TST_FMK_TESTS = "TestFrameworkTests.au3"

; ===============================================================================================================================
; Tests - Helpers
; ===============================================================================================================================

; Test helper that always passes.
Func __PassingTestFunc()
    _TestFmkAssert(True, "Always passes")
EndFunc

; Invalid Test Func helper
Func __InvaliTestFuncWithParam($vParam)
EndFunc

; Test helper that always fails. Suppresses console output to avoid false-looking
; failure messages when used to verify the framework's fail path behavior.
; Used to not show any message but increase the failure count for tests that needs to test it
Func __FailingTestFunc()
    __TestFmk_SetFailureConsoleWrite(__TestFmk_VoidConsoleWrite)
    _TestFmkAssert(False, "Always fails")
    __TestFmk_SetFailureConsoleWrite(ConsoleWrite)
EndFunc

; Reverts the failed and total counters by 1 when an intentional failure was triggered
; to test framework behavior, keeping the suite totals accurate
Func __RevertCounters($bCondition)
    Local $iAdjust = $bCondition ? 1 : 0
    $__TestFmkFailed -= $iAdjust
    $__TestFmkCount  -= $iAdjust
EndFunc

Global $g_bRunnerCalled = False

Func __TestRunnerFunc()
    $g_bRunnerCalled = True
EndFunc

; ===============================================================================================================================
; Tests - _TestFmkAssert
; ===============================================================================================================================
Func _TestFmkAssert_PassIncrementsPassed()
    _TestFmkHeader("Test: _TestFmkAssert() - passing condition increments passed count")

    Local $iPassed = $__TestFmkPassed
    Local $iFailed = $__TestFmkFailed

    _TestFmkAssert(True, "This should pass", True, True)

    _TestFmkAssert($__TestFmkPassed = $iPassed + 1, "Passed count incremented", $__TestFmkPassed, $iPassed + 1, $TST_FMK_TESTS)
    _TestFmkAssert($__TestFmkFailed = $iFailed,     "Failed count unchanged",   $__TestFmkFailed, $iFailed, 	$TST_FMK_TESTS)
EndFunc

Func _TestFmkAssert_FailIncrementsFailure()
    _TestFmkHeader("Test: _TestFmkAssert() - failing condition increments failed count")

    Local $iPassed = $__TestFmkPassed
    Local $iFailed = $__TestFmkFailed

    __FailingTestFunc()

    _TestFmkAssert($__TestFmkPassed = $iPassed,     "Passed count unchanged",   $__TestFmkPassed, $iPassed	  , $TST_FMK_TESTS)
    _TestFmkAssert($__TestFmkFailed = $iFailed + 1, "Failed count incremented", $__TestFmkFailed, $iFailed + 1, $TST_FMK_TESTS)

    ; Revert intentional failure from counter totals
    __RevertCounters($__TestFmkFailed = $iFailed + 1)
EndFunc

Func _TestFmkAssert_WorksWithoutOptionalParams()
    _TestFmkHeader("Test: _TestFmkAssert() - works correctly with only required params")

    Local $iPassed = $__TestFmkPassed

    _TestFmkAssert(True, "Only required params")

    _TestFmkAssert($__TestFmkPassed = $iPassed + 1, "Passed count incremented", $__TestFmkPassed, $iPassed + 1, $TST_FMK_TESTS)
EndFunc

Func _TestFmkAssert_AcceptsScriptNameParam()
    _TestFmkHeader("Test: _TestFmkAssert() - accepts custom script name parameter")

    Local $iPassed = $__TestFmkPassed

    _TestFmkAssert(True, "Test with custom script name", "", "", "OtherScript.au3")

    _TestFmkAssert($__TestFmkPassed = $iPassed + 1, "Passed count incremented", $__TestFmkPassed, $iPassed + 1, $TST_FMK_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _TestFmkHeader
; ===============================================================================================================================
Func _TestFmkHeader_ResetsStubsByDefault()
    _TestFmkHeader("Test: _TestFmkHeader() - resets stubs by default")

    _SetStubReturn("SomeType", 1, "value")
    _TestFmkHeader("Resetting stubs", True, $TFW_COLOR_BLUE) ; Blue matches PASS color to distinguish from test section headers

    _TestFmkAssert(Not MapExists($g_StubReturns, "SomeType"), "Stubs reset after header", MapExists($g_StubReturns, "SomeType"), False, $TST_FMK_TESTS)
EndFunc

Func _TestFmkHeader_SkipsResetWhenFalse()
    _TestFmkHeader("Test: _TestFmkHeader() - skips reset when bResetStubs is False")

    _SetStubReturn("SomeType", 1, "value")
    _TestFmkHeader("Not resetting stubs", False, $TFW_COLOR_BLUE) ; Blue matches PASS color to distinguish from test section headers

    _TestFmkAssert(MapExists($g_StubReturns, "SomeType"), "Stubs not reset", MapExists($g_StubReturns, "SomeType"), True, $TST_FMK_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _TestFmkRun
; ===============================================================================================================================
Func _TestFmkRun_ReturnsTrueWhenPassing()
    _TestFmkHeader("Test: _TestFmkRun() - returns True when test passes")

    Local $bResult = _TestFmkRun(__PassingTestFunc, True)

    _TestFmkAssert($bResult = True, "Returns True for passing test", $bResult, True, $TST_FMK_TESTS)
EndFunc

Func _TestFmkRun_ReturnsFalseWhenFailing()
    _TestFmkHeader("Test: _TestFmkRun() - returns False when test fails")

    Local $bResult = _TestFmkRun(__FailingTestFunc, True)

    _TestFmkAssert($bResult = False, "Returns False for failing test", $bResult, False, $TST_FMK_TESTS)

    ; Revert intentional failure from counter totals
    __RevertCounters($bResult = False)
EndFunc

Func _TestFmkRun_AccumulatesAllPassed()
    _TestFmkHeader("Test: _TestFmkRun() - keeps True when all tests pass")

    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(__PassingTestFunc, $bAllPassed)
    $bAllPassed = _TestFmkRun(__PassingTestFunc, $bAllPassed)

    _TestFmkAssert($bAllPassed = True, "Stays True after all passing", $bAllPassed, True, $TST_FMK_TESTS)
EndFunc

Func _TestFmkRun_AccumulatesOneFailed()
    _TestFmkHeader("Test: _TestFmkRun() - becomes False and stays False after one failure")

    Local $bAllPassed = True
    $bAllPassed = _TestFmkRun(__PassingTestFunc, $bAllPassed)
    $bAllPassed = _TestFmkRun(__FailingTestFunc, $bAllPassed)
    $bAllPassed = _TestFmkRun(__PassingTestFunc, $bAllPassed)

    _TestFmkAssert($bAllPassed = False, "Stays False after one failure", $bAllPassed, False, $TST_FMK_TESTS)

    ; Revert intentional failure from counter totals
    __RevertCounters($bAllPassed = False)
EndFunc

Func _TestFmkRun_DoesNothingForInvalidFunction()
    _TestFmkHeader("Test: _TestFmkRun() - records failure for invalid function reference")

    Local $iFailed = $__TestFmkFailed
    __TestFmk_SetFailureConsoleWrite(__TestFmk_VoidConsoleWrite)
    _TestFmkRun("invalid function", True)
	_TestFmkRun(__InvaliTestFuncWithParam, True)
    __TestFmk_SetFailureConsoleWrite(ConsoleWrite)

    Local $iFailedAfter = $__TestFmkFailed
    _TestFmkAssert($iFailedAfter = $iFailed + 2, "Failure recorded for invalid function", $iFailedAfter, $iFailed + 2, $TST_FMK_TESTS)

	; Revert intentional failure from counter totals
	; (must be called twice to revert the two added failures)
    __RevertCounters($iFailedAfter = $iFailed + 2)
	__RevertCounters($iFailedAfter = $iFailed + 2)
EndFunc

; ===============================================================================================================================
; Tests - _TestFmk_SetSilentMode
; ===============================================================================================================================
Func _TestFmk_SetSilentMode_SetsTrueCorrectly()
    _TestFmkHeader("Test: _TestFmk_SetSilentMode() - sets silent mode to True")

    Local $bSilentMode = __TestFmk_IsSilentMode()

	_TestFmk_SetSilentMode(True)
    Local $bSilent = __TestFmk_IsSilentMode()
    _TestFmk_SetSilentMode(False)

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = True, "Silent mode set to True", $bSilent, True, $TST_FMK_TESTS)
EndFunc

Func _TestFmk_SetSilentMode_SetsFalseCorrectly()
    _TestFmkHeader("Test: _TestFmk_SetSilentMode() - sets silent mode to False")

	Local $bSilentMode = __TestFmk_IsSilentMode()

    _TestFmk_SetSilentMode(True)
    _TestFmk_SetSilentMode(False)
    Local $bSilent = __TestFmk_IsSilentMode()

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = False, "Silent mode set to False", $bSilent, False, $TST_FMK_TESTS)
EndFunc

Func _TestFmk_SetSilentMode_DefaultIsFalse()
    _TestFmkHeader("Test: _TestFmk_SetSilentMode() - defaults to False when called with no args")

	Local $bSilentMode = __TestFmk_IsSilentMode()

    _TestFmk_SetSilentMode(True)
    _TestFmk_SetSilentMode()
    Local $bSilent = __TestFmk_IsSilentMode()

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = False, "Defaults to False", $bSilent, False, $TST_FMK_TESTS)
EndFunc

Func _TestFmk_SetSilentMode_IgnoresNonBool()
    _TestFmkHeader("Test: _TestFmk_SetSilentMode() - ignores non-boolean value and defaults to False")

	Local $bSilentMode = __TestFmk_IsSilentMode()

    _TestFmk_SetSilentMode(True)
    _TestFmk_SetSilentMode("not a bool")
    Local $bSilent = __TestFmk_IsSilentMode()

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = False, "Non-bool ignored, defaults to False", $bSilent, False, $TST_FMK_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __TestFmk_IsSilentMode
; ===============================================================================================================================
Func _TestFmk_IsSilentMode_ReturnsFalseByDefault()
    _TestFmkHeader("Test: __TestFmk_IsSilentMode() - returns False by default")

	Local $bSilentMode = __TestFmk_IsSilentMode()

    _TestFmk_SetSilentMode(False)
	Local $bSilent = __TestFmk_IsSilentMode()

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = False, "Returns False by default", $bSilent, False, $TST_FMK_TESTS)
EndFunc

Func _TestFmk_IsSilentMode_ReturnsTrueWhenSet()
    _TestFmkHeader("Test: __TestFmk_IsSilentMode() - returns True when silent mode is set")

	Local $bSilentMode = __TestFmk_IsSilentMode()

    _TestFmk_SetSilentMode(True)
    Local $bSilent = __TestFmk_IsSilentMode()
    _TestFmk_SetSilentMode(False)

	; revert silent mode
	_TestFmk_SetSilentMode($bSilentMode)

    _TestFmkAssert($bSilent = True, "Returns True when set", $bSilent, True, $TST_FMK_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _TestFmkRunAllTests
; ===============================================================================================================================
Func _TestFmkRunAllTests_RunsWhenScriptNameMatches()
    _TestFmkHeader("Test: _TestFmkRunAllTests() - runs function when script name matches")

    $g_bRunnerCalled = False
    _TestFmkRunAllTests(__TestRunnerFunc, @ScriptName)

    _TestFmkAssert($g_bRunnerCalled = True, "Runner function called", $g_bRunnerCalled, True, $TST_FMK_TESTS)
EndFunc

Func _TestFmkRunAllTests_DoesNotRunWhenScriptNameDiffers()
    _TestFmkHeader("Test: _TestFmkRunAllTests() - does not run function when script name does not match")

    $g_bRunnerCalled = False
    _TestFmkRunAllTests(__TestRunnerFunc, "OtherScript.au3")

    _TestFmkAssert($g_bRunnerCalled = False, "Runner function not called", $g_bRunnerCalled, False, $TST_FMK_TESTS)
EndFunc

Func _TestFmkRunAllTests_DoesNothingForInvalidFunction()
    _TestFmkHeader("Test: _TestFmkRunAllTests() - does nothing when invalid function provided")

    _TestFmkRunAllTests(0, @ScriptName)

    _TestFmkAssert(True, "No crash for invalid function", True, True, $TST_FMK_TESTS)
EndFunc

; ===============================================================================================================================
; Run tests
; ===============================================================================================================================
Func __RunTestFrameworkTest_TestFmkAssert(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmkAssert_PassIncrementsPassed,   	 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkAssert_FailIncrementsFailure,  	 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestFmkAssert_WorksWithoutOptionalParams, $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestFmkAssert_AcceptsScriptNameParam, 	 $bAllPassed)
EndFunc

Func __RunTestFrameworkTest_TestFmkHeader(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmkHeader_ResetsStubsByDefault, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkHeader_SkipsResetWhenFalse,  $bAllPassed)
EndFunc

Func __RunTestFrameworkTest_TestFmkRun(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmkRun_ReturnsTrueWhenPassing,  		 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkRun_ReturnsFalseWhenFailing, 		 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkRun_AccumulatesAllPassed,    		 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkRun_AccumulatesOneFailed,    		 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestFmkRun_DoesNothingForInvalidFunction, $bAllPassed)
EndFunc

Func __RunTestFrameworkTest_SetSilentMode(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmk_SetSilentMode_SetsTrueCorrectly,  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmk_SetSilentMode_SetsFalseCorrectly, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmk_SetSilentMode_DefaultIsFalse,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmk_SetSilentMode_IgnoresNonBool,     $bAllPassed)
EndFunc

Func __RunTestFrameworkTest_IsSilentMode(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmk_IsSilentMode_ReturnsFalseByDefault, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmk_IsSilentMode_ReturnsTrueWhenSet,    $bAllPassed)
EndFunc

Func __RunTestFrameworkTest_TestFmkRunAllTests(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestFmkRunAllTests_RunsWhenScriptNameMatches,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkRunAllTests_DoesNotRunWhenScriptNameDiffers, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFmkRunAllTests_DoesNothingForInvalidFunction,   $bAllPassed)
EndFunc

Func _RunTestFrameworkTests($bWriteSummary = True)
    Local $bAllPassed = True
    __RunTestFrameworkTest_TestFmkAssert($bAllPassed)
    __RunTestFrameworkTest_TestFmkHeader($bAllPassed)
    __RunTestFrameworkTest_TestFmkRun($bAllPassed)
    __RunTestFrameworkTest_SetSilentMode($bAllPassed)
    __RunTestFrameworkTest_IsSilentMode($bAllPassed)
    __RunTestFrameworkTest_TestFmkRunAllTests($bAllPassed)
    If $bWriteSummary Then _TestFmkSummary()
    Return $bAllPassed
EndFunc
_TestFmkRunAllTests(_RunTestFrameworkTests, $TST_FMK_TESTS)
