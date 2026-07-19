; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Tray.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt tray functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_TrayTip          = TrayTip
Global $g_hFn_TrayGetMsg       = TrayGetMsg
Global $g_hFn_TrayCreateItem   = TrayCreateItem
Global $g_hFn_TrayCreateMenu   = TrayCreateMenu
Global $g_hFn_TrayItemSetState = TrayItemSetState
Global $g_hFn_TrayItemSetText  = TrayItemSetText
Global $g_hFn_TrayItemGetState = TrayItemGetState
Global $g_hFn_TrayItemGetText  = TrayItemGetText

Func _Tstbl_TrayTip($sTitle, $sText, $iTimeout, $iOption = 0)
    Local $vResult = $g_hFn_TrayTip($sTitle, $sText, $iTimeout, $iOption)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayGetMsg()
    Local $vResult = $g_hFn_TrayGetMsg()
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayCreateItem($sText, $hMenu = -1, $iMenuItemID = -1, $iStyle = -1)
    Local $vResult = $g_hFn_TrayCreateItem($sText, $hMenu, $iMenuItemID, $iStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayCreateMenu($sText, $hMenu = -1, $iMenuItemID = -1)
    Local $vResult = $g_hFn_TrayCreateMenu($sText, $hMenu, $iMenuItemID)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemSetState($hItem, $iState)
    Local $vResult = $g_hFn_TrayItemSetState($hItem, $iState)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemSetText($hItem, $sText)
    Local $vResult = $g_hFn_TrayItemSetText($hItem, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemGetState($hItem)
    Local $vResult = $g_hFn_TrayItemGetState($hItem)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemGetText($hItem)
    Local $vResult = $g_hFn_TrayItemGetText($hItem)
    Return SetError(@error, @extended, $vResult)
EndFunc
