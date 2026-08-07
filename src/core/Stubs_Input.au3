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

Func __Stub_Send($sKeys, $iFlag = 0)
	Local $vReturn = __DefineStub("Send", __CallArgs("sKeys = " & $sKeys, "iFlag = " & $iFlag))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseClick($sButton = "left", $iX = Default, $iY = Default, $iClicks = 1, $iSpeed = 10)
	Local $aArgs = __CallArgs("sButton = " & $sButton, "iX = " & $iX, "iY = " & $iY, "iClicks = " & $iClicks, "iSpeed = " & $iSpeed)
	Local $vReturn = __DefineStub("MouseClick", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseMove($iX, $iY, $iSpeed = 10)
	Local $vReturn = __DefineStub("MouseMove", __CallArgs("iX = " & $iX, "iY = " & $iY, "iSpeed = " & $iSpeed))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_MouseGetPos($iIndex = 0)
	Local $vReturn = __DefineStub("MouseGetPos", __CallArgs("iIndex = " & $iIndex), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlClick($sTitle, $sText, $sControl, $sButton = "left", $iNumClicks = 1, $iX = Default, $iY = Default)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sControl = " & $sControl, _
							  "sButton = " & $sButton, "iNumClicks = " & $iNumClicks, "iX = " & $iX, "iY = " & $iY)
	Local $vReturn = __DefineStub("ControlClick", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlSetText($sTitle, $sText, $sControl, $sNewText, $iFlag = 0)
	Local $aArgs =  __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sControl = " & $sControl, "sNewText = " & $sNewText, "iFlag = " & $iFlag)
	Local $vReturn = __DefineStub("ControlSetText", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlGetText($sTitle, $sText, $sControl)
	Local $vReturn = __DefineStub("ControlGetText", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sControl = " & $sControl), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlSend($sTitle, $sText, $sControl, $sKeys, $iFlag = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sControl = " & $sControl, "sKeys = " & $sKeys, "iFlag = " & $iFlag)
	Local $vReturn = __DefineStub("ControlSend", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ControlFocus($sTitle, $sText, $sControl)
	Local $vReturn = __DefineStub("ControlFocus", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sControl = " & $sControl), 1)
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
