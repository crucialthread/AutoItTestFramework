; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Clipboard.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt clipboard functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_ClipGet()
	Local $vReturn = __DefineStub("ClipGet", __CallArgs(), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ClipPut($sClipValue)
	Local $vReturn = __DefineStub("ClipPut", __CallArgs("sClipValue = " & $sClipValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_ClipGet = __Stub_ClipGet
$g_hFn_ClipPut = __Stub_ClipPut
