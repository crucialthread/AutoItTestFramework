; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Core.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Core stub infrastructure shared by all stub category files.
;                  Provides the global stub stores, __StubInitType helper,
;                  _ResetStubs(), _SetStubReturn(), _StubCall() and _StubCallCount().
;                  Can be included via Stubs.au3, or via specific stubs like Stubs_Dialogs.au3 and others
; ===============================================================================================================================

#include-once
#include "Testable.au3"

; ===============================================================================================================================
; Global stub stores
; ===============================================================================================================================

Global $g_StubCalls[]    ; $g_StubCalls["TypeName"][index]["property"]
Global $g_StubReturns[]  ; $g_StubReturns["TypeName"][index] = return value

; ===============================================================================================================================
; Stub helper - initializes a type entry in the store if not already present
; ===============================================================================================================================

Func __StubInitType($sType)
    If Not MapExists($g_StubCalls, $sType) Then
        Local $mCalls[]
        $mCalls.count = 0
        $g_StubCalls[$sType] = $mCalls
    EndIf
    If Not MapExists($g_StubReturns, $sType) Then
        Local $mReturns[]
        $g_StubReturns[$sType] = $mReturns
    EndIf
EndFunc

; ===============================================================================================================================
; Public API
; ===============================================================================================================================

Func _ResetStubs()
    Local $oEmpty[]
    $g_StubCalls   = $oEmpty
    $g_StubReturns = $oEmpty
EndFunc

Func _SetStubReturn($sType, $iIdx, $vValue)
    If Not MapExists($g_StubReturns, $sType) Then
        Local $mReturns[]
        $g_StubReturns[$sType] = $mReturns
    EndIf
    $g_StubReturns[$sType][$iIdx] = $vValue
EndFunc

Func _StubCallCount($sType)
    If Not MapExists($g_StubCalls, $sType) Then Return 0
    Return $g_StubCalls[$sType].count
EndFunc

Func _StubCall($sType, $iIdx, $sProperty)
    If Not MapExists($g_StubCalls, $sType) Then Return ""
    If Not MapExists($g_StubCalls[$sType], $iIdx) Then Return ""
    Return $g_StubCalls[$sType][$iIdx][$sProperty]
EndFunc
