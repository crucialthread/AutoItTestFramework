; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Sound.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt sound functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_SoundPlay($sFilename, $bWait = False)
    __StubInitType("SoundPlay")
    Local $iIdx = $g_StubCalls["SoundPlay"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["bWait"]     = $bWait
    $g_StubCalls["SoundPlay"][$iIdx] = $oCall
    $g_StubCalls["SoundPlay"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["SoundPlay"], $iIdx) ? $g_StubReturns["SoundPlay"][$iIdx] : True
    Return $bReturn
EndFunc

$g_hFn_SoundPlay = _Stub_SoundPlay
