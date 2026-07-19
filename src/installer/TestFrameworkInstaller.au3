#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\img\installer.ico
#AutoIt3Wrapper_Outfile_x64=..\..\.out\TestFrameworkInstaller.exe
#AutoIt3Wrapper_Res_Comment=A simple, lightweight unit test framework for AutoIt
#AutoIt3Wrapper_Res_Description=AutoIt Test Framework Installer
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
; Title .........: AutoIt Test Framework - TestFrameworkInstaller.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Installation wizard for AutoIt Test Framework.
;                  Copies TestFramework.au3 and the Testable/Stubs library files to the
;                  AutoIt Vendor include folder and registers the path in the AutoIt include
;                  registry so the library is available from any project via
;                  #include <TestFramework.au3>.
;                  Detects the AutoIt installation folder from the registry.
;                  Detects existing installations and offers to upgrade.
;                  Registers itself in Add/Remove Programs for uninstall support.
; Note ..........: Requires administrator rights to write to Program Files.
; Note ..........: All files are embedded into the compiled .exe via FileInstall at
;                  compile time. The compiled .exe is fully self-contained.
; ===============================================================================================================================

#pragma compile(ExecLevel, requireAdministrator)
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include "..\core\Testable.au3"

; ===============================================================================================================================
; Constants
; ===============================================================================================================================

Global Const $INSTALLER_TITLE   = "AutoIt Test Framework Setup"
Global Const $INSTALLER_VERSION = "0.0.1"

Global Const $WIN_WIDTH     = 540
Global Const $WIN_HEIGHT    = 345
Global Const $FONT_FACE     = "Segoe UI"
Global Const $FONT_SIZE     = 11
Global Const $BTN_W         = 130
Global Const $BTN_H         = 34
Global Const $BTN_GAP       = 10
Global Const $BTN_Y         = $WIN_HEIGHT - 48
Global Const $FOOTER_SEP_Y  = $WIN_HEIGHT - 58
Global Const $HEADER_H      = 70
Global Const $CONTENT_TOP   = $HEADER_H + 10
Global Const $CONTENT_W     = $WIN_WIDTH - 40

Global Const $REG_UNINSTALL_KEY  = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItTestFramework"
Global Const $REG_INSTALL_KEY    = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt TestFramework"
Global Const $REG_AUTOIT_KEY_WOW = "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\AutoIt v3\AutoIt"
Global Const $REG_AUTOIT_KEY     = "HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt"
Global Const $REG_AUTOIT_INCLUDE = "HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt"

; ===============================================================================================================================
; Global state
; ===============================================================================================================================

Global $g_sAutoItDir   = ""
Global $g_sIncludePath = ""
Global $g_sChmPath     = ""
Global $g_bIsUpgrade   = False

Global $g_hFn_FileInstall = __FileInstall

; ===============================================================================================================================
; Entry point
; ===============================================================================================================================

If Not IsDeclared("__INSTALLER_TEST_MODE") Then
    _Main()
EndIf

Func _Main()
    __DetectPaths()
    __CheckExistingInstall()
    __RunWizard()
EndFunc

; ===============================================================================================================================
; Detection
; ===============================================================================================================================

Func __DetectPaths()
    $g_sAutoItDir = _Tstbl_RegRead($REG_AUTOIT_KEY_WOW, "InstallDir")
    If @error Then $g_sAutoItDir = _Tstbl_RegRead($REG_AUTOIT_KEY, "InstallDir")
    If @error Then $g_sAutoItDir = "C:\Program Files (x86)\AutoIt3"

    $g_sIncludePath = $g_sAutoItDir & "\Include\Vendor"
    $g_sChmPath     = $g_sAutoItDir & "\TestFramework"
EndFunc

Func __CheckExistingInstall()
    Local $sExistingVersion = _Tstbl_RegRead($REG_INSTALL_KEY, "Version")
    $g_bIsUpgrade = Not @error And $sExistingVersion <> ""

    If $g_bIsUpgrade Then
        Local $sExistingInclude = _Tstbl_RegRead($REG_INSTALL_KEY, "IncludePath")
        Local $sExistingChm     = _Tstbl_RegRead($REG_INSTALL_KEY, "ChmPath")
        If Not @error And _Tstbl_FileExists($sExistingInclude) Then $g_sIncludePath = $sExistingInclude
        If Not @error And _Tstbl_FileExists($sExistingChm)     Then $g_sChmPath     = $sExistingChm
    EndIf
EndFunc

; ===============================================================================================================================
; Wizard
; ===============================================================================================================================

