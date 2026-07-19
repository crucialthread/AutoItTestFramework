#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\img\installer.ico
#AutoIt3Wrapper_Outfile_x64=..\..\.out\TestFrameworkUninstaller.exe
#AutoIt3Wrapper_Res_Comment=A simple, lightweight unit test framework for AutoIt
#AutoIt3Wrapper_Res_Description=AutoIt Test Framework Uninstaller
#AutoIt3Wrapper_Res_Fileversion=0.0.1.0
#AutoIt3Wrapper_Res_ProductName=AutoIt Test Framework
#AutoIt3Wrapper_Res_ProductVersion=0.0.1
#AutoIt3Wrapper_Res_CompanyName=Crucial Thread
#AutoIt3Wrapper_Res_LegalCopyright=MIT License
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - TestFrameworkUninstaller.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Uninstaller for AutoIt Test Framework.
;                  Reads installation paths from the registry written by TestFrameworkInstaller.au3,
;                  removes all installed files, cleans up the AutoIt include registry entry,
;                  and removes the Add/Remove Programs entry.
;                  Removes the Vendor folder only if empty after uninstall.
;                  Removes the TestFramework folder only if empty after uninstall.
;                  Removes only the TestFramework path from the AutoIt include registry value
;                  without affecting any other vendor paths registered there.
; Note ..........: Requires administrator rights to delete from Program Files.
; ===============================================================================================================================

#pragma compile(ExecLevel, requireAdministrator)
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>
#include "..\core\Testable.au3"

; ===============================================================================================================================
; Constants
; ===============================================================================================================================

Global Const $UNINSTALLER_TITLE = "AutoIt Test Framework Uninstall"

Global Const $WIN_WIDTH    = 540
Global Const $WIN_HEIGHT   = 345
Global Const $FONT_FACE    = "Segoe UI"
Global Const $FONT_SIZE    = 11
Global Const $BTN_W        = 130
Global Const $BTN_H        = 34
Global Const $BTN_GAP      = 10
Global Const $BTN_Y        = $WIN_HEIGHT - 48
Global Const $FOOTER_SEP_Y = $WIN_HEIGHT - 58
Global Const $HEADER_H     = 70
Global Const $CONTENT_TOP  = $HEADER_H + 10
Global Const $CONTENT_W    = $WIN_WIDTH - 40

Global Const $REG_INSTALL_KEY   = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt TestFramework"
Global Const $REG_UNINSTALL_KEY = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItTestFramework"
Global Const $REG_AUTOIT_INCLUDE = "HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt"

; ===============================================================================================================================
; Global state
; ===============================================================================================================================

Global $g_sIncludePath = ""
Global $g_sChmPath     = ""

; ===============================================================================================================================
; Entry point
; ===============================================================================================================================

If Not IsDeclared("__UNINSTALLER_TEST_MODE") Then
    _Main()
EndIf

Func _Main()
    If Not __ReadInstallRecord() Then
        _Tstbl_MsgBox($MB_OK + $MB_ICONERROR, $UNINSTALLER_TITLE, _
            "AutoIt Test Framework installation record was not found." & @CRLF & @CRLF & _
            "It may have already been uninstalled.")
        Exit
    EndIf

    If StringInStr(StringLower(@ScriptFullPath), StringLower($g_sChmPath)) Then
        Local $sTempExe = @TempDir & "\TestFrameworkUninstaller.exe"
        _Tstbl_FileCopy(@ScriptFullPath, $sTempExe, $FC_OVERWRITE)
        _Tstbl_ShellExecute($sTempExe)
        Exit
    EndIf

    __RunWizard()
EndFunc

; ===============================================================================================================================
; Read install record
; ===============================================================================================================================

Func __ReadInstallRecord()
    $g_sIncludePath = _Tstbl_RegRead($REG_INSTALL_KEY, "IncludePath")
    If @error Then Return False
    $g_sChmPath = _Tstbl_RegRead($REG_INSTALL_KEY, "ChmPath")
    If @error Then Return False
    Return True
