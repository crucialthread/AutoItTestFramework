; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Clipboard.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt clipboard functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_ClipGet()
	Local $vReturn = __DefineStub("ClipGet", __CallArgs(), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ClipPut($sClip)
	Local $vReturn = __DefineStub("ClipPut", __CallArgs("sClip = " & $sClip), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_ClipGet = _Stub_ClipGet
$g_hFn_ClipPut = _Stub_ClipPut
