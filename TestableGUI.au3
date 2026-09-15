; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableGUI.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt GUI functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

; GUI creation and lifecycle
Global $g_hFn_GUICreate     = GUICreate
Global $g_hFn_GUIDelete     = GUIDelete
Global $g_hFn_GUISetState   = GUISetState
Global $g_hFn_GUISetBkColor = GUISetBkColor
Global $g_hFn_GUISetFont    = GUISetFont
Global $g_hFn_GUIGetMsg     = GUIGetMsg
Global $g_hFn_GUISwitch     = GUISwitch

; Control creation
Global $g_hFn_GUICtrlCreateLabel        = GUICtrlCreateLabel
Global $g_hFn_GUICtrlCreateButton       = GUICtrlCreateButton
Global $g_hFn_GUICtrlCreateInput        = GUICtrlCreateInput
Global $g_hFn_GUICtrlCreateEdit         = GUICtrlCreateEdit
Global $g_hFn_GUICtrlCreateCheckbox     = GUICtrlCreateCheckbox
Global $g_hFn_GUICtrlCreateRadio        = GUICtrlCreateRadio
Global $g_hFn_GUICtrlCreateCombo        = GUICtrlCreateCombo
Global $g_hFn_GUICtrlCreateList         = GUICtrlCreateList
Global $g_hFn_GUICtrlCreateListView     = GUICtrlCreateListView
Global $g_hFn_GUICtrlCreateListViewItem = GUICtrlCreateListViewItem
Global $g_hFn_GUICtrlCreateTreeView     = GUICtrlCreateTreeView
Global $g_hFn_GUICtrlCreateTreeViewItem = GUICtrlCreateTreeViewItem
Global $g_hFn_GUICtrlCreateProgress     = GUICtrlCreateProgress
Global $g_hFn_GUICtrlCreateTab          = GUICtrlCreateTab
Global $g_hFn_GUICtrlCreateTabItem      = GUICtrlCreateTabItem
Global $g_hFn_GUICtrlCreateDate         = GUICtrlCreateDate
Global $g_hFn_GUICtrlCreateUpdown       = GUICtrlCreateUpdown
Global $g_hFn_GUICtrlCreateGroup        = GUICtrlCreateGroup
Global $g_hFn_GUICtrlCreateMenu         = GUICtrlCreateMenu
Global $g_hFn_GUICtrlCreateMenuItem     = GUICtrlCreateMenuItem
Global $g_hFn_GUICtrlCreateSlider       = GUICtrlCreateSlider
Global $g_hFn_GUICtrlCreatePic          = GUICtrlCreatePic

; Control interaction
Global $g_hFn_GUICtrlGetHandle  = GUICtrlGetHandle
Global $g_hFn_GUICtrlSetState   = GUICtrlSetState
Global $g_hFn_GUICtrlGetState   = GUICtrlGetState
Global $g_hFn_GUICtrlSetData    = GUICtrlSetData
Global $g_hFn_GUICtrlRead       = GUICtrlRead
Global $g_hFn_GUICtrlDelete     = GUICtrlDelete
Global $g_hFn_GUICtrlSetFont    = GUICtrlSetFont
Global $g_hFn_GUICtrlSetColor   = GUICtrlSetColor
Global $g_hFn_GUICtrlSetBkColor = GUICtrlSetBkColor
Global $g_hFn_GUICtrlSetPos     = GUICtrlSetPos
Global $g_hFn_GUICtrlSetTip     = GUICtrlSetTip
Global $g_hFn_GUICtrlSendMsg    = GUICtrlSendMsg

