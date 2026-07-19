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

; --- Lifecycle ---

Func _Stub_GUICreate($sTitle, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $iStyle = -1, $iExStyle = -1, $hWndParent = 0)
    __StubInitType("GUICreate")
    Local $iIdx = $g_StubCalls["GUICreate"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["GUICreate"][$iIdx] = $oCall
    $g_StubCalls["GUICreate"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["GUICreate"], $iIdx) ? $g_StubReturns["GUICreate"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_GUIDelete($hWnd = 0)
    __StubInitType("GUIDelete")
    Local $iIdx = $g_StubCalls["GUIDelete"].count + 1
    Local $oCall[]
    $g_StubCalls["GUIDelete"][$iIdx] = $oCall
    $g_StubCalls["GUIDelete"].count  = $iIdx
EndFunc

Func _Stub_GUISetState($iState = @SW_SHOW, $hWnd = 0)
    __StubInitType("GUISetState")
    Local $iIdx = $g_StubCalls["GUISetState"].count + 1
    Local $oCall[]
    $oCall["iState"] = $iState
    $g_StubCalls["GUISetState"][$iIdx] = $oCall
    $g_StubCalls["GUISetState"].count  = $iIdx
EndFunc

Func _Stub_GUISetBkColor($iColor, $hWnd = 0)
    __StubInitType("GUISetBkColor")
    Local $iIdx = $g_StubCalls["GUISetBkColor"].count + 1
    Local $oCall[]
    $oCall["iColor"] = $iColor
    $g_StubCalls["GUISetBkColor"][$iIdx] = $oCall
    $g_StubCalls["GUISetBkColor"].count  = $iIdx
EndFunc

Func _Stub_GUISetFont($iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $hWnd = 0)
    __StubInitType("GUISetFont")
    Local $iIdx = $g_StubCalls["GUISetFont"].count + 1
    Local $oCall[]
    $oCall["iSize"] = $iSize
    $oCall["sName"] = $sName
    $g_StubCalls["GUISetFont"][$iIdx] = $oCall
    $g_StubCalls["GUISetFont"].count  = $iIdx
EndFunc

Func _Stub_GUIGetMsg($iAdvanced = 0)
    __StubInitType("GUIGetMsg")
    Local $iIdx = $g_StubCalls["GUIGetMsg"].count + 1
    Local $oCall[]
    $g_StubCalls["GUIGetMsg"][$iIdx] = $oCall
    $g_StubCalls["GUIGetMsg"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["GUIGetMsg"], $iIdx) ? $g_StubReturns["GUIGetMsg"][$iIdx] : $GUI_EVENT_CLOSE
    Return $iReturn
EndFunc

Func _Stub_GUISwitch($hWnd, $hWndTopMost = 0)
    __StubInitType("GUISwitch")
    Local $iIdx = $g_StubCalls["GUISwitch"].count + 1
    Local $oCall[]
    $g_StubCalls["GUISwitch"][$iIdx] = $oCall
    $g_StubCalls["GUISwitch"].count  = $iIdx
EndFunc

; --- Control creation ---

Func __StubCtrlCreate($sType, $sText)
    __StubInitType($sType)
    Local $iIdx = $g_StubCalls[$sType].count + 1
    Local $oCall[]
    $oCall["sText"] = $sText
    $g_StubCalls[$sType][$iIdx] = $oCall
    $g_StubCalls[$sType].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns[$sType], $iIdx) ? $g_StubReturns[$sType][$iIdx] : $iIdx + 100
    Return $iReturn
EndFunc

Func _Stub_GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateLabel", $sText)
EndFunc

Func _Stub_GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateButton", $sText)
EndFunc

Func _Stub_GUICtrlCreateInput($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateInput", $sText)
EndFunc

Func _Stub_GUICtrlCreateEdit($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateEdit", $sText)
EndFunc

Func _Stub_GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateCheckbox", $sText)
EndFunc

Func _Stub_GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateRadio", $sText)
EndFunc

Func _Stub_GUICtrlCreateCombo($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateCombo", $sText)
EndFunc

Func _Stub_GUICtrlCreateList($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateList", $sText)
EndFunc

Func _Stub_GUICtrlCreateListView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateListView", $sText)
EndFunc

Func _Stub_GUICtrlCreateListViewItem($sText, $hWnd)
    Return __StubCtrlCreate("GUICtrlCreateListViewItem", $sText)
EndFunc

Func _Stub_GUICtrlCreateTreeView($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateTreeView", $sText)
EndFunc

Func _Stub_GUICtrlCreateTreeViewItem($sText, $hWnd)
    Return __StubCtrlCreate("GUICtrlCreateTreeViewItem", $sText)
EndFunc

Func _Stub_GUICtrlCreateProgress($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateProgress", "")
EndFunc

Func _Stub_GUICtrlCreateTab($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateTab", "")
EndFunc

Func _Stub_GUICtrlCreateTabItem($sText)
    Return __StubCtrlCreate("GUICtrlCreateTabItem", $sText)
EndFunc

Func _Stub_GUICtrlCreateDate($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateDate", $sText)
EndFunc

Func _Stub_GUICtrlCreateUpdown($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateUpdown", "")
EndFunc

Func _Stub_GUICtrlCreateGroup($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateGroup", $sText)
EndFunc

Func _Stub_GUICtrlCreateMenu($sText, $hWnd = 0, $iStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateMenu", $sText)
EndFunc

Func _Stub_GUICtrlCreateMenuItem($sText, $hWnd, $iMenuItemID = -1, $iStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateMenuItem", $sText)
EndFunc

Func _Stub_GUICtrlCreateSlider($iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreateSlider", "")
EndFunc

Func _Stub_GUICtrlCreatePic($sFilename, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
    Return __StubCtrlCreate("GUICtrlCreatePic", $sFilename)
EndFunc

; --- Control interaction ---

Func _Stub_GUICtrlSetState($idCtrl, $iState)
    __StubInitType("GUICtrlSetState")
    Local $iIdx = $g_StubCalls["GUICtrlSetState"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["iState"] = $iState
    $g_StubCalls["GUICtrlSetState"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetState"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlGetState($idCtrl)
    __StubInitType("GUICtrlGetState")
    Local $iIdx = $g_StubCalls["GUICtrlGetState"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $g_StubCalls["GUICtrlGetState"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlGetState"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["GUICtrlGetState"], $iIdx) ? $g_StubReturns["GUICtrlGetState"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_GUICtrlSetData($idCtrl, $vData, $vDefault = "")
    __StubInitType("GUICtrlSetData")
    Local $iIdx = $g_StubCalls["GUICtrlSetData"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["vData"]  = $vData
    $g_StubCalls["GUICtrlSetData"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetData"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlRead($idCtrl, $iMode = 0)
    __StubInitType("GUICtrlRead")
    Local $iIdx = $g_StubCalls["GUICtrlRead"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $g_StubCalls["GUICtrlRead"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlRead"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["GUICtrlRead"], $iIdx) ? $g_StubReturns["GUICtrlRead"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_GUICtrlDelete($idCtrl)
    __StubInitType("GUICtrlDelete")
    Local $iIdx = $g_StubCalls["GUICtrlDelete"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $g_StubCalls["GUICtrlDelete"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlDelete"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlSetFont($idCtrl, $iSize, $iWeight = 400, $iAttrib = 0, $sName = "", $iQuality = -1)
    __StubInitType("GUICtrlSetFont")
    Local $iIdx = $g_StubCalls["GUICtrlSetFont"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["iSize"]  = $iSize
    $oCall["sName"]  = $sName
    $g_StubCalls["GUICtrlSetFont"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetFont"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlSetColor($idCtrl, $iColor)
    __StubInitType("GUICtrlSetColor")
    Local $iIdx = $g_StubCalls["GUICtrlSetColor"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["iColor"] = $iColor
    $g_StubCalls["GUICtrlSetColor"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetColor"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlSetBkColor($idCtrl, $iColor)
    __StubInitType("GUICtrlSetBkColor")
    Local $iIdx = $g_StubCalls["GUICtrlSetBkColor"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["iColor"] = $iColor
    $g_StubCalls["GUICtrlSetBkColor"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetBkColor"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlSetPos($idCtrl, $iLeft, $iTop, $iWidth = -1, $iHeight = -1)
    __StubInitType("GUICtrlSetPos")
    Local $iIdx = $g_StubCalls["GUICtrlSetPos"].count + 1
    Local $oCall[]
    $oCall["idCtrl"] = $idCtrl
    $oCall["iLeft"]  = $iLeft
    $oCall["iTop"]   = $iTop
    $g_StubCalls["GUICtrlSetPos"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetPos"].count  = $iIdx
EndFunc

Func _Stub_GUICtrlSetTip($idCtrl, $sTooltip, $sTitle = "", $iIcon = 0, $iOptions = 0)
    __StubInitType("GUICtrlSetTip")
    Local $iIdx = $g_StubCalls["GUICtrlSetTip"].count + 1
    Local $oCall[]
    $oCall["idCtrl"]   = $idCtrl
    $oCall["sTooltip"] = $sTooltip
    $g_StubCalls["GUICtrlSetTip"][$iIdx] = $oCall
    $g_StubCalls["GUICtrlSetTip"].count  = $iIdx
EndFunc

; --- Auto-wire ---
$g_hFn_GUICreate             = _Stub_GUICreate
$g_hFn_GUIDelete             = _Stub_GUIDelete
$g_hFn_GUISetState           = _Stub_GUISetState
$g_hFn_GUISetBkColor         = _Stub_GUISetBkColor
$g_hFn_GUISetFont            = _Stub_GUISetFont
$g_hFn_GUIGetMsg             = _Stub_GUIGetMsg
$g_hFn_GUISwitch             = _Stub_GUISwitch
$g_hFn_GUICtrlCreateLabel    = _Stub_GUICtrlCreateLabel
$g_hFn_GUICtrlCreateButton   = _Stub_GUICtrlCreateButton
$g_hFn_GUICtrlCreateInput    = _Stub_GUICtrlCreateInput
$g_hFn_GUICtrlCreateEdit     = _Stub_GUICtrlCreateEdit
$g_hFn_GUICtrlCreateCheckbox = _Stub_GUICtrlCreateCheckbox
$g_hFn_GUICtrlCreateRadio    = _Stub_GUICtrlCreateRadio
$g_hFn_GUICtrlCreateCombo    = _Stub_GUICtrlCreateCombo
$g_hFn_GUICtrlCreateList     = _Stub_GUICtrlCreateList
$g_hFn_GUICtrlCreateListView = _Stub_GUICtrlCreateListView
$g_hFn_GUICtrlCreateListViewItem  = _Stub_GUICtrlCreateListViewItem
$g_hFn_GUICtrlCreateTreeView      = _Stub_GUICtrlCreateTreeView
$g_hFn_GUICtrlCreateTreeViewItem  = _Stub_GUICtrlCreateTreeViewItem
$g_hFn_GUICtrlCreateProgress = _Stub_GUICtrlCreateProgress
$g_hFn_GUICtrlCreateTab      = _Stub_GUICtrlCreateTab
$g_hFn_GUICtrlCreateTabItem  = _Stub_GUICtrlCreateTabItem
$g_hFn_GUICtrlCreateDate     = _Stub_GUICtrlCreateDate
$g_hFn_GUICtrlCreateUpdown   = _Stub_GUICtrlCreateUpdown
$g_hFn_GUICtrlCreateGroup    = _Stub_GUICtrlCreateGroup
$g_hFn_GUICtrlCreateMenu     = _Stub_GUICtrlCreateMenu
$g_hFn_GUICtrlCreateMenuItem = _Stub_GUICtrlCreateMenuItem
$g_hFn_GUICtrlCreateSlider   = _Stub_GUICtrlCreateSlider
$g_hFn_GUICtrlCreatePic      = _Stub_GUICtrlCreatePic
$g_hFn_GUICtrlSetState       = _Stub_GUICtrlSetState
$g_hFn_GUICtrlGetState       = _Stub_GUICtrlGetState
$g_hFn_GUICtrlSetData        = _Stub_GUICtrlSetData
$g_hFn_GUICtrlRead           = _Stub_GUICtrlRead
$g_hFn_GUICtrlDelete         = _Stub_GUICtrlDelete
$g_hFn_GUICtrlSetFont        = _Stub_GUICtrlSetFont
$g_hFn_GUICtrlSetColor       = _Stub_GUICtrlSetColor
$g_hFn_GUICtrlSetBkColor     = _Stub_GUICtrlSetBkColor
$g_hFn_GUICtrlSetPos         = _Stub_GUICtrlSetPos
$g_hFn_GUICtrlSetTip         = _Stub_GUICtrlSetTip
