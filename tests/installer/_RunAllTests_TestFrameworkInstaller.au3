#include "TestFrameworkInstallerTests.au3"
#include "TestFrameworkUninstallerTests.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - _RunAllTests_TestFrameworkInstaller.au3
; Version .......: 1.1.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Runs all AutoIt Test Framework installer and uninstaller test suites.
; ===============================================================================================================================
_TestFmk_SetSilentMode(True)

Func _RunAllTests_TestFrameworkInstaller()

	Local $bWriteSummary = False
	Local $bAllPassed = True

	$bAllPassed = _RunTestFrameworkInstallerTests($bWriteSummary) And $bAllPassed
	$bAllPassed = _RunTestFrameworkUninstallerTests($bWriteSummary) And $bAllPassed

	_TestFmkSeparator(80, "=")
	__TestFmk_InfoConsoleWrite("+ Summary")
	_TestFmkSummary()

	Return $bAllPassed
EndFunc
Exit Not _RunAllTests_TestFrameworkInstaller()