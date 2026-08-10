; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Tray.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt tray functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_TrayTip($sTitle, $sText, $iTimeout, $iOption = 0)
	Local $vReturn = __DefineStub("TrayTip", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "iTimeout = " & $iTimeout, "iOption = " & $iOption))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayGetMsg()
	Local $vReturn = __DefineStub("TrayGetMsg", __CallArgs(), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayCreateItem($sText, $hMenuId = -1, $iMenuEntry = -1, $iMenuRadioItem = 0)
	Local $aArgs = __CallArgs("sText = " & $sText, "hMenuId = " & $hMenuId, "iMenuEntry = " & $iMenuEntry, "iMenuRadioItem = " & $iMenuRadioItem)
	Local $vReturn = __DefineStub("TrayCreateItem", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayCreateMenu($sMenuText, $hParentMenuId = -1, $iMenuEntry = -1)
	Local $vReturn = __DefineStub("TrayCreateMenu", __CallArgs("sMenuText = " & $sMenuText, "hParentMenuId = " & $hParentMenuId, "iMenuEntry = " & $iMenuEntry), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayItemSetState($hControlId, $iState)
	Local $vReturn = __DefineStub("TrayItemSetState", __CallArgs("hControlId = " & $hControlId, "iState = " & $iState), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayItemSetText($hControlId, $sText)
	Local $vReturn = __DefineStub("TrayItemSetText", __CallArgs("hControlId = " & $hControlId, "sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayItemGetState($hControlId)
	Local $vReturn = __DefineStub("TrayItemGetState", __CallArgs("hControlId = " & $hControlId), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_TrayItemGetText($hControlId)
	Local $vReturn = __DefineStub("TrayItemGetText", __CallArgs("hControlId = " & $hControlId), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_TrayTip          = __Stub_TrayTip
$g_hFn_TrayGetMsg       = __Stub_TrayGetMsg
$g_hFn_TrayCreateItem   = __Stub_TrayCreateItem
$g_hFn_TrayCreateMenu   = __Stub_TrayCreateMenu
$g_hFn_TrayItemSetState = __Stub_TrayItemSetState
$g_hFn_TrayItemSetText  = __Stub_TrayItemSetText
$g_hFn_TrayItemGetState = __Stub_TrayItemGetState
$g_hFn_TrayItemGetText  = __Stub_TrayItemGetText
