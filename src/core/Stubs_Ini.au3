; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Ini.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt INI file functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_IniRead($sFilename, $sSection, $sKey, $sDefault)
	Local $vReturn = __DefineStub("IniRead", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey), $sDefault)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniWrite($sFilename, $sSection, $sKey, $sValue)
	Local $vReturn = __DefineStub("IniWrite", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey, "sValue = " & $sValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniDelete($sFilename, $sSection, $sKey = "")
	Local $vReturn = __DefineStub("IniDelete", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniReadSection($sFilename, $sSection)
	Local $vReturn = __DefineStub("IniReadSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniReadSectionNames($sFilename)
	Local $vReturn = __DefineStub("IniReadSectionNames", __CallArgs("sFilename = " & $sFilename), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniWriteSection($sFilename, $sSection, $vData, $iIndex = 0)
	Local $vReturn = __DefineStub("IniWriteSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_IniRenameSection($sFilename, $sSection, $sNewSection, $bOverwrite = False)
	Local $vReturn = __DefineStub("IniRenameSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sNewSection = " & $sNewSection), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_IniRead             = _Stub_IniRead
$g_hFn_IniWrite            = _Stub_IniWrite
$g_hFn_IniDelete           = _Stub_IniDelete
$g_hFn_IniReadSection      = _Stub_IniReadSection
$g_hFn_IniReadSectionNames = _Stub_IniReadSectionNames
$g_hFn_IniWriteSection     = _Stub_IniWriteSection
$g_hFn_IniRenameSection    = _Stub_IniRenameSection
