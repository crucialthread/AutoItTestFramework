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
    __StubInitType("TrayTip")
    Local $iIdx = $g_StubCalls["TrayTip"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $oCall["sText"]  = $sText
    $g_StubCalls["TrayTip"][$iIdx] = $oCall
    $g_StubCalls["TrayTip"].count  = $iIdx
EndFunc

Func _Stub_TrayGetMsg()
    __StubInitType("TrayGetMsg")
    Local $iIdx = $g_StubCalls["TrayGetMsg"].count + 1
    Local $oCall[]
    $g_StubCalls["TrayGetMsg"][$iIdx] = $oCall
    $g_StubCalls["TrayGetMsg"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["TrayGetMsg"], $iIdx) ? $g_StubReturns["TrayGetMsg"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_TrayCreateItem($sText, $hMenu = -1, $iMenuItemID = -1, $iStyle = -1)
    __StubInitType("TrayCreateItem")
    Local $iIdx = $g_StubCalls["TrayCreateItem"].count + 1
    Local $oCall[]
    $oCall["sText"] = $sText
    $g_StubCalls["TrayCreateItem"][$iIdx] = $oCall
    $g_StubCalls["TrayCreateItem"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["TrayCreateItem"], $iIdx) ? $g_StubReturns["TrayCreateItem"][$iIdx] : $iIdx
    Return $iReturn
EndFunc

Func _Stub_TrayCreateMenu($sText, $hMenu = -1, $iMenuItemID = -1)
    __StubInitType("TrayCreateMenu")
    Local $iIdx = $g_StubCalls["TrayCreateMenu"].count + 1
    Local $oCall[]
    $oCall["sText"] = $sText
    $g_StubCalls["TrayCreateMenu"][$iIdx] = $oCall
    $g_StubCalls["TrayCreateMenu"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["TrayCreateMenu"], $iIdx) ? $g_StubReturns["TrayCreateMenu"][$iIdx] : $iIdx
    Return $iReturn
EndFunc

Func _Stub_TrayItemSetState($hItem, $iState)
    __StubInitType("TrayItemSetState")
    Local $iIdx = $g_StubCalls["TrayItemSetState"].count + 1
    Local $oCall[]
    $oCall["hItem"]  = $hItem
    $oCall["iState"] = $iState
    $g_StubCalls["TrayItemSetState"][$iIdx] = $oCall
    $g_StubCalls["TrayItemSetState"].count  = $iIdx
EndFunc

Func _Stub_TrayItemSetText($hItem, $sText)
    __StubInitType("TrayItemSetText")
    Local $iIdx = $g_StubCalls["TrayItemSetText"].count + 1
    Local $oCall[]
    $oCall["hItem"] = $hItem
    $oCall["sText"] = $sText
    $g_StubCalls["TrayItemSetText"][$iIdx] = $oCall
    $g_StubCalls["TrayItemSetText"].count  = $iIdx
EndFunc

Func _Stub_TrayItemGetState($hItem)
    __StubInitType("TrayItemGetState")
    Local $iIdx = $g_StubCalls["TrayItemGetState"].count + 1
    Local $oCall[]
    $oCall["hItem"] = $hItem
    $g_StubCalls["TrayItemGetState"][$iIdx] = $oCall
    $g_StubCalls["TrayItemGetState"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["TrayItemGetState"], $iIdx) ? $g_StubReturns["TrayItemGetState"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_TrayItemGetText($hItem)
    __StubInitType("TrayItemGetText")
    Local $iIdx = $g_StubCalls["TrayItemGetText"].count + 1
    Local $oCall[]
    $oCall["hItem"] = $hItem
    $g_StubCalls["TrayItemGetText"][$iIdx] = $oCall
    $g_StubCalls["TrayItemGetText"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["TrayItemGetText"], $iIdx) ? $g_StubReturns["TrayItemGetText"][$iIdx] : ""
    Return $sReturn
EndFunc

$g_hFn_TrayTip          = _Stub_TrayTip
$g_hFn_TrayGetMsg       = _Stub_TrayGetMsg
$g_hFn_TrayCreateItem   = _Stub_TrayCreateItem
$g_hFn_TrayCreateMenu   = _Stub_TrayCreateMenu
$g_hFn_TrayItemSetState = _Stub_TrayItemSetState
$g_hFn_TrayItemSetText  = _Stub_TrayItemSetText
$g_hFn_TrayItemGetState = _Stub_TrayItemGetState
$g_hFn_TrayItemGetText  = _Stub_TrayItemGetText
