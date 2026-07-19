; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_GUI.au3 library
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
Global $g_hFn_GUICtrlCreateLabel       = GUICtrlCreateLabel
Global $g_hFn_GUICtrlCreateButton      = GUICtrlCreateButton
Global $g_hFn_GUICtrlCreateInput       = GUICtrlCreateInput
Global $g_hFn_GUICtrlCreateEdit        = GUICtrlCreateEdit
Global $g_hFn_GUICtrlCreateCheckbox    = GUICtrlCreateCheckbox
Global $g_hFn_GUICtrlCreateRadio       = GUICtrlCreateRadio
Global $g_hFn_GUICtrlCreateCombo       = GUICtrlCreateCombo
Global $g_hFn_GUICtrlCreateList        = GUICtrlCreateList
Global $g_hFn_GUICtrlCreateListView    = GUICtrlCreateListView
Global $g_hFn_GUICtrlCreateListViewItem = GUICtrlCreateListViewItem
Global $g_hFn_GUICtrlCreateTreeView    = GUICtrlCreateTreeView
Global $g_hFn_GUICtrlCreateTreeViewItem = GUICtrlCreateTreeViewItem
Global $g_hFn_GUICtrlCreateProgress    = GUICtrlCreateProgress
Global $g_hFn_GUICtrlCreateTab         = GUICtrlCreateTab
Global $g_hFn_GUICtrlCreateTabItem     = GUICtrlCreateTabItem
Global $g_hFn_GUICtrlCreateDate        = GUICtrlCreateDate
Global $g_hFn_GUICtrlCreateUpdown      = GUICtrlCreateUpdown
Global $g_hFn_GUICtrlCreateGroup       = GUICtrlCreateGroup
Global $g_hFn_GUICtrlCreateMenu        = GUICtrlCreateMenu
Global $g_hFn_GUICtrlCreateMenuItem    = GUICtrlCreateMenuItem
Global $g_hFn_GUICtrlCreateSlider      = GUICtrlCreateSlider
Global $g_hFn_GUICtrlCreatePic         = GUICtrlCreatePic

; Control interaction
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

; GUI creation and lifecycle wrappers
Func _Tstbl_GUICreate($sTitle, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $iStyle = -1, $iExStyle = -1, $hWndParent = 0)
    Local $vResult = $g_hFn_GUICreate($sTitle, $iWidth, $iHeight, $iLeft, $iTop, $iStyle, $iExStyle, $hWndParent)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUIDelete($hWnd = 0)
    Local $vResult = $g_hFn_GUIDelete($hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetState($iState = @SW_SHOW, $hWnd = 0)
    Local $vResult = $g_hFn_GUISetState($iState, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetBkColor($iColor, $hWnd = 0)
    Local $vResult = $g_hFn_GUISetBkColor($iColor, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISetFont($iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $hWnd = 0)
    Local $vResult = $g_hFn_GUISetFont($iSize, $iWeight, $iAttrib, $sName, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUIGetMsg($iAdvanced = 0)
    Local $vResult = $g_hFn_GUIGetMsg($iAdvanced)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUISwitch($hWnd, $hWndTopMost = 0)
    Local $vResult = $g_hFn_GUISwitch($hWnd, $hWndTopMost)
    Return SetError(@error, @extended, $vResult)
EndFunc

; Control creation wrappers
Func _Tstbl_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateListViewItem($sText, $hWnd)
    Local $vResult = $g_hFn_GUICtrlCreateListViewItem($sText, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTreeView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateTreeView($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTreeViewItem($sText, $hWnd)
    Local $vResult = $g_hFn_GUICtrlCreateTreeViewItem($sText, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateProgress($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateProgress($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTab($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateTab($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateTabItem($sText)
    Local $vResult = $g_hFn_GUICtrlCreateTabItem($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateUpdown($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateUpdown($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateMenu($sText, $hWnd = 0, $iStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateMenu($sText, $hWnd, $iStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateMenuItem($sText, $hWnd, $iMenuItemID = -1, $iStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateMenuItem($sText, $hWnd, $iMenuItemID, $iStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreateSlider($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreateSlider($iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vResult = $g_hFn_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Return SetError(@error, @extended, $vResult)
EndFunc

; Control interaction wrappers
Func _Tstbl_GUICtrlSetState($idCtrl, $iState)
    Local $vResult = $g_hFn_GUICtrlSetState($idCtrl, $iState)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlGetState($idCtrl)
    Local $vResult = $g_hFn_GUICtrlGetState($idCtrl)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetData($idCtrl, $vData, $vDefault = "")
    Local $vResult = $g_hFn_GUICtrlSetData($idCtrl, $vData, $vDefault)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlRead($idCtrl, $iMode = 0)
    Local $vResult = $g_hFn_GUICtrlRead($idCtrl, $iMode)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlDelete($idCtrl)
    Local $vResult = $g_hFn_GUICtrlDelete($idCtrl)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetFont($idCtrl, $iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $iQuality = -1)
    Local $vResult = $g_hFn_GUICtrlSetFont($idCtrl, $iSize, $iWeight, $iAttrib, $sName, $iQuality)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetColor($idCtrl, $iColor)
    Local $vResult = $g_hFn_GUICtrlSetColor($idCtrl, $iColor)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetBkColor($idCtrl, $iColor)
    Local $vResult = $g_hFn_GUICtrlSetBkColor($idCtrl, $iColor)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetPos($idCtrl, $iLeft, $iTop, $iWidth = -1, $iHeight = -1)
    Local $vResult = $g_hFn_GUICtrlSetPos($idCtrl, $iLeft, $iTop, $iWidth, $iHeight)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_GUICtrlSetTip($idCtrl, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
    Local $vResult = $g_hFn_GUICtrlSetTip($idCtrl, $sTooltip, $sTitle, $iIcon, $iOptions)
    Return SetError(@error, @extended, $vResult)
EndFunc
