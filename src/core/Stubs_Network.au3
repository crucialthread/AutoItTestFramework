; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Network.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt network functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_InetGet($sURL, $sFilename, $iOptions = 0, $hDownloadCallback = 0)
    __StubInitType("InetGet")
    Local $iIdx = $g_StubCalls["InetGet"].count + 1
    Local $oCall[]
    $oCall["sURL"]      = $sURL
    $oCall["sFilename"] = $sFilename
    $g_StubCalls["InetGet"][$iIdx] = $oCall
    $g_StubCalls["InetGet"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["InetGet"], $iIdx) ? $g_StubReturns["InetGet"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_InetRead($sURL, $iOptions = 0)
    __StubInitType("InetRead")
    Local $iIdx = $g_StubCalls["InetRead"].count + 1
    Local $oCall[]
    $oCall["sURL"] = $sURL
    $g_StubCalls["InetRead"][$iIdx] = $oCall
    $g_StubCalls["InetRead"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["InetRead"], $iIdx) ? $g_StubReturns["InetRead"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_InetClose($hDownload)
    __StubInitType("InetClose")
    Local $iIdx = $g_StubCalls["InetClose"].count + 1
    Local $oCall[]
    $g_StubCalls["InetClose"][$iIdx] = $oCall
    $g_StubCalls["InetClose"].count  = $iIdx
EndFunc

Func _Stub_InetGetSize($sURL, $iOptions = 0)
    __StubInitType("InetGetSize")
    Local $iIdx = $g_StubCalls["InetGetSize"].count + 1
    Local $oCall[]
    $oCall["sURL"] = $sURL
    $g_StubCalls["InetGetSize"][$iIdx] = $oCall
    $g_StubCalls["InetGetSize"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["InetGetSize"], $iIdx) ? $g_StubReturns["InetGetSize"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_Ping($sHost, $iTimeout = 4000)
    __StubInitType("Ping")
    Local $iIdx = $g_StubCalls["Ping"].count + 1
    Local $oCall[]
    $oCall["sHost"] = $sHost
    $g_StubCalls["Ping"][$iIdx] = $oCall
    $g_StubCalls["Ping"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["Ping"], $iIdx) ? $g_StubReturns["Ping"][$iIdx] : 0
    Return $iReturn
EndFunc

$g_hFn_InetGet     = _Stub_InetGet
$g_hFn_InetRead    = _Stub_InetRead
$g_hFn_InetClose   = _Stub_InetClose
$g_hFn_InetGetSize = _Stub_InetGetSize
$g_hFn_Ping        = _Stub_Ping
