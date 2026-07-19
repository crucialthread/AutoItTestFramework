; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Input.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt input simulation functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_Send           = Send
Global $g_hFn_MouseClick     = MouseClick
Global $g_hFn_MouseMove      = MouseMove
Global $g_hFn_MouseGetPos    = MouseGetPos
Global $g_hFn_ControlClick   = ControlClick
Global $g_hFn_ControlSetText = ControlSetText
Global $g_hFn_ControlGetText = ControlGetText
Global $g_hFn_ControlSend    = ControlSend
Global $g_hFn_ControlFocus   = ControlFocus

Func _Tstbl_Send($sKeys, $iFlag = 0)
    Local $vResult = $g_hFn_Send($sKeys, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseClick($sButton = "left", $iX = -2147483647, $iY = -2147483647, $iClicks = 1, $iSpeed = -1)
    Local $vResult = $g_hFn_MouseClick($sButton, $iX, $iY, $iClicks, $iSpeed)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseMove($iX, $iY, $iSpeed = -1)
    Local $vResult = $g_hFn_MouseMove($iX, $iY, $iSpeed)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseGetPos($iIndex = 0)
    Local $vResult = $g_hFn_MouseGetPos($iIndex)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlClick($sTitle, $sText, $sControl, $sButton = "left", $iNumClicks = 1, $iX = -2147483647, $iY = -2147483647)
    Local $vResult = $g_hFn_ControlClick($sTitle, $sText, $sControl, $sButton, $iNumClicks, $iX, $iY)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlSetText($sTitle, $sText, $sControl, $sNewText, $bFlag = True)
    Local $vResult = $g_hFn_ControlSetText($sTitle, $sText, $sControl, $sNewText, $bFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlGetText($sTitle, $sText, $sControl)
    Local $vResult = $g_hFn_ControlGetText($sTitle, $sText, $sControl)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlSend($sTitle, $sText, $sControl, $sKeys, $iFlag = 0)
    Local $vResult = $g_hFn_ControlSend($sTitle, $sText, $sControl, $sKeys, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlFocus($sTitle, $sText, $sControl)
    Local $vResult = $g_hFn_ControlFocus($sTitle, $sText, $sControl)
    Return SetError(@error, @extended, $vResult)
EndFunc
