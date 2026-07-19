; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Ini.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt INI file functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_IniRead             = IniRead
Global $g_hFn_IniWrite            = IniWrite
Global $g_hFn_IniDelete           = IniDelete
Global $g_hFn_IniReadSection      = IniReadSection
Global $g_hFn_IniReadSectionNames = IniReadSectionNames
Global $g_hFn_IniWriteSection     = IniWriteSection
Global $g_hFn_IniRenameSection    = IniRenameSection

Func _Tstbl_IniRead($sFilename, $sSection, $sKey, $sDefault)
    Local $vResult = $g_hFn_IniRead($sFilename, $sSection, $sKey, $sDefault)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniWrite($sFilename, $sSection, $sKey, $sValue)
    Local $vResult = $g_hFn_IniWrite($sFilename, $sSection, $sKey, $sValue)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniDelete($sFilename, $sSection, $sKey = "")
    Local $vResult = $g_hFn_IniDelete($sFilename, $sSection, $sKey)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniReadSection($sFilename, $sSection)
    Local $vResult = $g_hFn_IniReadSection($sFilename, $sSection)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniReadSectionNames($sFilename)
    Local $vResult = $g_hFn_IniReadSectionNames($sFilename)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniWriteSection($sFilename, $sSection, $vData, $iIndex = 0)
    Local $vResult = $g_hFn_IniWriteSection($sFilename, $sSection, $vData, $iIndex)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IniRenameSection($sFilename, $sSection, $sNewSection, $bOverwrite = False)
    Local $vResult = $g_hFn_IniRenameSection($sFilename, $sSection, $sNewSection, $bOverwrite)
    Return SetError(@error, @extended, $vResult)
EndFunc
