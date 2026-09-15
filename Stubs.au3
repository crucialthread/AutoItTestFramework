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

#include "StubsCore.au3"
#include "StubsDialogs.au3"
#include "StubsFileSystem.au3"
#include "StubsIni.au3"
#include "StubsRegistry.au3"
#include "StubsProcess.au3"
#include "StubsGUI.au3"
#include "StubsNetwork.au3"
#include "StubsSystem.au3"
#include "StubsClipboard.au3"
#include "StubsInput.au3"
#include "StubsWindow.au3"
#include "StubsSplash.au3"
#include "StubsSound.au3"
#include "StubsTray.au3"
#include "StubsFileInstall.au3"
