; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - Stubs.au3 library
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Includes Stubs_Core.au3 and all Stubs_*.au3 category files.
;                  Include this file in test code to automatically wire all function pointers to their stubs.
; Usage .........: #include "Stubs.au3"
;                  Use _ResetStubs() between tests to clear all recorded calls and returns.
;                  Use _SetStubReturn($sType, $iIdx, $vValue) to pre-configure return values.
;                  Use _StubCallCount($sType) to verify how many times a function was called.
;                  Use _StubCall($sType, $iIdx, $sProperty) to inspect a specific call.
; ===============================================================================================================================

#include-once

#include "Stubs_Core.au3"
#include "Stubs_Dialogs.au3"
#include "Stubs_FileSystem.au3"
#include "Stubs_Ini.au3"
#include "Stubs_Registry.au3"
#include "Stubs_Process.au3"
#include "Stubs_GUI.au3"
#include "Stubs_Network.au3"
#include "Stubs_System.au3"
#include "Stubs_Clipboard.au3"
#include "Stubs_Input.au3"
#include "Stubs_Window.au3"
#include "Stubs_Splash.au3"
#include "Stubs_Sound.au3"
#include "Stubs_Tray.au3"
