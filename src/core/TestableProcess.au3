#include-once

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestableProcess.au3 library
; Version .......: 1.0.0
; AutoIt Version : 3.3.18.0
; Language ......: English
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt process and shell functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

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

Func _Tstbl_ShellExecute($sFilename, $sParameters = "", $sWorkingDir = "", $sShellVerb = Default, $iShowFlag = 1)
    Local $vResult = $g_hFn_ShellExecute($sFilename, $sParameters, $sWorkingDir, $sShellVerb, $iShowFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ShellExecuteWait($sFilename, $sParameters = "", $sWorkingDir = "", $sShellVerb = Default, $iShowFlag = 1)
    Local $vResult = $g_hFn_ShellExecuteWait($sFilename, $sParameters, $sWorkingDir, $sShellVerb, $iShowFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_Run($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptFlag = 0)
    Local $vResult = $g_hFn_Run($sProgram, $sWorkingDir, $iShowFlag, $nOptFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_RunWait($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptFlag = 0)
    Local $vResult = $g_hFn_RunWait($sProgram, $sWorkingDir, $iShowFlag, $nOptFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessExists($idProcess)
    Local $vResult = $g_hFn_ProcessExists($idProcess)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessClose($idProcess)
    Local $vResult = $g_hFn_ProcessClose($idProcess)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessWait($sProcessName, $iTimeout = 0)
    Local $vResult = $g_hFn_ProcessWait($sProcessName, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessWaitClose($sProcess, $iTimeout = 0)
    Local $vResult = $g_hFn_ProcessWaitClose($sProcess, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ProcessList($sProcessName = "")
    Local $vResult = $g_hFn_ProcessList($sProcessName)
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

Func _Tstbl_StdinWrite($hProcess, $vData = "")
    Local $vResult = $g_hFn_StdinWrite($hProcess, $vData)
    Return SetError(@error, @extended, $vResult)
EndFunc
