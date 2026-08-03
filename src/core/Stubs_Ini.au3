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
	Return __DefineStub("IniRead", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey), $sDefault)
EndFunc

Func _Stub_IniWrite($sFilename, $sSection, $sKey, $sValue)
	Return __DefineStub("IniWrite", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey, "sValue = " & $sValue), 1)
EndFunc

Func _Stub_IniDelete($sFilename, $sSection, $sKey = "")
	Return __DefineStub("IniDelete", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sKey = " & $sKey), 1)
EndFunc

Func _Stub_IniReadSection($sFilename, $sSection)
	Return __DefineStub("IniReadSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection), "")
EndFunc

Func _Stub_IniReadSectionNames($sFilename)
	Return __DefineStub("IniReadSectionNames", __CallArgs("sFilename = " & $sFilename), "")
EndFunc

Func _Stub_IniWriteSection($sFilename, $sSection, $vData, $iIndex = 0)
	Return __DefineStub("IniWriteSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection), 1)
EndFunc

Func _Stub_IniRenameSection($sFilename, $sSection, $sNewSection, $bOverwrite = False)
	Return __DefineStub("IniRenameSection", __CallArgs("sFilename = " & $sFilename, "sSection = " & $sSection, "sNewSection = " & $sNewSection), 1)
EndFunc

$g_hFn_IniRead             = _Stub_IniRead
$g_hFn_IniWrite            = _Stub_IniWrite
$g_hFn_IniDelete           = _Stub_IniDelete
$g_hFn_IniReadSection      = _Stub_IniReadSection
$g_hFn_IniReadSectionNames = _Stub_IniReadSectionNames
$g_hFn_IniWriteSection     = _Stub_IniWriteSection
$g_hFn_IniRenameSection    = _Stub_IniRenameSection
