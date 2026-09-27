#include "TestFrameworkTests.au3"
#include "TestableFileInstallTests.au3"
#include "StubsCoreTests.au3"
#include "StubsFileInstallTests.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - _RunAllTests_TestFrameworkCore.au3
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Runs all AutoIt Test Framework core test suites.
; ===============================================================================================================================
_TestFmk_SetSilentMode(True)

Func _RunAllTests_TestFrameworkCore()

	Local $bWriteSummary = False
	Local $bAllPassed = True

	$bAllPassed = _RunTestFrameworkTests($bWriteSummary) And $bAllPassed
	$bAllPassed = _RunTestableFileInstallTests($bWriteSummary) And $bAllPassed
	$bAllPassed = _RunStubsCoreTests($bWriteSummary) And $bAllPassed
	$bAllPassed = _RunStubsFileInstallTests($bWriteSummary) And $bAllPassed

	_TestFmkSeparator(80, "=")
	__TestFmk_InfoConsoleWrite("+ Summary")
	_TestFmkSummary()

	Return $bAllPassed
EndFunc
Exit Not _RunAllTests_TestFrameworkCore()