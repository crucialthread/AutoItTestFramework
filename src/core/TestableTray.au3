#include-once

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableTray.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt tray functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

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

Func _Tstbl_TrayCreateItem($sText, $hMenuId = -1, $iMenuEntry = -1, $iMenuRadioItem = 0)
    Local $vResult = $g_hFn_TrayCreateItem($sText, $hMenuId, $iMenuEntry, $iMenuRadioItem)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayCreateMenu($sMenuText, $hParentMenuId = -1, $iMenuEntry = -1)
    Local $vResult = $g_hFn_TrayCreateMenu($sMenuText, $hParentMenuId, $iMenuEntry)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemSetState($hControlId, $iState)
    Local $vResult = $g_hFn_TrayItemSetState($hControlId, $iState)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemSetText($hControlId, $sText)
    Local $vResult = $g_hFn_TrayItemSetText($hControlId, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemGetState($hControlId)
    Local $vResult = $g_hFn_TrayItemGetState($hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_TrayItemGetText($hControlId)
    Local $vResult = $g_hFn_TrayItemGetText($hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc
