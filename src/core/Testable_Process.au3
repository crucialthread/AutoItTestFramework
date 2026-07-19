; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Process.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt process and shell functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_ShellExecute     = ShellExecute
Global $g_hFn_ShellExecuteWait = ShellExecuteWait
Global $g_hFn_Run              = Run
Global $g_hFn_RunWait          = RunWait
Global $g_hFn_ProcessExists    = ProcessExists
Global $g_hFn_ProcessClose     = ProcessClose
Global $g_hFn_ProcessWait      = ProcessWait
Global $g_hFn_ProcessWaitClose = ProcessWaitClose
Global $g_hFn_ProcessList      = ProcessList
Global $g_hFn_StdoutRead       = StdoutRead
Global $g_hFn_StderrRead       = StderrRead
Global $g_hFn_StdinWrite       = StdinWrite

Func _Tstbl_ShellExecute($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "", $iShowFlag = 1)
    Local $vResult = $g_hFn_ShellExecute($sFilename, $sParams, $sWorkDir, $sVerb, $iShowFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ShellExecuteWait($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "", $iShowFlag = 1)
    Local $vResult = $g_hFn_ShellExecuteWait($sFilename, $sParams, $sWorkDir, $sVerb, $iShowFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_Run($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
    Local $vResult = $g_hFn_Run($sProgram, $sWorkingDir, $iShowFlag, $nOptionalStreamHandle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RunWait($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
    Local $vResult = $g_hFn_RunWait($sProgram, $sWorkingDir, $iShowFlag, $nOptionalStreamHandle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessExists($sProcess)
    Local $vResult = $g_hFn_ProcessExists($sProcess)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessClose($sProcess)
    Local $vResult = $g_hFn_ProcessClose($sProcess)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessWait($sProcess, $iTimeout = 0)
    Local $vResult = $g_hFn_ProcessWait($sProcess, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessWaitClose($sProcess, $iTimeout = 0)
    Local $vResult = $g_hFn_ProcessWaitClose($sProcess, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessList($sProcess = "")
    Local $vResult = $g_hFn_ProcessList($sProcess)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_StdoutRead($hProcess, $bPeek = False, $bBinary = False)
    Local $vResult = $g_hFn_StdoutRead($hProcess, $bPeek, $bBinary)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_StderrRead($hProcess, $bPeek = False, $bBinary = False)
    Local $vResult = $g_hFn_StderrRead($hProcess, $bPeek, $bBinary)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_StdinWrite($hProcess, $sData = "")
    Local $vResult = $g_hFn_StdinWrite($hProcess, $sData)
    Return SetError(@error, @extended, $vResult)
EndFunc
