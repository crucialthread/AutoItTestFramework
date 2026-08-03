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
	Return __DefineStub("InetGet", __CallArgs("sURL = " & $sURL, "sFilename = " & $sFilename), 1)
EndFunc

Func _Stub_InetRead($sURL, $iOptions = 0)
	Return __DefineStub("InetRead", __CallArgs("sURL = " & $sURL), "")
EndFunc

Func _Stub_InetClose($hDownload)
	Return __DefineStub("InetClose", __CallArgs(), True)
EndFunc

Func _Stub_InetGetSize($sURL, $iOptions = 0)
	Return __DefineStub("InetGetSize", __CallArgs("sURL = " & $sURL), 1)
EndFunc

Func _Stub_Ping($sHost, $iTimeout = 4000)
	Return __DefineStub("Ping", __CallArgs("sHost = " & $sHost), 1)
EndFunc

$g_hFn_InetGet     = _Stub_InetGet
$g_hFn_InetRead    = _Stub_InetRead
$g_hFn_InetClose   = _Stub_InetClose
$g_hFn_InetGetSize = _Stub_InetGetSize
$g_hFn_Ping        = _Stub_Ping
