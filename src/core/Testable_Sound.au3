; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Sound.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt sound functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_SoundPlay = SoundPlay

Func _Tstbl_SoundPlay($sFilename, $bWait = False)
    Local $vResult = $g_hFn_SoundPlay($sFilename, $bWait)
    Return SetError(@error, @extended, $vResult)
EndFunc
