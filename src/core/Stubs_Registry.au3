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
    __StubInitType("RegRead")
    Local $iIdx = $g_StubCalls["RegRead"].count + 1
    Local $oCall[]
    $oCall["sKeyname"]   = $sKeyname
    $oCall["sValuename"] = $sValuename
    $g_StubCalls["RegRead"][$iIdx] = $oCall
    $g_StubCalls["RegRead"].count  = $iIdx
    If MapExists($g_StubReturns["RegRead"], $iIdx) Then
        Local $vReturn = $g_StubReturns["RegRead"][$iIdx]
        If $vReturn = "__ERROR__" Then
            SetError(1)
            Return ""
        EndIf
        Return $vReturn
    EndIf
    Return ""
EndFunc

Func _Stub_RegWrite($sKeyname, $sValuename = "", $sType = "REG_SZ", $vValue = "")
    __StubInitType("RegWrite")
    Local $iIdx = $g_StubCalls["RegWrite"].count + 1
    Local $oCall[]
    $oCall["sKeyname"]   = $sKeyname
    $oCall["sValuename"] = $sValuename
    $oCall["sType"]      = $sType
    $oCall["vValue"]     = $vValue
    $g_StubCalls["RegWrite"][$iIdx] = $oCall
    $g_StubCalls["RegWrite"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["RegWrite"], $iIdx) ? $g_StubReturns["RegWrite"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_RegDelete($sKeyname, $sValuename = "")
    __StubInitType("RegDelete")
    Local $iIdx = $g_StubCalls["RegDelete"].count + 1
    Local $oCall[]
    $oCall["sKeyname"]   = $sKeyname
    $oCall["sValuename"] = $sValuename
    $g_StubCalls["RegDelete"][$iIdx] = $oCall
    $g_StubCalls["RegDelete"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["RegDelete"], $iIdx) ? $g_StubReturns["RegDelete"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_RegEnumKey($sKeyname, $iInstance)
    __StubInitType("RegEnumKey")
    Local $iIdx = $g_StubCalls["RegEnumKey"].count + 1
    Local $oCall[]
    $oCall["sKeyname"]  = $sKeyname
    $oCall["iInstance"] = $iInstance
    $g_StubCalls["RegEnumKey"][$iIdx] = $oCall
    $g_StubCalls["RegEnumKey"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["RegEnumKey"], $iIdx) ? $g_StubReturns["RegEnumKey"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_RegEnumVal($sKeyname, $iInstance)
    __StubInitType("RegEnumVal")
    Local $iIdx = $g_StubCalls["RegEnumVal"].count + 1
    Local $oCall[]
    $oCall["sKeyname"]  = $sKeyname
    $oCall["iInstance"] = $iInstance
    $g_StubCalls["RegEnumVal"][$iIdx] = $oCall
    $g_StubCalls["RegEnumVal"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["RegEnumVal"], $iIdx) ? $g_StubReturns["RegEnumVal"][$iIdx] : ""
    Return $sReturn
EndFunc

$g_hFn_RegRead    = _Stub_RegRead
$g_hFn_RegWrite   = _Stub_RegWrite
$g_hFn_RegDelete  = _Stub_RegDelete
$g_hFn_RegEnumKey = _Stub_RegEnumKey
$g_hFn_RegEnumVal = _Stub_RegEnumVal
