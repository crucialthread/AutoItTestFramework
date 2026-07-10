; #INDEX# =======================================================================================================================
; Title .........: TestFrameworkInstaller.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Installation wizard for AutoIt Test Framework.
;                  Copies TestFramework.au3 to the AutoIt Vendor include folder and registers
;                  the path in the AutoIt include registry so the library is available from
;                  any project via #include <TestFramework.au3>.
;                  Detects the AutoIt installation folder from the registry.
;                  Detects existing installations and offers to upgrade.
;                  Registers itself in Add/Remove Programs for uninstall support.
; Note ..........: Requires administrator rights to write to Program Files.
; Note ..........: TestFramework.au3 is embedded into the compiled .exe via FileInstall at
;                  compile time. The compiled .exe is fully self-contained and can be run
;                  from any location.
; ===============================================================================================================================

#RequireAdmin
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

; ===============================================================================================================================
; Constants
; ===============================================================================================================================

Global Const $INSTALLER_TITLE   = "AutoIt Test Framework Setup"
Global Const $INSTALLER_VERSION = "0.0.1"
Global Const $WIN_WIDTH         = 540
Global Const $WIN_HEIGHT        = 345
Global Const $FONT_FACE         = "Segoe UI"
Global Const $FONT_SIZE         = 11
Global Const $BTN_W             = 130
Global Const $BTN_H             = 34
Global Const $BTN_GAP           = 10
Global Const $BTN_Y             = $WIN_HEIGHT - 48
Global Const $FOOTER_SEP_Y      = $WIN_HEIGHT - 58
Global Const $HEADER_H          = 70
Global Const $CONTENT_TOP       = $HEADER_H + 10
Global Const $CONTENT_W         = $WIN_WIDTH - 40

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

; ===============================================================================================================================
; Entry point
; ===============================================================================================================================

_Main()

Func _Main()
    __DetectPaths()
    __CheckExistingInstall()
    __RunWizard()
EndFunc

; ===============================================================================================================================
; Detection
; ===============================================================================================================================

Func __DetectPaths()
    $g_sAutoItDir = RegRead($REG_AUTOIT_KEY_WOW, "InstallDir")
    If @error Then $g_sAutoItDir = RegRead($REG_AUTOIT_KEY, "InstallDir")
    If @error Then $g_sAutoItDir = "C:\Program Files (x86)\AutoIt3"

    $g_sIncludePath = $g_sAutoItDir & "\Include\Vendor"
    $g_sChmPath     = $g_sAutoItDir & "\TestFramework"
EndFunc

Func __CheckExistingInstall()
    Local $sExistingVersion = RegRead($REG_INSTALL_KEY, "Version")
    $g_bIsUpgrade = Not @error And $sExistingVersion <> ""

    If $g_bIsUpgrade Then
        Local $sExistingInclude = RegRead($REG_INSTALL_KEY, "IncludePath")
        Local $sExistingChm     = RegRead($REG_INSTALL_KEY, "ChmPath")
        If Not @error And FileExists($sExistingInclude) Then $g_sIncludePath = $sExistingInclude
        If Not @error And FileExists($sExistingChm)     Then $g_sChmPath     = $sExistingChm
    EndIf
EndFunc

; ===============================================================================================================================
; Wizard
; ===============================================================================================================================

