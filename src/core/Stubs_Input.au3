; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Input.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt input simulation functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_Send($sKeys, $iFlag = 0)
    __StubInitType("Send")
    Local $iIdx = $g_StubCalls["Send"].count + 1
    Local $oCall[]
    $oCall["sKeys"] = $sKeys
    $oCall["iFlag"] = $iFlag
    $g_StubCalls["Send"][$iIdx] = $oCall
    $g_StubCalls["Send"].count  = $iIdx
EndFunc

Func _Stub_MouseClick($sButton = "left", $iX = -2147483647, $iY = -2147483647, $iClicks = 1, $iSpeed = -1)
    __StubInitType("MouseClick")
    Local $iIdx = $g_StubCalls["MouseClick"].count + 1
    Local $oCall[]
    $oCall["sButton"] = $sButton
    $oCall["iX"]      = $iX
    $oCall["iY"]      = $iY
    $g_StubCalls["MouseClick"][$iIdx] = $oCall
    $g_StubCalls["MouseClick"].count  = $iIdx
EndFunc

Func _Stub_MouseMove($iX, $iY, $iSpeed = -1)
    __StubInitType("MouseMove")
    Local $iIdx = $g_StubCalls["MouseMove"].count + 1
    Local $oCall[]
    $oCall["iX"] = $iX
    $oCall["iY"] = $iY
    $g_StubCalls["MouseMove"][$iIdx] = $oCall
    $g_StubCalls["MouseMove"].count  = $iIdx
EndFunc

Func _Stub_MouseGetPos($iIndex = 0)
    __StubInitType("MouseGetPos")
    Local $iIdx = $g_StubCalls["MouseGetPos"].count + 1
    Local $oCall[]
    $g_StubCalls["MouseGetPos"][$iIdx] = $oCall
    $g_StubCalls["MouseGetPos"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["MouseGetPos"], $iIdx) ? $g_StubReturns["MouseGetPos"][$iIdx] : 0
    Return $vReturn
EndFunc

Func _Stub_ControlClick($sTitle, $sText, $sControl, $sButton = "left", $iNumClicks = 1, $iX = -2147483647, $iY = -2147483647)
    __StubInitType("ControlClick")
    Local $iIdx = $g_StubCalls["ControlClick"].count + 1
    Local $oCall[]
    $oCall["sTitle"]   = $sTitle
    $oCall["sControl"] = $sControl
    $oCall["sButton"]  = $sButton
    $g_StubCalls["ControlClick"][$iIdx] = $oCall
    $g_StubCalls["ControlClick"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ControlClick"], $iIdx) ? $g_StubReturns["ControlClick"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_ControlSetText($sTitle, $sText, $sControl, $sNewText, $bFlag = True)
    __StubInitType("ControlSetText")
    Local $iIdx = $g_StubCalls["ControlSetText"].count + 1
    Local $oCall[]
    $oCall["sTitle"]   = $sTitle
    $oCall["sControl"] = $sControl
    $oCall["sNewText"] = $sNewText
    $g_StubCalls["ControlSetText"][$iIdx] = $oCall
    $g_StubCalls["ControlSetText"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ControlSetText"], $iIdx) ? $g_StubReturns["ControlSetText"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_ControlGetText($sTitle, $sText, $sControl)
    __StubInitType("ControlGetText")
    Local $iIdx = $g_StubCalls["ControlGetText"].count + 1
    Local $oCall[]
    $oCall["sTitle"]   = $sTitle
    $oCall["sControl"] = $sControl
    $g_StubCalls["ControlGetText"][$iIdx] = $oCall
    $g_StubCalls["ControlGetText"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["ControlGetText"], $iIdx) ? $g_StubReturns["ControlGetText"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_ControlSend($sTitle, $sText, $sControl, $sKeys, $iFlag = 0)
    __StubInitType("ControlSend")
    Local $iIdx = $g_StubCalls["ControlSend"].count + 1
    Local $oCall[]
    $oCall["sTitle"]   = $sTitle
    $oCall["sControl"] = $sControl
    $oCall["sKeys"]    = $sKeys
    $g_StubCalls["ControlSend"][$iIdx] = $oCall
    $g_StubCalls["ControlSend"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ControlSend"], $iIdx) ? $g_StubReturns["ControlSend"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_ControlFocus($sTitle, $sText, $sControl)
    __StubInitType("ControlFocus")
    Local $iIdx = $g_StubCalls["ControlFocus"].count + 1
    Local $oCall[]
    $oCall["sTitle"]   = $sTitle
    $oCall["sControl"] = $sControl
    $g_StubCalls["ControlFocus"][$iIdx] = $oCall
    $g_StubCalls["ControlFocus"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ControlFocus"], $iIdx) ? $g_StubReturns["ControlFocus"][$iIdx] : True
    Return $bReturn
EndFunc

$g_hFn_Send           = _Stub_Send
$g_hFn_MouseClick     = _Stub_MouseClick
$g_hFn_MouseMove      = _Stub_MouseMove
$g_hFn_MouseGetPos    = _Stub_MouseGetPos
$g_hFn_ControlClick   = _Stub_ControlClick
$g_hFn_ControlSetText = _Stub_ControlSetText
$g_hFn_ControlGetText = _Stub_ControlGetText
$g_hFn_ControlSend    = _Stub_ControlSend
$g_hFn_ControlFocus   = _Stub_ControlFocus
