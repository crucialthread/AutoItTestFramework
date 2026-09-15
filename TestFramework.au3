; #INDEX# =======================================================================================================================
; Title .........: TestFramework.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Description ...: A simple unit test framework for AutoIt.
;                  Provides assertion and summary functions for unit tests.
; Author ........: Crucial Thread
; Dependencies ..: None
; Usage .........: #include "TestFramework.au3"
;                  _TestFmkHeader($sTitle)
;                  _TestFmkAssert($bCondition, $sDescription)
;                  _TestFmkAssert($bCondition, $sDescription, $vActual, $vExpected)
;                  _TestFmkRun($fTest)
;                  _TestFmkSummary()
; ===============================================================================================================================

#include-once
#include "Stubs.au3"

; Constant guard to enpower the script under test do not automatically run the
; entry point function in test mode by #include, allowing its functions to be tested.
; Usage example: > If Not IsDeclared("__TFW_TEST_MODE") Then _EntryPoint_Func()
Global const $__TFW_TEST_MODE = True

; Display test line number on every _TestFmkHeader
; Useful for large test files with many headers
Global $__bTestFmwVerbose = False

; Console output color constants — prefix characters for SciTE console coloring
Global Const $TFW_COLOR_WHITE  = ":"  ; white (no color)
Global Const $TFW_COLOR_RED    = "!"  ; bold red
Global Const $TFW_COLOR_BLUE   = ">"  ; blue
Global Const $TFW_COLOR_YELLOW = "-"  ; bold yellow
Global Const $TFW_COLOR_ORANGE = "+"  ; bold orange

