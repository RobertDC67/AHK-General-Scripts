
/*
;•--------------------- NOTES -----------------------------------------------• 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
○------------------------- Base Notes 
» Reload Script-------- DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script------------- DoubleTap--⮚ Ctrl + [Esc] 

» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
○------------------------- Script Specific Notes 
» SOURCE :  
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
○--------------------- NOTES END -----------------------------------------○ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;•--------------------- Auto-Execute ---------------------------------------• 
Gosub, AutoExecute
;○--------------------- Auto-Execute End ---------------------------------○ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 


Menu, Tray, Icon, filemgmt.dll, 1
Menu, Tray, Tip, % A_WinDir "\system32\*.dll's Icons"
Menu, Tray, NoStandard
Menu, Tray, Add, Reload, ReloadMenu
Menu, Tray, Add, Exit, ExitMenu
		
global Count := 350, File := "shell32.dll" 
global Shell32:=1,imageres:=0,pifmgr:=0,ddores:=0,moricons:=0,mmcndmgr:=0,netshell:=0,setupapi:=0,wmploc:=0,compstui:=0,ieframe:=0,accessibilitycpl:=0,mmres:=0,netcenter:=0,networkexplorer:=0,pnidui:=0,sensorscpl:=0,wpdshext:=0,dmdskres:=0,dsuiext:=0,mstscax:=0,wiashext:=0,comres:=0,actioncentercpl:=0,aclui:=0,autoplay:=0,comctl32:=0,filemgmt:=0,url:=0,xwizards:=0

CreateGui:
    Gui, Destroy 
;    Gui, +AlwaysOnTop
    Gui, -Caption
    Gui, -MaximizeBox 
    Gui, Color, SILVER
    Gui, Font, s10
        addRadioButtons()
	
	Gui, Add,ListView,x175 y5 w135 h670 gListClick ,Big Icons 	; List.(image)view for Big Icons
	ImageListID := IL_Create(Count,,1)	
	LV_SetImageList(ImageListID,1)
	loop, % Count
		IL_Add(ImageListID,File,A_Index) 
	loop, % Count
		LV_Add("Icon" A_Index, "     -     " A_Index,2)
	LV_ModifyCol(1,115)			; Adjusting width.
	
	Gui, Add,ListView,x350 y5 w135 h670 gListClick,Small Icons 	; List.(image)view for Small Icons
	ImageListID_small := IL_Create(Count)	
	LV_SetImageList(ImageListID_small)
	loop, % Count
		IL_Add(ImageListID_small,File,A_Index) 
	loop, % Count
		LV_Add("Icon" A_Index, "     -     " A_Index,2)
	LV_ModifyCol(1,115)			; Adjusting width.
	

Gui, Font, s10 BOLD, CALIBRI 				 ; Buttons
    colbgr:="black",coltxt:="Lime"
Gui, Add, Progress, x350  y680  w65  h25 Disabled Background%colbgr%
Gui, Add, Text, xp yp wp hp c%coltxt% BackgroundTrans Center 0x200 gRELOAD, RELOAD
    colbgr:="black",coltxt:="Red"
Gui, Add, Progress, x420  y680  w65  h25 Disabled Background%colbgr%
Gui, Add, Text, xp yp wp hp c%coltxt% BackgroundTrans Center 0x200 gEXIT, EXIT

Gui Show, h710 w490, DLL Icons Viewer" 
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag") ; ⬅ ⬅ [Used for Gui Dragging]
Return

RadioClick:
	Gui, Submit										
	File := (Shell32 ? "shell32.dll" : pifmgr ? "pifmgr.dll" : ddores ? "ddores.dll" : moricons ? "moricons.dll" : mmcndmgr ? "mmcndmgr.dll" : netshell ? "netshell.dll" : setupapi ? "setupapi.dll" : compstui ? "compstui.dll" : ieframe ? "ieframe.dll" : wmploc ? "wmploc.dll" : accessibilitycpl ? "accessibilitycpl.dll" : mmres ? "mmres.dll" : netcenter ? "netcenter.dll" : networkexplorer ? "networkexplorer.dll" : pnidui ? "pnidui.dll" : sensorscpl ? "sensorscpl.dll" : wpdshext ? "wpdshext.dll" : dmdskres ? "dmdskres.dll" : dsuiext ? "dsuiext.dll" : mstscax ? "mstscax.dll" : wiashext ? "wiashext.dll" : comres ? "comres.dll" : actioncentercpl ? "actioncentercpl.dll" : aclui ? "aclui.dll" : autoplay ? "autoplay.dll" : comctl32 ? "comctl32.dll" : filemgmt ? "filemgmt.dll" : url ? "url.dll" : xwizards ? "xwizards.dll" : "imageres.dll")
	Shell32=0,imageres:=0,ifmgr:=0,ddores:=0,moricons:=0,mmcndmgr:=0,netshell:=0,setupapi:=0,wmploc:=0,compstui:=0,ieframe:=0,accessibilitycpl:=0,mmres:=0,netcenter:=0,networkexplorer:=0,pnidui:=0,sensorscpl:=0,wpdshext:=0,dmdskres:=0,dsuiext:=0,mstscax:=0,wiashext:=0,comres:=0,actioncentercpl:=0,aclui:=0,autoplay:=0,comctl32:=0,filemgmt:=0,url:=0,xwizards:=0
	Loop, parse, % "Shell32,imageres,pifmgr,ddores,moricons,mmcndmgr,netshell,setupapi,wmploc,compstui,ieframe,accessibilitycpl,mmres,netcenter,networkexplorer,pnidui,sensorscpl,wpdshext,dmdskres,dsuiext,mstscax,wiashext,comres,actioncentercpl,aclui,autoplay,comctl32,filemgmt,url,xwizards", `,
		if (A_Loopfield=a_guicontrol)
			%a_guicontrol% := 1		
	gosub, CreateGui
return

ListClick(){
  If (A_GuiEvent = "DoubleClick"){
    Clipboard := A_WinDir "\system32\" File ", " A_EventInfo

	tooltip % "copied to clipboard"
	sleep 500
	tooltip
}}

addRadioButtons()
{
	Gui, Add,Radio,vaccessibilitycpl gRadioClick Checked%accessibilitycpl% ,accessibilitycpl.dll
	Gui, Add,Radio,vaclui gRadioClick Checked%aclui% ,aclui.dll
	Gui, Add,Radio,vactioncentercpl gRadioClick Checked%actioncentercpl% ,actioncentercpl.dll
	Gui, Add,Radio,vautoplay gRadioClick Checked%autoplay% ,autoplay.dll
	Gui, Add,Radio,vcomctl32 gRadioClick Checked%comctl32% ,comctl32.dll
	Gui, Add,Radio,vcompstui gRadioClick Checked%compstui% ,compstui.dll
	Gui, Add,Radio,vcomres gRadioClick Checked%comres% ,comres.dll
	Gui, Add,Radio,vddores gRadioClick Checked%ddores% ,ddores.dll
	Gui, Add,Radio,vdmdskres gRadioClick Checked%dmdskres% ,dmdskres.dll
	Gui, Add,Radio,vdsuiext gRadioClick Checked%dsuiext% ,dsuiext.dll
	Gui, Add,Radio,vfilemgmt gRadioClick Checked%filemgmt% ,filemgmt.dll
	Gui, Add,Radio,vieframe gRadioClick Checked%ieframe% ,ieframe.dll
	Gui, Add,Radio,vImageRes gRadioClick Checked%imageres% ,imageres.dll
	Gui, Add,Radio,vmmcndmgr gRadioClick Checked%mmcndmgr% ,mmcndmgr.dll
	Gui, Add,Radio,vmmres gRadioClick Checked%mmres% ,mmres.dll
	Gui, Add,Radio,vmoricons gRadioClick Checked%moricons% ,moricons.dll
	Gui, Add,Radio,vmstscax gRadioClick Checked%mstscax% ,mstscax.dll
	Gui, Add,Radio,vnetcenter gRadioClick Checked%netcenter% ,netcenter.dll
	Gui, Add,Radio,vnetshell gRadioClick Checked%netshell% ,netshell.dll
	Gui, Add,Radio,vnetworkexplorer gRadioClick Checked%networkexplorer% ,networkexplorer.dll
	Gui, Add,Radio,vpifmgr gRadioClick Checked%pifmgr% ,pifmgr.dll
	Gui, Add,Radio,vpnidui gRadioClick Checked%pnidui% ,pnidui.dll
	Gui, Add,Radio,vsensorscpl gRadioClick Checked%sensorscpl% ,sensorscpl.dll
	Gui, Add,Radio,vsetupapi gRadioClick Checked%setupapi% ,setupapi.dll
	Gui, Add,Radio,vShell32  gRadioClick Checked%Shell32%,shell32.dll
	Gui, Add,Radio,vurl gRadioClick Checked%url% ,url.dll
	Gui, Add,Radio,vwiashext gRadioClick Checked%wiashext% ,wiashext.dll
	Gui, Add,Radio,vwmploc gRadioClick Checked%wmploc% ,wmploc.dll
	Gui, Add,Radio,vwpdshext gRadioClick Checked%wpdshext% ,wpdshext.dll
	Gui, Add,Radio,vxwizards gRadioClick Checked%xwizards% ,xwizards.dll
}

ReloadMenu:
Reload

ExitMenu:
GuiClose:
	ExitApp

#IfWinActive ahk_class AutoHotkeyGUI
	WheelDown::
		ControlClick, SysListView321, ,,WD,1
		ControlClick, SysListView322, ,,WD,1
	return
	
	WheelUp::
		ControlClick, SysListView321, ,,WU,1
		ControlClick, SysListView322, ,,WU,1
	return
#IfWinActive


; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
WM_LBUTTONDOWNdrag() {
   PostMessage, 0x00A1, 2, 0
} 
RETURN
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;•--------------------- Reload/Exit Routine -------------------------------• 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
Reload:
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
    Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
Exit:
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
        ExitApp
Return
;○------------------ Reload/Exit Routine End ----------------------------○ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;•--------------------- Script Updater -------------------------------------• 
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
;∘—— If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 2100, 100
Reload
;○------------------- Script Updater End ---------------------------------○ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;•--------------------- Auto-Execute Sub ---------------------------------• 
AutoExecute: 
#NoEnv 
#Persistent 
#SingleInstance, Force 
SetBatchLines -1 
SetTimer, UpdateCheck, 500 
SetTitleMatchMode, 2 
SoundGet, master_volume
Menu, Tray, Icon, imageres.dll, 98 	 ; Tray note icon.
Return
;○------------------ Auto-Execute Sub End ------------------------------○ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 

/* 
 •-------------------------------------------------------------------------------------------------• 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 •-------------------------------------------------------------------------------------------------• 
*/ 

