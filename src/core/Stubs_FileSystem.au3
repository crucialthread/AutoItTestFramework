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
	Return __DefineStub("FileExists", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_FileDelete($sPath)
	Return __DefineStub("FileDelete", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_FileCopy($sSource, $sDest, $iFlag = 0)
	Return __DefineStub("FileCopy", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
EndFunc

Func _Stub_FileMove($sSource, $sDest, $iFlag = 0)
	Return __DefineStub("FileMove", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
EndFunc

Func _Stub_FileGetAttrib($sPath)
	Return __DefineStub("FileGetAttrib", __CallArgs("sPath = " & $sPath), "")
EndFunc

Func _Stub_FileGetSize($sPath)
	Return __DefineStub("FileGetSize", __CallArgs("sPath = " & $sPath), 0)
EndFunc

Func _Stub_FileGetTime($sPath, $iType = 0, $iFormat = 0)
	Return __DefineStub("FileGetTime", __CallArgs("sPath = " & $sPath, "iType = " & $iType, "iFormat = " & $iFormat), "")
EndFunc

Func _Stub_FileGetVersion($sPath, $sVersion = "FileVersion")
	Return __DefineStub("FileGetVersion", __CallArgs("sPath = " & $sPath), "")
EndFunc

Func _Stub_FileRead($hFile, $iCount = -1)
	Return __DefineStub("FileRead", __CallArgs("hFile = " & $hFile), "")
EndFunc

Func _Stub_FileWrite($hFile, $sText)
	Return __DefineStub("FileWrite", __CallArgs("hFile = " & $hFile, "sText = " & $sText), 1)
EndFunc

Func _Stub_FileOpen($sFilename, $iMode = 0)
	Return __DefineStub("FileOpen", __CallArgs("sFilename = " & $sFilename, "iMode = " & $iMode), 1)
EndFunc

Func _Stub_FileClose($hFile)
	Return __DefineStub("FileClose", __CallArgs("hFile = " & $hFile), 1)
EndFunc

Func _Stub_FileReadLine($hFile, $iLine = -1)
	Return __DefineStub("FileReadLine", __CallArgs("hFile = " & $hFile), "")
EndFunc

Func _Stub_FileWriteLine($hFile, $sLine)
	Return __DefineStub("FileWriteLine", __CallArgs("hFile = " & $hFile, "sLine = " & $sLine), 1)
EndFunc

Func _Stub_FileReadToArray($sFilePath, ByRef $aArray, $iFlags = 0)
	Return __DefineStub("FileReadToArray", __CallArgs("sFilePath = " & $sFilePath), "")
EndFunc

Func _Stub_FileCreateShortcut($sFile, $sLnk, $sWorkDir = "", $sArgs = "", $sDesc = "", $sHotkey = "", $iIconIndex = 0, $iState = @SW_SHOWNORMAL)
	Return __DefineStub("FileCreateShortcut", __CallArgs("sFile = " & $sFile, "sLnk = " & $sLnk), 1)
EndFunc

Func _Stub_FileSetAttrib($sPath, $sAttrib, $iRecurse = 0)
	Return __DefineStub("FileSetAttrib", __CallArgs("sPath = " & $sPath, "sAttrib = " & $sAttrib), 1)
EndFunc

Func _Stub_FileSetTime($sPath, $sTime = "", $iType = -1, $iRecurse = 0)
	Return __DefineStub("FileSetTime", __CallArgs("sPath = " & $sPath, "sTime = " & $sTime), 1)
EndFunc

Func _Stub_DirCreate($sPath)
	Return __DefineStub("DirCreate", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_DirRemove($sPath, $iRecurse = 0)
	Return __DefineStub("DirRemove", __CallArgs("sPath = " & $sPath), 1)
EndFunc

Func _Stub_DirCopy($sSource, $sDest, $iFlag = 0)
	Return __DefineStub("DirCopy", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
EndFunc

Func _Stub_DirMove($sSource, $sDest, $iFlag = 0)
	Return __DefineStub("DirMove", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
EndFunc

Func _Stub_DirGetSize($sPath, $iFlag = 0)
	Return __DefineStub("DirGetSize", __CallArgs("sPath = " & $sPath), 0)
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
