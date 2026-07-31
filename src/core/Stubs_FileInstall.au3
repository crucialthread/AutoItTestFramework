; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_FileInstall.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt FileInstall function.
;                  Can be included directly or via Stubs.au3.
;
;                  Unlike other stubs, this one requires the script under test to have called
;                  _Tstbl_Implement_FileInstall() with a valid function. The guard at the top
;                  of _Stub_FileInstall() checks the implemented flag - if no implementation
;                  was registered, calls are ignored and False is returned, since there are no
;                  literal FileInstall paths defined to intercept.
; ===============================================================================================================================
#include-once

#include "Stubs_Core.au3"

Func _Stub_FileInstall($sSource, $sDest, $iFlag = 0)
    If Not __Tstbl_IsFileInstallImplemented() Then Return False
    __StubInitType("FileInstall")
    Local $iIdx = $g_StubCalls["FileInstall"].count + 1
    Local $oCall[]
    $oCall.sSource = $sSource
    $oCall.sDest   = $sDest
    $g_StubCalls["FileInstall"][$iIdx] = $oCall
    $g_StubCalls["FileInstall"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileInstall"], $iIdx) ? $g_StubReturns["FileInstall"][$iIdx] : True
    Return $bReturn
EndFunc

$g_hFn_FileInstall = _Stub_FileInstall
