; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_GUI.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt GUI functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"
#include <GUIConstantsEx.au3>

Func _Stub_GUICreate($sTitle, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $iStyle = -1, $iExStyle = -1, $hWndParent = 0)
    Local $vReturn = __DefineStub("GUICreate", __CallArgs("sTitle = " & $sTitle), 1)
    Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUIDelete($hWnd = 0)
	Local $vReturn =__DefineStub("GUIDelete", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUISetState($iState = @SW_SHOW, $hWnd = 0)
	Local $vReturn = __DefineStub("GUISetState", __CallArgs("iState = " & $iState), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUISetBkColor($iColor, $hWnd = 0)
	Local $vReturn = __DefineStub("GUISetBkColor", __CallArgs("iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUISetFont($iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $hWnd = 0)
	Local $vReturn = __DefineStub("GUISetFont", __CallArgs("iSize = " & $iSize, "sName = " & $sName), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUIGetMsg($iAdvanced = 0)
	Local $vReturn = __DefineStub("GUIGetMsg", __CallArgs(), $GUI_EVENT_CLOSE)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUISwitch($hWnd, $hWndTopMost = 0)
	Local $vReturn = __DefineStub("GUISwitch", __CallArgs(), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Control creation ---

Func _Stub_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateLabel", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateButton", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateInput", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateEdit", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateCheckbox", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateRadio", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateCombo", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateList", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateListView", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateListViewItem($sText, $hWnd)
	Local $vReturn = __DefineStub("GUICtrlCreateListViewItem", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateTreeView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeView", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateTreeViewItem($sText, $hWnd)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeViewItem", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateProgress($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateProgress", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateTab($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Local $vReturn = __DefineStub("GUICtrlCreateTab", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateTabItem($sText)
	Local $vReturn = __DefineStub("GUICtrlCreateTabItem", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateDate", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateUpdown($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateUpdown", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateGroup", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateMenu($sText, $hWnd = 0, $iStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateMenu", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateMenuItem($sText, $hWnd, $iMenuItemID = -1, $iStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateMenuItem", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreateSlider($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateSlider", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreatePic", __CallArgs("sFilename = " & $sFilename), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Control interaction ---

Func _Stub_GUICtrlSetState($idCtrl, $iState)
	Local $vReturn = __DefineStub("GUICtrlSetState", __CallArgs("idCtrl = " & $idCtrl, "iState = " & $iState), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlGetState($idCtrl)
	Local $vReturn = __DefineStub("GUICtrlGetState", __CallArgs("idCtrl = " & $idCtrl), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetData($idCtrl, $vData, $vDefault = "")
	Local $vReturn = __DefineStub("GUICtrlSetData", __CallArgs("idCtrl = " & $idCtrl, "vData = " & $vData), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlRead($idCtrl, $iMode = 0)
	Local $vReturn = __DefineStub("GUICtrlRead", __CallArgs("idCtrl = " & $idCtrl), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlDelete($idCtrl)
	Local $vReturn = __DefineStub("GUICtrlDelete", __CallArgs("idCtrl = " & $idCtrl), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetFont($idCtrl, $iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $iQuality = -1)
	Local $vReturn = __DefineStub("GUICtrlSetFont", __CallArgs("idCtrl = " & $idCtrl, "iSize = " & $iSize, "sName = " & $sName), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetColor($idCtrl, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetColor", __CallArgs("idCtrl = " & $idCtrl, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetBkColor($idCtrl, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetBkColor", __CallArgs("idCtrl = " & $idCtrl, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetPos($idCtrl, $iLeft, $iTop, $iWidth = -1, $iHeight = -1)
	Local $vReturn = __DefineStub("GUICtrlSetPos", __CallArgs("idCtrl = " & $idCtrl, "iLeft = " & $iLeft, "iTop = " & $iTop), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_GUICtrlSetTip($idCtrl, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
	Local $vReturn = __DefineStub("GUICtrlSetTip", __CallArgs("idCtrl = " & $idCtrl, "sTooltip = " & $sTooltip), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Auto-wire ---
$g_hFn_GUICreate             		= _Stub_GUICreate
$g_hFn_GUIDelete             		= _Stub_GUIDelete
$g_hFn_GUISetState           		= _Stub_GUISetState
$g_hFn_GUISetBkColor         		= _Stub_GUISetBkColor
$g_hFn_GUISetFont            		= _Stub_GUISetFont
$g_hFn_GUIGetMsg             		= _Stub_GUIGetMsg
$g_hFn_GUISwitch             		= _Stub_GUISwitch
$g_hFn_GUICtrlCreateLabel    		= _Stub_GUICtrlCreateLabel
$g_hFn_GUICtrlCreateButton   		= _Stub_GUICtrlCreateButton
$g_hFn_GUICtrlCreateInput    		= _Stub_GUICtrlCreateInput
$g_hFn_GUICtrlCreateEdit     		= _Stub_GUICtrlCreateEdit
$g_hFn_GUICtrlCreateCheckbox 		= _Stub_GUICtrlCreateCheckbox
$g_hFn_GUICtrlCreateRadio    		= _Stub_GUICtrlCreateRadio
$g_hFn_GUICtrlCreateCombo    		= _Stub_GUICtrlCreateCombo
$g_hFn_GUICtrlCreateList     		= _Stub_GUICtrlCreateList
$g_hFn_GUICtrlCreateListView 		= _Stub_GUICtrlCreateListView
$g_hFn_GUICtrlCreateListViewItem  	= _Stub_GUICtrlCreateListViewItem
$g_hFn_GUICtrlCreateTreeView      	= _Stub_GUICtrlCreateTreeView
$g_hFn_GUICtrlCreateTreeViewItem  	= _Stub_GUICtrlCreateTreeViewItem
$g_hFn_GUICtrlCreateProgress 		= _Stub_GUICtrlCreateProgress
$g_hFn_GUICtrlCreateTab      		= _Stub_GUICtrlCreateTab
$g_hFn_GUICtrlCreateTabItem  		= _Stub_GUICtrlCreateTabItem
$g_hFn_GUICtrlCreateDate     		= _Stub_GUICtrlCreateDate
$g_hFn_GUICtrlCreateUpdown   		= _Stub_GUICtrlCreateUpdown
$g_hFn_GUICtrlCreateGroup    		= _Stub_GUICtrlCreateGroup
$g_hFn_GUICtrlCreateMenu     		= _Stub_GUICtrlCreateMenu
$g_hFn_GUICtrlCreateMenuItem 		= _Stub_GUICtrlCreateMenuItem
$g_hFn_GUICtrlCreateSlider   		= _Stub_GUICtrlCreateSlider
$g_hFn_GUICtrlCreatePic      		= _Stub_GUICtrlCreatePic
$g_hFn_GUICtrlSetState       		= _Stub_GUICtrlSetState
$g_hFn_GUICtrlGetState       		= _Stub_GUICtrlGetState
$g_hFn_GUICtrlSetData        		= _Stub_GUICtrlSetData
$g_hFn_GUICtrlRead           		= _Stub_GUICtrlRead
$g_hFn_GUICtrlDelete         		= _Stub_GUICtrlDelete
$g_hFn_GUICtrlSetFont        		= _Stub_GUICtrlSetFont
$g_hFn_GUICtrlSetColor       		= _Stub_GUICtrlSetColor
$g_hFn_GUICtrlSetBkColor     		= _Stub_GUICtrlSetBkColor
$g_hFn_GUICtrlSetPos         		= _Stub_GUICtrlSetPos
$g_hFn_GUICtrlSetTip         		= _Stub_GUICtrlSetTip
