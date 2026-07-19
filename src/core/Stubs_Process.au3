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
    __StubInitType("ShellExecute")
    Local $iIdx = $g_StubCalls["ShellExecute"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sParams"]   = $sParams
    $g_StubCalls["ShellExecute"][$iIdx] = $oCall
    $g_StubCalls["ShellExecute"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ShellExecute"], $iIdx) ? $g_StubReturns["ShellExecute"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_ShellExecuteWait($sFilename, $sParams = "", $sWorkDir = "", $sVerb = "", $iShowFlag = 1)
    __StubInitType("ShellExecuteWait")
    Local $iIdx = $g_StubCalls["ShellExecuteWait"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["sParams"]   = $sParams
    $g_StubCalls["ShellExecuteWait"][$iIdx] = $oCall
    $g_StubCalls["ShellExecuteWait"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["ShellExecuteWait"], $iIdx) ? $g_StubReturns["ShellExecuteWait"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_Run($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
    __StubInitType("Run")
    Local $iIdx = $g_StubCalls["Run"].count + 1
    Local $oCall[]
    $oCall["sProgram"] = $sProgram
    $g_StubCalls["Run"][$iIdx] = $oCall
    $g_StubCalls["Run"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["Run"], $iIdx) ? $g_StubReturns["Run"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_RunWait($sProgram, $sWorkingDir = "", $iShowFlag = @SW_SHOWNORMAL, $nOptionalStreamHandle = 0)
    __StubInitType("RunWait")
    Local $iIdx = $g_StubCalls["RunWait"].count + 1
    Local $oCall[]
    $oCall["sProgram"] = $sProgram
    $g_StubCalls["RunWait"][$iIdx] = $oCall
    $g_StubCalls["RunWait"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["RunWait"], $iIdx) ? $g_StubReturns["RunWait"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_ProcessExists($sProcess)
    __StubInitType("ProcessExists")
    Local $iIdx = $g_StubCalls["ProcessExists"].count + 1
    Local $oCall[]
    $oCall["sProcess"] = $sProcess
    $g_StubCalls["ProcessExists"][$iIdx] = $oCall
    $g_StubCalls["ProcessExists"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["ProcessExists"], $iIdx) ? $g_StubReturns["ProcessExists"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_ProcessClose($sProcess)
    __StubInitType("ProcessClose")
    Local $iIdx = $g_StubCalls["ProcessClose"].count + 1
    Local $oCall[]
    $oCall["sProcess"] = $sProcess
    $g_StubCalls["ProcessClose"][$iIdx] = $oCall
    $g_StubCalls["ProcessClose"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["ProcessClose"], $iIdx) ? $g_StubReturns["ProcessClose"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_ProcessWait($sProcess, $iTimeout = 0)
    __StubInitType("ProcessWait")
    Local $iIdx = $g_StubCalls["ProcessWait"].count + 1
    Local $oCall[]
    $oCall["sProcess"] = $sProcess
    $g_StubCalls["ProcessWait"][$iIdx] = $oCall
    $g_StubCalls["ProcessWait"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["ProcessWait"], $iIdx) ? $g_StubReturns["ProcessWait"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_ProcessWaitClose($sProcess, $iTimeout = 0)
    __StubInitType("ProcessWaitClose")
    Local $iIdx = $g_StubCalls["ProcessWaitClose"].count + 1
    Local $oCall[]
    $oCall["sProcess"] = $sProcess
    $g_StubCalls["ProcessWaitClose"][$iIdx] = $oCall
    $g_StubCalls["ProcessWaitClose"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["ProcessWaitClose"], $iIdx) ? $g_StubReturns["ProcessWaitClose"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_ProcessList($sProcess = "")
    __StubInitType("ProcessList")
    Local $iIdx = $g_StubCalls["ProcessList"].count + 1
    Local $oCall[]
    $oCall["sProcess"] = $sProcess
    $g_StubCalls["ProcessList"][$iIdx] = $oCall
    $g_StubCalls["ProcessList"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["ProcessList"], $iIdx) ? $g_StubReturns["ProcessList"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_StdoutRead($hProcess, $bPeek = False, $bBinary = False)
    __StubInitType("StdoutRead")
    Local $iIdx = $g_StubCalls["StdoutRead"].count + 1
    Local $oCall[]
    $oCall["hProcess"] = $hProcess
    $g_StubCalls["StdoutRead"][$iIdx] = $oCall
    $g_StubCalls["StdoutRead"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["StdoutRead"], $iIdx) ? $g_StubReturns["StdoutRead"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_StderrRead($hProcess, $bPeek = False, $bBinary = False)
    __StubInitType("StderrRead")
    Local $iIdx = $g_StubCalls["StderrRead"].count + 1
    Local $oCall[]
    $oCall["hProcess"] = $hProcess
    $g_StubCalls["StderrRead"][$iIdx] = $oCall
    $g_StubCalls["StderrRead"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["StderrRead"], $iIdx) ? $g_StubReturns["StderrRead"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_StdinWrite($hProcess, $sData = "")
    __StubInitType("StdinWrite")
    Local $iIdx = $g_StubCalls["StdinWrite"].count + 1
    Local $oCall[]
    $oCall["hProcess"] = $hProcess
    $oCall["sData"]    = $sData
    $g_StubCalls["StdinWrite"][$iIdx] = $oCall
    $g_StubCalls["StdinWrite"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["StdinWrite"], $iIdx) ? $g_StubReturns["StdinWrite"][$iIdx] : True
    Return $bReturn
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
