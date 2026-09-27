#include-once

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableInput.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt input simulation functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

Global $g_hFn_Send           = Send
Global $g_hFn_MouseClick     = MouseClick
Global $g_hFn_MouseMove      = MouseMove
Global $g_hFn_MouseGetPos    = MouseGetPos
Global $g_hFn_ControlClick   = ControlClick
Global $g_hFn_ControlSetText = ControlSetText
Global $g_hFn_ControlGetText = ControlGetText
Global $g_hFn_ControlSend    = ControlSend
Global $g_hFn_ControlFocus   = ControlFocus

Func _Tstbl_Send($sKeyStrokes, $iFlag = 0)
    Local $vResult = $g_hFn_Send($sKeyStrokes, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseClick($sButton = "left", $iXPos = Default, $iYPos = Default, $iClicks = 1, $iSpeed = 10)
    Local $vResult = $g_hFn_MouseClick($sButton, $iXPos, $iYPos, $iClicks, $iSpeed)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseMove($iXPos, $iYPos, $iSpeed = 10)
    Local $vResult = $g_hFn_MouseMove($iXPos, $iYPos, $iSpeed)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_MouseGetPos($iIndex = 0)
    Local $vResult = $g_hFn_MouseGetPos($iIndex)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlClick($sTitle, $sText, $hControlId, $sButton = "left", $iNumClicks = 1, $iXPos = Default, $iYPos = Default)
    Local $vResult = $g_hFn_ControlClick($sTitle, $sText, $hControlId, $sButton, $iNumClicks, $iXPos, $iYPos)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlSetText($sTitle, $sText, $hControlId, $sNewText, $iFlag = 0)
    Local $vResult = $g_hFn_ControlSetText($sTitle, $sText, $hControlId, $sNewText, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlGetText($sTitle, $sText, $hControlId)
    Local $vResult = $g_hFn_ControlGetText($sTitle, $sText, $hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlSend($sTitle, $sText, $hControlId, $sString, $iFlag = 0)
    Local $vResult = $g_hFn_ControlSend($sTitle, $sText, $hControlId, $sString, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ControlFocus($sTitle, $sText, $hControlId)
    Local $vResult = $g_hFn_ControlFocus($sTitle, $sText, $hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc
