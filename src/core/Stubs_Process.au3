; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Process.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt process and shell functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_ShellExecute($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "", $iShowFlag = 1)
	Local $vReturn = __DefineStub("ShellExecute", __CallArgs("sFilename = " & $sFilename, "sParams = " & $sParams), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ShellExecuteWait($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "", $iShowFlag = 1)
	Local $vReturn = __DefineStub("ShellExecuteWait", __CallArgs("sFilename = " & $sFilename, "sParams = " & $sParams), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_Run($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
	Local $vReturn = __DefineStub("Run", __CallArgs("sProgram = " & $sProgram), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_RunWait($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
	Local $vReturn = __DefineStub("RunWait", __CallArgs("sProgram = " & $sProgram), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ProcessExists($sProcess)
	Local $vReturn = __DefineStub("ProcessExists", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ProcessClose($sProcess)
	Local $vReturn = __DefineStub("ProcessClose", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ProcessWait($sProcess, $iTimeout = 0)
	Local $vReturn = __DefineStub("ProcessWait", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ProcessWaitClose($sProcess, $iTimeout = 0)
	Local $vReturn = __DefineStub("ProcessWaitClose", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_ProcessList($sProcess = "")
	Local $vReturn = __DefineStub("ProcessList", __CallArgs("sProcess = " & $sProcess), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_StdoutRead($hProcess, $bPeek = False, $bBinary = False)
	Local $vReturn = __DefineStub("StdoutRead", __CallArgs("hProcess = " & $hProcess), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_StderrRead($hProcess, $bPeek = False, $bBinary = False)
	Local $vReturn = __DefineStub("StderrRead", __CallArgs("hProcess = " & $hProcess), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func _Stub_StdinWrite($hProcess, $sData = "")
	Local $vReturn = __DefineStub("StdinWrite", __CallArgs("hProcess = " & $hProcess, "sData = " & $sData), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_ShellExecute     = _Stub_ShellExecute
$g_hFn_ShellExecuteWait = _Stub_ShellExecuteWait
$g_hFn_Run              = _Stub_Run
$g_hFn_RunWait          = _Stub_RunWait
$g_hFn_ProcessExists    = _Stub_ProcessExists
$g_hFn_ProcessClose     = _Stub_ProcessClose
$g_hFn_ProcessWait      = _Stub_ProcessWait
$g_hFn_ProcessWaitClose = _Stub_ProcessWaitClose
$g_hFn_ProcessList      = _Stub_ProcessList
$g_hFn_StdoutRead       = _Stub_StdoutRead
$g_hFn_StderrRead       = _Stub_StderrRead
$g_hFn_StdinWrite       = _Stub_StdinWrite
