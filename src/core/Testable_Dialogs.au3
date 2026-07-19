; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Dialogs.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt dialog functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once
#include <MsgBoxConstants.au3>

Global $g_hFn_MsgBox           = MsgBox
Global $g_hFn_InputBox         = InputBox
Global $g_hFn_FileOpenDialog   = FileOpenDialog
Global $g_hFn_FileSaveDialog   = FileSaveDialog
Global $g_hFn_FileSelectFolder = FileSelectFolder

Func _Tstbl_MsgBox($iFlag, $sTitle, $sText, $iTimeout = 0, $hWnd = 0)
    Local $vResult = $g_hFn_MsgBox($iFlag, $sTitle, $sText, $iTimeout, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_InputBox($sTitle, $sPrompt, $sDefault = "", $sPassword = "", $iWidth = -1, $iHeight = -1, $iLeft = Default, $iTop = Default, $iTimeout = 0, $hWnd = 0)
    Local $vResult = $g_hFn_InputBox($sTitle, $sPrompt, $sDefault, $sPassword, $iWidth, $iHeight, $iLeft, $iTop, $iTimeout, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
    Local $vResult = $g_hFn_FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions, $sDefaultName, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileSaveDialog($sTitle, $sInitDir, $sFilter, $iOptions = 0, $sDefaultName = "", $hWnd = 0)
    Local $vResult = $g_hFn_FileSaveDialog($sTitle, $sInitDir, $sFilter, $iOptions, $sDefaultName, $hWnd)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileSelectFolder($sMsg, $sRootDir = "", $iFlag = 0, $sInitDir = "", $hWnd = 0)
    Local $vResult = $g_hFn_FileSelectFolder($sMsg, $sRootDir, $iFlag, $sInitDir)
    Return SetError(@error, @extended, $vResult)
EndFunc
