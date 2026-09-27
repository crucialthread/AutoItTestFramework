#include-once

; #INDEX# =======================================================================================================================
; Title .........: TestableSplash.au3
; Title .........: AutoIt Test Framework - Testable_Splash.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt splash and progress functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

Global $g_hFn_SplashTextOn  = SplashTextOn
Global $g_hFn_SplashImageOn = SplashImageOn
Global $g_hFn_SplashOff     = SplashOff
Global $g_hFn_ProgressOn    = ProgressOn
Global $g_hFn_ProgressSet   = ProgressSet
Global $g_hFn_ProgressOff   = ProgressOff

Func _Tstbl_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOption = 0, $sFontName = "", $iFontSize = 12, $iFontWeight = 0)
    Local $vResult = $g_hFn_SplashTextOn($sTitle, $sText, $iWidth, $iHeight, $iXPos, $iYPos, $iOption, $sFontName, $iFontSize, $iFontWeight)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_SplashImageOn($sTitle, $sFileName, $iWidth = 500, $iHeight = 400, $iXPos = Default, $iYPos = Default, $iOption = 1)
    Local $vResult = $g_hFn_SplashImageOn($sTitle, $sFileName, $iWidth, $iHeight, $iXPos, $iYPos, $iOption)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_SplashOff()
    Local $vResult = $g_hFn_SplashOff()
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = Default, $iYPos = Default, $iOption = 1)
    Local $vResult = $g_hFn_ProgressOn($sTitle, $sText, $sSubText, $iXPos, $iYPos, $iOption)
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
