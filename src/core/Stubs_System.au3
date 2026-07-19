; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_System.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt system functions.
;                  Can be included directly or via Stubs.au3
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_Sleep($iDelay)
    __StubInitType("Sleep")
    Local $iIdx = $g_StubCalls["Sleep"].count + 1
    Local $oCall[]
    $oCall["iDelay"] = $iDelay
    $g_StubCalls["Sleep"][$iIdx] = $oCall
    $g_StubCalls["Sleep"].count  = $iIdx
EndFunc

Func _Stub_Shutdown($iCode)
    __StubInitType("Shutdown")
    Local $iIdx = $g_StubCalls["Shutdown"].count + 1
    Local $oCall[]
    $oCall["iCode"] = $iCode
    $g_StubCalls["Shutdown"][$iIdx] = $oCall
    $g_StubCalls["Shutdown"].count  = $iIdx
EndFunc

Func _Stub_IsAdmin()
    __StubInitType("IsAdmin")
    Local $iIdx = $g_StubCalls["IsAdmin"].count + 1
    Local $oCall[]
    $g_StubCalls["IsAdmin"][$iIdx] = $oCall
    $g_StubCalls["IsAdmin"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["IsAdmin"], $iIdx) ? $g_StubReturns["IsAdmin"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_EnvGet($sEnvVarName)
    __StubInitType("EnvGet")
    Local $iIdx = $g_StubCalls["EnvGet"].count + 1
    Local $oCall[]
    $oCall["sEnvVarName"] = $sEnvVarName
    $g_StubCalls["EnvGet"][$iIdx] = $oCall
    $g_StubCalls["EnvGet"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["EnvGet"], $iIdx) ? $g_StubReturns["EnvGet"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_EnvSet($sEnvVarName, $sValue = "")
    __StubInitType("EnvSet")
    Local $iIdx = $g_StubCalls["EnvSet"].count + 1
    Local $oCall[]
    $oCall["sEnvVarName"] = $sEnvVarName
    $oCall["sValue"]      = $sValue
    $g_StubCalls["EnvSet"][$iIdx] = $oCall
    $g_StubCalls["EnvSet"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["EnvSet"], $iIdx) ? $g_StubReturns["EnvSet"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DriveGetDrive($sType = "ALL")
    __StubInitType("DriveGetDrive")
    Local $iIdx = $g_StubCalls["DriveGetDrive"].count + 1
    Local $oCall[]
    $oCall["sType"] = $sType
    $g_StubCalls["DriveGetDrive"][$iIdx] = $oCall
    $g_StubCalls["DriveGetDrive"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["DriveGetDrive"], $iIdx) ? $g_StubReturns["DriveGetDrive"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_DriveGetFileSystem($sDrive)
    __StubInitType("DriveGetFileSystem")
    Local $iIdx = $g_StubCalls["DriveGetFileSystem"].count + 1
    Local $oCall[]
    $oCall["sDrive"] = $sDrive
    $g_StubCalls["DriveGetFileSystem"][$iIdx] = $oCall
    $g_StubCalls["DriveGetFileSystem"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["DriveGetFileSystem"], $iIdx) ? $g_StubReturns["DriveGetFileSystem"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_DriveSpaceFree($sPath)
    __StubInitType("DriveSpaceFree")
    Local $iIdx = $g_StubCalls["DriveSpaceFree"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["DriveSpaceFree"][$iIdx] = $oCall
    $g_StubCalls["DriveSpaceFree"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["DriveSpaceFree"], $iIdx) ? $g_StubReturns["DriveSpaceFree"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_DriveSpaceTotal($sPath)
    __StubInitType("DriveSpaceTotal")
    Local $iIdx = $g_StubCalls["DriveSpaceTotal"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["DriveSpaceTotal"][$iIdx] = $oCall
    $g_StubCalls["DriveSpaceTotal"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["DriveSpaceTotal"], $iIdx) ? $g_StubReturns["DriveSpaceTotal"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_DriveStatus($sDrive)
    __StubInitType("DriveStatus")
    Local $iIdx = $g_StubCalls["DriveStatus"].count + 1
    Local $oCall[]
    $oCall["sDrive"] = $sDrive
    $g_StubCalls["DriveStatus"][$iIdx] = $oCall
    $g_StubCalls["DriveStatus"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["DriveStatus"], $iIdx) ? $g_StubReturns["DriveStatus"][$iIdx] : "READY"
    Return $sReturn
EndFunc

Func _Stub_DriveGetLabel($sDrive)
    __StubInitType("DriveGetLabel")
    Local $iIdx = $g_StubCalls["DriveGetLabel"].count + 1
    Local $oCall[]
    $oCall["sDrive"] = $sDrive
    $g_StubCalls["DriveGetLabel"][$iIdx] = $oCall
    $g_StubCalls["DriveGetLabel"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["DriveGetLabel"], $iIdx) ? $g_StubReturns["DriveGetLabel"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_DriveGetType($sDrive)
    __StubInitType("DriveGetType")
    Local $iIdx = $g_StubCalls["DriveGetType"].count + 1
    Local $oCall[]
    $oCall["sDrive"] = $sDrive
    $g_StubCalls["DriveGetType"][$iIdx] = $oCall
    $g_StubCalls["DriveGetType"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["DriveGetType"], $iIdx) ? $g_StubReturns["DriveGetType"][$iIdx] : ""
    Return $sReturn
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
