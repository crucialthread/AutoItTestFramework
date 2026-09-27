#include-once

#include "Stubs.au3"

;#INDEX# ========================================================================================================================
; Title .........: AutoIt Test Framework - TestFramework.au3
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: A lightweight unit test framework for AutoIt.
;                  Provides assertion and summary functions for unit tests.
;================================================================================================================================

;#FUNCTIONS# ====================================================================================================================
; _TestFmk_SetSilentMode	- Enables or disables silent mode (pass and header output are suppressed)
; _TestFmkHeader			- Prints a labeled section header to identify a group of related tests
; _TestFmkAssert			- Evaluates a condition, records pass or fail, and prints the result
; _TestFmkRun				- Runs a test function and accumulates its pass/fail result into a cumulative boolean
; _TestFmkSeparator			- Prints a separator line to visually divide groups of related tests
; _TestFmkSummary			- Prints the final Total/Passed/Failed summary block
; _TestFmkRunAllTests		- Runs the test suite function
; ===============================================================================================================================

;#INTERNAL_USE_ONLY# ============================================================================================================
; __TestFmk_IsSilentMode
; __TestFmk_InfoConsoleWrite
; __TestFmk_FailureConsoleWrite
; __TestFmk_VoidConsoleWrite
; __TestFmk_SetFailureConsoleWrite
; ===============================================================================================================================

;================================================================================================================================
#Region ; >>> [GLOBALS]
;================================================================================================================================

; Constant guard to enpower the script under test do not automatically run the
; entry point function in test mode by #include, allowing its functions to be tested.
; Usage example: > If Not IsDeclared("__TFW_TEST_MODE") Then _EntryPoint_Func()
Global const $__TFW_TEST_MODE = True

; Display test line number on every _TestFmkHeader
; Useful to debug large test files with many headers
Global $__bTestFmwVerbose = False

; If true shows only failure messages
Global $__bTestFmwSilent  = False

; Function pointer for ConsoleWrite used by _TestFmkAssert on failure output.
; Can be replaced via __TestFmk_SetFailureConsoleWrite() to suppress output in tests
; that intentionally trigger failures to verify framework behavior.
; Note: Used to tests for TestFramework.au3 itself
Global $g_hFn_TestFmkFailureConsoleWrite = ConsoleWrite

; Console output color constants — prefix characters for SciTE console coloring
Global Const $TFW_COLOR_WHITE  = ":"  ; white (no color)
Global Const $TFW_COLOR_RED    = "!"  ; bold red
Global Const $TFW_COLOR_BLUE   = ">"  ; blue
Global Const $TFW_COLOR_YELLOW = "-"  ; bold yellow
Global Const $TFW_COLOR_ORANGE = "+"  ; bold orange

; Accumulator Test counters
Global $__TestFmkCount  = 0
Global $__TestFmkPassed = 0
Global $__TestFmkFailed = 0

;================================================================================================================================
#EndRegion <<< [GLOBALS]
;================================================================================================================================

