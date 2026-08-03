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
	Return __DefineStub("ClipGet", __CallArgs(), "")
EndFunc

Func _Stub_ClipPut($sClip)
	Return __DefineStub("ClipPut", __CallArgs("sClip = " & $sClip), 1)
EndFunc

$g_hFn_ClipGet = _Stub_ClipGet
$g_hFn_ClipPut = _Stub_ClipPut
