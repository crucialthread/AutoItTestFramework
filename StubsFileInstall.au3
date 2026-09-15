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
;                  was registered, calls are ignored and returns Null with @error = 1,
;                  since there are no literal FileInstall paths defined to intercept.
; ===============================================================================================================================
#include-once

#include "StubsCore.au3"

Func __Stub_FileInstall($sSource, $sDest, $iFlag = 0)
    If Not __Tstbl_IsFileInstallImplemented() Then Return SetError(1, 0, Null)
    Local $vReturn = __DefineStub("FileInstall", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest, "iFlag = " & $iFlag), 1)
    Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_FileInstall = __Stub_FileInstall