; GUI creation and lifecycle wrappers
Func _Tstbl_GUICreate($sTitle, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $iStyle = -1, $iExStyle = -1, $hWndParent = 0)
    Local $vResult = $g_hFn_GUICreate($sTitle, $iWidth, $iHeight, $iLeft, $iTop, $iStyle, $iExStyle, $hWndParent)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUIDelete($hWnd = Default)
    Local $vResult = $g_hFn_GUIDelete($hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetState($iState = @SW_SHOW, $hWnd = Default)
    Local $vResult = $g_hFn_GUISetState($iState, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetBkColor($iColor, $hWnd = Default)
    Local $vResult = $g_hFn_GUISetBkColor($iColor, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetFont($iFontSize, $iFontWeight = 0, $iFontAttribute = 0, $sFontName = "", $hWnd = Default, $iFontQuality = 0)
    Local $vResult = $g_hFn_GUISetFont($iFontSize, $iFontWeight, $iFontAttribute, $sFontName, $hWnd, $iFontQuality)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUIGetMsg($iAdvanced = 0)
    Local $vResult = $g_hFn_GUIGetMsg($iAdvanced)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISwitch($hWnd, $hTabItemId = Default)
    Local $vResult = $g_hFn_GUISwitch($hWnd, $hTabItemId)
    Return SetError(@error, @extended, $vResult)
EndFunc

; Control creation wrappers

Func _Tstbl_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateListViewItem($sText, $hListViewId)
    Local $vResult = $g_hFn_GUICtrlCreateListViewItem($sText, $hListViewId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTreeView($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateTreeView($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTreeViewItem($sText, $hTreeViewId)
    Local $vResult = $g_hFn_GUICtrlCreateTreeViewItem($sText, $hTreeViewId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateProgress($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateProgress($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTab($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateTab($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTabItem($sText)
    Local $vResult = $g_hFn_GUICtrlCreateTabItem($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateUpdown($hInputControlId, $iStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateUpdown($hInputControlId, $iStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateMenu($sText, $hParentMenuId = -1, $iMenuEntry = -1)
    Local $vResult = $g_hFn_GUICtrlCreateMenu($sText, $hParentMenuId, $iMenuEntry)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateMenuItem($sText, $hMenuId, $iMenuEntry = -1, $iMenuRadioItem  = 0)
    Local $vResult = $g_hFn_GUICtrlCreateMenuItem($sText, $hMenuId, $iMenuEntry, $iMenuRadioItem)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateSlider($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateSlider($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

; Control interaction wrappers
Func _Tstbl_GUICtrlGetHandle($hControlId)
    Local $vResult = $g_hFn_GUICtrlGetHandle($hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetState($hControlId, $iState)
    Local $vResult = $g_hFn_GUICtrlSetState($hControlId, $iState)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlGetState($hControlId)
    Local $vResult = $g_hFn_GUICtrlGetState($hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetData($hControlId, $vData, $vDefault = "")
    Local $vResult = $g_hFn_GUICtrlSetData($hControlId, $vData, $vDefault)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlRead($hControlId, $iAdvanced = 0)
    Local $vResult = $g_hFn_GUICtrlRead($hControlId, $iAdvanced)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlDelete($hControlId)
    Local $vResult = $g_hFn_GUICtrlDelete($hControlId)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetFont($hControlId, $iFontSize, $iFontWeight = 0, $iFontAttribute = 0, $sName = "", $iFontQuality = 0)
    Local $vResult = $g_hFn_GUICtrlSetFont($hControlId, $iFontSize, $iFontWeight, $iFontAttribute, $sName, $iFontQuality)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetColor($hControlId, $iColor)
    Local $vResult = $g_hFn_GUICtrlSetColor($hControlId, $iColor)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetBkColor($hControlId, $iColor)
    Local $vResult = $g_hFn_GUICtrlSetBkColor($hControlId, $iColor)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetPos($hControlId, $iLeft, $iTop, $iWidth = Default, $iHeight = Default)
    Local $vResult = $g_hFn_GUICtrlSetPos($hControlId, $iLeft, $iTop, $iWidth, $iHeight)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetTip($hControlId, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
    Local $vResult = $g_hFn_GUICtrlSetTip($hControlId, $sTooltip, $sTitle, $iIcon, $iOptions)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSendMsg($hControlId, $sMsg, $vWParam, $vLParam)
    Local $vResult = $g_hFn_GUICtrlSendMsg($hControlId, $sMsg, $vWParam, $vLParam)
    Return SetError(@error, @extended, $vResult)
EndFunc