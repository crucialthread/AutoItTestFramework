; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Dialogs.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt dialog functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_MsgBox($iFlag, $sTitle, $sText, $iTimeout = 0, $hWnd = 0)
	Local $aArgs = __CallArgs("iFlag = " & $iFlag, "sTitle = " & $sTitle, "sText = " & $sText, "hWnd = " & $hWnd)
	Local $vReturn = __DefineStub("MsgBox", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_InputBox($sTitle, $sPrompt, $sDefault = "", $sPasswordChar = "", $iWidth = 250, $iHeight = 190, $iLeft = Default, $iTop = Default, $iTimeout = 0, $hWnd = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sPrompt = " & $sPrompt, "sDefault = " & $sDefault, "sPasswordChar = " & $sPasswordChar, _
							  "iWidth = " & $iWidth, "iHeight = " & $iHeight, "iLeft = " & $iLeft, "iTop = " & $iTop, "iTimeout = " & $iTimeout, "hWnd = " & $hWnd)
	Local $vReturn = __DefineStub("InputBox", $aArgs, "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sInitDir = " & $sInitDir, "sFilter = " & $sFilter, _
							  "iOptions = " & $iOptions, "sDefaultName = " & $sDefaultName, "hWnd = " & $hWnd)
	Local $vReturn = __DefineStub("FileOpenDialog", __CallArgs("sTitle = " & $sTitle), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileSaveDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
	Local $aArgs = __CallArgs("sTitle = " & $sTitle, "sInitDir = " & $sInitDir, "sFilter = " & $sFilter, _
							  "iOptions = " & $iOptions, "sDefaultName = " & $sDefaultName, "hWnd = " & $hWnd)
	Local $vReturn = __DefineStub("FileSaveDialog", $aArgs, "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileSelectFolder($sMsg, $sRootDir = "", $iFlag = 0, $sInitDir = "", $hWnd = 0)
	Local $aArgs = __CallArgs("sMsg = " & $sMsg, "sRootDir = " & $sRootDir, "iFlag = " & $iFlag, "sInitDir = " & $sInitDir, "hWnd = " & $hWnd)
	Local $vReturn = __DefineStub("FileSelectFolder", $aArgs, "")
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_MsgBox           = __Stub_MsgBox
$g_hFn_InputBox         = __Stub_InputBox
$g_hFn_FileOpenDialog   = __Stub_FileOpenDialog
$g_hFn_FileSaveDialog   = __Stub_FileSaveDialog
$g_hFn_FileSelectFolder = __Stub_FileSelectFolder
