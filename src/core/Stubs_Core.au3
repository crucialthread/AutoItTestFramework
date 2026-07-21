; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Core.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Core stub infrastructure shared by all Stubs_*.au3 category files.
;                  Provides $g_StubCalls, $g_StubReturns, __StubInitType and _ResetStubs.
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
; Reset - call between tests to clear all recorded calls and returns
; ===============================================================================================================================

Func _ResetStubs()
    Local $oEmpty[]
    $g_StubCalls   = $oEmpty
    $g_StubReturns = $oEmpty
EndFunc

; ===============================================================================================================================
; Set Stub value helper - set a stub return value to be used on a test
; ===============================================================================================================================

Func _SetStubReturn($sType, $iIdx, $vValue)
    If Not MapExists($g_StubReturns, $sType) Then
        Local $mReturns[]
        $g_StubReturns[$sType] = $mReturns
    EndIf
    $g_StubReturns[$sType][$iIdx] = $vValue
EndFunc

