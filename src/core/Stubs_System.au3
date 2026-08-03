; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_System.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt system functions.
;                  Can be included directly or via Stubs.au3
; ===============================================================================================================================

#include-once
#include <AutoItConstants.au3>
#include "Stubs_Core.au3"

Func _Stub_Sleep($iDelay)
	Return __DefineStub("Sleep", __CallArgs("iDelay = " & $iDelay))
EndFunc

Func _Stub_Shutdown($iCode)
	Return __DefineStub("Shutdown", __CallArgs("iCode = " & $iCode), 1)
EndFunc

Func _Stub_IsAdmin()
	Return __DefineStub("IsAdmin", __CallArgs(), 1)
EndFunc

Func _Stub_EnvGet($sEnvVarName)
	Return __DefineStub("EnvGet", __CallArgs("sEnvVarName = " & $sEnvVarName), $sEnvVarName)
EndFunc

Func _Stub_EnvSet($sEnvVarName, $sValue = "")
	Return __DefineStub("EnvSet", __CallArgs("sEnvVarName = " & $sEnvVarName, "sValue = " & $sValue), 1)
EndFunc

Func _Stub_DriveGetDrive($sType = "ALL")
	Return __DefineStub("DriveGetDrive", __CallArgs("sType = " & $sType), "")
EndFunc

Func _Stub_DriveGetFileSystem($sDrive)
	Return __DefineStub("DriveGetFileSystem", __CallArgs("sDrive = " & $sDrive), $DT_NTFS)
EndFunc

Func _Stub_DriveSpaceFree($sPath)
	Return __DefineStub("DriveSpaceFree", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_DriveSpaceTotal($sPath)
	Return __DefineStub("DriveSpaceTotal", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_DriveStatus($sDrive)
	Return __DefineStub("DriveStatus", __CallArgs("sDrive = " & $sDrive), $DS_READY)
EndFunc

Func _Stub_DriveGetLabel($sDrive)
	Return __DefineStub("DriveGetLabel", __CallArgs("sDrive = " & $sDrive), "")
EndFunc

Func _Stub_DriveGetType($sDrive)
	Return __DefineStub("DriveGetType", __CallArgs("sDrive = " & $sDrive), "Fixed")
EndFunc

Func _Stub_ConsoleWrite($sText)
	Return __DefineStub("ConsoleWrite", __CallArgs("sText = " & $sText), 1)
EndFunc

Func _Stub_ConsoleWriteError($sText)
	Return __DefineStub("ConsoleWriteError", __CallArgs("sText = " & $sText), 1)
EndFunc

$g_hFn_Sleep              = _Stub_Sleep
$g_hFn_Shutdown           = _Stub_Shutdown
$g_hFn_IsAdmin            = _Stub_IsAdmin
$g_hFn_EnvGet             = _Stub_EnvGet
$g_hFn_EnvSet             = _Stub_EnvSet
$g_hFn_DriveGetDrive      = _Stub_DriveGetDrive
$g_hFn_DriveGetFileSystem = _Stub_DriveGetFileSystem
$g_hFn_DriveSpaceFree     = _Stub_DriveSpaceFree
$g_hFn_DriveSpaceTotal    = _Stub_DriveSpaceTotal
$g_hFn_DriveStatus        = _Stub_DriveStatus
$g_hFn_DriveGetLabel      = _Stub_DriveGetLabel
$g_hFn_DriveGetType       = _Stub_DriveGetType
$g_hFn_ConsoleWrite       = _Stub_ConsoleWrite
$g_hFn_ConsoleWriteError  = _Stub_ConsoleWriteError
