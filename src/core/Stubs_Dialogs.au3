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
	Local $vReturn = __DefineStub("MsgBox", __CallArgs("iFlag = " & $iFlag, "sTitle = " & $sTitle, "sText = " & $sText), $IDOK)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_InputBox($sTitle, $sPrompt, $sDefault = "", $sPassword = "", $iWidth = 0, $iHeight = 0, $iLeft = -1, $iTop = -1, $iTimeout = 0, $hWnd = 0)
	Local $vReturn = __DefineStub("InputBox", __CallArgs("sTitle = " & $sTitle, "sPrompt = " & $sPrompt), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
	Local $vReturn = __DefineStub("FileOpenDialog", __CallArgs("sTitle = " & $sTitle), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_FileSaveDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
	Local $vReturn = __DefineStub("FileSaveDialog", __CallArgs("sTitle = " & $sTitle), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_FileSelectFolder($sMsg, $sRootDir = "", $iFlag = 0, $sInitDir = "")
	Local $vReturn = __DefineStub("FileSelectFolder", __CallArgs("sMsg = " & $sMsg), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_MsgBox           = _Stub_MsgBox
$g_hFn_InputBox         = _Stub_InputBox
$g_hFn_FileOpenDialog   = _Stub_FileOpenDialog
$g_hFn_FileSaveDialog   = _Stub_FileSaveDialog
$g_hFn_FileSelectFolder = _Stub_FileSelectFolder
