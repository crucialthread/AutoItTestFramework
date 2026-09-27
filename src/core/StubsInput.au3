#include-once

#include "StubsCore.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsInput.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt input simulation functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

Func __Stub_Send($sKeyStrokes, $iFlag = 0)
	Local $vReturn = __DefineStub("Send", __CallArgs("sKeyStrokes = " & $sKeyStrokes, "iFlag = " & $iFlag))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseClick($sButton = "left", $iXPos = Default, $iYPos = Default, $iClicks = 1, $iSpeed = 10)
	Local $aArgs = __CallArgs("sButton = " & $sButton, "iXPos = " & $iXPos, "iYPos = " & $iYPos, "iClicks = " & $iClicks, "iSpeed = " & $iSpeed)
	Local $vReturn = __DefineStub("MouseClick", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseMove($iXPos, $iYPos, $iSpeed = 10)
	Local $vReturn = __DefineStub("MouseMove", __CallArgs("iXPos = " & $iXPos, "iYPos = " & $iYPos, "iSpeed = " & $iSpeed))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseGetPos($iIndex = 0)
	Local $vReturn = __DefineStub("MouseGetPos", __CallArgs("iIndex = " & $iIndex), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlClick($sTitle, $sText, $hControlId, $sButton = "left", $iNumClicks = 1, $iXPos = Default, $iYPos = Default)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "hControlId = " & $hControlId, _
							  "sButton = " & $sButton, "iNumClicks = " & $iNumClicks, "iXPos = " & $iXPos, "iYPos = " & $iYPos)
	Local $vReturn = __DefineStub("ControlClick", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlSetText($sTitle, $sText, $hControlId, $sNewText, $iFlag = 0)
	Local $aArgs =  __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "hControlId = " & $hControlId, "sNewText = " & $sNewText, "iFlag = " & $iFlag)
	Local $vReturn = __DefineStub("ControlSetText", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlGetText($sTitle, $sText, $hControlId)
	Local $vReturn = __DefineStub("ControlGetText", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "hControlId = " & $hControlId), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlSend($sTitle, $sText, $hControlId, $sString, $iFlag = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "hControlId = " & $hControlId, "sString = " & $sString, "iFlag = " & $iFlag)
	Local $vReturn = __DefineStub("ControlSend", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlFocus($sTitle, $sText, $hControlId)
	Local $vReturn = __DefineStub("ControlFocus", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "hControlId = " & $hControlId), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_Send           = __Stub_Send
$g_hFn_MouseClick     = __Stub_MouseClick
$g_hFn_MouseMove      = __Stub_MouseMove
$g_hFn_MouseGetPos    = __Stub_MouseGetPos
$g_hFn_ControlClick   = __Stub_ControlClick
$g_hFn_ControlSetText = __Stub_ControlSetText
$g_hFn_ControlGetText = __Stub_ControlGetText
$g_hFn_ControlSend    = __Stub_ControlSend
$g_hFn_ControlFocus   = __Stub_ControlFocus
