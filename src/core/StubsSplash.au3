; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Splash.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt splash and progress functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOpt = 0, $sFont = "", $iFontSize = 12, $iFontStyle = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "iWidth = " & $iWidth, "iHeight = " & $iHeight, _
							  "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOpt = " & $iOpt, _
							  "sFont = " & $sFont, "iFontSize = " & $iFontSize, "iFontStyle = " & $iFontStyle)
	Local $vReturn = __DefineStub("SplashTextOn", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func __Stub_SplashImageOn($sTitle, $sFile, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOpt = 1)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sFile = " & $sFile, "iWidth = " & $iWidth, "iHeight = " & $iHeight, _
							  "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOpt = " & $iOpt)
	Local $vReturn = __DefineStub("SplashImageOn", $aArgs)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func __Stub_SplashOff()
	Local $vReturn = __DefineStub("SplashOff", __CallArgs())
	Return SetError(@error, 0, $vReturn)
EndFunc


Func __Stub_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = Default, $iYPos = Default, $iOpt = 1)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sSubText = " & $sSubText, "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOpt = " & $iOpt)
	Local $vReturn = __DefineStub("ProgressOn", $aArgs)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func __Stub_ProgressSet($iPercent, $sText = "", $sTitle = "")
	Local $vReturn = __DefineStub("ProgressSet", __CallArgs("iPercent = " & $iPercent, "sText = " & $sText))
	Return SetError(@error, 0, $vReturn)
EndFunc


Func __Stub_ProgressOff()
	Local $vReturn = __DefineStub("ProgressOff", __CallArgs())
	Return SetError(@error, 0, $vReturn)
EndFunc


$g_hFn_SplashTextOn  = __Stub_SplashTextOn
$g_hFn_SplashImageOn = __Stub_SplashImageOn
$g_hFn_SplashOff     = __Stub_SplashOff
$g_hFn_ProgressOn    = __Stub_ProgressOn
$g_hFn_ProgressSet   = __Stub_ProgressSet
$g_hFn_ProgressOff   = __Stub_ProgressOff
