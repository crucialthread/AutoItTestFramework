; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Process.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt process and shell functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_ShellExecute($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "open", $iShowFlag = 1)
	Local $aArgs = __CallArgs("sFilename = " & $sFilename, "sParams = " & $sParams, "sWorkDir = " & $sWorkDir, _
							  "sVerb = " & $sVerb, "iShowFlag = " & $iShowFlag)
	Local $vReturn = __DefineStub("ShellExecute", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ShellExecuteWait($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "open", $iShowFlag = 1)
	Local $aArgs = __CallArgs("sFilename = " & $sFilename, "sParams = " & $sParams, "sWorkDir = " & $sWorkDir, _
							  "sVerb = " & $sVerb, "iShowFlag = " & $iShowFlag)
	Local $vReturn = __DefineStub("ShellExecuteWait", $aArgs, 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_Run($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
	Local $aArgs = __CallArgs("sProgram = " & $sProgram, "sWorkingDir = " & $sWorkingDir, "iShowFlag = " & $iShowFlag, _
							  "nOptionalStreamHandle = " & $nOptionalStreamHandle)
	Local $vReturn = __DefineStub("Run", $aArgs, 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_RunWait($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
	Local $aArgs = __CallArgs("sProgram = " & $sProgram, "sWorkingDir = " & $sWorkingDir, "iShowFlag = " & $iShowFlag, _
							  "nOptionalStreamHandle = " & $nOptionalStreamHandle)
	Local $vReturn = __DefineStub("RunWait", $aArgs, 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProcessExists($sProcess)
	Local $vReturn = __DefineStub("ProcessExists", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProcessClose($sProcess)
	Local $vReturn = __DefineStub("ProcessClose", __CallArgs("sProcess = " & $sProcess), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProcessWait($sProcess, $iTimeout = 0)
	Local $vReturn = __DefineStub("ProcessWait", __CallArgs("sProcess = " & $sProcess, "iTimeout = " & $iTimeout), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProcessWaitClose($sProcess, $iTimeout = 0)
	Local $vReturn = __DefineStub("ProcessWaitClose", __CallArgs("sProcess = " & $sProcess, "iTimeout = " & $iTimeout), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ProcessList($sProcess = "")
	Local $vReturn = __DefineStub("ProcessList", __CallArgs("sProcess = " & $sProcess), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_StdoutRead($hProcess, $bPeek = False, $bBinary = False)
	Local $vReturn = __DefineStub("StdoutRead", __CallArgs("hProcess = " & $hProcess, "bPeek = " & $bPeek, "bBinary = " & $bBinary), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_StderrRead($hProcess, $bPeek = False, $bBinary = False)
	Local $vReturn = __DefineStub("StderrRead", __CallArgs("hProcess = " & $hProcess, "bPeek = " & $bPeek, "bBinary = " & $bBinary), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_StdinWrite($hProcess, $vData = "")
	Local $vReturn = __DefineStub("StdinWrite", __CallArgs("hProcess = " & $hProcess, "vData = " & $vData), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_ShellExecute     = __Stub_ShellExecute
$g_hFn_ShellExecuteWait = __Stub_ShellExecuteWait
$g_hFn_Run              = __Stub_Run
$g_hFn_RunWait          = __Stub_RunWait
$g_hFn_ProcessExists    = __Stub_ProcessExists
$g_hFn_ProcessClose     = __Stub_ProcessClose
$g_hFn_ProcessWait      = __Stub_ProcessWait
$g_hFn_ProcessWaitClose = __Stub_ProcessWaitClose
$g_hFn_ProcessList      = __Stub_ProcessList
$g_hFn_StdoutRead       = __Stub_StdoutRead
$g_hFn_StderrRead       = __Stub_StderrRead
$g_hFn_StdinWrite       = __Stub_StdinWrite
