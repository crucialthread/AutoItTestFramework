; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Network.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt network functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_InetGet     = InetGet
Global $g_hFn_InetRead    = InetRead
Global $g_hFn_InetClose   = InetClose
Global $g_hFn_InetGetSize = InetGetSize
Global $g_hFn_Ping        = Ping

Func _Tstbl_InetGet($sURL, $sFilename, $iOptions = 0, $hDownloadCallback = 0)
    Local $vResult = $g_hFn_InetGet($sURL, $sFilename, $iOptions, $hDownloadCallback)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_InetRead($sURL, $iOptions = 0)
    Local $vResult = $g_hFn_InetRead($sURL, $iOptions)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_InetClose($hDownload)
    Local $vResult = $g_hFn_InetClose($hDownload)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_InetGetSize($sURL, $iOptions = 0)
    Local $vResult = $g_hFn_InetGetSize($sURL, $iOptions)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_Ping($sHost, $iTimeout = 4000)
    Local $vResult = $g_hFn_Ping($sHost, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc
