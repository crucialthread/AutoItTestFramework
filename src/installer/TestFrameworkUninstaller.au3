; #INDEX# =======================================================================================================================
; Title .........: TestFrameworkUninstaller.au3
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
; Note ..........: This script is compiled to TestFrameworkUninstaller.exe by the GitHub Actions
;                  release workflow and embedded in the installer via FileInstall, then copied
;                  to the CHM folder so Add/Remove Programs can find it.
; ===============================================================================================================================

#RequireAdmin
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>

; ===============================================================================================================================
; Constants
; ===============================================================================================================================

Global Const $UNINSTALLER_TITLE  = "AutoIt Test Framework Uninstall"
Global Const $WIN_WIDTH          = 540
Global Const $WIN_HEIGHT         = 345
Global Const $FONT_FACE          = "Segoe UI"
Global Const $FONT_SIZE          = 11
Global Const $BTN_W              = 130
Global Const $BTN_H              = 34
Global Const $BTN_GAP            = 10
Global Const $BTN_Y              = $WIN_HEIGHT - 48
Global Const $FOOTER_SEP_Y       = $WIN_HEIGHT - 58
Global Const $HEADER_H           = 70
Global Const $CONTENT_TOP        = $HEADER_H + 10
Global Const $CONTENT_W          = $WIN_WIDTH - 40

Global Const $REG_INSTALL_KEY    = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt TestFramework"
Global Const $REG_UNINSTALL_KEY  = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItTestFramework"
Global Const $REG_AUTOIT_INCLUDE = "HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt"

; ===============================================================================================================================
; Global state
; ===============================================================================================================================

Global $g_sIncludePath = ""
Global $g_sChmPath     = ""

; ===============================================================================================================================
; Entry point
; ===============================================================================================================================

_Main()

Func _Main()
    If Not __ReadInstallRecord() Then
        MsgBox($MB_OK + $MB_ICONERROR, $UNINSTALLER_TITLE, _
            "AutoIt Test Framework installation record was not found." & @CRLF & @CRLF & _
            "It may have already been uninstalled.")
        Exit
    EndIf
    __RunWizard()
EndFunc

; ===============================================================================================================================
; Read install record
; ===============================================================================================================================

Func __ReadInstallRecord()
    $g_sIncludePath = RegRead($REG_INSTALL_KEY, "IncludePath")
    If @error Then Return False
    $g_sChmPath = RegRead($REG_INSTALL_KEY, "ChmPath")
    If @error Then Return False
    Return True
EndFunc

; ===============================================================================================================================
; Wizard
; ===============================================================================================================================

