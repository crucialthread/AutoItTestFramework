#include-once

#include "StubsCore.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsRegistry.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt registry functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

Func __Stub_RegRead($sKeyName, $sValueName)
	Local $vReturn = __DefineStub("RegRead", __CallArgs("sKeyName = " & $sKeyName, "sValueName = " & $sValueName), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegWrite($sKeyName, $sValueName = "", $sKeyType = "REG_SZ", $sValue = "")
	Local $vReturn = __DefineStub("RegWrite", __CallArgs("sKeyName = " & $sKeyName, "sValueName = " & $sValueName, "sKeyType = " & $sKeyType, "sValue = " & $sValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegDelete($sKeyName, $sValueName = "")
	Local $vReturn = __DefineStub("RegDelete", __CallArgs("sKeyName = " & $sKeyName, "sValueName = " & $sValueName), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegEnumKey($sKeyName, $iKeyInstance)
	Local $vReturn = __DefineStub("RegEnumKey", __CallArgs("sKeyName = " & $sKeyName, "iKeyInstance = " & $iKeyInstance), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegEnumVal($sKeyName, $iKeyInstance)
	Local $vReturn = __DefineStub("RegEnumVal", __CallArgs("sKeyName = " & $sKeyName, "iKeyInstance = " & $iKeyInstance), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_RegRead    = __Stub_RegRead
$g_hFn_RegWrite   = __Stub_RegWrite
$g_hFn_RegDelete  = __Stub_RegDelete
$g_hFn_RegEnumKey = __Stub_RegEnumKey
$g_hFn_RegEnumVal = __Stub_RegEnumVal
