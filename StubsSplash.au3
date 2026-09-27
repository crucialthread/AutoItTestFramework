#include-once

#include "StubsCore.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsSplash.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt splash and progress functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

Func __Stub_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOption = 0, $sFontName = "", $iFontSize = 12, $iFontWeight = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "iWidth = " & $iWidth, "iHeight = " & $iHeight, _
							  "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOption = " & $iOption, _
							  "sFontName = " & $sFontName, "iFontSize = " & $iFontSize, "iFontWeight = " & $iFontWeight)
	Local $vReturn = __DefineStub("SplashTextOn", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_SplashImageOn($sTitle, $sFileName, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOption = 1)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sFileName = " & $sFileName, "iWidth = " & $iWidth, "iHeight = " & $iHeight, _
							  "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOption = " & $iOption)
	Local $vReturn = __DefineStub("SplashImageOn", $aArgs)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_SplashOff()
	Local $vReturn = __DefineStub("SplashOff", __CallArgs())
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = Default, $iYPos = Default, $iOption = 1)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sSubText = " & $sSubText, "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iOption = " & $iOption)
	Local $vReturn = __DefineStub("ProgressOn", $aArgs)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProgressSet($iPercent, $sText = "", $sTitle = "")
	Local $vReturn = __DefineStub("ProgressSet", __CallArgs("iPercent = " & $iPercent, "sText = " & $sText, "sTitle = " & $sTitle))
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