Global $__TestFmkCount  = 0
Global $__TestFmkPassed = 0
Global $__TestFmkFailed = 0

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Function pointer for ConsoleWrite used by _TestFmkAssert on failure output.
; Can be replaced via __TestFmk_SetConsoleWrite() to suppress output in tests
; that intentionally trigger failures to verify framework behavior.
Global $g_hFn_TestFmkConsoleWrite = ConsoleWrite

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ConsoleWrite wrapper for failure output in _TestFmkAssert. Routes through
; $g_hFn_TestFmkConsoleWrite allowing output to be suppressed in tests that
; intentionally trigger failures to verify framework behavior.
Func __TestFmk_ConsoleWrite($sText)
    Local $vResult = $g_hFn_TestFmkConsoleWrite($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ConsoleWrite replacement that does nothing - suppresses failure output.
; Used in tests that intentionally trigger _TestFmkAssert failures to verify
; framework behavior without polluting the console with false-looking failures.
Func __TestFmk_VoidConsoleWrite($sText)
	Return
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Sets the ConsoleWrite function used by _TestFmkAssert on failure output.
; Pass __TestFmk_VoidConsoleWrite to suppress output, ConsoleWrite to restore.
; Falls back to ConsoleWrite if an invalid function is provided.
; Note: created mainly to allow create tests for the test framework itself
;       suppressesing console failures output to avoid false-looking during tests
;		intended to check the failures, but can be used by any other test that needs to do the same.
Func __TestFmk_SetConsoleWrite($hConsoleWrite)
	$g_hFn_TestFmkConsoleWrite = IsFunc($hConsoleWrite) ? $hConsoleWrite : ConsoleWrite
EndFunc

; Print a test section header
; $sTitle  	   - title of the test section
; $bResetStubs - Automatically run _ResetStubs() (see StubsCore.au3 for more details)
; $sColor      - color constant: $TFW_COLOR_ORANGE (default), $TFW_COLOR_YELLOW, $TFW_COLOR_BLUE, $TFW_COLOR_RED
; $LineNumber  - Line in the test related to the _TestFmkHeader
Func _TestFmkHeader($sTitle, $bResetStubs = True, $sColor = $TFW_COLOR_ORANGE, $LineNumber = @ScriptLineNumber)
	Local $sVerbose = $__bTestFmwVerbose ? "[#" & $LineNumber & "] " : ""
	ConsoleWrite(@CRLF & $sColor & " --- " & $sVerbose & $sTitle & " --- " & @CRLF)
	If $bResetStubs Then _ResetStubs()
EndFunc

; Assert a condition and record pass/fail
; $bCondition   - condition to evaluate
; $sDescription - description of the test
; $vActual      - optional actual value to display on failure
; $vExpected    - optional expected value to display on failure
; $LineNumber   - line in the test related to the failure
Func _TestFmkAssert($bCondition, $sDescription, $vActual = "", $vExpected = "", $LineNumber = @ScriptLineNumber)
    $__TestFmkCount += 1
    If $bCondition Then
        $__TestFmkPassed += 1
        ConsoleWrite($TFW_COLOR_BLUE & " [PASS] " & $sDescription & @CRLF)
    Else
        $__TestFmkFailed += 1
        Local $sDetail = ""
        If String($vActual) <> "" Or String($vExpected) <> "" Then
			$sDetail = " (actual: " & $vActual & ", expected: " & $vExpected & ")"
        EndIf
		$sDetail = $sDetail & " [Line: " & $LineNumber & "]"
		__TestFmk_ConsoleWrite($TFW_COLOR_RED & " [FAIL] " & $sDescription & $sDetail & @CRLF)
    EndIf
EndFunc

; Run a test function and return True if no new failures were added
; $fTest          - function reference to the test to run
; $bNothingFailed - optional accumulated state from previous tests (default: True)
;                   pass $bNothingFailed to accumulate results across multiple tests,
;                   becomes False once any test in the chain fails
; Returns         : True if this test passed AND $bNothingFailed is True, False otherwise
Func _TestFmkRun($fTest, $bNothingFailed = True)

	; snapshot about failures count before test runs
    Local $iFailed = $__TestFmkFailed

	; run test where _TestFmkAssert used for the test updates the global $__TestFmkFailed
    $fTest()

	; True if the new total failures count is the same than before, false otherwise
    Local $bResult = $__TestFmkFailed = $iFailed

	; Return True only if this test passed and nothing has failed before it
    Return $bResult And $bNothingFailed
EndFunc

; Print a separator line for a given length and character with an optional new line before and after
; $iLength 		  - lenght of the line (default 80)
; $sChar 		  - character to print (default "-")
; $vNewLineBefore - New line before (default), or Null
; $vNewLineAfter  - New line after (default), or Null
Func _TestFmkSeparator($iLength = 80, $sChar = "-", $vNewLineBefore = @CRLF, $vNewLineAfter = @CRLF)
	Local $sSeparator = ""
	For $i = 1 to Int($iLength)
		$sSeparator &= $sChar
	Next
	ConsoleWrite($vNewLineBefore & $sSeparator & $vNewLineAfter)
EndFunc

; Print test summary
Func _TestFmkSummary()
	_TestFmkSeparator(80, "=")
    ConsoleWrite($TFW_COLOR_ORANGE & " Total:  " & $__TestFmkCount  & @CRLF)
    ConsoleWrite($TFW_COLOR_BLUE   & " Passed: " & $__TestFmkPassed & @CRLF)
    If $__TestFmkFailed > 0 Then
        ConsoleWrite($TFW_COLOR_RED   & " Failed: " & $__TestFmkFailed & @CRLF)
    Else
        ConsoleWrite($TFW_COLOR_WHITE & " Failed: " & $__TestFmkFailed & @CRLF)
    EndIf
	_TestFmkSeparator(80, "=", Null)
EndFunc

; Runs the given test function only when the current script matches $sScriptName.
; Allows test scripts to be included by another script without auto-executing their tests.
; Each test script should call this at the bottom passing its own runner function
; Default $sScriptName = @ScriptName makes the test runner execute only when the script is run directly (TODO review, seems not be true)
Func _TestFmkRunAllTests($hRunnerFunction, $sScriptName = @ScriptName)
	If Not IsFunc($hRunnerFunction) Then Return
	If @ScriptName = $sScriptName Then $hRunnerFunction()
EndFunc
