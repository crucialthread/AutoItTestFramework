; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Testable_Window.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Testable wrappers for AutoIt window management functions.
;                  Can be included directly or via Testable.au3
; ===============================================================================================================================

#include-once

Global $g_hFn_WinExists       = WinExists
Global $g_hFn_WinActive       = WinActive
Global $g_hFn_WinActivate     = WinActivate
Global $g_hFn_WinWait         = WinWait
Global $g_hFn_WinWaitActive   = WinWaitActive
Global $g_hFn_WinWaitClose    = WinWaitClose
Global $g_hFn_WinClose        = WinClose
Global $g_hFn_WinKill         = WinKill
Global $g_hFn_WinGetText      = WinGetText
Global $g_hFn_WinGetTitle     = WinGetTitle
Global $g_hFn_WinGetState     = WinGetState
Global $g_hFn_WinSetState     = WinSetState
Global $g_hFn_WinSetTitle     = WinSetTitle
Global $g_hFn_WinMove         = WinMove
Global $g_hFn_WinGetPos       = WinGetPos

Func _Tstbl_WinExists($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinExists($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinActive($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinActive($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinActivate($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinActivate($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinWait($sTitle, $sText = "", $iTimeout = 0)
    Local $vResult = $g_hFn_WinWait($sTitle, $sText, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinWaitActive($sTitle, $sText = "", $iTimeout = 0)
    Local $vResult = $g_hFn_WinWaitActive($sTitle, $sText, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinWaitClose($sTitle, $sText = "", $iTimeout = 0)
    Local $vResult = $g_hFn_WinWaitClose($sTitle, $sText, $iTimeout)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinClose($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinClose($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinKill($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinKill($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinGetText($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinGetText($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinGetTitle($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinGetTitle($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinGetState($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinGetState($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinSetState($sTitle, $sText, $iFlags)
    Local $vResult = $g_hFn_WinSetState($sTitle, $sText, $iFlags)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinSetTitle($sTitle, $sText, $sNewTitle)
    Local $vResult = $g_hFn_WinSetTitle($sTitle, $sText, $sNewTitle)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinMove($sTitle, $sText, $iX, $iY, $iWidth = -1, $iHeight = -1)
    Local $vResult = $g_hFn_WinMove($sTitle, $sText, $iX, $iY, $iWidth, $iHeight)
    Return SetError(@error, @extended, $vResult)
EndFunc

Func _Tstbl_WinGetPos($sTitle, $sText = "")
    Local $vResult = $g_hFn_WinGetPos($sTitle, $sText)
    Return SetError(@error, @extended, $vResult)
EndFunc
