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

Func _Tstbl_RegRead($sKeyname, $sValuename)
    Local $vResult = $g_hFn_RegRead($sKeyname, $sValuename)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegWrite($sKeyname, $sValuename = "", $sType = "REG_SZ", $vValue = "")
    Local $vResult = $g_hFn_RegWrite($sKeyname, $sValuename, $sType, $vValue)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegDelete($sKeyname, $sValuename = "")
    Local $vResult = $g_hFn_RegDelete($sKeyname, $sValuename)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegEnumKey($sKeyname, $iInstance)
    Local $vResult = $g_hFn_RegEnumKey($sKeyname, $iInstance)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RegEnumVal($sKeyname, $iInstance)
    Local $vResult = $g_hFn_RegEnumVal($sKeyname, $iInstance)
    Return SetError(@error, @extended, $vResult)
EndFunc