Func __RunWizard()
    Local $hWin = GUICreate($INSTALLER_TITLE, $WIN_WIDTH, $WIN_HEIGHT, -1, -1, _
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

    ; --- Footer buttons (centered group: Cancel | Back | Next) ---
    Local $iTotalBtnW = (3 * $BTN_W) + (2 * $BTN_GAP)
    Local $iBtnStartX = ($WIN_WIDTH - $iTotalBtnW) / 2
    Local $idBtnCancel = GUICtrlCreateButton("Cancel",  $iBtnStartX,                          $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnBack   = GUICtrlCreateButton("< Back",  $iBtnStartX + $BTN_W + $BTN_GAP,      $BTN_Y, $BTN_W, $BTN_H)
    Local $idBtnNext   = GUICtrlCreateButton("Next >",  $iBtnStartX + 2 * ($BTN_W + $BTN_GAP), $BTN_Y, $BTN_W, $BTN_H)
    GUICtrlSetFont($idBtnCancel, $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetFont($idBtnBack,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetFont($idBtnNext,   $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)

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
        "    #include <TestFramework.au3>" & @CRLF & @CRLF & _
        "Click Next to continue or Cancel to exit."
    $aPage1[0] = GUICtrlCreateLabel($sWelcomeText, 15, $CONTENT_TOP, $CONTENT_W, 240)
    GUICtrlSetFont($aPage1[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage1[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage1[1] = GUICtrlCreateLabel("Version " & $INSTALLER_VERSION, 15, $FOOTER_SEP_Y - 25, 200, 20)
    GUICtrlSetFont($aPage1[1], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetColor($aPage1[1], 0x888888)
    GUICtrlSetBkColor($aPage1[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 2 - Install Path
    ; ===================================================================
    Local $aPage2[4]
    $aPage2[0] = GUICtrlCreateLabel( _
        "TestFramework.au3 will be copied to the folder below." & @CRLF & @CRLF & _
        "A registry entry will be created so AutoIt finds it automatically" & @CRLF & _
        "using #include <TestFramework.au3> from any project.", _
        15, $CONTENT_TOP, $CONTENT_W, 90)
    GUICtrlSetFont($aPage2[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage2[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage2[1] = GUICtrlCreateLabel("Install folder:", 15, $CONTENT_TOP + 105, 200, 22)
    GUICtrlSetFont($aPage2[1], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage2[1], $GUI_BKCOLOR_TRANSPARENT)
    $aPage2[2] = GUICtrlCreateInput($g_sIncludePath, 15, $CONTENT_TOP + 128, $WIN_WIDTH - 115, 28)
    GUICtrlSetFont($aPage2[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    $aPage2[3] = GUICtrlCreateButton("Browse...", $WIN_WIDTH - 95, $CONTENT_TOP + 127, 80, 30)
    GUICtrlSetFont($aPage2[3], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)

    ; ===================================================================
    ; Page 3 - Ready to Install
    ; ===================================================================
    Local $aPage3[2]
    $aPage3[0] = GUICtrlCreateLabel("The following actions will be performed:", 10, $CONTENT_TOP, $WIN_WIDTH - 20, 22)
    GUICtrlSetFont($aPage3[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage3[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage3[1] = GUICtrlCreateLabel("", 10, $CONTENT_TOP + 30, $WIN_WIDTH - 20, $FOOTER_SEP_Y - $CONTENT_TOP - 40)
    GUICtrlSetFont($aPage3[1], 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage3[1], $GUI_BKCOLOR_TRANSPARENT)

    ; ===================================================================
    ; Page 4 - Progress + Finish
    ; ===================================================================
    Local $aPage4[4]
    $aPage4[0] = GUICtrlCreateLabel("", 15, $CONTENT_TOP, $CONTENT_W, 24)
    GUICtrlSetFont($aPage4[0], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage4[0], $GUI_BKCOLOR_TRANSPARENT)
    $aPage4[1] = GUICtrlCreateProgress(15, $CONTENT_TOP + 32, $CONTENT_W, 24)
    $aPage4[2] = GUICtrlCreateLabel("", 15, $CONTENT_TOP + 70, $CONTENT_W, $FOOTER_SEP_Y - ($CONTENT_TOP + 70) - 40)
    GUICtrlSetFont($aPage4[2], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage4[2], $GUI_BKCOLOR_TRANSPARENT)
    $aPage4[3] = GUICtrlCreateCheckbox("Open documentation", 15, $FOOTER_SEP_Y - 32, 220, 24)
    GUICtrlSetFont($aPage4[3], $FONT_SIZE, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    GUICtrlSetBkColor($aPage4[3], $GUI_BKCOLOR_TRANSPARENT)

    ; --- Hide all pages ---
    __HidePage($aPage1)
    __HidePage($aPage2)
    __HidePage($aPage3)
    __HidePage($aPage4)

    GUISetState(@SW_SHOW, $hWin)

    Local $iPage = 1
    __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)

    ; ===================================================================
    ; Event loop
    ; ===================================================================
    While True
        Local $iMsg = GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE, $idBtnCancel
                If $iPage < 4 Then
                    If MsgBox($MB_YESNO + $MB_ICONQUESTION, $INSTALLER_TITLE, _
                        "Are you sure you want to cancel the installation?") = $IDYES Then
                        GUIDelete($hWin)
                        Exit
                    EndIf
                EndIf

            Case $idBtnNext
                Switch $iPage
                    Case 1
                        $iPage = 2

                    Case 2
                        $g_sIncludePath = GUICtrlRead($aPage2[2])
                        __UpdateReadyPage($aPage3[1])
                        $iPage = 3

                    Case 3
                        $iPage = 4
                        GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
                        GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
                        GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
                        __ShowPage($iPage, $aPage1, $aPage2, $aPage3, $aPage4, $idHeaderSub, $idBtnNext, $idBtnBack, $idBtnCancel)
                        __RunInstall($aPage4[0], $aPage4[1])
                        GUICtrlSetData($aPage4[0], "")
                        GUICtrlSetData($aPage4[2], _
                            "AutoIt Test Framework has been successfully installed." & @CRLF & @CRLF & _
                            "You can now use it from any AutoIt project:" & @CRLF & @CRLF & _
                            "    #include <TestFramework.au3>" & @CRLF & @CRLF & _
                            "Thank you for installing AutoIt Test Framework.")
                        GUICtrlSetState($aPage4[3], $GUI_SHOW)
                        GUICtrlSetData($idHeaderSub, "Installation complete")
                        GUICtrlSetData($idBtnNext, "Finish")
                        GUICtrlSetState($idBtnNext, $GUI_ENABLE)
                        $iPage = 5

                    Case 5
                        If GUICtrlRead($aPage4[3]) = $GUI_CHECKED Then
                            ShellExecute($g_sChmPath & "\TestFramework.chm")
                        EndIf
                        GUIDelete($hWin)
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
                Local $sFolder = FileSelectFolder("Select install folder", $g_sIncludePath)
                If Not @error Then GUICtrlSetData($aPage2[2], $sFolder)
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
            GUICtrlSetData($idHeaderSub, $sWelcome)
            GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage1)

        Case 2
            GUICtrlSetData($idHeaderSub, "Choose install folder")
            GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            GUICtrlSetData($idBtnNext, "Next >")
            __ShowPageControls($aPage2)

        Case 3
            GUICtrlSetData($idHeaderSub, "Ready to install")
            GUICtrlSetState($idBtnBack,   $GUI_ENABLE)
            GUICtrlSetState($idBtnNext,   $GUI_ENABLE)
            GUICtrlSetState($idBtnCancel, $GUI_ENABLE)
            GUICtrlSetData($idBtnNext, "Install")
            __ShowPageControls($aPage3)

        Case 4
            GUICtrlSetData($idHeaderSub, "Installing, please wait...")
            GUICtrlSetState($idBtnBack,   $GUI_DISABLE)
            GUICtrlSetState($idBtnNext,   $GUI_DISABLE)
            GUICtrlSetState($idBtnCancel, $GUI_DISABLE)
            GUICtrlSetState($aPage4[3],   $GUI_HIDE)
            __ShowPageControls($aPage4)
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

Func __UpdateReadyPage($idLabel)
    GUICtrlSetFont($idLabel, 10, $FW_NORMAL, $GUI_FONTNORMAL, $FONT_FACE)
    Local $sText = ""
    $sText &= "  - Create folder (if needed):   " & $g_sIncludePath & @CRLF
    $sText &= "  - Copy TestFramework.au3 to:   " & $g_sIncludePath & @CRLF
    $sText &= "  - Create folder (if needed):   " & $g_sChmPath & @CRLF
    $sText &= "  - Copy TestFramework.chm to:   " & $g_sChmPath & @CRLF
    $sText &= "  - Copy TestFrameworkUninstaller.exe to: " & $g_sChmPath & @CRLF
    $sText &= "  - Create AutoIt registry entry for include path"
    GUICtrlSetData($idLabel, $sText)
EndFunc

; ===============================================================================================================================
; Installation logic
; ===============================================================================================================================

Func __RunInstall($idStatusLabel, $idProgress)
    Local $iStep  = 0
    Local $iSteps = 6

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Creating install folders...")
    DirCreate($g_sIncludePath)
    DirCreate($g_sChmPath)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFramework.au3...")
    FileInstall("..\core\TestFramework.au3", $g_sIncludePath & "\TestFramework.au3", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFramework.chm...")
    FileInstall("..\..\chm\TestFramework.chm", $g_sChmPath & "\TestFramework.chm", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Copying TestFrameworkUninstaller.exe...")
    FileInstall("TestFrameworkUninstaller.exe", $g_sChmPath & "\TestFrameworkUninstaller.exe", $FC_OVERWRITE)
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Writing AutoIt include registry entry...")
    __WriteIncludeRegistry()
    $iStep += 1

    __ProgressStep($idStatusLabel, $idProgress, $iStep, $iSteps, "Finalizing installation...")
    __WriteInstallRegistry()
    __WriteUninstallRegistry()

    GUICtrlSetData($idProgress, 100)
EndFunc

Func __ProgressStep($idLabel, $idProgress, $iStep, $iSteps, $sStatus)
    GUICtrlSetData($idLabel, $sStatus)
    GUICtrlSetData($idProgress, Int(($iStep / $iSteps) * 100))
EndFunc

; ===============================================================================================================================
; Registry writers
; ===============================================================================================================================

Func __WriteIncludeRegistry()
    Local $sExisting = RegRead($REG_AUTOIT_INCLUDE, "Include")
    If @error Then $sExisting = ""
    If Not StringInStr($sExisting, $g_sIncludePath) Then
        Local $sNew = ($sExisting = "") ? $g_sIncludePath : $sExisting & ";" & $g_sIncludePath
        RegWrite($REG_AUTOIT_INCLUDE, "Include", "REG_SZ", $sNew)
    EndIf
EndFunc

Func __WriteInstallRegistry()
    RegWrite($REG_INSTALL_KEY, "Version",     "REG_SZ", $INSTALLER_VERSION)
    RegWrite($REG_INSTALL_KEY, "IncludePath", "REG_SZ", $g_sIncludePath)
    RegWrite($REG_INSTALL_KEY, "ChmPath",     "REG_SZ", $g_sChmPath)
EndFunc

Func __WriteUninstallRegistry()
    Local $sUninstallerPath = $g_sChmPath & "\TestFrameworkUninstaller.exe"
    RegWrite($REG_UNINSTALL_KEY, "DisplayName",     "REG_SZ",    "AutoIt Test Framework")
    RegWrite($REG_UNINSTALL_KEY, "DisplayVersion",  "REG_SZ",    $INSTALLER_VERSION)
    RegWrite($REG_UNINSTALL_KEY, "Publisher",       "REG_SZ",    "crucialthread")
    RegWrite($REG_UNINSTALL_KEY, "UninstallString", "REG_SZ",    '"' & $sUninstallerPath & '"')
    RegWrite($REG_UNINSTALL_KEY, "NoModify",        "REG_DWORD", 1)
EndFunc
