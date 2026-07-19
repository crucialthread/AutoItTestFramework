; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_System.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt system functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_Sleep              = Sleep
Global $g_hFn_Shutdown           = Shutdown
Global $g_hFn_IsAdmin            = IsAdmin
Global $g_hFn_EnvGet             = EnvGet
Global $g_hFn_EnvSet             = EnvSet
Global $g_hFn_DriveGetDrive      = DriveGetDrive
Global $g_hFn_DriveGetFileSystem = DriveGetFileSystem
Global $g_hFn_DriveSpaceFree     = DriveSpaceFree
Global $g_hFn_DriveSpaceTotal    = DriveSpaceTotal
Global $g_hFn_DriveStatus        = DriveStatus
Global $g_hFn_DriveGetLabel      = DriveGetLabel
Global $g_hFn_DriveGetType       = DriveGetType
Global $g_hFn_ConsoleWrite       = ConsoleWrite
Global $g_hFn_ConsoleWriteError  = ConsoleWriteError

Func _Tstbl_Sleep($iDelay)
    Local $vResult = $g_hFn_Sleep($iDelay)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_Shutdown($iCode)
    Local $vResult = $g_hFn_Shutdown($iCode)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_IsAdmin()
    Local $vResult = $g_hFn_IsAdmin()
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_EnvGet($sEnvVarName)
    Local $vResult = $g_hFn_EnvGet($sEnvVarName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_EnvSet($sEnvVarName, $sValue = "")
    Local $vResult = $g_hFn_EnvSet($sEnvVarName, $sValue)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveGetDrive($sType = "ALL")
    Local $vResult = $g_hFn_DriveGetDrive($sType)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveGetFileSystem($sDrive)
    Local $vResult = $g_hFn_DriveGetFileSystem($sDrive)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveSpaceFree($sPath)
    Local $vResult = $g_hFn_DriveSpaceFree($sPath)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveSpaceTotal($sPath)
    Local $vResult = $g_hFn_DriveSpaceTotal($sPath)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveStatus($sDrive)
    Local $vResult = $g_hFn_DriveStatus($sDrive)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveGetLabel($sDrive)
    Local $vResult = $g_hFn_DriveGetLabel($sDrive)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DriveGetType($sDrive)
    Local $vResult = $g_hFn_DriveGetType($sDrive)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ConsoleWrite($sText)
    Local $vResult = $g_hFn_ConsoleWrite($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_ConsoleWriteError($sText)
    Local $vResult = $g_hFn_ConsoleWriteError($sText)
    Return SetError(@error, @extended, $vResult)
EndFunc
