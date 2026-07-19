; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Dialogs.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt dialog functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"
#include <MsgBoxConstants.au3>

Func _Stub_MsgBox($iFlag, $sTitle, $sText, $iTimeout = 0, $hWnd = 0)
    __StubInitType("MsgBox")
    Local $iIdx = $g_StubCalls["MsgBox"].count + 1
    Local $oCall[]
    $oCall["iFlag"]  = $iFlag
    $oCall["sTitle"] = $sTitle
    $oCall["sText"]  = $sText
    $g_StubCalls["MsgBox"][$iIdx] = $oCall
    $g_StubCalls["MsgBox"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["MsgBox"], $iIdx) ? $g_StubReturns["MsgBox"][$iIdx] : $IDOK
    Return $iReturn
EndFunc

Func _Stub_InputBox($sTitle, $sPrompt, $sDefault = "", $sPassword = "", $iWidth = 0, $iHeight = 0, $iLeft = -1, $iTop = -1, $iTimeout = 0, $hWnd = 0)
    __StubInitType("InputBox")
    Local $iIdx = $g_StubCalls["InputBox"].count + 1
    Local $oCall[]
    $oCall["sTitle"]  = $sTitle
    $oCall["sPrompt"] = $sPrompt
    $g_StubCalls["InputBox"][$iIdx] = $oCall
    $g_StubCalls["InputBox"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["InputBox"], $iIdx) ? $g_StubReturns["InputBox"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
    __StubInitType("FileOpenDialog")
    Local $iIdx = $g_StubCalls["FileOpenDialog"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["FileOpenDialog"][$iIdx] = $oCall
    $g_StubCalls["FileOpenDialog"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileOpenDialog"], $iIdx) ? $g_StubReturns["FileOpenDialog"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileSaveDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
    __StubInitType("FileSaveDialog")
    Local $iIdx = $g_StubCalls["FileSaveDialog"].count + 1
    Local $oCall[]
    $oCall["sTitle"] = $sTitle
    $g_StubCalls["FileSaveDialog"][$iIdx] = $oCall
    $g_StubCalls["FileSaveDialog"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileSaveDialog"], $iIdx) ? $g_StubReturns["FileSaveDialog"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileSelectFolder($sMsg, $sRootDir = "", $iFlag = 0, $sInitDir = "")
    __StubInitType("FileSelectFolder")
    Local $iIdx = $g_StubCalls["FileSelectFolder"].count + 1
    Local $oCall[]
    $oCall["sMsg"] = $sMsg
    $g_StubCalls["FileSelectFolder"][$iIdx] = $oCall
    $g_StubCalls["FileSelectFolder"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileSelectFolder"], $iIdx) ? $g_StubReturns["FileSelectFolder"][$iIdx] : ""
    Return $sReturn
EndFunc

$g_hFn_MsgBox           = _Stub_MsgBox
$g_hFn_InputBox         = _Stub_InputBox
$g_hFn_FileOpenDialog   = _Stub_FileOpenDialog
$g_hFn_FileSaveDialog   = _Stub_FileSaveDialog
$g_hFn_FileSelectFolder = _Stub_FileSelectFolder
