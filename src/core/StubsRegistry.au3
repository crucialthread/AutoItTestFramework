; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Registry.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt registry functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_RegRead($sKeyname, $sValuename)
	Local $vReturn = __DefineStub("RegRead", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegWrite($sKeyname, $sValuename = "", $sType = "REG_SZ", $vValue = "")
	Local $vReturn = __DefineStub("RegWrite", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename, "sType = " & $sType, "vValue = " & $vValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegDelete($sKeyname, $sValuename = "")
	Local $vReturn = __DefineStub("RegDelete", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegEnumKey($sKeyname, $iInstance)
	Local $vReturn = __DefineStub("RegEnumKey", __CallArgs("sKeyname = " & $sKeyname, "iInstance = " & $iInstance), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RegEnumVal($sKeyname, $iInstance)
	Local $vReturn = __DefineStub("RegEnumVal", __CallArgs("sKeyname = " & $sKeyname, "iInstance = " & $iInstance), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_RegRead    = __Stub_RegRead
$g_hFn_RegWrite   = __Stub_RegWrite
$g_hFn_RegDelete  = __Stub_RegDelete
$g_hFn_RegEnumKey = __Stub_RegEnumKey
$g_hFn_RegEnumVal = __Stub_RegEnumVal
