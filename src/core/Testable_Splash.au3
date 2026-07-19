; #INDEX# =======================================================================================================================
; Title .........: Testable_Splash.au3
; Title .........: AutoIt Test Framework - Testable_Splash.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt splash and progress functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_SplashTextOn  = SplashTextOn
Global $g_hFn_SplashImageOn = SplashImageOn
Global $g_hFn_SplashOff     = SplashOff
Global $g_hFn_ProgressOn    = ProgressOn
Global $g_hFn_ProgressSet   = ProgressSet
Global $g_hFn_ProgressOff   = ProgressOff

Func _Tstbl_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = -1, $iYPos = -1, $iOpt = 1, $sFont = "", $iFontSize = 15, $iFontStyle = 0)
    Local $vResult = $g_hFn_SplashTextOn($sTitle, $sText, $iWidth, $iHeight, $iXPos, $iYPos, $iOpt, $sFont, $iFontSize, $iFontStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_SplashImageOn($sTitle, $sFile, $iWidth = -1, $iHeight = -1, $iXPos = -1, $iYPos = -1, $iOpt = 1)
    Local $vResult = $g_hFn_SplashImageOn($sTitle, $sFile, $iWidth, $iHeight, $iXPos, $iYPos, $iOpt)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_SplashOff()
    Local $vResult = $g_hFn_SplashOff()
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = -1, $iYPos = -1, $iOpt = 1)
    Local $vResult = $g_hFn_ProgressOn($sTitle, $sText, $sSubText, $iXPos, $iYPos, $iOpt)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProgressSet($iPercent, $sText = "", $sTitle = "")
    Local $vResult = $g_hFn_ProgressSet($iPercent, $sText, $sTitle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProgressOff()
    Local $vResult = $g_hFn_ProgressOff()
    Return SetError(@error, @extended, $vResult)
EndFunc
