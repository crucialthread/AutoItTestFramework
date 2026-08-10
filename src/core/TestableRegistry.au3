; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Registry.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt registry functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_RegRead    = RegRead
Global $g_hFn_RegWrite   = RegWrite
Global $g_hFn_RegDelete  = RegDelete
Global $g_hFn_RegEnumKey = RegEnumKey
Global $g_hFn_RegEnumVal = RegEnumVal

Func _Tstbl_RegRead($sKeyName, $sValueName)
    Local $vResult = $g_hFn_RegRead($sKeyName, $sValueName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegWrite($sKeyName, $sValueName = "", $sKeyType = "REG_SZ", $sValue = "")
    Local $vResult = $g_hFn_RegWrite($sKeyName, $sValueName, $sKeyType, $sValue)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegDelete($sKeyName, $sValueName = "")
    Local $vResult = $g_hFn_RegDelete($sKeyName, $sValueName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegEnumKey($sKeyName, $iKeyInstance)
    Local $vResult = $g_hFn_RegEnumKey($sKeyName, $iKeyInstance)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegEnumVal($sKeyName, $iKeyInstance)
    Local $vResult = $g_hFn_RegEnumVal($sKeyName, $iKeyInstance)
    Return SetError(@error, @extended, $vResult)
EndFunc
