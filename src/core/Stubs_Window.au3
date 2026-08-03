; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs_Window.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub implementations for AutoIt window management functions.
;                  Can be included directly or via Stubs.au3.
; ===============================================================================================================================

#include-once
#include <AutoItConstants.au3>
#include "Stubs_Core.au3"

Func _Stub_WinExists($sTitle, $sText = "")
	Return __DefineStub("WinExists", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinActive($sTitle, $sText = "")
	Return __DefineStub("WinActive", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinActivate($sTitle, $sText = "")
	Return __DefineStub("WinActivate", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinWait($sTitle, $sText = "", $iTimeout = 0)
	Return __DefineStub("WinWait", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinWaitActive($sTitle, $sText = "", $iTimeout = 0)
	Return __DefineStub("WinWaitActive", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinWaitClose($sTitle, $sText = "", $iTimeout = 0)
	Return __DefineStub("WinWaitClose", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinClose($sTitle, $sText = "")
	Return __DefineStub("WinClose", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinKill($sTitle, $sText = "")
	Return __DefineStub("WinKill", __CallArgs("sTitle = " & $sTitle), 1)
EndFunc

Func _Stub_WinGetText($sTitle, $sText = "")
	Return __DefineStub("WinGetText", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), $sText)
EndFunc

Func _Stub_WinGetTitle($sTitle, $sText = "")
	Return __DefineStub("WinGetTitle", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), $sTitle)
EndFunc

Func _Stub_WinGetState($sTitle, $sText = "")
	Return __DefineStub("WinGetState", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), $WIN_STATE_EXISTS)
EndFunc

Func _Stub_WinSetState($sTitle, $sText, $iFlags)
	Return __DefineStub("WinSetState", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "iFlags = " & $iFlags), 1)
EndFunc

Func _Stub_WinSetTitle($sTitle, $sText, $sNewTitle)
	Return __DefineStub("WinSetTitle", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "sNewTitle = " & $sNewTitle), 1)
EndFunc

Func _Stub_WinMove($sTitle, $sText, $iX, $iY, $iWidth = -1, $iHeight = -1)
	Return __DefineStub("WinMove", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText, "iX = " & $iX, "iY = " & $iY), 1)
EndFunc

Func _Stub_WinGetPos($sTitle, $sText = "")
	Return __DefineStub("WinGetPos", __CallArgs("sTitle = " & $sTitle, "sText = " & $sText), "")
EndFunc

$g_hFn_WinExists       = _Stub_WinExists
$g_hFn_WinActive       = _Stub_WinActive
$g_hFn_WinActivate     = _Stub_WinActivate
$g_hFn_WinWait         = _Stub_WinWait
$g_hFn_WinWaitActive   = _Stub_WinWaitActive
$g_hFn_WinWaitClose    = _Stub_WinWaitClose
$g_hFn_WinClose        = _Stub_WinClose
$g_hFn_WinKill         = _Stub_WinKill
$g_hFn_WinGetText      = _Stub_WinGetText
$g_hFn_WinGetTitle     = _Stub_WinGetTitle
$g_hFn_WinGetState     = _Stub_WinGetState
$g_hFn_WinSetState     = _Stub_WinSetState
$g_hFn_WinSetTitle     = _Stub_WinSetTitle
$g_hFn_WinMove         = _Stub_WinMove
$g_hFn_WinGetPos       = _Stub_WinGetPos
