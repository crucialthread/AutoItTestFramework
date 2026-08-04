; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Input.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt input simulation functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_Send($sKeys, $iFlag = 0)
	Local $vReturn = __DefineStub("Send", __CallArgs("sKeys = " & $sKeys, "iFlag = " & $iFlag))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_MouseClick($sButton = "left", $iX = -2147483647, $iY = -2147483647, $iClicks = 1, $iSpeed = -1)
	Local $vReturn = __DefineStub("MouseClick", __CallArgs("sButton = " & $sButton, "iX = " & $iX, "iY = " & $iY), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_MouseMove($iX, $iY, $iSpeed = -1)
	Local $vReturn = __DefineStub("MouseMove", __CallArgs("iX = " & $iX, "iY = " & $iY))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_MouseGetPos($iIndex = 0)
	Local $vReturn = __DefineStub("MouseGetPos", __CallArgs(), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ControlClick($sTitle, $sText, $sControl, $sButton = "left", $iNumClicks = 1, $iX = -2147483647, $iY = -2147483647)
	Local $vReturn = __DefineStub("ControlClick", __CallArgs("sTitle = " & $sTitle, "sControl = " & $sControl, "sButton = " & $sButton), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ControlSetText($sTitle, $sText, $sControl, $sNewText, $bFlag = True)
	Local $vReturn = __DefineStub("ControlSetText", __CallArgs("sTitle = " & $sTitle, "sControl = " & $sControl, "sNewText = " & $sNewText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ControlGetText($sTitle, $sText, $sControl)
	Local $vReturn = __DefineStub("ControlGetText", __CallArgs("sTitle = " & $sTitle, "sControl = " & $sControl), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ControlSend($sTitle, $sText, $sControl, $sKeys, $iFlag = 0)
	Local $vReturn = __DefineStub("ControlSend", __CallArgs("sTitle = " & $sTitle, "sControl = " & $sControl, "sKeys = " & $sKeys), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ControlFocus($sTitle, $sText, $sControl)
	Local $vReturn = __DefineStub("ControlFocus", __CallArgs("sTitle = " & $sTitle, "sControl = " & $sControl), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_Send           = _Stub_Send
$g_hFn_MouseClick     = _Stub_MouseClick
$g_hFn_MouseMove      = _Stub_MouseMove
$g_hFn_MouseGetPos    = _Stub_MouseGetPos
$g_hFn_ControlClick   = _Stub_ControlClick
$g_hFn_ControlSetText = _Stub_ControlSetText
$g_hFn_ControlGetText = _Stub_ControlGetText
$g_hFn_ControlSend    = _Stub_ControlSend
$g_hFn_ControlFocus   = _Stub_ControlFocus
