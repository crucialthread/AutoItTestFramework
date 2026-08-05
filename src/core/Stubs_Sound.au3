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

Func _Stub_SoundPlay($sFilename, $iWait = 0)
	Local $vReturn = __DefineStub("SoundPlay", __CallArgs("sFilename = " & $sFilename, "iWait = " & $iWait), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_SoundPlay = _Stub_SoundPlay
