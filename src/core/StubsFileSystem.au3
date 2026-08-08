; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_FileSystem.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt file system functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include "StubsCore.au3"

Func __Stub_FileExists($sPath)
    Local $vReturn = __DefineStub("FileExists", __CallArgs("sPath = " & $sPath), 1)
    Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileDelete($sFileName)
	Local $vReturn = __DefineStub("FileDelete", __CallArgs("sFileName = " & $sFileName), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileCopy($sSource, $sDest, $iFlag = 0)
	Local $vReturn = __DefineStub("FileCopy", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest, "iFlag = " & $iFlag), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileMove($sSource, $sDest, $iFlag = 0)
	Local $vReturn = __DefineStub("FileMove", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest, "iFlag = " & $iFlag), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileGetAttrib($sFileName)
	Local $vReturn = __DefineStub("FileGetAttrib", __CallArgs("sFileName = " & $sFileName), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileGetSize($sFileName)
	Local $vReturn = __DefineStub("FileGetSize", __CallArgs("sFileName = " & $sFileName), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileGetTime($sFileName, $iOption = 0, $iFormat = 0)
	Local $vReturn = __DefineStub("FileGetTime", __CallArgs("sFileName = " & $sFileName, "iOption = " & $iOption, "iFormat = " & $iFormat), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileGetVersion($sFileName, $sStringName = "FileVersion")
	Local $vReturn = __DefineStub("FileGetVersion", __CallArgs("sFileName = " & $sFileName, "sStringName = " & $sStringName), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileRead($hFile, $iCount = -1)
	Local $vReturn = __DefineStub("FileRead", __CallArgs("hFile = " & $hFile, "iCount = " & $iCount), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileWrite($hFile, $sText)
	Local $vReturn = __DefineStub("FileWrite", __CallArgs("hFile = " & $hFile, "sText = " & $sText), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileOpen($sFilename, $iMode = 0)
	Local $vReturn = __DefineStub("FileOpen", __CallArgs("sFilename = " & $sFilename, "iMode = " & $iMode), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileClose($hFile)
	Local $vReturn = __DefineStub("FileClose", __CallArgs("hFile = " & $hFile), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileReadLine($hFile, $iLine = 1)
	Local $vReturn = __DefineStub("FileReadLine", __CallArgs("hFile = " & $hFile,"iLine = " & $iLine), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileWriteLine($hFile, $sLine)
	Local $vReturn = __DefineStub("FileWriteLine", __CallArgs("hFile = " & $hFile, "sLine = " & $sLine), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileReadToArray($hFile)
	Local $vReturn = __DefineStub("FileReadToArray", __CallArgs("hFile = " & $hFile), "")
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileCreateShortcut($sFile, $sLnk, $sWorkDir = "", $sArgs = "", $sDesc = "", $sIconFilename = "", $sHotkey = "", $iIconIndex = 0, $iState = @SW_SHOWNORMAL)
	Local $vReturn = __DefineStub("FileCreateShortcut", __CallArgs("sFile = " & $sFile, "sLnk = " & $sLnk), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileSetAttrib($sFilePattern, $sAttrib, $iRecurse = 0)
	Local $vReturn = __DefineStub("FileSetAttrib", __CallArgs("sFilePattern = " & $sFilePattern, "sAttrib = " & $sAttrib), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_FileSetTime($sFilePattern, $sTime = "", $iType = 0, $iRecurse = 0)
	Local $vReturn = __DefineStub("FileSetTime", __CallArgs("sFilePattern = " & $sFilePattern, "sTime = " & $sTime), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DirCreate($sPath)
    Local $vReturn = __DefineStub("DirCreate", __CallArgs("sPath = " & $sPath), 1)
    Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DirRemove($sPath, $iRecurse = 0)
	Local $vReturn = __DefineStub("DirRemove", __CallArgs("sPath = " & $sPath), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DirCopy($sSource, $sDest, $iFlag = 0)
	Local $vReturn = __DefineStub("DirCopy", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DirMove($sSource, $sDest, $iFlag = 0)
	Local $vReturn = __DefineStub("DirMove", __CallArgs("sSource = " & $sSource, "sDest = " & $sDest), 1)
	Return SetError(@error, 0, $vReturn)
EndFunc

Func __Stub_DirGetSize($sPath, $iFlag = 0)
	Local $vReturn = __DefineStub("DirGetSize", __CallArgs("sPath = " & $sPath), 0)
	Return SetError(@error, 0, $vReturn)
EndFunc

$g_hFn_FileExists         = __Stub_FileExists
$g_hFn_FileDelete         = __Stub_FileDelete
$g_hFn_FileCopy           = __Stub_FileCopy
$g_hFn_FileMove           = __Stub_FileMove
$g_hFn_FileGetAttrib      = __Stub_FileGetAttrib
$g_hFn_FileGetSize        = __Stub_FileGetSize
$g_hFn_FileGetTime        = __Stub_FileGetTime
$g_hFn_FileGetVersion     = __Stub_FileGetVersion
$g_hFn_FileRead           = __Stub_FileRead
$g_hFn_FileWrite          = __Stub_FileWrite
$g_hFn_FileOpen           = __Stub_FileOpen
$g_hFn_FileClose          = __Stub_FileClose
$g_hFn_FileReadLine       = __Stub_FileReadLine
$g_hFn_FileWriteLine      = __Stub_FileWriteLine
$g_hFn_FileReadToArray    = __Stub_FileReadToArray
$g_hFn_FileCreateShortcut = __Stub_FileCreateShortcut
$g_hFn_FileSetAttrib      = __Stub_FileSetAttrib
$g_hFn_FileSetTime        = __Stub_FileSetTime
$g_hFn_DirCreate          = __Stub_DirCreate
$g_hFn_DirRemove          = __Stub_DirRemove
$g_hFn_DirCopy            = __Stub_DirCopy
$g_hFn_DirMove            = __Stub_DirMove
$g_hFn_DirGetSize         = __Stub_DirGetSize
