#include-once

#include "..\..\src\core\TestFramework.au3"
#include "..\..\src\core\StubConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubsCoreTests.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Unit tests for Stubs_Core.au3.
;                  Tests core stub infrastructure: type coercion, call recording, accessor
;                  functions, fallback param matching, and reset behavior.
; ===============================================================================================================================
Local Const $STUBS_CORE_TESTS = "StubsCoreTests.au3"

; ===============================================================================================================================
; Tests - __StubInitType
; ===============================================================================================================================
Func _TestStubInitType_CreatesCallsEntry()
    _TestFmkHeader("Test: __StubInitType() - creates calls entry with count 0")

    __StubInitType("TestType")

    Local $bExists = MapExists($g_StubCalls, "TestType")
    _TestFmkAssert($bExists,                       "Calls entry created",    $bExists,                   True, $STUBS_CORE_TESTS)
    _TestFmkAssert(_StubCallCount("TestType") = 0, "Count initialized to 0", _StubCallCount("TestType"),    0, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubInitType_CreatesReturnsEntry()
    _TestFmkHeader("Test: __StubInitType() - creates returns entry")

    __StubInitType("TestType")

    _TestFmkAssert(MapExists($g_StubReturns, "TestType"), "Returns entry created", MapExists($g_StubReturns, "TestType"), True, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubInitType_DoesNotOverwriteExisting()
    _TestFmkHeader("Test: __StubInitType() - does not overwrite existing entry")

    __DefineStub("TestType", __CallArgs(), Null)
    __StubInitType("TestType")

    _TestFmkAssert(_StubCallCount("TestType") = 1, "Count not reset", _StubCallCount("TestType"), 1, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __SanitizeStubParam
; ===============================================================================================================================
Func _TestSanitizeStubParam_KeepsValidChars()
    _TestFmkHeader("Test: __SanitizeStubParam() - keeps letters, digits, underscores")

	Local $sSanitized = __SanitizeStubParam("sMyParam_1")

	_TestFmkAssert($sSanitized = "sMyParam_1", "Valid chars kept", $sSanitized, "sMyParam_1", $STUBS_CORE_TESTS)
EndFunc

Func _TestSanitizeStubParam_StripsInvalidChars()
    _TestFmkHeader("Test: __SanitizeStubParam() - strips non-alphanumeric characters")

	Local $sSanitized = __SanitizeStubParam("s My-Param!")

    _TestFmkAssert($sSanitized = "sMyParam", "Invalid chars stripped", $sSanitized, "sMyParam", $STUBS_CORE_TESTS)
EndFunc

Func _TestSanitizeStubParam_AllInvalid()
    _TestFmkHeader("Test: __SanitizeStubParam() - returns empty string when all chars invalid")

	Local $sSanitized = __SanitizeStubParam("!@#$%")

    _TestFmkAssert($sSanitized = "", "Returns empty string", $sSanitized, "", $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __CoerceStubValue
; ===============================================================================================================================
Func _TestCoerceStubValue_True()
    _TestFmkHeader("Test: __CoerceStubValue() - coerces 'True' to boolean True")

    Local $vResult = __CoerceStubValue("True")

    _TestFmkAssert(IsBool($vResult), "Result is boolean", IsBool($vResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = True, "Value is True", $vResult, True, $STUBS_CORE_TESTS)
EndFunc

Func _TestCoerceStubValue_False()
    _TestFmkHeader("Test: __CoerceStubValue() - coerces 'False' to boolean False")

    Local $vResult = __CoerceStubValue("False")

    _TestFmkAssert(IsBool($vResult), "Result is boolean", IsBool($vResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = False, "Value is False", $vResult, False, $STUBS_CORE_TESTS)
EndFunc

Func _TestCoerceStubValue_Integer()
    _TestFmkHeader("Test: __CoerceStubValue() - coerces numeric string to number")

    Local $vResult = __CoerceStubValue("42")

    _TestFmkAssert(IsNumber($vResult), "Result is number", IsNumber($vResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = 42, "Value is 42", $vResult, 42, $STUBS_CORE_TESTS)
EndFunc

Func _TestCoerceStubValue_Float()
    _TestFmkHeader("Test: __CoerceStubValue() - coerces float string to number")

    Local $vResult = __CoerceStubValue("3.14")

    _TestFmkAssert(IsNumber($vResult), "Result is number", IsNumber($vResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = 3.14, "Value is 3.14", $vResult, 3.14, $STUBS_CORE_TESTS)
EndFunc

Func _TestCoerceStubValue_Default()
    _TestFmkHeader("Test: __CoerceStubValue() - coerces 'Default' to Default keyword")

    Local $vResult = __CoerceStubValue("Default")

    _TestFmkAssert(IsKeyword($vResult) = 1, "Result is Default keyword", IsKeyword($vResult), 1, $STUBS_CORE_TESTS)
EndFunc

Func _TestCoerceStubValue_String()
    _TestFmkHeader("Test: __CoerceStubValue() - keeps non-special strings as string")

    Local $vResult = __CoerceStubValue("C:\Some\Path")

    _TestFmkAssert(IsString($vResult), "Result is string", IsString($vResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = "C:\Some\Path", "Value unchanged", $vResult, "C:\Some\Path", $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __StubObject
; ===============================================================================================================================
Func _TestStubObject_BuildsMapFromArgs()
    _TestFmkHeader("Test: __StubObject() - builds map with correct types from ""key = value"" args")

    Local $aArgs   = __CallArgs("sTitle = Hello", "iCount = 3")
    Local $mResult = __StubObject($aArgs)

    Local $bIsMap  = IsMap($mResult)
    Local $sTitle  = $bIsMap And MapExists($mResult, "sTitle") ? $mResult.sTitle : Null
    Local $iCount  = $bIsMap And MapExists($mResult, "iCount") ? $mResult.iCount : Null

    _TestFmkAssert($bIsMap,           "Returns a map",         $bIsMap,  True, 	  $STUBS_CORE_TESTS)
    _TestFmkAssert($sTitle = "Hello", "String value correct",  $sTitle,  "Hello", $STUBS_CORE_TESTS)
    _TestFmkAssert($iCount = 3,       "Integer value coerced", $iCount,  3, 	  $STUBS_CORE_TESTS)
EndFunc

Func _TestStubObject_SkipsEmptyKey()
    _TestFmkHeader("Test: __StubObject() - skips entries with invalid key that sanitizes to empty")

    Local $aArgs   = __CallArgs("!@# = value")
    Local $mResult = __StubObject($aArgs)

    Local $iKeyCount = UBound(MapKeys($mResult))
    _TestFmkAssert($iKeyCount = 0, "No keys added for invalid key", $iKeyCount, 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubObject_SkipsEntryWithNoEqualSign()
    _TestFmkHeader("Test: __StubObject() - skips entries with no equal sign")

    Local $aArgs   = __CallArgs("NoEqualInKeyValue", "invalid: value")
    Local $mResult = __StubObject($aArgs)

    Local $iKeyCount = UBound(MapKeys($mResult))
    _TestFmkAssert($iKeyCount = 0, "No keys added for entries without '='", $iKeyCount, 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubObject_PreservesEqualsInValue()
    _TestFmkHeader("Test: __StubObject() - treats only first '=' as delimiter preserving others '=' in value")

    Local $aArgs   = __CallArgs("sExpr = a = b")
    Local $mResult = __StubObject($aArgs)

    Local $bIsMap  = IsMap($mResult)
    Local $sExpr   = $bIsMap And MapExists($mResult, "sExpr") ? $mResult.sExpr : Null
    _TestFmkAssert($sExpr = "a = b", "Extra '=' signs in value are preserved", $sExpr, "a = b", $STUBS_CORE_TESTS)
EndFunc

Func _TestStubObject_InvalidArray()
    _TestFmkHeader("Test: __StubObject() - returns empty map for invalid array")

    Local $mResult = __StubObject("not an array")

    _TestFmkAssert(IsMap($mResult), 			  "Returns a map", IsMap($mResult), 	   True, $STUBS_CORE_TESTS)
    _TestFmkAssert(UBound(MapKeys($mResult)) = 0, "Map is empty",  UBound(MapKeys($mResult)), 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubObject_EmptyArray()
    _TestFmkHeader("Test: __StubObject() - returns empty map for empty array")

    Local $mResult = __StubObject(__CallArgs())

    Local $iKeyCount = UBound(MapKeys($mResult))
	_TestFmkAssert(IsMap($mResult), "Returns a map", 				 IsMap($mResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert($iKeyCount = 0,  "No keys added for empty array", $iKeyCount, 		 0, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __CallArgs
; ===============================================================================================================================
Func _TestCallArgs_NoArgs()
    _TestFmkHeader("Test: __CallArgs() - returns empty array when called with no arguments")

    Local $aResult = __CallArgs()

    _TestFmkAssert(IsArray($aResult), "Returns array", IsArray($aResult), True, $STUBS_CORE_TESTS)
    _TestFmkAssert(UBound($aResult) = 0, "Array is empty", UBound($aResult), 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestCallArgs_OneArg()
    _TestFmkHeader("Test: __CallArgs() - returns array with one element")

    Local $aResult = __CallArgs("sPath = C:\test")

    _TestFmkAssert(UBound($aResult) = 1, "Array has one element", UBound($aResult), 1, 				 $STUBS_CORE_TESTS)
    _TestFmkAssert($aResult[0] = "sPath = C:\test", "Value correct", $aResult[0], "sPath = C:\test", $STUBS_CORE_TESTS)
EndFunc

Func _TestCallArgs_MultipleArgs()
    _TestFmkHeader("Test: __CallArgs() - returns array with correct number of elements")

    Local $aResult = __CallArgs("sSource = file1", "sDest = file2", "iFlag = 1")

    _TestFmkAssert(UBound($aResult) = 3, "Array has three elements", UBound($aResult), 3, $STUBS_CORE_TESTS)
    _TestFmkAssert($aResult[0] = "sSource = file1", "First value correct", $aResult[0], "sSource = file1", $STUBS_CORE_TESTS)
    _TestFmkAssert($aResult[1] = "sDest = file2",   "Second value correct", $aResult[1], "sDest = file2",  $STUBS_CORE_TESTS)
    _TestFmkAssert($aResult[2] = "iFlag = 1",       "Third value correct",  $aResult[2], "iFlag = 1", 	   $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __DefineStub
; ===============================================================================================================================
Func _TestDefineStub_RecordsCall()
    _TestFmkHeader("Test: __DefineStub() - records call with 1-based index")

    __DefineStub("TestType", __CallArgs("sPath = C:\test"), Null)

	Local $iCount = _StubCallCount("TestType")
	Local $sPath  = _StubCall("TestType", $_1st, "sPath")

    _TestFmkAssert($iCount = 1, 	   "Call count is 1", 		  $iCount, 1, 		 $STUBS_CORE_TESTS)
    _TestFmkAssert($sPath = "C:\test", "Path recorded correctly", $sPath, "C:\test", $STUBS_CORE_TESTS)
EndFunc

Func _TestDefineStub_ReturnsDefault()
    _TestFmkHeader("Test: __DefineStub() - returns default when no stub return configured")

    Local $vResult = __DefineStub("TestType", __CallArgs(), "defaultValue")

    _TestFmkAssert($vResult = "defaultValue", "Returns default value", $vResult, "defaultValue", $STUBS_CORE_TESTS)
EndFunc

Func _TestDefineStub_ReturnsConfiguredValue()
    _TestFmkHeader("Test: __DefineStub() - returns configured stub return value")

    _SetStubReturn("TestType", 1, "configuredValue")

    Local $vResult = __DefineStub("TestType", __CallArgs(), "defaultValue")

    _TestFmkAssert($vResult = "configuredValue", "Returns configured value", $vResult, "configuredValue", $STUBS_CORE_TESTS)
EndFunc

Func _TestDefineStub_StubError()
    _TestFmkHeader("Test: __DefineStub() - returns SetError when $STUB_ERROR configured")

    _SetStubReturn("TestType", 1, $STUB_ERROR)

    Local $vResult = __DefineStub("TestType", __CallArgs(), "defaultValue")
    Local $iErr = @error

    _TestFmkAssert($iErr = 1, "Sets @error = 1", $iErr, 1, $STUBS_CORE_TESTS)
    _TestFmkAssert($vResult = "", "Returns empty string", $vResult, "", $STUBS_CORE_TESTS)
EndFunc

Func _TestDefineStub_IncrementsIndex()
    _TestFmkHeader("Test: __DefineStub() - increments call index on each call")

    __DefineStub("TestType", __CallArgs("sPath = C:\first"),  Null)
    __DefineStub("TestType", __CallArgs("sPath = C:\second"), Null)

	Local $iStubCount = _StubCallCount("TestType")
	Local $sPath1st   = _StubCall("TestType", $_1st, "sPath")
	Local $sPath2nd   = _StubCall("TestType", $_2nd, "sPath")

    _TestFmkAssert($iStubCount = 2, 		"Call count is 2", 		$iStubCount, 2, 		$STUBS_CORE_TESTS)
    _TestFmkAssert($sPath1st = "C:\first",  "First call recorded",  $sPath1st, "C:\first",  $STUBS_CORE_TESTS)
    _TestFmkAssert($sPath2nd = "C:\second", "Second call recorded", $sPath2nd, "C:\second", $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __ParamOffset
; ===============================================================================================================================
Func _TestParamOffset_SingleLetter()
    _TestFmkHeader("Test: __ParamOffset() - returns 1 for single letter prefix")

    _TestFmkAssert(__ParamOffset("sTitle") = 1, "s prefix offset is 1", __ParamOffset("sTitle"), 1, $STUBS_CORE_TESTS)
    _TestFmkAssert(__ParamOffset("iCount") = 1, "i prefix offset is 1", __ParamOffset("iCount"), 1, $STUBS_CORE_TESTS)
    _TestFmkAssert(__ParamOffset("bFlag")  = 1, "b prefix offset is 1", __ParamOffset("bFlag"),  1, $STUBS_CORE_TESTS)
    _TestFmkAssert(__ParamOffset("hWnd")   = 1, "h prefix offset is 1",  __ParamOffset("hWnd"),  1, $STUBS_CORE_TESTS)
EndFunc

Func _TestParamOffset_IdPrefix()
    _TestFmkHeader("Test: __ParamOffset() - returns 2 for id prefix")

    _TestFmkAssert(__ParamOffset("idCtrl") = 2, "id prefix offset is 2", __ParamOffset("idCtrl"), 2, $STUBS_CORE_TESTS)
EndFunc

Func _TestParamOffset_NoPrefix()
    _TestFmkHeader("Test: __ParamOffset() - returns 0 for uppercase or no prefix")

    _TestFmkAssert(__ParamOffset("Title")  = 0, "Uppercase offset is 0", __ParamOffset("Title"),  0, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - __FallBackParam
; ===============================================================================================================================
Func _TestFallBackParam_MatchesDifferentPrefix()
    _TestFmkHeader("Test: __FallBackParam() - matches key with different prefix")

    Local $aKeys[2] = ["vTitle", "iCount"]
	Local $vResult  = __FallBackParam("sTitle", $aKeys)

    _TestFmkAssert($vResult = "vTitle", "Finds vTitle via sTitle", $vResult, "vTitle", $STUBS_CORE_TESTS)
EndFunc

Func _TestFallBackParam_ReturnsNullWhenNoMatch()
    _TestFmkHeader("Test: __FallBackParam() - returns Null when no match found")

    Local $aKeys[2] = ["sPath", "iCount"]
	Local $vResult  = __FallBackParam("sTitle", $aKeys)

    _TestFmkAssert($vResult = Null, "Returns Null when no match", $vResult, Null, $STUBS_CORE_TESTS)
EndFunc

Func _TestFallBackParam_IdPrefixMatch()
    _TestFmkHeader("Test: __FallBackParam() - matches id prefix correctly")

    Local $aKeys[1] = ["sCtrl"]
	Local $vResult  = __FallBackParam("idCtrl", $aKeys)

    _TestFmkAssert($vResult = "sCtrl", "idCtrl matches sCtrl by base name", $vResult, "sCtrl", $STUBS_CORE_TESTS)
EndFunc

Func _TestFallBackParam_InvalidArray()
    _TestFmkHeader("Test: __FallBackParam() - returns Null for non-array keys")

	Local $vResult = __FallBackParam("sTitle", "not an array")

    _TestFmkAssert($vResult = Null, "Returns Null for non-array", $vResult, Null, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _ResetStubs
; ===============================================================================================================================
Func _TestResetStubs_ClearsCalls()
    _TestFmkHeader("Test: _ResetStubs() - clears recorded calls")

    __DefineStub("TestType", __CallArgs(), Null)
    _ResetStubs()
	Local $iStubCount = _StubCallCount("TestType")

    _TestFmkAssert($iStubCount = 0, "Calls cleared after reset", $iStubCount, 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestResetStubs_ClearsReturns()
    _TestFmkHeader("Test: _ResetStubs() - clears configured returns")

    _SetStubReturn("TestType", 1, "someValue")
    _ResetStubs()
    Local $vResult = __DefineStub("TestType", __CallArgs(), "defaultValue")

    _TestFmkAssert($vResult = "defaultValue", "Returns default after reset", $vResult, "defaultValue", $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _SetStubReturn
; ===============================================================================================================================

Func _TestSetStubReturn_StoresValue()
    _TestFmkHeader("Test: _SetStubReturn() - stores return value at given index")

    _SetStubReturn("TestType", 1, "myValue")
    Local $vResult = __DefineStub("TestType", __CallArgs(), Null)

    _TestFmkAssert($vResult = "myValue", "Value stored correctly", $vResult, "myValue", $STUBS_CORE_TESTS)
EndFunc

Func _TestSetStubReturn_CreatesMapWhenMissing()
    _TestFmkHeader("Test: _SetStubReturn() - creates returns map when type not yet present")

    _SetStubReturn("NewType", 1, "value")
	Local $bStubExist = MapExists($g_StubReturns, "NewType")

    _TestFmkAssert($bStubExist = True, "Returns map created", $bStubExist, True, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _StubCallCount
; ===============================================================================================================================
Func _TestStubCallCount_NeverCalled()
    _TestFmkHeader("Test: _StubCallCount() - returns 0 when stub never called")

	Local $iStubCount = _StubCallCount("NeverCalledType")

    _TestFmkAssert($iStubCount = 0, "Returns 0 for unknown type", $iStubCount, 0, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubCallCount_AfterCalls()
    _TestFmkHeader("Test: _StubCallCount() - returns correct count after calls")

    __DefineStub("TestType", __CallArgs(), Null)
    __DefineStub("TestType", __CallArgs(), Null)
    __DefineStub("TestType", __CallArgs(), Null)

	Local $iStubCount = _StubCallCount("TestType")

    _TestFmkAssert($iStubCount = 3, "Returns 3 after 3 calls", $iStubCount, 3, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _StubCall
; ===============================================================================================================================
Func _TestStubCall_ExactMatch()
    _TestFmkHeader("Test: _StubCall() - returns value on exact param name match")

    __DefineStub("TestType", __CallArgs("sTitle = Hello"), Null)

	Local $vReturn = _StubCall("TestType", $_1st, "sTitle")

    _TestFmkAssert($vReturn = "Hello", "Exact match returns value", $vReturn, "Hello", $STUBS_CORE_TESTS)
EndFunc

Func _TestStubCall_FallbackMatch()
    _TestFmkHeader("Test: _StubCall() - returns value via fallback prefix match")

    __DefineStub("TestType", __CallArgs("vTitle = Hello"), Null)

	Local $vReturn = _StubCall("TestType", $_1st, "sTitle")

    _TestFmkAssert($vReturn = "Hello", "Fallback match returns value", $vReturn, "Hello", $STUBS_CORE_TESTS)
EndFunc

Func _TestStubCall_MissingType()
    _TestFmkHeader("Test: _StubCall() - returns Null for missing type")

	Local $vReturn = _StubCall("NeverCalledType", $_1st, "sTitle")

    _TestFmkAssert($vReturn = Null, "Returns Null for missing type", $vReturn, Null, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubCall_MissingIndex()
    _TestFmkHeader("Test: _StubCall() - returns Null for missing index")

    __DefineStub("TestType", __CallArgs("sTitle = Hello"), Null)

	Local $vReturn = _StubCall("TestType", $_2nd, "sTitle")

    _TestFmkAssert($vReturn = Null, "Returns Null for missing index", $vReturn, Null, $STUBS_CORE_TESTS)
EndFunc

Func _TestStubCall_MissingParam()
    _TestFmkHeader("Test: _StubCall() - returns Null for missing param")

    __DefineStub("TestType", __CallArgs("sTitle = Hello"), Null)

	Local $vReturn = _StubCall("TestType", $_1st, "sPath")

    _TestFmkAssert($vReturn = Null, "Returns Null for missing param", $vReturn, Null, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Tests - _GetStubCall
; ===============================================================================================================================
Func _TestGetStubCall_ReturnsValueLikeStubCall()
    _TestFmkHeader("Test: _GetStubCall() - returns same value as _StubCall")

    __DefineStub("TestType", __CallArgs("sTitle = Hello"), Null)

    Local $vStubCall    = _StubCall("TestType",    $_1st, "sTitle")
    Local $vGetStubCall = _GetStubCall("TestType", $_1st, "sTitle")

    _TestFmkAssert($vGetStubCall = $vStubCall, "Returns same value as _StubCall", $vGetStubCall, $vStubCall, $STUBS_CORE_TESTS)
EndFunc

; ===============================================================================================================================
; Run tests
; ===============================================================================================================================
Func __RunStubsCoreTest_StubInitType(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestStubInitType_CreatesCallsEntry,       $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubInitType_CreatesReturnsEntry,     $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubInitType_DoesNotOverwriteExisting,$bAllPassed)
EndFunc

Func __RunStubsCoreTest_SanitizeStubParam(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestSanitizeStubParam_KeepsValidChars,    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestSanitizeStubParam_StripsInvalidChars, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestSanitizeStubParam_AllInvalid,         $bAllPassed)
EndFunc

Func __RunStubsCoreTest_CoerceStubValue(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_True,    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_False,   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_Integer, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_Float,   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_Default, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCoerceStubValue_String,  $bAllPassed)
EndFunc

Func __RunStubsCoreTest_StubObject(ByRef $bAllPassed)
    _TestFmkSeparator()
	$bAllPassed = _TestFmkRun(_TestStubObject_BuildsMapFromArgs,      	 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestStubObject_SkipsEmptyKey,          	 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestStubObject_SkipsEntryWithNoEqualSign, $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestStubObject_PreservesEqualsInValue, 	 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestStubObject_InvalidArray,           	 $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestStubObject_EmptyArray,           	 $bAllPassed)
EndFunc

Func __RunStubsCoreTest_CallArgs(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestCallArgs_NoArgs,                      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCallArgs_OneArg,                      $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestCallArgs_MultipleArgs,                $bAllPassed)
EndFunc

Func __RunStubsCoreTest_DefineStub(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestDefineStub_RecordsCall,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDefineStub_ReturnsDefault,            $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDefineStub_ReturnsConfiguredValue,    $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDefineStub_StubError,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestDefineStub_IncrementsIndex,           $bAllPassed)
EndFunc

Func __RunStubsCoreTest_ParamOffset(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestParamOffset_SingleLetter,             $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestParamOffset_IdPrefix,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestParamOffset_NoPrefix,                 $bAllPassed)
EndFunc

Func __RunStubsCoreTest_FallBackParam(ByRef $bAllPassed)
    _TestFmkSeparator()
	$bAllPassed = _TestFmkRun(_TestFallBackParam_MatchesDifferentPrefix, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFallBackParam_ReturnsNullWhenNoMatch, $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestFallBackParam_IdPrefixMatch,          $bAllPassed)
	$bAllPassed = _TestFmkRun(_TestFallBackParam_InvalidArray,           $bAllPassed)
EndFunc

Func __RunStubsCoreTest_ResetStubs(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestResetStubs_ClearsCalls,   $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestResetStubs_ClearsReturns, $bAllPassed)
EndFunc

Func __RunStubsCoreTest_SetStubReturn(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestSetStubReturn_StoresValue,           $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestSetStubReturn_CreatesMapWhenMissing, $bAllPassed)
EndFunc

Func __RunStubsCoreTest_StubCallCount(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestStubCallCount_NeverCalled,            $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubCallCount_AfterCalls,             $bAllPassed)
EndFunc

Func __RunStubsCoreTest_StubCall(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestStubCall_ExactMatch,                  $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubCall_FallbackMatch,               $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubCall_MissingType,                 $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubCall_MissingIndex,                $bAllPassed)
    $bAllPassed = _TestFmkRun(_TestStubCall_MissingParam,                $bAllPassed)
EndFunc

Func __RunStubsCoreTest_GetStubCall(ByRef $bAllPassed)
    _TestFmkSeparator()
    $bAllPassed = _TestFmkRun(_TestGetStubCall_ReturnsValueLikeStubCall, $bAllPassed)
EndFunc

Func _RunStubsCoreTests($bWriteSummary = True)
    Local $bAllPassed = True
	__RunStubsCoreTest_StubInitType($bAllPassed)
	__RunStubsCoreTest_SanitizeStubParam($bAllPassed)
	__RunStubsCoreTest_CoerceStubValue($bAllPassed)
	__RunStubsCoreTest_StubObject($bAllPassed)
	__RunStubsCoreTest_CallArgs($bAllPassed)
	__RunStubsCoreTest_DefineStub($bAllPassed)
	__RunStubsCoreTest_ParamOffset($bAllPassed)
	__RunStubsCoreTest_FallBackParam($bAllPassed)
	__RunStubsCoreTest_ResetStubs($bAllPassed)
	__RunStubsCoreTest_SetStubReturn($bAllPassed)
	__RunStubsCoreTest_StubCallCount($bAllPassed)
	__RunStubsCoreTest_StubCall($bAllPassed)
	__RunStubsCoreTest_GetStubCall($bAllPassed)
    If $bWriteSummary Then _TestFmkSummary()
    Return $bAllPassed
EndFunc
_TestFmkRunAllTests(_RunStubsCoreTests, $STUBS_CORE_TESTS)
