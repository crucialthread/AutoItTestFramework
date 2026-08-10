; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Network.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt network functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_InetGet($sURL, $sFilename, $iOptions = 0, $iBackground  = 0)
	Local $aArgs = __CallArgs("sURL = " & $sURL, "sFilename = " & $sFilename, "iOptions = " & $iOptions, "iBackground = " & $iBackground)
	Local $vReturn = __DefineStub("InetGet", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_InetRead($sURL, $iOptions = 0)
	Local $vReturn = __DefineStub("InetRead", __CallArgs("sURL = " & $sURL, "iOptions = " & $iOptions), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_InetClose($hHandle)
	Local $vReturn = __DefineStub("InetClose", __CallArgs("hHandle = " & $hHandle), True)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_InetGetSize($sURL, $iOptions = 0)
	Local $vReturn = __DefineStub("InetGetSize", __CallArgs("sURL = " & $sURL, "iOptions = " & $iOptions), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_Ping($sHost, $iTimeout = 4000)
	Local $vReturn = __DefineStub("Ping", __CallArgs("sHost = " & $sHost, "iTimeout = " & $iTimeout), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_InetGet     = __Stub_InetGet
$g_hFn_InetRead    = __Stub_InetRead
$g_hFn_InetClose   = __Stub_InetClose
$g_hFn_InetGetSize = __Stub_InetGetSize
$g_hFn_Ping        = __Stub_Ping
