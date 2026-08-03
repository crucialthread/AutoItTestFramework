; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Registry.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt registry functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_RegRead($sKeyname, $sValuename)
	Local $vReturn = __DefineStub("RegRead", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename), "")
	If $vReturn = "__ERROR__" Then
		SetError(1)
		Return ""
	EndIf
	Return $vReturn
EndFunc

Func _Stub_RegWrite($sKeyname, $sValuename = "", $sType = "REG_SZ", $vValue = "")
	Return __DefineStub("RegWrite", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename, "sType = " & $sType, "vValue = " & $vValue), 1)
EndFunc

Func _Stub_RegDelete($sKeyname, $sValuename = "")
	Return __DefineStub("RegDelete", __CallArgs("sKeyname = " & $sKeyname, "sValuename = " & $sValuename), 1)
EndFunc

Func _Stub_RegEnumKey($sKeyname, $iInstance)
	Return __DefineStub("RegEnumKey", __CallArgs("sKeyname = " & $sKeyname, "iInstance = " & $iInstance), "")
EndFunc

Func _Stub_RegEnumVal($sKeyname, $iInstance)
	Return __DefineStub("RegEnumVal", __CallArgs("sKeyname = " & $sKeyname, "iInstance = " & $iInstance), "")
EndFunc

$g_hFn_RegRead    = _Stub_RegRead
$g_hFn_RegWrite   = _Stub_RegWrite
$g_hFn_RegDelete  = _Stub_RegDelete
$g_hFn_RegEnumKey = _Stub_RegEnumKey
$g_hFn_RegEnumVal = _Stub_RegEnumVal
