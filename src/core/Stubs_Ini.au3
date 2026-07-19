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
    __StubInitType("IniRead")
    Local $iIdx = $g_StubCalls["IniRead"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sSection"]  = $sSection
    $oCall["sKey"]      = $sKey
    $g_StubCalls["IniRead"][$iIdx] = $oCall
    $g_StubCalls["IniRead"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["IniRead"], $iIdx) ? $g_StubReturns["IniRead"][$iIdx] : $sDefault
    Return $sReturn
EndFunc

Func _Stub_IniWrite($sFilename, $sSection, $sKey, $sValue)
    __StubInitType("IniWrite")
    Local $iIdx = $g_StubCalls["IniWrite"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sSection"]  = $sSection
    $oCall["sKey"]      = $sKey
    $oCall["sValue"]    = $sValue
    $g_StubCalls["IniWrite"][$iIdx] = $oCall
    $g_StubCalls["IniWrite"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["IniWrite"], $iIdx) ? $g_StubReturns["IniWrite"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_IniDelete($sFilename, $sSection, $sKey = "")
    __StubInitType("IniDelete")
    Local $iIdx = $g_StubCalls["IniDelete"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sSection"]  = $sSection
    $oCall["sKey"]      = $sKey
    $g_StubCalls["IniDelete"][$iIdx] = $oCall
    $g_StubCalls["IniDelete"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["IniDelete"], $iIdx) ? $g_StubReturns["IniDelete"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_IniReadSection($sFilename, $sSection)
    __StubInitType("IniReadSection")
    Local $iIdx = $g_StubCalls["IniReadSection"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sSection"]  = $sSection
    $g_StubCalls["IniReadSection"][$iIdx] = $oCall
    $g_StubCalls["IniReadSection"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["IniReadSection"], $iIdx) ? $g_StubReturns["IniReadSection"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_IniReadSectionNames($sFilename)
    __StubInitType("IniReadSectionNames")
    Local $iIdx = $g_StubCalls["IniReadSectionNames"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $g_StubCalls["IniReadSectionNames"][$iIdx] = $oCall
    $g_StubCalls["IniReadSectionNames"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["IniReadSectionNames"], $iIdx) ? $g_StubReturns["IniReadSectionNames"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_IniWriteSection($sFilename, $sSection, $vData, $iIndex = 0)
    __StubInitType("IniWriteSection")
    Local $iIdx = $g_StubCalls["IniWriteSection"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sSection"]  = $sSection
    $g_StubCalls["IniWriteSection"][$iIdx] = $oCall
    $g_StubCalls["IniWriteSection"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["IniWriteSection"], $iIdx) ? $g_StubReturns["IniWriteSection"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_IniRenameSection($sFilename, $sSection, $sNewSection, $bOverwrite = False)
    __StubInitType("IniRenameSection")
    Local $iIdx = $g_StubCalls["IniRenameSection"].count + 1
    Local $oCall[]
    $oCall["sFilename"]   = $sFilename
    $oCall["sSection"]    = $sSection
    $oCall["sNewSection"] = $sNewSection
    $g_StubCalls["IniRenameSection"][$iIdx] = $oCall
    $g_StubCalls["IniRenameSection"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["IniRenameSection"], $iIdx) ? $g_StubReturns["IniRenameSection"][$iIdx] : True
    Return $bReturn
EndFunc

$g_hFn_IniRead             = _Stub_IniRead
$g_hFn_IniWrite            = _Stub_IniWrite
$g_hFn_IniDelete           = _Stub_IniDelete
$g_hFn_IniReadSection      = _Stub_IniReadSection
$g_hFn_IniReadSectionNames = _Stub_IniReadSectionNames
$g_hFn_IniWriteSection     = _Stub_IniWriteSection
$g_hFn_IniRenameSection    = _Stub_IniRenameSection
