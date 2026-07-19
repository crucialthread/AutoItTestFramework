; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_FileSystem.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt file system functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "Stubs_Core.au3"

Func _Stub_FileExists($sPath)
    __StubInitType("FileExists")
    Local $iIdx = $g_StubCalls["FileExists"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["FileExists"][$iIdx] = $oCall
    $g_StubCalls["FileExists"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileExists"], $iIdx) ? $g_StubReturns["FileExists"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileDelete($sPath)
    __StubInitType("FileDelete")
    Local $iIdx = $g_StubCalls["FileDelete"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["FileDelete"][$iIdx] = $oCall
    $g_StubCalls["FileDelete"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileDelete"], $iIdx) ? $g_StubReturns["FileDelete"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileCopy($sSource, $sDest, $iFlag = 0)
    __StubInitType("FileCopy")
    Local $iIdx = $g_StubCalls["FileCopy"].count + 1
    Local $oCall[]
    $oCall["sSource"] = $sSource
    $oCall["sDest"]   = $sDest
    $g_StubCalls["FileCopy"][$iIdx] = $oCall
    $g_StubCalls["FileCopy"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileCopy"], $iIdx) ? $g_StubReturns["FileCopy"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileMove($sSource, $sDest, $iFlag = 0)
    __StubInitType("FileMove")
    Local $iIdx = $g_StubCalls["FileMove"].count + 1
    Local $oCall[]
    $oCall["sSource"] = $sSource
    $oCall["sDest"]   = $sDest
    $g_StubCalls["FileMove"][$iIdx] = $oCall
    $g_StubCalls["FileMove"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileMove"], $iIdx) ? $g_StubReturns["FileMove"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileGetAttrib($sPath)
    __StubInitType("FileGetAttrib")
    Local $iIdx = $g_StubCalls["FileGetAttrib"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["FileGetAttrib"][$iIdx] = $oCall
    $g_StubCalls["FileGetAttrib"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileGetAttrib"], $iIdx) ? $g_StubReturns["FileGetAttrib"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileGetSize($sPath)
    __StubInitType("FileGetSize")
    Local $iIdx = $g_StubCalls["FileGetSize"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["FileGetSize"][$iIdx] = $oCall
    $g_StubCalls["FileGetSize"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["FileGetSize"], $iIdx) ? $g_StubReturns["FileGetSize"][$iIdx] : 0
    Return $iReturn
EndFunc

Func _Stub_FileGetTime($sPath, $iType = 0, $iFormat = 0)
    __StubInitType("FileGetTime")
    Local $iIdx = $g_StubCalls["FileGetTime"].count + 1
    Local $oCall[]
    $oCall["sPath"]   = $sPath
    $oCall["iType"]   = $iType
    $oCall["iFormat"] = $iFormat
    $g_StubCalls["FileGetTime"][$iIdx] = $oCall
    $g_StubCalls["FileGetTime"].count  = $iIdx
    Local $vReturn = MapExists($g_StubReturns["FileGetTime"], $iIdx) ? $g_StubReturns["FileGetTime"][$iIdx] : ""
    Return $vReturn
EndFunc

Func _Stub_FileGetVersion($sPath, $sVersion = "FileVersion")
    __StubInitType("FileGetVersion")
    Local $iIdx = $g_StubCalls["FileGetVersion"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["FileGetVersion"][$iIdx] = $oCall
    $g_StubCalls["FileGetVersion"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileGetVersion"], $iIdx) ? $g_StubReturns["FileGetVersion"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileRead($hFile, $iCount = -1)
    __StubInitType("FileRead")
    Local $iIdx = $g_StubCalls["FileRead"].count + 1
    Local $oCall[]
    $oCall["hFile"] = $hFile
    $g_StubCalls["FileRead"][$iIdx] = $oCall
    $g_StubCalls["FileRead"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileRead"], $iIdx) ? $g_StubReturns["FileRead"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileWrite($hFile, $sText)
    __StubInitType("FileWrite")
    Local $iIdx = $g_StubCalls["FileWrite"].count + 1
    Local $oCall[]
    $oCall["hFile"] = $hFile
    $oCall["sText"] = $sText
    $g_StubCalls["FileWrite"][$iIdx] = $oCall
    $g_StubCalls["FileWrite"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileWrite"], $iIdx) ? $g_StubReturns["FileWrite"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileOpen($sFilename, $iMode = 0)
    __StubInitType("FileOpen")
    Local $iIdx = $g_StubCalls["FileOpen"].count + 1
    Local $oCall[]
    $oCall["sFilename"] = $sFilename
    $oCall["iMode"]     = $iMode
    $g_StubCalls["FileOpen"][$iIdx] = $oCall
    $g_StubCalls["FileOpen"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["FileOpen"], $iIdx) ? $g_StubReturns["FileOpen"][$iIdx] : 1
    Return $iReturn
EndFunc

Func _Stub_FileClose($hFile)
    __StubInitType("FileClose")
    Local $iIdx = $g_StubCalls["FileClose"].count + 1
    Local $oCall[]
    $oCall["hFile"] = $hFile
    $g_StubCalls["FileClose"][$iIdx] = $oCall
    $g_StubCalls["FileClose"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileClose"], $iIdx) ? $g_StubReturns["FileClose"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileReadLine($hFile, $iLine = -1)
    __StubInitType("FileReadLine")
    Local $iIdx = $g_StubCalls["FileReadLine"].count + 1
    Local $oCall[]
    $oCall["hFile"] = $hFile
    $g_StubCalls["FileReadLine"][$iIdx] = $oCall
    $g_StubCalls["FileReadLine"].count  = $iIdx
    Local $sReturn = MapExists($g_StubReturns["FileReadLine"], $iIdx) ? $g_StubReturns["FileReadLine"][$iIdx] : ""
    Return $sReturn
EndFunc

Func _Stub_FileWriteLine($hFile, $sLine)
    __StubInitType("FileWriteLine")
    Local $iIdx = $g_StubCalls["FileWriteLine"].count + 1
    Local $oCall[]
    $oCall["hFile"] = $hFile
    $oCall["sLine"] = $sLine
    $g_StubCalls["FileWriteLine"][$iIdx] = $oCall
    $g_StubCalls["FileWriteLine"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileWriteLine"], $iIdx) ? $g_StubReturns["FileWriteLine"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileReadToArray($sFilePath, ByRef $aArray, $iFlags = 0)
    __StubInitType("FileReadToArray")
    Local $iIdx = $g_StubCalls["FileReadToArray"].count + 1
    Local $oCall[]
    $oCall["sFilePath"] = $sFilePath
    $g_StubCalls["FileReadToArray"][$iIdx] = $oCall
    $g_StubCalls["FileReadToArray"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileReadToArray"], $iIdx) ? $g_StubReturns["FileReadToArray"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileCreateShortcut($sFile, $sLnk, $sWorkDir = "", $sArgs = "", $sDesc = "", $sHotkey = "", $iIconIndex = 0, $iState = @SW_SHOWNORMAL)
    __StubInitType("FileCreateShortcut")
    Local $iIdx = $g_StubCalls["FileCreateShortcut"].count + 1
    Local $oCall[]
    $oCall["sFile"] = $sFile
    $oCall["sLnk"]  = $sLnk
    $g_StubCalls["FileCreateShortcut"][$iIdx] = $oCall
    $g_StubCalls["FileCreateShortcut"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileCreateShortcut"], $iIdx) ? $g_StubReturns["FileCreateShortcut"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileSetAttrib($sPath, $sAttrib, $iRecurse = 0)
    __StubInitType("FileSetAttrib")
    Local $iIdx = $g_StubCalls["FileSetAttrib"].count + 1
    Local $oCall[]
    $oCall["sPath"]    = $sPath
    $oCall["sAttrib"]  = $sAttrib
    $g_StubCalls["FileSetAttrib"][$iIdx] = $oCall
    $g_StubCalls["FileSetAttrib"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileSetAttrib"], $iIdx) ? $g_StubReturns["FileSetAttrib"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_FileSetTime($sPath, $sTime = "", $iType = -1, $iRecurse = 0)
    __StubInitType("FileSetTime")
    Local $iIdx = $g_StubCalls["FileSetTime"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $oCall["sTime"] = $sTime
    $g_StubCalls["FileSetTime"][$iIdx] = $oCall
    $g_StubCalls["FileSetTime"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["FileSetTime"], $iIdx) ? $g_StubReturns["FileSetTime"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DirCreate($sPath)
    __StubInitType("DirCreate")
    Local $iIdx = $g_StubCalls["DirCreate"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["DirCreate"][$iIdx] = $oCall
    $g_StubCalls["DirCreate"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["DirCreate"], $iIdx) ? $g_StubReturns["DirCreate"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DirRemove($sPath, $iRecurse = 0)
    __StubInitType("DirRemove")
    Local $iIdx = $g_StubCalls["DirRemove"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["DirRemove"][$iIdx] = $oCall
    $g_StubCalls["DirRemove"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["DirRemove"], $iIdx) ? $g_StubReturns["DirRemove"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DirCopy($sSource, $sDest, $iFlag = 0)
    __StubInitType("DirCopy")
    Local $iIdx = $g_StubCalls["DirCopy"].count + 1
    Local $oCall[]
    $oCall["sSource"] = $sSource
    $oCall["sDest"]   = $sDest
    $g_StubCalls["DirCopy"][$iIdx] = $oCall
    $g_StubCalls["DirCopy"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["DirCopy"], $iIdx) ? $g_StubReturns["DirCopy"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DirMove($sSource, $sDest, $iFlag = 0)
    __StubInitType("DirMove")
    Local $iIdx = $g_StubCalls["DirMove"].count + 1
    Local $oCall[]
    $oCall["sSource"] = $sSource
    $oCall["sDest"]   = $sDest
    $g_StubCalls["DirMove"][$iIdx] = $oCall
    $g_StubCalls["DirMove"].count  = $iIdx
    Local $bReturn = MapExists($g_StubReturns["DirMove"], $iIdx) ? $g_StubReturns["DirMove"][$iIdx] : True
    Return $bReturn
EndFunc

Func _Stub_DirGetSize($sPath, $iFlag = 0)
    __StubInitType("DirGetSize")
    Local $iIdx = $g_StubCalls["DirGetSize"].count + 1
    Local $oCall[]
    $oCall["sPath"] = $sPath
    $g_StubCalls["DirGetSize"][$iIdx] = $oCall
    $g_StubCalls["DirGetSize"].count  = $iIdx
    Local $iReturn = MapExists($g_StubReturns["DirGetSize"], $iIdx) ? $g_StubReturns["DirGetSize"][$iIdx] : 0
    Return $iReturn
EndFunc

$g_hFn_FileExists        = _Stub_FileExists
$g_hFn_FileDelete        = _Stub_FileDelete
$g_hFn_FileCopy          = _Stub_FileCopy
$g_hFn_FileMove          = _Stub_FileMove
$g_hFn_FileGetAttrib     = _Stub_FileGetAttrib
$g_hFn_FileGetSize       = _Stub_FileGetSize
$g_hFn_FileGetTime       = _Stub_FileGetTime
$g_hFn_FileGetVersion    = _Stub_FileGetVersion
$g_hFn_FileRead          = _Stub_FileRead
$g_hFn_FileWrite         = _Stub_FileWrite
$g_hFn_FileOpen          = _Stub_FileOpen
$g_hFn_FileClose         = _Stub_FileClose
$g_hFn_FileReadLine      = _Stub_FileReadLine
$g_hFn_FileWriteLine     = _Stub_FileWriteLine
$g_hFn_FileReadToArray   = _Stub_FileReadToArray
$g_hFn_FileCreateShortcut = _Stub_FileCreateShortcut
$g_hFn_FileSetAttrib     = _Stub_FileSetAttrib
$g_hFn_FileSetTime       = _Stub_FileSetTime
$g_hFn_DirCreate         = _Stub_DirCreate
$g_hFn_DirRemove         = _Stub_DirRemove
$g_hFn_DirCopy           = _Stub_DirCopy
$g_hFn_DirMove           = _Stub_DirMove
$g_hFn_DirGetSize        = _Stub_DirGetSize
