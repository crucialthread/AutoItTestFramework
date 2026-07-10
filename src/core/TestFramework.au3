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

; Console output color constants — prefix characters for SciTE console coloring
Global Const $TFW_COLOR_WHITE  = ":"  ; white (no color)
Global Const $TFW_COLOR_RED    = "!"  ; bold red
Global Const $TFW_COLOR_BLUE   = ">"  ; blue
Global Const $TFW_COLOR_YELLOW = "-"  ; bold yellow
Global Const $TFW_COLOR_ORANGE = "+"  ; bold orange

Global $__TestFmkCount  = 0
Global $__TestFmkPassed = 0
Global $__TestFmkFailed = 0

; Print a test section header
; $sTitle  - title of the test section
; $sColor  - color constant: $TFW_COLOR_ORANGE (default), $TFW_COLOR_YELLOW, $TFW_COLOR_BLUE, $TFW_COLOR_RED
Func _TestFmkHeader($sTitle, $sColor = $TFW_COLOR_ORANGE)
    ConsoleWrite(@CRLF & $sColor & " --- " & $sTitle & " ---" & @CRLF)
EndFunc

; Assert a condition and record pass/fail
; $bCondition   - condition to evaluate
; $sDescription - description of the test
; $vActual      - optional actual value to display on failure
; $vExpected    - optional expected value to display on failure
Func _TestFmkAssert($bCondition, $sDescription, $vActual = "", $vExpected = "")
    $__TestFmkCount += 1
    If $bCondition Then
        $__TestFmkPassed += 1
        ConsoleWrite($TFW_COLOR_BLUE & " [PASS] " & $sDescription & @CRLF)
    Else
        $__TestFmkFailed += 1
        Local $sDetail = ""
        If $vActual <> "" Or $vExpected <> "" Then
            $sDetail = " (expected: " & $vExpected & ", actual: " & $vActual & ")"
        EndIf
        ConsoleWrite($TFW_COLOR_RED & " [FAIL] " & $sDescription & $sDetail & @CRLF)
    EndIf
EndFunc

; Run a test function and return True if no new failures were added
; $fTest        - function reference to the test to run
; $bCumulative  - optional cumulative result from previous tests (default: True)
;                 pass $bAllPassed to accumulate results across multiple tests
; Returns       : True if this test passed AND $bCumulative is True, False otherwise
Func _TestFmkRun($fTest, $bCumulative = True)

	; snapshot about failures count before test runs
    Local $iFailed = $__TestFmkFailed

	; run test where _TestFmkAssert used for the test updates the global $__TestFmkFailed
    $fTest()

	; True if the new total failures count is the same than before, false otherwise
    Local $bResult = $__TestFmkFailed = $iFailed

	; Return True if no new failures were added,
	; and accumulate with previous results
    Return $bResult And $bCumulative
EndFunc

; Print test summary
Func _TestFmkSummary()
    ConsoleWrite(@CRLF & "==============================" & @CRLF)
    ConsoleWrite($TFW_COLOR_ORANGE & " Total:  " & $__TestFmkCount  & @CRLF)
    ConsoleWrite($TFW_COLOR_BLUE   & " Passed: " & $__TestFmkPassed & @CRLF)
    If $__TestFmkFailed > 0 Then
        ConsoleWrite($TFW_COLOR_RED   & " Failed: " & $__TestFmkFailed & @CRLF)
    Else
        ConsoleWrite($TFW_COLOR_WHITE & " Failed: " & $__TestFmkFailed & @CRLF)
    EndIf
    ConsoleWrite("==============================" & @CRLF)
EndFunc
