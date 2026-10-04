#include-once

#include "..\..\lib\CrucialSetupWizard\CrucialSetupWizard.au3"
#include "..\..\lib\TryCatch\TryCatch.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFmkInstallerShared.au3
; Version .......: 1.0.1
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: AutoIt Test Framework Installer/Uninstaller shared constants, globals, and functions.
;
; Dependencies ..: AutoItTryCatch (https://github.com/crucialthread/AutoItTryCatch) to provide try/catch and thrown exceptions
;                  CrucialSetupWizard (https://github.com/crucialthread/CrucialSetupWizard) to provide installer GUI wizard
;                  AutoItTestFramework itself from the dist branch as a submodule, required by CrucialSetupWizard
; ===============================================================================================================================

; ===============================================================================================================================
; Constants
; ===============================================================================================================================

Global Const $TFW_INSTALLER_VERSION = "1.0.1"
Global Const $TFW_APP_NAME 			= "AutoIt Test Framework"
Global Const $TFW_UNINSTALLER_TITLE = $TFW_APP_NAME & " Uninstall"

Global Const $REG_UNINSTALL_KEY  = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItTestFramework"
Global Const $REG_INSTALL_KEY    = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt TestFramework"
Global Const $REG_AUTOIT_KEY_WOW = "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\AutoIt v3\AutoIt"
Global Const $REG_AUTOIT_KEY     = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt"
Global Const $REG_AUTOIT_INCLUDE = "HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt"

; ===============================================================================================================================
; Global state
; ===============================================================================================================================

Global $g_sAutoItDir   = ""
Global $g_sIncludePath = ""
Global $g_sInstallPath = ""
Global $g_bIsUpgrade   = False

; #FUNCTION# ====================================================================================================================
; An unitility wrap-up to _ProgressStep that does not update progressbar if an exception was thrown
; ===============================================================================================================================
Func __UpdateProgressBar($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
	If _OnErrorResume() Then Return SetError(__GetStackCount(), 0, False)
	_ProgressStep($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
EndFunc