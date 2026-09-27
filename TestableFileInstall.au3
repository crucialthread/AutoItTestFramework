#include-once

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableFileInstall.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt FileInstall function.
;                  Can be included directly or via Testable.au3
;
;                  Unlike other testable wrappers, this one is not linked to the real FileInstall() built-in
;                  by default. FileInstall() is special in AutoIt - Aut2Exe requires its source path to be a
;                  string literal at compile time, meaning it cannot be called through a function pointer like
;                  other built-ins - doing so would pass a variable to the source path argument, which AutoIt
;                  does not allow for FileInstall.
;
;                  Reference - AutoIt official documentation:
;                      - The source file must be specified using a string literal and can not be a variable,
;                        a macro, a calculation nor function call.
;                      - The file must be able to be found during compiling, however variables,
;                        calculations and function calls do not get resolved until the script itself is running,
;                        long after compiling, making them unsuitable to define the source file.
;
;                      https://www.autoitscript.com/autoit3/docs/functions/FileInstall.htm
;
;                  To make FileInstall testable, the script that uses this library must define its own function
;                  with a Select or If-ElseIf block where each call to FileInstall() uses a string literal, then
;                  register it via _Tstbl_Implement_FileInstall(). Example of what the script-side implementation
;                  should look like:
;
;                      > Func __FileInstall($sSource, $sDest, $iFlag)
;                      >    Select
;                      >        Case $sSource = "path\to\file1.au3"
;                      >            FileInstall("path\to\file1.au3", $sDest, $iFlag)
;                      >        Case $sSource = "..\path\to\file2.au3"
;                      >            FileInstall("..\path\to\file2.au3", $sDest, $iFlag)
;                      >    EndSelect
;                      > EndFunc
;
;                      > _Tstbl_Implement_FileInstall(__FileInstall)
;
;                  Once registered, it can be called in script code like:
;                      > _Tstbl_FileInstall("path\to\file1.au3", $g_sDestPath & "\file1.au3", $FC_OVERWRITE)
;
;                  Until that is done, _Tstbl_FileInstall() remains linked to a dummy and returns Null with @error = 1.
; ===============================================================================================================================

Global Const $STUB_FILEINSTALL_FUNCNAME = "__Stub_FileInstall"
Global $g_bFileInstallImplemented       = False
Global $g_hFn_FileInstall               = __Tstbl_Dummy_FileInstall

Func _Tstbl_FileInstall($sSource, $sDest, $iFlag = 0)
    If __Tstbl_IsFileInstallDummy() Then Return SetError(1, 0, Null)
    Local $vResult = $g_hFn_FileInstall($sSource, $sDest, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func __Tstbl_Dummy_FileInstall($sSource, $sDest, $iFlag = 0)
EndFunc

; Returns True if _Tstbl_FileInstall() is still linked to the dummy - meaning
; _Tstbl_Implement_FileInstall() has not been called yet with a valid function.
Func __Tstbl_IsFileInstallDummy()
    Return $g_hFn_FileInstall = __Tstbl_Dummy_FileInstall
EndFunc

; Returns True if _Tstbl_Implement_FileInstall() has been called with a valid function.
; Used by the stub to decide whether to record calls or return early.
Func __Tstbl_IsFileInstallImplemented()
    Return $g_bFileInstallImplemented
EndFunc

; Registers the script-provided FileInstall wrapper as the active implementation.
; 1) Sets the implemented flag to True if a valid function was provided.
;    Used by the stub to decide whether to record calls or return early.
;    If no implementation is registered, stub calls are ignored and False is returned
; 2) If the stub is already wired, returns without overwriting it - preventing
;    the script under test from overwriting the stub. In tests, stubs are included
;    before the script under test, so by the time the script calls this function
;    the stub is already in place. This guard ensures it stays that way.
; 3) Sets the pointer to the provided function if valid, falling back to the
;    dummy implementation otherwise.
Func _Tstbl_Implement_FileInstall($hFileInstall)
    $g_bFileInstallImplemented = IsFunc($hFileInstall) ? True : False
    If FuncName($g_hFn_FileInstall) = $STUB_FILEINSTALL_FUNCNAME Then Return
    $g_hFn_FileInstall = IsFunc($hFileInstall) ? $hFileInstall : __Tstbl_Dummy_FileInstall
EndFunc
