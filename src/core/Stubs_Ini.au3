; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Ini.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt INI file functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include <Array.au3>
#include "Stubs_Core.au3"

Func __Stub_IniRead($sFilename, $sSection, $sKey, $sDefault)
	Local $vReturn = __DefineStub("IniRead", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey, "sDefault = " & $sDefault), $sDefault)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniWrite($sFilename, $sSection, $sKey, $sValue)
	Local $vReturn = __DefineStub("IniWrite", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey, "sValue = " & $sValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniDelete($sFilename, $sSection, $sKey = "")
	Local $vReturn = __DefineStub("IniDelete", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniReadSection($sFilename, $sSection)
	Local $vReturn = __DefineStub("IniReadSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniReadSectionNames($sFilename)
	Local $vReturn = __DefineStub("IniReadSectionNames", __CallArgs("sFilename = " & $sFilename), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniWriteSection($sFilename, $sSection, $vData, $iIndex = 1)
	Local $aArgs = __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, _
							  "vData = " & (IsArray($vData)? _ArrayToString($vData): $vData), "iIndex = " & $iIndex)
	Local $vReturn = __DefineStub("IniWriteSection", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IniRenameSection($sFilename, $sSection, $sNewSection, $iFlag = 0)
	Local $aArgs = __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sNewSection = " & $sNewSection, "iFlag = " & $iFlag)
	Local $vReturn = __DefineStub("IniRenameSection", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_IniRead             = __Stub_IniRead
$g_hFn_IniWrite            = __Stub_IniWrite
$g_hFn_IniDelete           = __Stub_IniDelete
$g_hFn_IniReadSection      = __Stub_IniReadSection
$g_hFn_IniReadSectionNames = __Stub_IniReadSectionNames
$g_hFn_IniWriteSection     = __Stub_IniWriteSection
$g_hFn_IniRenameSection    = __Stub_IniRenameSection