EndFunc

; ===============================================================================================================================
; Wizard
; ===============================================================================================================================

Func __RunWizard()
    Local $hWin = _Tstbl_GUICreate($UNINSTALLER_TITLE, $WIN_WIDTH, $WIN_HEIGHT, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX))
    _Tstbl_GUISetBkColor(0xF0F0F0)

    ; --- Header bar ---
    Local $idHeader = _Tstbl_GUICtrlCreateLabel("", 0, 0, $WIN_WIDTH, $HEADER_H)
    _Tstbl_GUICtrlSetBkColor($idHeader, 0xFFFFFF)
    Local $idHeaderTitle = _Tstbl_GUICtrlCreateLabel("AutoIt Test Framework", 15, 12, $WIN_WIDTH - 30, 26)
    _Tstbl_GUICtrlSetFont($idHeaderTitle, 14, $FW_BOLD, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($idHeaderTitle, 0xFFFFFF)
    Local $idHeaderSub = _Tstbl_GUICtrlCreateLabel("", 15, 38, $WIN_WIDTH - 30, 22)
    _Tstbl_GUICtrlSetFont($idHeaderSub, $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetColor($idHeaderSub, 0x444444)
    _Tstbl_GUICtrlSetBkColor($idHeaderSub, 0xFFFFFF)
    Local $idHeaderSep = _Tstbl_GUICtrlCreateLabel("", 0, $HEADER_H, $WIN_WIDTH, 1)
    _Tstbl_GUICtrlSetBkColor($idHeaderSep, 0xCCCCCC)

    ; --- Footer separator ---
    Local $idFooterSep = _Tstbl_GUICtrlCreateLabel("", 0, $FOOTER_SEP_Y, $WIN_WIDTH, 1)
    _Tstbl_GUICtrlSetBkColor($idFooterSep, 0xD0D0D0)

    ; --- Footer buttons ---
    Local $iTotalBtnW  = (3 * $BTN_W) + (2 * $BTN_GAP)
    Local $iBtnStartX  = ($WIN_WIDTH - $iTotalBtnW) / 2
    Local $idBtnCancel = _Tstbl_GUICtrlCreateButton("Cancel", $iBtnStartX,                           $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnBack   = _Tstbl_GUICtrlCreateButton("< Back", $iBtnStartX + $BTN_W + $BTN_GAP,       $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnNext   = _Tstbl_GUICtrlCreateButton("Next >", $iBtnStartX + 2 * ($BTN_W + $BTN_GAP), $BTN_Y, $BTN_W, $BTN_H)
    _Tstbl_GUICtrlSetFont($idBtnCancel, $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetFont($idBtnBack,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetFont($idBtnNext,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)

    ; ===================================================================
    ; Page 1 - Welcome / Confirm
    ; ===================================================================
    Local $aPage1[2]
    $aPage1[0] = _Tstbl_GUICtrlCreateLabel( _
        "This wizard will remove AutoIt Test Framework from your computer." & @CRLF & @CRLF & _
        "Current installation:" & @CRLF & @CRLF & _
        " Library:       " & $g_sIncludePath & @CRLF & _
        " Documentation: " & $g_sChmPath & @CRLF & @CRLF & _
        "Click Next to continue or Cancel to exit.", _
        15, $CONTENT_TOP, $CONTENT_W, $FOOTER_SEP_Y - $CONTENT_TOP - 10)
    _Tstbl_GUICtrlSetFont($aPage1[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage1[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage1[1] = _Tstbl_GUICtrlCreateLabel("", 0, 0, 0, 0)

    ; ===================================================================
    ; Page 2 - Ready to Uninstall
    ; ===================================================================
    Local $aPage2[2]
    $aPage2[0] = _Tstbl_GUICtrlCreateLabel("The following actions will be performed:", 10, $CONTENT_TOP, $WIN_WIDTH - 20, 22)
    _Tstbl_GUICtrlSetFont($aPage2[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage2[0], $GUI_BKCOLOR_TRANSPARENT)
    Local $sReadyText = ""
    $sReadyText &= " - Delete TestFramework.au3 from: " & $g_sIncludePath & @CRLF
    $sReadyText &= " - Remove include path from AutoIt registry entry" & @CRLF
    $sReadyText &= " - Remove Vendor folder if empty" & @CRLF
    $sReadyText &= " - Delete TestFramework.chm from: " & $g_sChmPath & @CRLF
    $sReadyText &= " - Remove TestFramework folder if empty" & @CRLF
    $sReadyText &= " - Remove from Add/Remove Programs"
    $aPage2[1] = _Tstbl_GUICtrlCreateLabel($sReadyText, 10, $CONTENT_TOP + 30, $WIN_WIDTH - 20, $FOOTER_SEP_Y - $CONTENT_TOP - 40)
    _Tstbl_GUICtrlSetFont($aPage2[1], 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage2[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 3 - Progress + Finish
    ; ===================================================================
    Local $aPage3[3]
    $aPage3[0] = _Tstbl_GUICtrlCreateLabel("", 15, $CONTENT_TOP, $CONTENT_W, 24)
    _Tstbl_GUICtrlSetFont($aPage3[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage3[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage3[1] = _Tstbl_GUICtrlCreateProgress(15, $CONTENT_TOP + 32, $CONTENT_W, 24)
    $aPage3[2] = _Tstbl_GUICtrlCreateLabel("", 15, $CONTENT_TOP + 70, $CONTENT_W, $FOOTER_SEP_Y - ($CONTENT_TOP + 70) - 40)
    _Tstbl_GUICtrlSetFont($aPage3[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage3[2], $GUI_BKCOLOR_TRANSPARENT)

    ; --- Hide all pages ---
    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)

    _Tstbl_GUISetState(@SW_SHOW, $hWin)

    Local $iPage = 1
    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    ; ===================================================================
    ; Event loop
    ; ===================================================================
    While True
        Local $iMsg = _Tstbl_GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE, $idBtnCancel
                If $iPage < 3 Then
                    If _Tstbl_MsgBox($MB_YESNO + $MB_ICONQUESTION, $UNINSTALLER_TITLE, _
                        "Are you sure you want to cancel the uninstallation?") = $IDYES Then
                        _Tstbl_GUIDelete($hWin)
                        Exit
                    EndIf
                EndIf

            Case $idBtnNext
                Switch $iPage
                    Case 1
                        $iPage = 2

                    Case 2
                        $iPage = 3
                        _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
                        _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
                        _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
                        __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                        __RunUninstall($aPage3[0], $aPage3[1])
                        _Tstbl_GUICtrlSetData($aPage3[0], "")
                        _Tstbl_GUICtrlSetData($aPage3[2], _
                            "AutoIt Test Framework has been successfully uninstalled." & @CRLF & @CRLF & _
                            "Thank you for using AutoIt Test Framework.")
                        _Tstbl_GUICtrlSetData($idHeaderSub, "Uninstallation complete")
                        _Tstbl_GUICtrlSetData($idBtnNext, "Finish")
                        _Tstbl_GUICtrlSetState($idBtnNext, $GUI_ENABLE)
                        $iPage = 4

                    Case 4
                        _Tstbl_GUIDelete($hWin)
                        Exit
                EndSwitch

                If $iPage <> 4 Then
                    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                EndIf

            Case $idBtnBack
                Switch $iPage
                    Case 2
                        $iPage = 1
                EndSwitch
                __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
        EndSwitch
    WEnd
EndFunc

; ===============================================================================================================================
; Page helpers
; ===============================================================================================================================

Func __ShowPage($iPage, ByRef $aPage1, ByRef $aPage2, ByRef $aPage3, _
    $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)

    Switch $iPage
        Case 1
            _Tstbl_GUICtrlSetData($idHeaderSub, "Welcome to AutoIt Test Framework Uninstall")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            _Tstbl_GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage1)

        Case 2
            _Tstbl_GUICtrlSetData($idHeaderSub, "Ready to uninstall")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            _Tstbl_GUICtrlSetData($idBtnNext, "Uninstall")
            __ShowPageControls($aPage2)

        Case 3
            _Tstbl_GUICtrlSetData($idHeaderSub, "Uninstalling, please wait...")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
            __ShowPageControls($aPage3)
    EndSwitch
EndFunc

Func __HidePage(ByRef $aPage)
    For $i = 0 To UBound($aPage) - 1
        _Tstbl_GUICtrlSetState($aPage[$i], $GUI_HIDE)
    Next
EndFunc

Func __ShowPageControls(ByRef $aPage)
    For $i = 0 To UBound($aPage) - 1
        _Tstbl_GUICtrlSetState($aPage[$i], $GUI_SHOW)
    Next
EndFunc

; ===============================================================================================================================
; Uninstall logic
; ===============================================================================================================================

Func __RunUninstall($idStatusLabel, $idProgress)
    Local $iStep  = 0
    Local $iSteps = 8

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework.au3...")
    _Tstbl_FileDelete($g_sIncludePath & "\TestFramework.au3")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing Testable library...")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Clipboard.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Dialogs.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_FileSystem.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_GUI.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Ini.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Input.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Network.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Process.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Registry.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Sound.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Splash.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_System.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Tray.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Testable_Window.au3")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing Stubs library...")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Core.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Clipboard.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Dialogs.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_FileSystem.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_GUI.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Ini.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Input.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Network.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Process.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Registry.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Sound.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Splash.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_System.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Tray.au3")
    _Tstbl_FileDelete($g_sIncludePath & "\Stubs_Window.au3")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Updating AutoIt include registry entry...")
    __RemoveIncludeRegistry()
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing Vendor folder if empty...")
    __RemoveFolderIfEmpty($g_sIncludePath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework.chm...")
    _Tstbl_FileDelete($g_sChmPath & "\TestFramework.chm")
    _Tstbl_FileDelete($g_sChmPath & "\TestFrameworkUninstaller.exe")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework folder if empty...")
    __RemoveFolderIfEmpty($g_sChmPath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing registry entries...")
    _Tstbl_RegDelete($REG_INSTALL_KEY)
    _Tstbl_RegDelete($REG_UNINSTALL_KEY)

    _Tstbl_GUICtrlSetData($idProgress, 100)
EndFunc

Func __ProgressStep($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
    _Tstbl_GUICtrlSetData($idLabel,    $sStatus)
    _Tstbl_GUICtrlSetData($idProgress, Int(($iStep / $iSteps) * 100))
EndFunc

; ===============================================================================================================================
; Helpers
; ===============================================================================================================================

Func __RemoveIncludeRegistry()
    Local $sExisting = _Tstbl_RegRead($REG_AUTOIT_INCLUDE, "Include")
    If @error Then Return

    Local $aPaths = StringSplit($sExisting, ";", 1)
    Local $sNew = ""
    For $i = 1 To $aPaths[0]
        Local $sPath = StringStripWS($aPaths[$i], 3)
        If $sPath <> "" And StringLower($sPath) <> StringLower($g_sIncludePath) Then
            $sNew &= ($sNew = "") ? $sPath : ";" & $sPath
        EndIf
    Next

    If $sNew = "" Then
        _Tstbl_RegDelete($REG_AUTOIT_INCLUDE, "Include")
    Else
        _Tstbl_RegWrite($REG_AUTOIT_INCLUDE, "Include", "REG_SZ", $sNew)
    EndIf
EndFunc

Func __RemoveFolderIfEmpty($sFolder)
    If Not _Tstbl_FileExists($sFolder) Then Return
    Local $aFiles = _FileListToArray($sFolder)
    If @error Or $aFiles[0] = 0 Then _Tstbl_DirRemove($sFolder)
EndFunc
