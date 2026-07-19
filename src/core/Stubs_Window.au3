; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Window.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt window management functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_WinExists($sTitle, $sText = "")
    __StubInitType("WinExists")
    Local $iIdx = $g_StubCalls["WinExists"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinExists"][$iIdx] = $oCall
    $g_StubCalls["WinExists"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinExists"], $iIdx) ? $g_StubReturns["WinExists"][$iIdx] : False
    Return $bReturn
EndFunc

Func _Stub_WinActive($sTitle, $sText = "")
    __StubInitType("WinActive")
    Local $iIdx = $g_StubCalls["WinActive"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinActive"][$iIdx] = $oCall
    $g_StubCalls["WinActive"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinActive"], $iIdx) ? $g_StubReturns["WinActive"][$iIdx] : False
    Return $bReturn
EndFunc

Func _Stub_WinActivate($sTitle, $sText = "")
    __StubInitType("WinActivate")
    Local $iIdx = $g_StubCalls["WinActivate"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinActivate"][$iIdx] = $oCall
    $g_StubCalls["WinActivate"].count  = $iIdx
EndFunc

Func _Stub_WinWait($sTitle, $sText = "", $iTimeout = 0)
    __StubInitType("WinWait")
    Local $iIdx = $g_StubCalls["WinWait"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinWait"][$iIdx] = $oCall
    $g_StubCalls["WinWait"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["WinWait"], $iIdx) ? $g_StubReturns["WinWait"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_WinWaitActive($sTitle, $sText = "", $iTimeout = 0)
    __StubInitType("WinWaitActive")
    Local $iIdx = $g_StubCalls["WinWaitActive"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinWaitActive"][$iIdx] = $oCall
    $g_StubCalls["WinWaitActive"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["WinWaitActive"], $iIdx) ? $g_StubReturns["WinWaitActive"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_WinWaitClose($sTitle, $sText = "", $iTimeout = 0)
    __StubInitType("WinWaitClose")
    Local $iIdx = $g_StubCalls["WinWaitClose"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinWaitClose"][$iIdx] = $oCall
    $g_StubCalls["WinWaitClose"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["WinWaitClose"], $iIdx) ? $g_StubReturns["WinWaitClose"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_WinClose($sTitle, $sText = "")
    __StubInitType("WinClose")
    Local $iIdx = $g_StubCalls["WinClose"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinClose"][$iIdx] = $oCall
    $g_StubCalls["WinClose"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinClose"], $iIdx) ? $g_StubReturns["WinClose"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_WinKill($sTitle, $sText = "")
    __StubInitType("WinKill")
    Local $iIdx = $g_StubCalls["WinKill"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinKill"][$iIdx] = $oCall
    $g_StubCalls["WinKill"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinKill"], $iIdx) ? $g_StubReturns["WinKill"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_WinGetText($sTitle, $sText = "")
    __StubInitType("WinGetText")
    Local $iIdx = $g_StubCalls["WinGetText"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinGetText"][$iIdx] = $oCall
    $g_StubCalls["WinGetText"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["WinGetText"], $iIdx) ? $g_StubReturns["WinGetText"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_WinGetTitle($sTitle, $sText = "")
    __StubInitType("WinGetTitle")
    Local $iIdx = $g_StubCalls["WinGetTitle"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinGetTitle"][$iIdx] = $oCall
    $g_StubCalls["WinGetTitle"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["WinGetTitle"], $iIdx) ? $g_StubReturns["WinGetTitle"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_WinGetState($sTitle, $sText = "")
    __StubInitType("WinGetState")
    Local $iIdx = $g_StubCalls["WinGetState"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinGetState"][$iIdx] = $oCall
    $g_StubCalls["WinGetState"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["WinGetState"], $iIdx) ? $g_StubReturns["WinGetState"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_WinSetState($sTitle, $sText, $iFlags)
    __StubInitType("WinSetState")
    Local $iIdx = $g_StubCalls["WinSetState"].count + 1
    Local $oCall[]
    $oCall["sTitle"]  = $sTitle
    $oCall["iFlags"]  = $iFlags
    $g_StubCalls["WinSetState"][$iIdx] = $oCall
    $g_StubCalls["WinSetState"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinSetState"], $iIdx) ? $g_StubReturns["WinSetState"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_WinSetTitle($sTitle, $sText, $sNewTitle)
    __StubInitType("WinSetTitle")
    Local $iIdx = $g_StubCalls["WinSetTitle"].count + 1
    Local $oCall[]
    $oCall["sTitle"]    = $sTitle
    $oCall["sNewTitle"] = $sNewTitle
    $g_StubCalls["WinSetTitle"][$iIdx] = $oCall
    $g_StubCalls["WinSetTitle"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinSetTitle"], $iIdx) ? $g_StubReturns["WinSetTitle"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_WinMove($sTitle, $sText, $iX, $iY, $iWidth = -1, $iHeight = -1)
    __StubInitType("WinMove")
    Local $iIdx = $g_StubCalls["WinMove"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $oCall["iX"]     = $iX
    $oCall["iY"]     = $iY
    $g_StubCalls["WinMove"][$iIdx] = $oCall
    $g_StubCalls["WinMove"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["WinMove"], $iIdx) ? $g_StubReturns["WinMove"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_WinGetPos($sTitle, $sText = "")
    __StubInitType("WinGetPos")
    Local $iIdx = $g_StubCalls["WinGetPos"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["WinGetPos"][$iIdx] = $oCall
    $g_StubCalls["WinGetPos"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["WinGetPos"], $iIdx) ? $g_StubReturns["WinGetPos"][$iIdx] : ""
    Return $vReturn
EndFunc

$g_hFn_WinExists       = _Stub_WinExists
$g_hFn_WinActive       = _Stub_WinActive
$g_hFn_WinActivate     = _Stub_WinActivate
$g_hFn_WinWait         = _Stub_WinWait
$g_hFn_WinWaitActive   = _Stub_WinWaitActive
$g_hFn_WinWaitClose    = _Stub_WinWaitClose
$g_hFn_WinClose        = _Stub_WinClose
$g_hFn_WinKill         = _Stub_WinKill
$g_hFn_WinGetText      = _Stub_WinGetText
$g_hFn_WinGetTitle     = _Stub_WinGetTitle
$g_hFn_WinGetState     = _Stub_WinGetState
$g_hFn_WinSetState     = _Stub_WinSetState
$g_hFn_WinSetTitle     = _Stub_WinSetTitle
$g_hFn_WinMove         = _Stub_WinMove
$g_hFn_WinGetPos       = _Stub_WinGetPos
