#include-once

#include <GUIConstantsEx.au3>
#include "StubsCore.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsGUI.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt GUI functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

Func __Stub_GUICreate($sTitle, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $iStyle = -1, $iExStyle = -1, $hWndParent = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "iWidth = " & $iWidth, "iHeight = " & $iHeight, "iLeft = " & $iLeft, _
							  "iTop = " & $iTop, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle, "hWndParent = " & $hWndParent)
    Local $vReturn = __DefineStub("GUICreate", $aArgs, 1)
    Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUIDelete($hWnd = Default)
	Local $vReturn =__DefineStub("GUIDelete", __CallArgs("hWnd = " & $hWnd), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUISetState($iState = @SW_SHOW, $hWnd = Default)
	Local $vReturn = __DefineStub("GUISetState", __CallArgs("iState = " & $iState, "hWnd = " & $hWnd), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUISetBkColor($iColor, $hWnd = Default)
	Local $vReturn = __DefineStub("GUISetBkColor", __CallArgs("iColor = " & $iColor, "hWnd = " & $hWnd), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUISetFont($iFontSize, $iFontWeight = 0, $iFontAttribute = 0, $sFontName = "", $hWnd = Default, $iFontQuality = 0)
	Local $aArgs = __CallArgs("iFontSize = " & $iFontSize, "iFontWeight = " & $iFontWeight, "iFontAttribute = " & $iFontAttribute, _
							  "sFontName = " & $sFontName, "hWnd = " & $hWnd, "iFontQuality = " & $iFontQuality)
	Local $vReturn = __DefineStub("GUISetFont", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUIGetMsg($iAdvanced = 0)
	Local $vReturn = __DefineStub("GUIGetMsg", __CallArgs("iAdvanced = " & $iAdvanced), $GUI_EVENT_CLOSE)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUISwitch($hWnd, $hTabItemId = Default)
	Local $vReturn = __DefineStub("GUISwitch", __CallArgs("hWnd = " & $hWnd, "hTabItemId = " & $hTabItemId), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Control creation ---

Func __Stub_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateLabel", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateButton", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateInput", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateEdit", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateCheckbox", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateRadio", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateCombo", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateList", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateListView", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateListViewItem($sText, $hListViewId)
	Local $vReturn = __DefineStub("GUICtrlCreateListViewItem", __CallArgs("sText = " & $sText, "hListViewId = " & $hListViewId), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTreeView($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeView", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTreeViewItem($sText, $hTreeViewId)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeViewItem", __CallArgs("sText = " & $sText, "hTreeViewId = " & $hTreeViewId), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateProgress($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateProgress", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTab($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
    Local $vReturn = __DefineStub("GUICtrlCreateTab", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTabItem($sText)
	Local $vReturn = __DefineStub("GUICtrlCreateTabItem", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateDate", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateUpdown($hInputControlId, $iStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateUpdown", __CallArgs("hInputControlId = " & $hInputControlId, "iStyle = " & $iStyle), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateGroup", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateMenu($sText, $hParentMenuId = -1, $iMenuEntry = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "hParentMenuId = " & $hParentMenuId, "iMenuEntry = " & $iMenuEntry)
	Local $vReturn = __DefineStub("GUICtrlCreateMenu", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateMenuItem($sText, $hMenuId, $iMenuEntry = -1, $iMenuRadioItem  = 0)
	Local $aArgs = __CallArgs("sText = " & $sText, "hMenuId = " & $hMenuId, "iMenuEntry = " & $iMenuEntry, "iMenuRadioItem = " & $iMenuRadioItem)
	Local $vReturn = __DefineStub("GUICtrlCreateMenuItem", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateSlider($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateSlider", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sFilename = " & $sFilename, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreatePic", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Control interaction ---

Func __Stub_GUICtrlGetHandle($hControlId)
	Local $vReturn = __DefineStub("GUICtrlGetHandle", __CallArgs("hControlId = " & $hControlId), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetState($hControlId, $iState)
	Local $vReturn = __DefineStub("GUICtrlSetState", __CallArgs("hControlId = " & $hControlId, "iState = " & $iState), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlGetState($hControlId)
	Local $vReturn = __DefineStub("GUICtrlGetState", __CallArgs("hControlId = " & $hControlId), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetData($hControlId, $vData, $vDefault = "")
	Local $vReturn = __DefineStub("GUICtrlSetData", __CallArgs("hControlId = " & $hControlId, "vData = " & $vData, "vDefault = " & $vDefault), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlRead($hControlId, $iAdvanced = 0)
	Local $vReturn = __DefineStub("GUICtrlRead", __CallArgs("hControlId = " & $hControlId, "iAdvanced = " & $iAdvanced), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlDelete($hControlId)
	Local $vReturn = __DefineStub("GUICtrlDelete", __CallArgs("hControlId = " & $hControlId), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetFont($hControlId, $iFontSize, $iFontWeight = 0, $iFontAttribute = 0, $sFontName = "", $iFontQuality = 0)
	Local $aArgs = __CallArgs("hControlId = " & $hControlId, "iFontSize = " & $iFontSize, "iFontWeight = " & $iFontWeight, _
							  "iFontAttribute = " & $iFontAttribute, "sFontName = " & $sFontName, "iFontQuality = " & $iFontQuality)
	Local $vReturn = __DefineStub("GUICtrlSetFont", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetColor($hControlId, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetColor", __CallArgs("hControlId = " & $hControlId, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetBkColor($hControlId, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetBkColor", __CallArgs("hControlId = " & $hControlId, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetPos($hControlId, $iLeft, $iTop, $iWidth = Default, $iHeight = Default)
	Local $aArgs =  __CallArgs("hControlId = " & $hControlId, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, "iHeight = " & $iHeight)
	Local $vReturn = __DefineStub("GUICtrlSetPos", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetTip($hControlId, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
	Local $aArgs = __CallArgs("hControlId = " & $hControlId, "sTooltip = " & $sTooltip, "sTitle = " & $sTitle, "iIcon = " & $iIcon, "iOptions = " & $iOptions)
	Local $vReturn = __DefineStub("GUICtrlSetTip", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSendMsg($hControlId, $sMsg, $vWParam, $vLParam)
	Local $aArgs = __CallArgs("hControlId = " & $hControlId, "sMsg = " & $sMsg, "vWParam = " & $vWParam, "vLParam = " & $vLParam)
	Local $vReturn = __DefineStub("GUICtrlSendMsg", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

; --- Auto-wire ---
$g_hFn_GUICreate             		= __Stub_GUICreate
$g_hFn_GUIDelete             		= __Stub_GUIDelete
$g_hFn_GUISetState           		= __Stub_GUISetState
$g_hFn_GUISetBkColor         		= __Stub_GUISetBkColor
$g_hFn_GUISetFont            		= __Stub_GUISetFont
$g_hFn_GUIGetMsg             		= __Stub_GUIGetMsg
$g_hFn_GUISwitch             		= __Stub_GUISwitch
$g_hFn_GUICtrlCreateLabel    		= __Stub_GUICtrlCreateLabel
$g_hFn_GUICtrlCreateButton   		= __Stub_GUICtrlCreateButton
$g_hFn_GUICtrlCreateInput    		= __Stub_GUICtrlCreateInput
$g_hFn_GUICtrlCreateEdit     		= __Stub_GUICtrlCreateEdit
$g_hFn_GUICtrlCreateCheckbox 		= __Stub_GUICtrlCreateCheckbox
$g_hFn_GUICtrlCreateRadio    		= __Stub_GUICtrlCreateRadio
$g_hFn_GUICtrlCreateCombo    		= __Stub_GUICtrlCreateCombo
$g_hFn_GUICtrlCreateList     		= __Stub_GUICtrlCreateList
$g_hFn_GUICtrlCreateListView 		= __Stub_GUICtrlCreateListView
$g_hFn_GUICtrlCreateListViewItem  	= __Stub_GUICtrlCreateListViewItem
$g_hFn_GUICtrlCreateTreeView      	= __Stub_GUICtrlCreateTreeView
$g_hFn_GUICtrlCreateTreeViewItem  	= __Stub_GUICtrlCreateTreeViewItem
$g_hFn_GUICtrlCreateProgress 		= __Stub_GUICtrlCreateProgress
$g_hFn_GUICtrlCreateTab      		= __Stub_GUICtrlCreateTab
$g_hFn_GUICtrlCreateTabItem  		= __Stub_GUICtrlCreateTabItem
$g_hFn_GUICtrlCreateDate     		= __Stub_GUICtrlCreateDate
$g_hFn_GUICtrlCreateUpdown   		= __Stub_GUICtrlCreateUpdown
$g_hFn_GUICtrlCreateGroup    		= __Stub_GUICtrlCreateGroup
$g_hFn_GUICtrlCreateMenu     		= __Stub_GUICtrlCreateMenu
$g_hFn_GUICtrlCreateMenuItem 		= __Stub_GUICtrlCreateMenuItem
$g_hFn_GUICtrlCreateSlider   		= __Stub_GUICtrlCreateSlider
$g_hFn_GUICtrlCreatePic      		= __Stub_GUICtrlCreatePic
$g_hFn_GUICtrlGetHandle       		= __Stub_GUICtrlGetHandle
$g_hFn_GUICtrlSetState       		= __Stub_GUICtrlSetState
$g_hFn_GUICtrlGetState       		= __Stub_GUICtrlGetState
$g_hFn_GUICtrlSetData        		= __Stub_GUICtrlSetData
$g_hFn_GUICtrlRead           		= __Stub_GUICtrlRead
$g_hFn_GUICtrlDelete         		= __Stub_GUICtrlDelete
$g_hFn_GUICtrlSetFont        		= __Stub_GUICtrlSetFont
$g_hFn_GUICtrlSetColor       		= __Stub_GUICtrlSetColor
$g_hFn_GUICtrlSetBkColor     		= __Stub_GUICtrlSetBkColor
$g_hFn_GUICtrlSetPos         		= __Stub_GUICtrlSetPos
$g_hFn_GUICtrlSetTip         		= __Stub_GUICtrlSetTip
$g_hFn_GUICtrlSendMsg    			= __Stub_GUICtrlSendMsg