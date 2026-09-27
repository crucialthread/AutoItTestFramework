#include-once

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableSound.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt sound functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

Global $g_hFn_SoundPlay = SoundPlay

Func _Tstbl_SoundPlay($sFilename, $iWait = 0)
    Local $vResult = $g_hFn_SoundPlay($sFilename, $iWait)
    Return SetError(@error, @extended, $vResult)
EndFunc