Func __RunWizard()
    Local $hWin = _Tstbl_GUICreate($INSTALLER_TITLE, $WIN_WIDTH, $WIN_HEIGHT, -1, -1, _
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
    ; Page 1 - Welcome
    ; ===================================================================
    Local $aPage1[2]
    Local $sWelcomeText = $g_bIsUpgrade ? _
        "Welcome to the AutoIt Test Framework Setup Wizard." & @CRLF & @CRLF & _
        "This wizard will upgrade AutoIt Test Framework on your computer." & @CRLF & @CRLF & _
        "Click Next to continue or Cancel to exit." : _
        "Welcome to the AutoIt Test Framework Setup Wizard." & @CRLF & @CRLF & _
        "This wizard will install AutoIt Test Framework on your computer," & @CRLF & _
        "making it available from any AutoIt project via:" & @CRLF & @CRLF & _
        " #include <TestFramework.au3>" & @CRLF & @CRLF & _
        "Click Next to continue or Cancel to exit."
    $aPage1[0] = _Tstbl_GUICtrlCreateLabel($sWelcomeText, 15, $CONTENT_TOP, $CONTENT_W, 240)
    _Tstbl_GUICtrlSetFont($aPage1[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage1[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage1[1] = _Tstbl_GUICtrlCreateLabel("Version " & $INSTALLER_VERSION, 15, $FOOTER_SEP_Y - 25, 200, 20)
    _Tstbl_GUICtrlSetFont($aPage1[1], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetColor($aPage1[1], 0x888888)
    _Tstbl_GUICtrlSetBkColor($aPage1[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 2 - Install Path
    ; ===================================================================
    Local $aPage2[4]
    $aPage2[0] = _Tstbl_GUICtrlCreateLabel( _
        "TestFramework.au3 will be copied to the folder below." & @CRLF & @CRLF & _
        "A registry entry will be created so AutoIt finds it automatically" & @CRLF & _
        "using #include <TestFramework.au3> from any project.", _
        15, $CONTENT_TOP, $CONTENT_W, 90)
    _Tstbl_GUICtrlSetFont($aPage2[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage2[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage2[1] = _Tstbl_GUICtrlCreateLabel("Install folder:", 15, $CONTENT_TOP + 105, 200, 22)
    _Tstbl_GUICtrlSetFont($aPage2[1], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage2[1], $GUI_BKCOLOR_TRANSPARENT)
    $aPage2[2] = _Tstbl_GUICtrlCreateInput($g_sIncludePath, 15, $CONTENT_TOP + 128, $WIN_WIDTH - 115, 28)
    _Tstbl_GUICtrlSetFont($aPage2[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    $aPage2[3] = _Tstbl_GUICtrlCreateButton("Browse...", $WIN_WIDTH - 95, $CONTENT_TOP + 127, 80, 30)
    _Tstbl_GUICtrlSetFont($aPage2[3], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)

    ; ===================================================================
    ; Page 3 - Ready to Install
    ; ===================================================================
    Local $aPage3[2]
    $aPage3[0] = _Tstbl_GUICtrlCreateLabel("The following actions will be performed:", 10, $CONTENT_TOP, $WIN_WIDTH - 20, 22)
    _Tstbl_GUICtrlSetFont($aPage3[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage3[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage3[1] = _Tstbl_GUICtrlCreateLabel("", 10, $CONTENT_TOP + 30, $WIN_WIDTH - 20, $FOOTER_SEP_Y - $CONTENT_TOP - 40)
    _Tstbl_GUICtrlSetFont($aPage3[1], 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage3[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 4 - Progress + Finish
    ; ===================================================================
    Local $aPage4[4]
    $aPage4[0] = _Tstbl_GUICtrlCreateLabel("", 15, $CONTENT_TOP, $CONTENT_W, 24)
    _Tstbl_GUICtrlSetFont($aPage4[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage4[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage4[1] = _Tstbl_GUICtrlCreateProgress(15, $CONTENT_TOP + 32, $CONTENT_W, 24)
    $aPage4[2] = _Tstbl_GUICtrlCreateLabel("", 15, $CONTENT_TOP + 70, $CONTENT_W, $FOOTER_SEP_Y - ($CONTENT_TOP + 70) - 40)
    _Tstbl_GUICtrlSetFont($aPage4[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage4[2], $GUI_BKCOLOR_TRANSPARENT)
    $aPage4[3] = _Tstbl_GUICtrlCreateCheckbox("Open documentation", 15, $FOOTER_SEP_Y - 32, 220, 24)
    _Tstbl_GUICtrlSetFont($aPage4[3], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    _Tstbl_GUICtrlSetBkColor($aPage4[3], $GUI_BKCOLOR_TRANSPARENT)

    ; --- Hide all pages ---
    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)
    __HidePage($aPage4)

    _Tstbl_GUISetState(@SW_SHOW, $hWin)

    Local $iPage = 1
    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    ; ===================================================================
    ; Event loop
    ; ===================================================================
    While True
        Local $iMsg = _Tstbl_GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE, $idBtnCancel
                If $iPage < 4 Then
                    If _Tstbl_MsgBox($MB_YESNO + $MB_ICONQUESTION, $INSTALLER_TITLE, _
                        "Are you sure you want to cancel the installation?") = $IDYES Then
                        _Tstbl_GUIDelete($hWin)
                        Exit
                    EndIf
                EndIf

            Case $idBtnNext
                Switch $iPage
                    Case 1
                        $iPage = 2

                    Case 2
                        $g_sIncludePath = _Tstbl_GUICtrlRead($aPage2[2])
                        __UpdateReadyPage($aPage3[1])
                        $iPage = 3

                    Case 3
                        $iPage = 4
                        _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
                        _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
                        _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
                        __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                        __RunInstall($aPage4[0], $aPage4[1])
                        _Tstbl_GUICtrlSetData($aPage4[0], "")
                        _Tstbl_GUICtrlSetData($aPage4[2], _
                            "AutoIt Test Framework has been successfully installed." & @CRLF & @CRLF & _
                            "You can now use it from any AutoIt project:" & @CRLF & @CRLF & _
                            " #include <TestFramework.au3>" & @CRLF & @CRLF & _
                            "Thank you for installing AutoIt Test Framework.")
                        _Tstbl_GUICtrlSetState($aPage4[3], $GUI_SHOW)
                        _Tstbl_GUICtrlSetData($idHeaderSub, "Installation complete")
                        _Tstbl_GUICtrlSetData($idBtnNext, "Finish")
                        _Tstbl_GUICtrlSetState($idBtnNext, $GUI_ENABLE)
                        $iPage = 5

                    Case 5
                        If _Tstbl_GUICtrlRead($aPage4[3]) = $GUI_CHECKED Then
                            _Tstbl_ShellExecute($g_sChmPath & "\TestFramework.chm")
                        EndIf
                        _Tstbl_GUIDelete($hWin)
                        Exit
                EndSwitch

                If $iPage <> 5 Then
                    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                EndIf

            Case $idBtnBack
                Switch $iPage
                    Case 2
                        $iPage = 1
                    Case 3
                        $iPage = 2
                EndSwitch
                __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

            Case $aPage2[3]
                Local $sFolder = _Tstbl_FileSelectFolder("Select install folder", $g_sIncludePath)
                If Not @error Then _Tstbl_GUICtrlSetData($aPage2[2], $sFolder)
        EndSwitch
    WEnd
EndFunc

; ===============================================================================================================================
; Page helpers
; ===============================================================================================================================

Func __ShowPage($iPage, ByRef $aPage1, ByRef $aPage2, ByRef $aPage3, ByRef $aPage4, _
    $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)
    __HidePage($aPage4)

    Local $sWelcome = $g_bIsUpgrade ? "Upgrading AutoIt Test Framework" : "Welcome to AutoIt Test Framework Setup"

    Switch $iPage
        Case 1
            _Tstbl_GUICtrlSetData($idHeaderSub, $sWelcome)
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            _Tstbl_GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage1)

        Case 2
            _Tstbl_GUICtrlSetData($idHeaderSub, "Choose install folder")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            _Tstbl_GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage2)

        Case 3
            _Tstbl_GUICtrlSetData($idHeaderSub, "Ready to install")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            _Tstbl_GUICtrlSetData($idBtnNext, "Install")
            __ShowPageControls($aPage3)

        Case 4
            _Tstbl_GUICtrlSetData($idHeaderSub, "Installing, please wait...")
            _Tstbl_GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
            _Tstbl_GUICtrlSetState($aPage4[3],   $GUI_HIDE)
            __ShowPageControls($aPage4)
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

Func __UpdateReadyPage($idLabel)
    _Tstbl_GUICtrlSetFont($idLabel, 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    Local $sText = ""
    $sText &= " - Create folder (if needed): " & $g_sIncludePath & @CRLF
    $sText &= " - Copy TestFramework.au3 to: " & $g_sIncludePath & @CRLF
    $sText &= " - Create folder (if needed): " & $g_sChmPath & @CRLF
    $sText &= " - Copy TestFramework.chm to: " & $g_sChmPath & @CRLF
    $sText &= " - Copy TestFrameworkUninstaller.exe to: " & $g_sChmPath & @CRLF
    $sText &= " - Create AutoIt registry entry for include path"
    _Tstbl_GUICtrlSetData($idLabel, $sText)
EndFunc

; ===============================================================================================================================
; Installation logic
; ===============================================================================================================================

; __FileInstall wraps FileInstall with literal string paths so Aut2Exe can find
; and embed all files at compile time, while still allowing the function to be
; called through $g_hFn_FileInstall and stubbed in tests.
Func __FileInstall($sSrc, $sDest, $iFlag)
    Select
        Case $sSrc = "..\core\TestFramework.au3"
            FileInstall("..\core\TestFramework.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable.au3"
            FileInstall("..\core\Testable.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Clipboard.au3"
            FileInstall("..\core\Testable_Clipboard.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Dialogs.au3"
            FileInstall("..\core\Testable_Dialogs.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_FileSystem.au3"
            FileInstall("..\core\Testable_FileSystem.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_GUI.au3"
            FileInstall("..\core\Testable_GUI.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Ini.au3"
            FileInstall("..\core\Testable_Ini.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Input.au3"
            FileInstall("..\core\Testable_Input.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Network.au3"
            FileInstall("..\core\Testable_Network.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Process.au3"
            FileInstall("..\core\Testable_Process.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Registry.au3"
            FileInstall("..\core\Testable_Registry.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Sound.au3"
            FileInstall("..\core\Testable_Sound.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Splash.au3"
            FileInstall("..\core\Testable_Splash.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_System.au3"
            FileInstall("..\core\Testable_System.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Tray.au3"
            FileInstall("..\core\Testable_Tray.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Testable_Window.au3"
            FileInstall("..\core\Testable_Window.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs.au3"
            FileInstall("..\core\Stubs.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Core.au3"
            FileInstall("..\core\Stubs_Core.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Clipboard.au3"
            FileInstall("..\core\Stubs_Clipboard.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Dialogs.au3"
            FileInstall("..\core\Stubs_Dialogs.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_FileSystem.au3"
            FileInstall("..\core\Stubs_FileSystem.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_GUI.au3"
            FileInstall("..\core\Stubs_GUI.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Ini.au3"
            FileInstall("..\core\Stubs_Ini.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Input.au3"
            FileInstall("..\core\Stubs_Input.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Network.au3"
            FileInstall("..\core\Stubs_Network.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Process.au3"
            FileInstall("..\core\Stubs_Process.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Registry.au3"
            FileInstall("..\core\Stubs_Registry.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Sound.au3"
            FileInstall("..\core\Stubs_Sound.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Splash.au3"
            FileInstall("..\core\Stubs_Splash.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_System.au3"
            FileInstall("..\core\Stubs_System.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Tray.au3"
            FileInstall("..\core\Stubs_Tray.au3", $sDest, $iFlag)
        Case $sSrc = "..\core\Stubs_Window.au3"
            FileInstall("..\core\Stubs_Window.au3", $sDest, $iFlag)
        Case $sSrc = "..\..\chm\TestFramework.chm"
            FileInstall("..\..\chm\TestFramework.chm", $sDest, $iFlag)
        Case $sSrc = "..\..\.out\TestFrameworkUninstaller.exe"
            FileInstall("..\..\.out\TestFrameworkUninstaller.exe", $sDest, $iFlag)
    EndSelect
EndFunc

Func __RunInstall($idStatusLabel, $idProgress)
    Local $iStep  = 0
    Local $iSteps = 9

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Creating install folders...")
    _Tstbl_DirCreate($g_sIncludePath)
    _Tstbl_DirCreate($g_sChmPath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFramework.au3...")
    $g_hFn_FileInstall("..\core\TestFramework.au3", $g_sIncludePath & "\TestFramework.au3", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying Testable library...")
    $g_hFn_FileInstall("..\core\Testable.au3",          $g_sIncludePath & "\Testable.au3",          $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Clipboard.au3", $g_sIncludePath & "\Testable_Clipboard.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Dialogs.au3",  $g_sIncludePath & "\Testable_Dialogs.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_FileSystem.au3", $g_sIncludePath & "\Testable_FileSystem.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_GUI.au3",      $g_sIncludePath & "\Testable_GUI.au3",      $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Ini.au3",      $g_sIncludePath & "\Testable_Ini.au3",      $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Input.au3",    $g_sIncludePath & "\Testable_Input.au3",    $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Network.au3",  $g_sIncludePath & "\Testable_Network.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Process.au3",  $g_sIncludePath & "\Testable_Process.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Registry.au3", $g_sIncludePath & "\Testable_Registry.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Sound.au3",    $g_sIncludePath & "\Testable_Sound.au3",    $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Splash.au3",   $g_sIncludePath & "\Testable_Splash.au3",   $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_System.au3",   $g_sIncludePath & "\Testable_System.au3",   $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Tray.au3",     $g_sIncludePath & "\Testable_Tray.au3",     $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Testable_Window.au3",   $g_sIncludePath & "\Testable_Window.au3",   $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying Stubs library...")
    $g_hFn_FileInstall("..\core\Stubs.au3",          $g_sIncludePath & "\Stubs.au3",          $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Core.au3",     $g_sIncludePath & "\Stubs_Core.au3",     $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Clipboard.au3", $g_sIncludePath & "\Stubs_Clipboard.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Dialogs.au3",  $g_sIncludePath & "\Stubs_Dialogs.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_FileSystem.au3", $g_sIncludePath & "\Stubs_FileSystem.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_GUI.au3",      $g_sIncludePath & "\Stubs_GUI.au3",      $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Ini.au3",      $g_sIncludePath & "\Stubs_Ini.au3",      $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Input.au3",    $g_sIncludePath & "\Stubs_Input.au3",    $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Network.au3",  $g_sIncludePath & "\Stubs_Network.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Process.au3",  $g_sIncludePath & "\Stubs_Process.au3",  $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Registry.au3", $g_sIncludePath & "\Stubs_Registry.au3", $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Sound.au3",    $g_sIncludePath & "\Stubs_Sound.au3",    $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Splash.au3",   $g_sIncludePath & "\Stubs_Splash.au3",   $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_System.au3",   $g_sIncludePath & "\Stubs_System.au3",   $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Tray.au3",     $g_sIncludePath & "\Stubs_Tray.au3",     $FC_OVERWRITE)
    $g_hFn_FileInstall("..\core\Stubs_Window.au3",   $g_sIncludePath & "\Stubs_Window.au3",   $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFramework.chm...")
    $g_hFn_FileInstall("..\..\chm\TestFramework.chm", $g_sChmPath & "\TestFramework.chm", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFrameworkUninstaller.exe...")
    $g_hFn_FileInstall("..\..\.out\TestFrameworkUninstaller.exe", $g_sChmPath & "\TestFrameworkUninstaller.exe", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Writing AutoIt include registry entry...")
    __WriteIncludeRegistry()
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Finalizing installation...")
    __WriteInstallRegistry()
    __WriteUninstallRegistry()
    $iStep += 1

    _Tstbl_GUICtrlSetData($idProgress, 100)
EndFunc

Func __ProgressStep($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
    _Tstbl_GUICtrlSetData($idLabel,    $sStatus)
    _Tstbl_GUICtrlSetData($idProgress, Int(($iStep / $iSteps) * 100))
EndFunc

; ===============================================================================================================================
; Registry writers
; ===============================================================================================================================

Func __WriteIncludeRegistry()
    Local $sExisting = _Tstbl_RegRead($REG_AUTOIT_INCLUDE, "Include")
    If @error Then $sExisting = ""
    If Not StringInStr($sExisting, $g_sIncludePath) Then
        Local $sNew = ($sExisting = "") ? $g_sIncludePath : $sExisting & ";" & $g_sIncludePath
        _Tstbl_RegWrite($REG_AUTOIT_INCLUDE, "Include", "REG_SZ", $sNew)
    EndIf
EndFunc

Func __WriteInstallRegistry()
    _Tstbl_RegWrite($REG_INSTALL_KEY, "Version",     "REG_SZ", $INSTALLER_VERSION)
    _Tstbl_RegWrite($REG_INSTALL_KEY, "IncludePath", "REG_SZ", $g_sIncludePath)
    _Tstbl_RegWrite($REG_INSTALL_KEY, "ChmPath",     "REG_SZ", $g_sChmPath)
EndFunc

Func __WriteUninstallRegistry()
    Local $sUninstallerPath = $g_sChmPath & "\TestFrameworkUninstaller.exe"
    _Tstbl_RegWrite($REG_UNINSTALL_KEY, "DisplayName",     "REG_SZ",    "AutoIt Test Framework")
    _Tstbl_RegWrite($REG_UNINSTALL_KEY, "DisplayVersion",  "REG_SZ",    $INSTALLER_VERSION)
    _Tstbl_RegWrite($REG_UNINSTALL_KEY, "Publisher",       "REG_SZ",    "crucialthread")
    _Tstbl_RegWrite($REG_UNINSTALL_KEY, "UninstallString", "REG_SZ",    '"' & $sUninstallerPath & '"')
    _Tstbl_RegWrite($REG_UNINSTALL_KEY, "NoModify",        "REG_DWORD", 1)
EndFunc
