; #INDEX# =======================================================================================================================
; Title .........: AutoIt Test Framework - StubConstants.au3
; Version .......: 0.0.1
; AutoIt Version : 3.3.18.0
; Author ........: Crucial Thread
; Description ...: Stub Constants to be included in an AutoIt v3 script test using AutoIt Test Framework
; Note ..........: Const names are case insensitive, so it is possible to use $Param_NewTitle rather than $PARAM_NEWTITLE for ex.
; ===============================================================================================================================

#include-once

; ===============================================================================================================================
; Stub call index enum - 1-based for readability
; ===============================================================================================================================
Global Enum $_1st = 1, $_2nd, $_3rd, $_4th, $_5th, $_6th, $_7th, $_8th, $_9th
Global Enum $_Id1 = 1, $_Id2, $_Id3, $_Id4, $_Id5, $_Id6, $_Id7, $_Id8, $_Id9

; #CONSTANTS# ===================================================================================================================

Global Const $PARAM_DEFAULT = "sDefault"
Global Const $PARAM_DEFAULTNAME = "sDefaultName"
Global Const $PARAM_TITLE = "sTitle"
Global Const $PARAM_NEWTITLE = "sNewTitle"
Global Const $PARAM_TEXT = "sText"
Global Const $PARAM_SUBTEXT = "sSubText"
Global Const $PARAM_MSG = "sMsg"
Global Const $PARAM_STRING = "sString"

Global Const $PARAM_CLIPVALUE = "sClipValue"

Global Const $PARAM_FLAG = "iFlag"
Global Const $PARAM_SHOWFLAG = "iShowFlag"
Global Const $PARAM_OPTFLAG = "nOptFlag"
Global Const $PARAM_OPTION = "iOption"
Global Const $PARAM_OPTIONS = "iOptions"

Global Const $PARAM_STYLE = "iStyle"
Global Const $PARAM_EXSTYLE = "iExStyle"

Global Const $PARAM_WAIT = "iWait"
Global Const $PARAM_TIMEOUT = "iTimeout"
Global Const $PARAM_COUNT = "iCount"

Global Const $PARAM_MODE = "iMode"
Global Const $PARAM_STATE = "iState"
Global Const $PARAM_ADVANCED = "iAdvanced"

Global Const $PARAM_WND = "hWnd"
Global Const $PARAM_WNDPARENT = "hWndParent"
Global Const $PARAM_HANDLE = "hHandle"

Global Const $PARAM_WIDTH = "iWidth"
Global Const $PARAM_HEIGHT = "iHeight"
Global Const $PARAM_LEFT = "iLeft"
Global Const $PARAM_TOP = "iTop"

Global Const $PARAM_XPOS = "iXPos"
Global Const $PARAM_YPOS = "iYPos"

Global Const $PARAM_COLOR = "iColor"

Global Const $PARAM_FONTATTRIBUTE = "iFontAttribute"
Global Const $PARAM_FONTNAME = "sFontName"
Global Const $PARAM_FONTWEIGHT = "iFontWeight"
Global Const $PARAM_FONTQUALITY = "iFontQuality"
Global Const $PARAM_FONTSIZE = "iFontSize"

Global Const $PARAM_TABITEMID = "hTabItemId"
Global Const $PARAM_CONTROLID = "hControlId"
Global Const $PARAM_LISTVIEWID = "hListViewId"
Global Const $PARAM_TREEVIEWID = "hTreeViewId"
Global Const $PARAM_INPUTCONTROLID = "hInputControlId"
Global Const $PARAM_MENUID = "hMenuId"
Global Const $PARAM_PARENTMENUID = "hParentMenuId"

Global Const $PARAM_MENUENTRY = "iMenuEntry"
Global Const $PARAM_MENURADIOITEM = "iMenuRadioItem"
Global Const $PARAM_TOOLTIP = "sTooltip"
Global Const $PARAM_INDEX = "iIndex"
Global Const $PARAM_PROMPT = "sPrompt"
Global Const $PARAM_PASSWORDCHAR = "sPasswordChar"

Global Const $PARAM_SOURCE = "sSource"
Global Const $PARAM_DEST = "sDest"
Global Const $PARAM_INITDIR = "sInitDir"
Global Const $PARAM_ROOTDIR = "sRootDir"
Global Const $PARAM_WORKINGDIR = "sWorkingDir"
Global Const $PARAM_FILTER = "sFilter"

Global Const $PARAM_PATH = "sPath"
Global Const $PARAM_LNK = "sLnk"
Global Const $PARAM_FILE = "sFile"
Global Const $PARAM_FILENAME = "sFileName"
Global Const $PARAM_FILEPATTERN = "sFilePattern"
Global Const $PARAM_FILEATTRIB = "sFileAttrib"
Global Const $PARAM_FILETIME_FORMAT = "iFileTimeFormat"
Global Const $PARAM_FILEINFO = "sFileInfo"
Global Const $PARAM_TIME = "sTime"

Global Const $PARAM_LINE = "iLine"
Global Const $PARAM_TEXTLINE = "sTextLine"

Global Const $PARAM_DATA = "vData"
Global Const $PARAM_VALUE = "sValue"
Global Const $PARAM_PARAMETERS = "sParameters"
Global Const $PARAM_WPARAM = "vWParam"
Global Const $PARAM_LPARAM = "vLParam"

Global Const $PARAM_KEY = "sKey"
Global Const $PARAM_SECTION = "sSection"
Global Const $PARAM_NEWSECTION = "sNewSection"

Global Const $PARAM_KEYNAME = "sKeyName"
Global Const $PARAM_VALUENAME = "sValueName"
Global Const $PARAM_KEYTYPE = "sKeyType"
Global Const $PARAM_KEYINSTANCE = "iKeyInstance"

Global Const $PARAM_URL = "sURL"
Global Const $PARAM_HOST = "sHost"
Global Const $PARAM_BACKGROUND = "iBackground"

Global Const $PARAM_PROCESS = "idProcess" ;hProcess
Global Const $PARAM_PROCESSNAME = "sProcessName"
Global Const $PARAM_SHELLVERB = "sShellVerb"
Global Const $PARAM_PEEK = "bPeek"
Global Const $PARAM_BINARY = "bBinary"

Global Const $PARAM_PERCENT = "iPercent"
Global Const $PARAM_DELAY = "iDelay"
Global Const $PARAM_CODE = "iCode"
Global Const $PARAM_ENVVARNAME = "sEnvVarName"
Global Const $PARAM_DRIVE = "sDrive"
Global Const $PARAM_OPERATION = "iOperation"

Global Const $PARAM_KEYSTROKES = "sKeyStrokes"
Global Const $PARAM_BUTTON = "sButton"
Global Const $PARAM_CLICKS = "iClicks"
Global Const $PARAM_NUMCLICKS = "iNumClicks"
Global Const $PARAM_SPEED = "iSpeed"
