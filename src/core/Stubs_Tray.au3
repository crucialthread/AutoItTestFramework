; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Tray.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt tray functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_TrayTip($sTitle, $sText, $iTimeout, $iOption = 0)
	Return __DefineStub("TrayTip", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText))
EndFunc

Func _Stub_TrayGetMsg()
	Return __DefineStub("TrayGetMsg", __CallArgs(), 0)
EndFunc

Func _Stub_TrayCreateItem($sText, $hMenu = -1, $iMenuItemID = -1, $iStyle = -1)
	Return __DefineStub("TrayCreateItem", __CallArgs("sText = " & $sText), 1)
EndFunc

Func _Stub_TrayCreateMenu($sText, $hMenu = -1, $iMenuItemID = -1)
	Return __DefineStub("TrayCreateMenu", __CallArgs("sText = " & $sText), 1)
EndFunc

Func _Stub_TrayItemSetState($hItem, $iState)
	Return __DefineStub("TrayItemSetState", __CallArgs("hItem = " & $hItem, "iState = " & $iState), 1)
EndFunc

Func _Stub_TrayItemSetText($hItem, $sText)
	Return __DefineStub("TrayItemSetText", __CallArgs("hItem = " & $hItem, "sText = " & $sText), 1)
EndFunc

Func _Stub_TrayItemGetState($hItem)
	Return __DefineStub("TrayItemGetState", __CallArgs("hItem = " & $hItem), 0)
EndFunc

Func _Stub_TrayItemGetText($hItem)
	Return __DefineStub("TrayItemGetText", __CallArgs("hItem = " & $hItem), "")
EndFunc

$g_hFn_TrayTip          = _Stub_TrayTip
$g_hFn_TrayGetMsg       = _Stub_TrayGetMsg
$g_hFn_TrayCreateItem   = _Stub_TrayCreateItem
$g_hFn_TrayCreateMenu   = _Stub_TrayCreateMenu
$g_hFn_TrayItemSetState = _Stub_TrayItemSetState
$g_hFn_TrayItemSetText  = _Stub_TrayItemSetText
$g_hFn_TrayItemGetState = _Stub_TrayItemGetState
$g_hFn_TrayItemGetText  = _Stub_TrayItemGetText
