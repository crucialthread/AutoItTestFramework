; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Clipboard.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt clipboard functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_ClipGet = ClipGet
Global $g_hFn_ClipPut = ClipPut

Func _Tstbl_ClipGet()
    Local $vResult = $g_hFn_ClipGet()
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ClipPut($sClip)
    Local $vResult = $g_hFn_ClipPut($sClip)
    Return SetError(@error, @extended, $vResult)
EndFunc
