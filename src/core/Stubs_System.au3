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
	Local $vReturn = __DefineStub("Sleep", __CallArgs("iDelay = " & $iDelay))
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_Shutdown($iCode)
	Local $vReturn = __DefineStub("Shutdown", __CallArgs("iCode = " & $iCode), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_IsAdmin()
	Local $vReturn = __DefineStub("IsAdmin", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_EnvGet($sEnvVarName)
	Local $vReturn = __DefineStub("EnvGet", __CallArgs("sEnvVarName = " & $sEnvVarName), $sEnvVarName)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_EnvSet($sEnvVarName, $sValue = "")
	Local $vReturn = __DefineStub("EnvSet", __CallArgs("sEnvVarName = " & $sEnvVarName, "sValue = " & $sValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveGetDrive($sType = "ALL")
	Local $vReturn = __DefineStub("DriveGetDrive", __CallArgs("sType = " & $sType), "")
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveGetFileSystem($sDrive)
	Local $vReturn = __DefineStub("DriveGetFileSystem", __CallArgs("sDrive = " & $sDrive), $DT_NTFS)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveSpaceFree($sPath)
	Local $vReturn = __DefineStub("DriveSpaceFree", __CallArgs("sPath = " & $sPath), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveSpaceTotal($sPath)
	Local $vReturn = __DefineStub("DriveSpaceTotal", __CallArgs("sPath = " & $sPath), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveStatus($sDrive)
	Local $vReturn = __DefineStub("DriveStatus", __CallArgs("sDrive = " & $sDrive), $DS_READY)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveGetLabel($sDrive)
	Local $vReturn = __DefineStub("DriveGetLabel", __CallArgs("sDrive = " & $sDrive), "")
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_DriveGetType($sDrive, $iOperation = 1)
	Local $vReturn = __DefineStub("DriveGetType", __CallArgs("sDrive = " & $sDrive), "Fixed")
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_ConsoleWrite($sText)
	Local $vReturn = __DefineStub("ConsoleWrite", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc


Func _Stub_ConsoleWriteError($sText)
	Local $vReturn = __DefineStub("ConsoleWriteError", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
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