Func __RunWizard()
    Local $hWin = GUICreate($UNINSTALLER_TITLE, $WIN_WIDTH, $WIN_HEIGHT, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX))
    GUISetBkColor(0xF0F0F0)

    ; --- Header bar ---
    Local $idHeader = GUICtrlCreateLabel("", 0, 0, $WIN_WIDTH, $HEADER_H)
    GUICtrlSetBkColor($idHeader, 0xFFFFFF)
    Local $idHeaderTitle = GUICtrlCreateLabel("AutoIt Test Framework", 15, 12, $WIN_WIDTH - 30, 26)
    GUICtrlSetFont($idHeaderTitle, 14, $FW_BOLD, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($idHeaderTitle, 0xFFFFFF)
    Local $idHeaderSub = GUICtrlCreateLabel("", 15, 38, $WIN_WIDTH - 30, 22)
    GUICtrlSetFont($idHeaderSub, $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetColor($idHeaderSub, 0x444444)
    GUICtrlSetBkColor($idHeaderSub, 0xFFFFFF)
    Local $idHeaderSep = GUICtrlCreateLabel("", 0, $HEADER_H, $WIN_WIDTH, 1)
    GUICtrlSetBkColor($idHeaderSep, 0xCCCCCC)

    ; --- Footer separator ---
    Local $idFooterSep = GUICtrlCreateLabel("", 0, $FOOTER_SEP_Y, $WIN_WIDTH, 1)
    GUICtrlSetBkColor($idFooterSep, 0xD0D0D0)

    ; --- Footer buttons (centered: Cancel | Back | Next/Uninstall/Finish) ---
    Local $iTotalBtnW  = (3 * $BTN_W) + (2 * $BTN_GAP)
    Local $iBtnStartX  = ($WIN_WIDTH - $iTotalBtnW) / 2
    Local $idBtnCancel = GUICtrlCreateButton("Cancel",     $iBtnStartX,                           $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnBack   = GUICtrlCreateButton("< Back",     $iBtnStartX + $BTN_W + $BTN_GAP,       $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnNext   = GUICtrlCreateButton("Next >",     $iBtnStartX + 2 * ($BTN_W + $BTN_GAP), $BTN_Y, $BTN_W, $BTN_H)
    GUICtrlSetFont($idBtnCancel, $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetFont($idBtnBack,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetFont($idBtnNext,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)

    ; ===================================================================
    ; Page 1 - Welcome / Confirm
    ; ===================================================================
    Local $aPage1[2]
    $aPage1[0] = GUICtrlCreateLabel( _
        "This wizard will remove AutoIt Test Framework from your computer." & @CRLF & @CRLF & _
        "Current installation:" & @CRLF & @CRLF & _
        "  Library:       " & $g_sIncludePath & @CRLF & _
        "  Documentation: " & $g_sChmPath & @CRLF & @CRLF & _
        "Click Next to continue or Cancel to exit.", _
        15, $CONTENT_TOP, $CONTENT_W, $FOOTER_SEP_Y - $CONTENT_TOP - 10)
    GUICtrlSetFont($aPage1[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage1[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage1[1] = GUICtrlCreateLabel("", 0, 0, 0, 0) ; placeholder

    ; ===================================================================
    ; Page 2 - Ready to Uninstall
    ; ===================================================================
    Local $aPage2[2]
    $aPage2[0] = GUICtrlCreateLabel("The following actions will be performed:", 10, $CONTENT_TOP, $WIN_WIDTH - 20, 22)
    GUICtrlSetFont($aPage2[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage2[0], $GUI_BKCOLOR_TRANSPARENT)
    Local $sReadyText = ""
    $sReadyText &= "  - Delete TestFramework.au3 from:      " & $g_sIncludePath & @CRLF
    $sReadyText &= "  - Remove include path from AutoIt registry entry" & @CRLF
    $sReadyText &= "  - Remove Vendor folder if empty" & @CRLF
    $sReadyText &= "  - Delete TestFramework.chm from:      " & $g_sChmPath & @CRLF
    $sReadyText &= "  - Remove TestFramework folder if empty" & @CRLF
    $sReadyText &= "  - Remove from Add/Remove Programs"
    $aPage2[1] = GUICtrlCreateLabel($sReadyText, 10, $CONTENT_TOP + 30, $WIN_WIDTH - 20, $FOOTER_SEP_Y - $CONTENT_TOP - 40)
    GUICtrlSetFont($aPage2[1], 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage2[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 3 - Progress + Finish
    ; ===================================================================
    Local $aPage3[3]
    $aPage3[0] = GUICtrlCreateLabel("", 15, $CONTENT_TOP, $CONTENT_W, 24)
    GUICtrlSetFont($aPage3[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage3[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage3[1] = GUICtrlCreateProgress(15, $CONTENT_TOP + 32, $CONTENT_W, 24)
    $aPage3[2] = GUICtrlCreateLabel("", 15, $CONTENT_TOP + 70, $CONTENT_W, $FOOTER_SEP_Y - ($CONTENT_TOP + 70) - 40)
    GUICtrlSetFont($aPage3[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage3[2], $GUI_BKCOLOR_TRANSPARENT)

    ; --- Hide all pages ---
    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)

    GUISetState(@SW_SHOW, $hWin)

    Local $iPage = 1
    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    ; ===================================================================
    ; Event loop
    ; ===================================================================
    While True
        Local $iMsg = GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE, $idBtnCancel
                If $iPage < 3 Then
                    If MsgBox($MB_YESNO + $MB_ICONQUESTION, $UNINSTALLER_TITLE, _
                        "Are you sure you want to cancel the uninstallation?") = $IDYES Then
                        GUIDelete($hWin)
                        Exit
                    EndIf
                EndIf

            Case $idBtnNext
                Switch $iPage
                    Case 1
                        $iPage = 2

                    Case 2
                        $iPage = 3
                        GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
                        GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
                        GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
                        __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                        __RunUninstall($aPage3[0], $aPage3[1])
                        GUICtrlSetData($aPage3[0], "")
                        GUICtrlSetData($aPage3[2], _
                            "AutoIt Test Framework has been successfully uninstalled." & @CRLF & @CRLF & _
                            "Thank you for using AutoIt Test Framework.")
                        GUICtrlSetData($idHeaderSub, "Uninstallation complete")
                        GUICtrlSetData($idBtnNext, "Finish")
                        GUICtrlSetState($idBtnNext, $GUI_ENABLE)
                        $iPage = 4

                    Case 4
                        GUIDelete($hWin)
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
            GUICtrlSetData($idHeaderSub, "Welcome to AutoIt Test Framework Uninstall")
            GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage1)

        Case 2
            GUICtrlSetData($idHeaderSub, "Ready to uninstall")
            GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            GUICtrlSetData($idBtnNext, "Uninstall")
            __ShowPageControls($aPage2)

        Case 3
            GUICtrlSetData($idHeaderSub, "Uninstalling, please wait...")
            GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
            GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
            __ShowPageControls($aPage3)
    EndSwitch
EndFunc

Func __HidePage(ByRef $aPage)
    For $i = 0 To UBound($aPage) - 1
        GUICtrlSetState($aPage[$i], $GUI_HIDE)
    Next
EndFunc

Func __ShowPageControls(ByRef $aPage)
    For $i = 0 To UBound($aPage) - 1
        GUICtrlSetState($aPage[$i], $GUI_SHOW)
    Next
EndFunc

; ===============================================================================================================================
; Uninstall logic
; ===============================================================================================================================

Func __RunUninstall($idStatusLabel, $idProgress)
    Local $iStep  = 0
    Local $iSteps = 6

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework.au3...")
    FileDelete($g_sIncludePath & "\TestFramework.au3")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Updating AutoIt include registry entry...")
    __RemoveIncludeRegistry()
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing Vendor folder if empty...")
    __RemoveFolderIfEmpty($g_sIncludePath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework.chm...")
    FileDelete($g_sChmPath & "\TestFramework.chm")
    FileDelete($g_sChmPath & "\TestFrameworkUninstaller.exe")
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing TestFramework folder if empty...")
    __RemoveFolderIfEmpty($g_sChmPath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Removing registry entries...")
    RegDelete($REG_INSTALL_KEY)
    RegDelete($REG_UNINSTALL_KEY)

    GUICtrlSetData($idProgress, 100)
EndFunc

Func __ProgressStep($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
    GUICtrlSetData($idLabel, $sStatus)
    GUICtrlSetData($idProgress, Int(($iStep / $iSteps) * 100))
EndFunc

; ===============================================================================================================================
; Helpers
; ===============================================================================================================================

; Removes our include path from the semicolon-delimited AutoIt Include registry value.
; Removes the registry value entirely only if it becomes empty after removing our path.
; Leaves any other vendor paths in the value untouched.
Func __RemoveIncludeRegistry()
    Local $sExisting = RegRead($REG_AUTOIT_INCLUDE, "Include")
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
        RegDelete($REG_AUTOIT_INCLUDE, "Include")
    Else
        RegWrite($REG_AUTOIT_INCLUDE, "Include", "REG_SZ", $sNew)
    EndIf
EndFunc

; Deletes $sFolder if it contains no files or subfolders
Func __RemoveFolderIfEmpty($sFolder)
    If Not FileExists($sFolder) Then Return
    Local $aFiles = _FileListToArray($sFolder)
    If @error Or $aFiles[0] = 0 Then DirRemove($sFolder)
EndFunc
