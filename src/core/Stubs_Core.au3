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
#include <StringConstants.au3>

; ===============================================================================================================================
; Global stub stores
; ===============================================================================================================================

Global Const $STUB_ERROR = "__ERROR__"

Global $g_StubCalls[]    ; $g_StubCalls["TypeName"][index]["property"]
Global $g_StubReturns[]  ; $g_StubReturns["TypeName"][index] = return value

; #INTERNAL_USE_ONLY# ===========================================================================================================
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

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Sanitize param key - strips any character that is not a letter, digit, or underscore from a
;               	   parameter key, ensuring it is a valid map key
; ===============================================================================================================================
Func __SanitizeStubParam($sParam)
	Return StringRegExpReplace(String($sParam), "[^a-zA-Z0-9_]", "")
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Coerce value - coerces a recorded string value back to its proper type. String "Default"
;                becomes Default type, "True"/"False" become booleans, numeric strings become numbers,
;                everything else stays a string. Used for non-string parameters (keys not prefixed with "s")
; ===============================================================================================================================
Func __CoerceStubValue($sVal)
	If $sVal = "Default" Then Return Default
	If $sVal = "True" Then Return True
	If $sVal = "False" Then Return False
	If StringIsInt($sVal) Or StringIsFloat($sVal) Then Return Number($sVal)
	Return $sVal
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Build call object - builds a map of recorded parameters from an array of "key = value" strings.
;               	  The key is sanitized and, unless it is a string parameter (prefixed with
;                     "s"), its value is coerced back to its proper type. Values containing "=" are
;                     preserved since only the first "=" is treated as the delimiter
; ===============================================================================================================================
Func __StubObject($aArgs)
	Local $mParams[]

	If Not IsArray($aArgs) Then Return $mParams

    For $sArg In $aArgs
        Local $iPos = StringInStr($sArg, "=")
        If $iPos = 0 Then ContinueLoop

        Local $sKey = StringStripWS(StringLeft($sArg, $iPos - 1), $STR_STRIPLEADING + $STR_STRIPTRAILING)
        Local $sVal = StringStripWS(StringMid($sArg, $iPos + 1), $STR_STRIPLEADING + $STR_STRIPTRAILING)

        $sKey = __SanitizeStubParam($sKey)
		If $sKey = "" Then ContinueLoop

		$mParams[$sKey] = StringLeft($sKey,1) = "s" ? $sVal : __CoerceStubValue($sVal)
    Next

	Return $mParams
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Collect args - collects the arguments actually passed into an array, using @NumParams so
;                only the supplied arguments are included and trailing defaults are excluded.
;                Supports up to 10 arguments
; ===============================================================================================================================
Func __CallArgs($v01 = Default, $v02 = Default, $v03 = Default, $v04 = Default, $v05 = Default, _
                $v06 = Default, $v07 = Default, $v08 = Default, $v09 = Default, $v10 = Default)

    Local $aAll[10] = [$v01, $v02, $v03, $v04, $v05, $v06, $v07, $v08, $v09, $v10]
    Local $aArgs[@NumParams]

    For $i = 0 To @NumParams - 1
        $aArgs[$i] = $aAll[$i]
    Next

    Return $aArgs
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Define stub - records a call to the given built-in and returns the configured return value.
;               Initializes the type store, appends the recorded parameters at the next
;               1-based index, and returns the value set via _SetStubReturn() for this call
;               index, or $vDefaultReturn if none was configured.
;               If the configured return value is $STUB_ERROR, sets @error = 1 and returns
;               an empty string, simulating a failed built-in call.
; ===============================================================================================================================
Func __DefineStub($sBuiltInFunc, $aArgs, $vDefaultReturn = Null)
	__StubInitType($sBuiltInFunc)
	Local $iIdx = $g_StubCalls[$sBuiltInFunc].count + 1
	$g_StubCalls[$sBuiltInFunc][$iIdx] = __StubObject($aArgs)
	$g_StubCalls[$sBuiltInFunc].count  = $iIdx
	Local $vReturn = MapExists($g_StubReturns[$sBuiltInFunc], $iIdx) ? $g_StubReturns[$sBuiltInFunc][$iIdx] : $vDefaultReturn
	If $vReturn == $STUB_ERROR Then Return SetError(1, 0, "")
	Return $vReturn
EndFunc

; ===============================================================================================================================
; Reset - call between tests to clear all recorded calls and returns
; ===============================================================================================================================
Func _ResetStubs()
    Local $mEmpty[]
    $g_StubCalls   = $mEmpty
    $g_StubReturns = $mEmpty
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

