; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Splash.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt splash and progress functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_SplashTextOn($sTitle, $sText, $iWidth = 500, $iHeight = 400, $iXPos = -1, $iYPos = -1, $iOpt = 1, $sFont = "", $iFontSize = 15, $iFontStyle = 0)
    __StubInitType("SplashTextOn")
    Local $iIdx = $g_StubCalls["SplashTextOn"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $oCall["sText"]  = $sText
    $g_StubCalls["SplashTextOn"][$iIdx] = $oCall
    $g_StubCalls["SplashTextOn"].count  = $iIdx
EndFunc

Func _Stub_SplashImageOn($sTitle, $sFile, $iWidth = -1, $iHeight = -1, $iXPos = -1, $iYPos = -1, $iOpt = 1)
    __StubInitType("SplashImageOn")
    Local $iIdx = $g_StubCalls["SplashImageOn"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $oCall["sFile"]  = $sFile
    $g_StubCalls["SplashImageOn"][$iIdx] = $oCall
    $g_StubCalls["SplashImageOn"].count  = $iIdx
EndFunc

Func _Stub_SplashOff()
    __StubInitType("SplashOff")
    Local $iIdx = $g_StubCalls["SplashOff"].count + 1
    Local $oCall[]
    $g_StubCalls["SplashOff"][$iIdx] = $oCall
    $g_StubCalls["SplashOff"].count  = $iIdx
EndFunc

Func _Stub_ProgressOn($sTitle, $sText, $sSubText = "", $iXPos = -1, $iYPos = -1, $iOpt = 1)
    __StubInitType("ProgressOn")
    Local $iIdx = $g_StubCalls["ProgressOn"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $oCall["sText"]  = $sText
    $g_StubCalls["ProgressOn"][$iIdx] = $oCall
    $g_StubCalls["ProgressOn"].count  = $iIdx
EndFunc

Func _Stub_ProgressSet($iPercent, $sText = "", $sTitle = "")
    __StubInitType("ProgressSet")
    Local $iIdx = $g_StubCalls["ProgressSet"].count + 1
    Local $oCall[]
    $oCall["iPercent"] = $iPercent
    $oCall["sText"]    = $sText
    $g_StubCalls["ProgressSet"][$iIdx] = $oCall
    $g_StubCalls["ProgressSet"].count  = $iIdx
EndFunc

Func _Stub_ProgressOff()
    __StubInitType("ProgressOff")
    Local $iIdx = $g_StubCalls["ProgressOff"].count + 1
    Local $oCall[]
    $g_StubCalls["ProgressOff"][$iIdx] = $oCall
    $g_StubCalls["ProgressOff"].count  = $iIdx
EndFunc

$g_hFn_SplashTextOn  = _Stub_SplashTextOn
$g_hFn_SplashImageOn = _Stub_SplashImageOn
$g_hFn_SplashOff     = _Stub_SplashOff
$g_hFn_ProgressOn    = _Stub_ProgressOn
$g_hFn_ProgressSet   = _Stub_ProgressSet
$g_hFn_ProgressOff   = _Stub_ProgressOff
