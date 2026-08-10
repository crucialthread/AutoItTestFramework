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
#include "StubsCore.au3"

Func __Stub_Sleep($iDelay)
	Local $vReturn = __DefineStub("Sleep", __CallArgs("iDelay = " & $iDelay))
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_Shutdown($iCode)
	Local $vReturn = __DefineStub("Shutdown", __CallArgs("iCode = " & $iCode), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_IsAdmin()
	Local $vReturn = __DefineStub("IsAdmin", __CallArgs(), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_EnvGet($sEnvVarName)
	Local $vReturn = __DefineStub("EnvGet", __CallArgs("sEnvVarName = " & $sEnvVarName), $sEnvVarName)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_EnvSet($sEnvVarName, $sValue = "")
	Local $vReturn = __DefineStub("EnvSet", __CallArgs("sEnvVarName = " & $sEnvVarName, "sValue = " & $sValue), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveGetDrive($sType = "ALL")
	Local $vReturn = __DefineStub("DriveGetDrive", __CallArgs("sType = " & $sType), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveGetFileSystem($sPath)
	Local $vReturn = __DefineStub("DriveGetFileSystem", __CallArgs("sPath = " & $sPath), $DT_NTFS)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveSpaceFree($sPath)
	Local $vReturn = __DefineStub("DriveSpaceFree", __CallArgs("sPath = " & $sPath), 1.0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveSpaceTotal($sPath)
	Local $vReturn = __DefineStub("DriveSpaceTotal", __CallArgs("sPath = " & $sPath), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveStatus($sPath)
	Local $vReturn = __DefineStub("DriveStatus", __CallArgs("sPath = " & $sPath), $DS_READY)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveGetLabel($sPath)
	Local $vReturn = __DefineStub("DriveGetLabel", __CallArgs("sPath = " & $sPath), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DriveGetType($sPath, $iOperation = 1)
	Local $vReturn = __DefineStub("DriveGetType", __CallArgs("sPath = " & $sPath, "iOperation = " & $iOperation), "Fixed")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ConsoleWrite($sText)
	Local $vReturn = __DefineStub("ConsoleWrite", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_ConsoleWriteError($sText)
	Local $vReturn = __DefineStub("ConsoleWriteError", __CallArgs("sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_Sleep              = __Stub_Sleep
$g_hFn_Shutdown           = __Stub_Shutdown
$g_hFn_IsAdmin            = __Stub_IsAdmin
$g_hFn_EnvGet             = __Stub_EnvGet
$g_hFn_EnvSet             = __Stub_EnvSet
$g_hFn_DriveGetDrive      = __Stub_DriveGetDrive
$g_hFn_DriveGetFileSystem = __Stub_DriveGetFileSystem
$g_hFn_DriveSpaceFree     = __Stub_DriveSpaceFree
$g_hFn_DriveSpaceTotal    = __Stub_DriveSpaceTotal
$g_hFn_DriveStatus        = __Stub_DriveStatus
$g_hFn_DriveGetLabel      = __Stub_DriveGetLabel
$g_hFn_DriveGetType       = __Stub_DriveGetType
$g_hFn_ConsoleWrite       = __Stub_ConsoleWrite
$g_hFn_ConsoleWriteError  = __Stub_ConsoleWriteError
