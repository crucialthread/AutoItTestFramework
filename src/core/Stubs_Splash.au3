; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Splash.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt splash and progress functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = -1, $iYPos = -1, $iOpt = 1, $sFont = "", $iFontSize = 15, $iFontStyle = 0)
	Local $vReturn = __DefineStub("SplashTextOn", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_SplashImageOn($sTitle, $sFile, $iWidth = -1, $iHeight = -1, $iXPos = -1, $iYPos = -1, $iOpt = 1)
	Local $vReturn = __DefineStub("SplashImageOn", __CallArgs("sTitle = " & $sTitle, "sFile = " & $sFile))
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_SplashOff()
	Local $vReturn = __DefineStub("SplashOff", __CallArgs())
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = -1, $iYPos = -1, $iOpt = 1)
	Local $vReturn = __DefineStub("ProgressOn", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText))
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_ProgressSet($iPercent, $sText = "", $sTitle = "")
	Local $vReturn = __DefineStub("ProgressSet", __CallArgs("iPercent = " & $iPercent, "sText = " & $sText))
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_ProgressOff()
	Local $vReturn = __DefineStub("ProgressOff", __CallArgs())
	Return SetError(@error, 0, $vReturn)
EndFunc


$g_hFn_SplashTextOn  = _Stub_SplashTextOn
$g_hFn_SplashImageOn = _Stub_SplashImageOn
$g_hFn_SplashOff     = _Stub_SplashOff
$g_hFn_ProgressOn    = _Stub_ProgressOn
$g_hFn_ProgressSet   = _Stub_ProgressSet
$g_hFn_ProgressOff   = _Stub_ProgressOff
