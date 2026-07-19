; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Clipboard.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt clipboard functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_ClipGet()
    __StubInitType("ClipGet")
    Local $iIdx = $g_StubCalls["ClipGet"].count + 1
    Local $oCall[]
    $g_StubCalls["ClipGet"][$iIdx] = $oCall
    $g_StubCalls["ClipGet"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["ClipGet"], $iIdx) ? $g_StubReturns["ClipGet"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_ClipPut($sClip)
    __StubInitType("ClipPut")
    Local $iIdx = $g_StubCalls["ClipPut"].count + 1
    Local $oCall[]
    $oCall["sClip"] = $sClip
    $g_StubCalls["ClipPut"][$iIdx] = $oCall
    $g_StubCalls["ClipPut"].count  = $iIdx
EndFunc

$g_hFn_ClipGet = _Stub_ClipGet
$g_hFn_ClipPut = _Stub_ClipPut
