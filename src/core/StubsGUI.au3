; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_GUI.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt GUI functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include <GUIConstantsEx.au3>
#include "StubsCore.au3"

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

Func __Stub_GUISetFont($iSize, $iWeight = 0, $iAttrib = 0, $sFontName = "", $hWnd = Default, $iQuality = 0)
	Local $aArgs = __CallArgs("iSize = " & $iSize, "iWeight = " & $iWeight, "iAttrib = " & $iAttrib, _
							  "sFontName = " & $sFontName, "hWnd = " & $hWnd, "iQuality = " & $iQuality)
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

Func __Stub_GUICtrlCreateListViewItem($sText, $idListView)
	Local $vReturn = __DefineStub("GUICtrlCreateListViewItem", __CallArgs("sText = " & $sText, "idListView = " & $idListView), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTreeView($iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeView", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateTreeViewItem($sText, $idTreeview)
	Local $vReturn = __DefineStub("GUICtrlCreateTreeViewItem", __CallArgs("sText = " & $sText, "idTreeview = " & $idTreeview), 1)
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

Func __Stub_GUICtrlCreateUpdown($idInputControl, $iStyle = -1)
	Local $vReturn = __DefineStub("GUICtrlCreateUpdown", __CallArgs("idInputControl = " & $idInputControl, "iStyle = " & $iStyle), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = Default, $iHeight = Default, $iStyle = -1, $iExStyle = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, _
							  "iHeight = " & $iHeight, "iStyle = " & $iStyle, "iExStyle = " & $iExStyle)
	Local $vReturn = __DefineStub("GUICtrlCreateGroup", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateMenu($sText, $idParentMenu = -1, $iMenuEntry = -1)
	Local $aArgs = __CallArgs("sText = " & $sText, "idParentMenu = " & $idParentMenu, "iMenuEntry = " & $iMenuEntry)
	Local $vReturn = __DefineStub("GUICtrlCreateMenu", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlCreateMenuItem($sText, $IdMenu, $iMenuEntry = -1, $iMenuRadioItem  = 0)
	Local $aArgs = __CallArgs("sText = " & $sText, "$IdMenu = " & $IdMenu, "$iMenuEntry = " & $iMenuEntry, "$iMenuRadioItem = " & $iMenuRadioItem)
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

Func __Stub_GUICtrlSetState($idCtrl, $iState)
	Local $vReturn = __DefineStub("GUICtrlSetState", __CallArgs("idCtrl = " & $idCtrl, "iState = " & $iState), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlGetState($idCtrl)
	Local $vReturn = __DefineStub("GUICtrlGetState", __CallArgs("idCtrl = " & $idCtrl), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetData($idCtrl, $vData, $vDefault = "")
	Local $vReturn = __DefineStub("GUICtrlSetData", __CallArgs("idCtrl = " & $idCtrl, "vData = " & $vData, "vDefault = " & $vDefault), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlRead($idCtrl, $iAdvanced = 0)
	Local $vReturn = __DefineStub("GUICtrlRead", __CallArgs("idCtrl = " & $idCtrl, "iAdvanced = " & $iAdvanced), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlDelete($idCtrl)
	Local $vReturn = __DefineStub("GUICtrlDelete", __CallArgs("idCtrl = " & $idCtrl), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetFont($idCtrl, $iSize, $iWeight = 0, $iAttrib = 0, $sName = "", $iQuality = 0)
	Local $aArgs = __CallArgs("idCtrl = " & $idCtrl, "iSize = " & $iSize, "iWeight = " & $iWeight, _
							  "iAttrib = " & $iAttrib, "sName = " & $sName, "iQuality = " & $iQuality)
	Local $vReturn = __DefineStub("GUICtrlSetFont", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetColor($idCtrl, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetColor", __CallArgs("idCtrl = " & $idCtrl, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetBkColor($idCtrl, $iColor)
	Local $vReturn = __DefineStub("GUICtrlSetBkColor", __CallArgs("idCtrl = " & $idCtrl, "iColor = " & $iColor), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetPos($idCtrl, $iLeft, $iTop, $iWidth = Default, $iHeight = Default)
	Local $aArgs =  __CallArgs("idCtrl = " & $idCtrl, "iLeft = " & $iLeft, "iTop = " & $iTop, "iWidth = " & $iWidth, "iHeight = " & $iHeight)
	Local $vReturn = __DefineStub("GUICtrlSetPos", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_GUICtrlSetTip($idCtrl, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
	Local $aArgs = __CallArgs("idCtrl = " & $idCtrl, "sTooltip = " & $sTooltip, "sTitle = " & $sTitle, "iIcon = " & $iIcon, "iOptions = " & $iOptions)
	Local $vReturn = __DefineStub("GUICtrlSetTip", $aArgs, 1)
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
