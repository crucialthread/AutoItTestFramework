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
	Return __DefineStub("FileInstall", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
EndFunc

$g_hFn_FileInstall = _Stub_FileInstall
