; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_FileSystem.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt file system functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_FileExists         = FileExists
Global $g_hFn_FileDelete         = FileDelete
Global $g_hFn_FileCopy           = FileCopy
Global $g_hFn_FileMove           = FileMove
Global $g_hFn_FileGetAttrib      = FileGetAttrib
Global $g_hFn_FileGetSize        = FileGetSize
Global $g_hFn_FileGetTime        = FileGetTime
Global $g_hFn_FileGetVersion     = FileGetVersion
Global $g_hFn_FileRead           = FileRead
Global $g_hFn_FileWrite          = FileWrite
Global $g_hFn_FileOpen           = FileOpen
Global $g_hFn_FileClose          = FileClose
Global $g_hFn_FileReadLine       = FileReadLine
Global $g_hFn_FileWriteLine      = FileWriteLine
Global $g_hFn_FileReadToArray    = FileReadToArray
Global $g_hFn_FileCreateShortcut = FileCreateShortcut
Global $g_hFn_FileSetAttrib      = FileSetAttrib
Global $g_hFn_FileSetTime        = FileSetTime
Global $g_hFn_DirCreate          = DirCreate
Global $g_hFn_DirRemove          = DirRemove
Global $g_hFn_DirCopy            = DirCopy
Global $g_hFn_DirMove            = DirMove
Global $g_hFn_DirGetSize         = DirGetSize

Func _Tstbl_FileExists($sPath)
    Local $vResult = $g_hFn_FileExists($sPath)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileDelete($sFileName)
    Local $vResult = $g_hFn_FileDelete($sFileName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileCopy($sSource, $sDest, $iFlag = 0)
    Local $vResult = $g_hFn_FileCopy($sSource, $sDest, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileMove($sSource, $sDest, $iFlag = 0)
    Local $vResult = $g_hFn_FileMove($sSource, $sDest, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileGetAttrib($sFileName)
    Local $vResult = $g_hFn_FileGetAttrib($sFileName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileGetSize($sFileName)
    Local $vResult = $g_hFn_FileGetSize($sFileName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileGetTime($sFileName, $iOption = 0, $iFormat = 0)
    Local $vResult = $g_hFn_FileGetTime($sFileName, $iOption, $iFormat)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileGetVersion($sFileName, $sStringName = "FileVersion")
    Local $vResult = $g_hFn_FileGetVersion($sFileName, $sStringName)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileRead($hFile, $iCount = -1)
    Local $vResult = $g_hFn_FileRead($hFile, $iCount)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileWrite($hFile, $sText)
    Local $vResult = $g_hFn_FileWrite($hFile, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileOpen($sFilename, $iMode = 0)
    Local $vResult = $g_hFn_FileOpen($sFilename, $iMode)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileClose($hFile)
    Local $vResult = $g_hFn_FileClose($hFile)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileReadLine($hFile, $iLine = 1)
    Local $vResult = $g_hFn_FileReadLine($hFile, $iLine)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileWriteLine($hFile, $sLine)
    Local $vResult = $g_hFn_FileWriteLine($hFile, $sLine)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileReadToArray($hFile)
    Local $vResult = $g_hFn_FileReadToArray($hFile)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileCreateShortcut($sFile, $sLnk, $sWorkDir = "", $sArgs = "", $sDesc = "", $sIconFilename = "", $sHotkey = "", $iIconIndex = 0, $iState = @SW_SHOWNORMAL)
    Local $vResult = $g_hFn_FileCreateShortcut($sFile, $sLnk, $sWorkDir, $sArgs, $sDesc, $sHotkey, $iIconIndex, $iState)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileSetAttrib($sFilePattern, $sAttrib, $iRecurse = 0)
    Local $vResult = $g_hFn_FileSetAttrib($sFilePattern, $sAttrib, $iRecurse)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_FileSetTime($sFilePattern, $sTime = "", $iType = 0, $iRecurse = 0)
    Local $vResult = $g_hFn_FileSetTime($sFilePattern, $sTime, $iType, $iRecurse)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DirCreate($sPath)
    Local $vResult = $g_hFn_DirCreate($sPath)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DirRemove($sPath, $iRecurse = 0)
    Local $vResult = $g_hFn_DirRemove($sPath, $iRecurse)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DirCopy($sSource, $sDest, $iFlag = 0)
    Local $vResult = $g_hFn_DirCopy($sSource, $sDest, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DirMove($sSource, $sDest, $iFlag = 0)
    Local $vResult = $g_hFn_DirMove($sSource, $sDest, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_DirGetSize($sPath, $iFlag = 0)
    Local $vResult = $g_hFn_DirGetSize($sPath, $iFlag)
    Return SetError(@error, @extended, $vResult)
EndFunc
