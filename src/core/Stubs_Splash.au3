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
	Return __DefineStub("SplashTextOn", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), 1)
EndFunc

Func _Stub_SplashImageOn($sTitle, $sFile, $iWidth = -1, $iHeight = -1, $iXPos = -1, $iYPos = -1, $iOpt = 1)
	Return __DefineStub("SplashImageOn", __CallArgs("sTitle = " & $sTitle, "sFile = " & $sFile))
EndFunc

Func _Stub_SplashOff()
	Return __DefineStub("SplashOff", __CallArgs())
EndFunc

Func _Stub_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = -1, $iYPos = -1, $iOpt = 1)
	Return __DefineStub("ProgressOn", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText))
EndFunc

Func _Stub_ProgressSet($iPercent, $sText = "", $sTitle = "")
	Return __DefineStub("ProgressSet", __CallArgs("iPercent = " & $iPercent, "sText = " & $sText))
EndFunc

Func _Stub_ProgressOff()
	Return __DefineStub("ProgressOff", __CallArgs())
EndFunc

$g_hFn_SplashTextOn  = _Stub_SplashTextOn
$g_hFn_SplashImageOn = _Stub_SplashImageOn
$g_hFn_SplashOff     = _Stub_SplashOff
$g_hFn_ProgressOn    = _Stub_ProgressOn
$g_hFn_ProgressSet   = _Stub_ProgressSet
$g_hFn_ProgressOff   = _Stub_ProgressOff