;================================================================================================================================
#Region ; >>> [INTERNAL_USE_ONLY]
;================================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Check if the silent mode is on or off
Func __TestFmk_IsSilentMode()
	Return $__bTestFmwSilent
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Receives the text to be displayed and shows only if tne silent mode is off
Func __TestFmk_InfoConsoleWrite($sText)
	If Not __TestFmk_IsSilentMode() Then ConsoleWrite($sText)
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ConsoleWrite wrapper for failure output in _TestFmkAssert. Routes through
; $g_hFn_TestFmkFailureConsoleWrite allowing output to be suppressed in tests that
; intentionally trigger failures to verify framework behavior.
; Note: Used to tests for TestFramework.au3 itself
Func __TestFmk_FailureConsoleWrite($sText)
    Local $vResult = $g_hFn_TestFmkFailureConsoleWrite($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ConsoleWrite replacement that does nothing - suppresses failure output.
; Used in tests that intentionally trigger _TestFmkAssert failures to verify
; framework behavior without polluting the console with false-looking failures.
; Note: Used to tests for TestFramework.au3 itself
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
Func __TestFmk_SetFailureConsoleWrite($hConsoleWrite)
	$g_hFn_TestFmkFailureConsoleWrite = IsFunc($hConsoleWrite) ? $hConsoleWrite : ConsoleWrite
EndFunc

;================================================================================================================================
#EndRegion <<< [INTERNAL_USE_ONLY]
;================================================================================================================================

;================================================================================================================================
#Region ; >>> [FUNCTIONS]
;================================================================================================================================

; #FUNCTION# ====================================================================================================================
; Set silent mode on/off
; Mode  on: supress messages but failure
; Mode off: display any message (Default)
Func _TestFmk_SetSilentMode($bSilent = False)
	$__bTestFmwSilent = IsBool($bSilent)? $bSilent : False
EndFunc

; #FUNCTION# ====================================================================================================================
; Print a test section header
; $sTitle  	   - title of the test section
; $bResetStubs - Automatically run _ResetStubs() (see StubsCore.au3 for more details)
; $sColor      - color constant: $TFW_COLOR_ORANGE (default), $TFW_COLOR_YELLOW, $TFW_COLOR_BLUE, $TFW_COLOR_RED
; $LineNumber  - Line in the test related to the _TestFmkHeader
; Note ........: Setting global $__bTestFmwVerbose to true display the line number for the header.
;                Useful to debug large test files with many headers
Func _TestFmkHeader($sTitle, $bResetStubs = True, $sColor = $TFW_COLOR_ORANGE, $LineNumber = @ScriptLineNumber)
	Local $sVerbose = $__bTestFmwVerbose ? "[#" & $LineNumber & "] " : ""
	__TestFmk_InfoConsoleWrite(@CRLF & $sColor & " --- " & $sVerbose & $sTitle & " --- " & @CRLF)
	If $bResetStubs Then _ResetStubs()
EndFunc

; #FUNCTION# ====================================================================================================================
; Assert a condition and record pass/fail
; $bCondition   - condition to evaluate
; $sDescription - description of the test
; $vActual      - the actual value produced by condition to be displayed on failure
; $vExpected    - the expected value to be displayed on failure
; $sScriptName  - script name where the assertion lives; defaults to @ScriptName and is
;                 included in the failure output only when it differs from the running script
; $LineNumber   - line in the test file related to the failure
Func _TestFmkAssert($bCondition, $sDescription, $vActual = "", $vExpected = "", $sScriptName = @ScriptName, $LineNumber = @ScriptLineNumber)
    $__TestFmkCount += 1
    If $bCondition Then
        $__TestFmkPassed += 1
        __TestFmk_InfoConsoleWrite($TFW_COLOR_BLUE & " [PASS] " & $sDescription & @CRLF)
    Else
        $__TestFmkFailed += 1
        Local $sDetail = ""
        If String($vActual) <> "" Or String($vExpected) <> "" Then
			$sDetail = " (actual: " & $vActual & ", expected: " & $vExpected & ")"
        EndIf
		$sScriptName = @ScriptName <> $sScriptName ? $sScriptName & " - " : ""
		$sDetail = $sDetail & " [" & $sScriptName & "Line: " & $LineNumber & "]"
		__TestFmk_FailureConsoleWrite($TFW_COLOR_RED & " [FAIL] " & $sDescription & $sDetail & @CRLF)
    EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Run a test function and return True if no new failures were added
; $hFuncTest      - function reference to the test to run. If the reference is invalid or
;                   the function cannot be called, a failure is recorded automatically.
; $bNothingFailed - optional accumulated failure state from previous tests (default: True)
;                   pass $bNothingFailed to accumulate results across multiple tests,
;                   becomes False once any test in the chain fails
; Returns         : True if this test passed AND $bNothingFailed is True, False otherwise
Func _TestFmkRun($hFuncTest, $bNothingFailed = True)

	; snapshot about failures count before test runs
    Local $iFailed = $__TestFmkFailed

	; run test where _TestFmkAssert used for the test updates the global $__TestFmkFailed
	; Increase failures if the test function is invalid
	Local $bFuncError = Not IsFunc($hFuncTest)
	If Not $bFuncError Then Call($hFuncTest)
	$bFuncError = $bFuncError Or (@error = 0xDEAD And @extended = 0xBEEF)
	If $bFuncError Then _TestFmkAssert(False, "ERROR: Invalid function reference to test on _TestFmkRun")

	; True if the new total failures count is the same than before, false otherwise
    Local $bResult = $__TestFmkFailed = $iFailed

	; Return True only if this test passed and nothing has failed before it
    Return $bResult And $bNothingFailed
EndFunc

; #FUNCTION# ====================================================================================================================
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
	__TestFmk_InfoConsoleWrite($vNewLineBefore & $sSeparator & $vNewLineAfter)
EndFunc

; #FUNCTION# ====================================================================================================================
; Print test summary
Func _TestFmkSummary()
	_TestFmkSeparator(80, "=")
	ConsoleWrite($TFW_COLOR_ORANGE & " Total:  " & $__TestFmkCount  & @CRLF)
    __TestFmk_InfoConsoleWrite($TFW_COLOR_BLUE   & " Passed: " & $__TestFmkPassed & @CRLF)
    If $__TestFmkFailed > 0 Then
        ConsoleWrite($TFW_COLOR_RED   & " Failed: " & $__TestFmkFailed & @CRLF)
    Else
        ConsoleWrite($TFW_COLOR_WHITE & " Failed: " & $__TestFmkFailed & @CRLF)
    EndIf
	_TestFmkSeparator(80, "=", Null)
EndFunc

; #FUNCTION# ====================================================================================================================
; Runs the given test function only when the current script matches $sScriptName.
; Allows test scripts to be included by another script without auto-executing their tests.
; Each test script should call this at the bottom passing its own runner function
; Default $sScriptName = @ScriptName makes the test runner execute only when the script is run directly (TODO review, seems not be true)
Func _TestFmkRunAllTests($hRunnerFunction, $sScriptName = @ScriptName)
	If Not IsFunc($hRunnerFunction) Then Return
	If @ScriptName = $sScriptName Then $hRunnerFunction()
EndFunc

;================================================================================================================================
#EndRegion <<< [FUNCTIONS]
;================================================================================================================================