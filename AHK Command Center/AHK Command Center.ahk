
/*
;⮞--------------------- NOTES ----------------------------------------------∙ 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
∙--------------∙ Base Notes ∙--------------∙ 
» Reload Script-------- DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script------------- DoubleTap--⮚ Ctrl + [Esc] 
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
∙--------------∙ Script Specific Notes ∙--------------∙ 
» SOURCE :  https://www.autohotkey.com/board/topic/38653-see-running-autohotkey-scripts-and-end-them/page-2
» bruno
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 





_Process:=Object()


Gui, 1: New
Gui, 1: 
    +AlwaysOnTop -Caption +Border
Gui, 1: Color, 676767
Gui, 1: Margin, 10, 10


Gui, 1: Add, ListView, c57ABFF Background212121 Grid -LV0x10 -multi w277 h250 AltSubmit vListView gListView, Name|PID



Gui, 1: Add, Button, x+-262 y+5 w50 h20, Refresh
Gui, 1: Add, Button, x+0 y+-20 w50 h20, Reload
Gui, 1: Add, Button, x+0 y+-20 w50 h20, Close
Gui, 1: Add, Button, x+0 y+-20 w50 h20, Save
Gui, 1: Add, Button, x+0 y+-20 w50 h20, Edit
Gui, 1: Add, Button, x+-200 y+0 w50 h20, Pause
Gui, 1: Add, Button, x+0 y+-20 w50 h20, Suspend
Gui, 1: Add, Button, x+0 y+-20 w50 h20, KillAll

Menu, MyContextMenu, Add, Refresh, ButtonRefresh
Menu, MyContextMenu, Add, Reload, ButtonReload
Menu, MyContextMenu, Add, Close, ButtonClose
Menu, MyContextMenu, Add, Save, ButtonSave
Menu, MyContextMenu, Add, Edit, ButtonEdit
Menu, MyContextMenu, Add, Pause, ButtonPause
Menu, MyContextMenu, Add, Suspend, ButtonSuspend

LV_ModifyCol()

ButtonRefresh:
  Gui, 1: Show
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag") 	 ; Gui Drag Pt.1
    LV_Delete()
    _Processes:=0
    _Process.Remove(0,_Process.MaxIndex())
    GuiControl, -ReDraw, ListView
    For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name='AutoHotkey.exe'")
    {
        If(Process.ExecutablePath==A_AHKPath)
        {
            _Processes++
            _Process[_Processes]:=[Extract_Script_Name_From_CommandLine(Process.CommandLine)
                  ,Extract_Script_Path_From_CommandLine(Process.CommandLine),Process.ProcessID]
            LV_Add("",_Process[_Processes,1],Process.ProcessID)
        }
    }
    LV_ModifyCol()
    GuiControl, +ReDraw, ListView
Return

ButtonSave:
t := ""
Loop % LV_GetCount()
{
    LV_GetText(OutputVar1,A_Index,1)
    LV_GetText(OutputVar2,A_Index,2)
    t .= OutputVar1 A_Space OutputVar2 "`n"
}
MsgBox, 262212, `n`n" t, Would you like to save this file to Clipboard? ; 262208+4
IfMsgBox, Yes, GoTo MN
IfMsgBox, No, Return

MN:
Clipboard := t
Return

; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
ButtonKillAll:
Soundbeep, 1700,300
AHK_Kill_All() 	 ; 
Tray_Refresh() 	 ; https://www.autohotkey.com/boards/viewtopic.php?t=19832#p156072
    Return
;--------------------- 
AHK_Kill_All() { 		 ; <-- Exits all AHK apps EXCEPT the calling script.
    DetectHiddenWindows, % ( ( DHW:=A_DetectHiddenWindows ) + 0 ) . "On"
    WinGet, L, List, ahk_class AutoHotkey
        Loop %L%
            If ( L%A_Index% <> WinExist( A_ScriptFullPath " ahk_class AutoHotkey" ) )
        PostMessage, 0x111, 65405, 0,, % "ahk_id " L%A_Index%
    DetectHiddenWindows, %DHW%
Sleep, 100
    {
  eee := DllCall( "FindWindowEx", "uint", 0, "uint", 0, "str", "Shell_TrayWnd", "str", "")
  ddd := DllCall( "FindWindowEx", "uint", eee, "uint", 0, "str", "TrayNotifyWnd", "str", "")
  ccc := DllCall( "FindWindowEx", "uint", ddd, "uint", 0, "str", "SysPager", "str", "")
  hNotificationArea := DllCall( "FindWindowEx", "uint", ccc, "uint", 0, "str", "ToolbarWindow32", "str", "Notification Area")
  
  xx = 3
  yy = 5
  Transform, yyx, BitShiftLeft, yy, 16
  loop, 6 ;152
  {
    xx += 15
    SendMessage, 0x200, , yyx + xx, , ahk_id %hNotificationArea%
  }
}
Sleep, 250
    SoundSet, 1
    Soundbeep, 1900, 75
Sleep, 10
        Soundbeep, 1600, 75
Sleep, 10
    Soundbeep, 1800, 75
Sleep, 10
        Soundbeep, 1500, 75
Sleep, 10
    Soundbeep, 1700, 75
Sleep, 10
        Soundbeep, 1400, 75
;            Soundbeep, 1200, 300
    Sleep, 200
}
;------------------------------------------ 
Tray_Refresh() {
    WM_MOUSEMOVE := 0x200
    detectHiddenWin := A_DetectHiddenWindows
    DetectHiddenWindows, On

    allTitles := ["ahk_class Shell_TrayWnd"
            , "ahk_class NotifyIconOverflowWindow"]
    allControls := ["ToolbarWindow321"
                ,"ToolbarWindow322"
                ,"ToolbarWindow323"
                ,"ToolbarWindow324"]
    allIconSizes := [24,32]

    for id, title in allTitles {
        for id, controlName in allControls
        {
            for id, iconSize in allIconSizes
            {
                ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
                y := htTray - 10
                While (y > 0)
                {
                    x := wdTray - iconSize/2
                    While (x > 0)
                    {
                        point := (y << 16) + x
                        PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
                        x -= iconSize/2
                    }
                    y -= iconSize/2
                }
            }
        }
    }
    DetectHiddenWindows, %detectHiddenWin%
SoundSet, 1
    Soundbeep, 1200, 400
Sleep, 200
;------------------------------------------ 
    ExitApp 	 ; <--Self exit once all others scripts are exited and Tray is refreshed.
}
Return
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 

ButtonReload:
  If !LV_GetNext(0)
        Return
RowNumber = 0 ; This causes the first loop iteration to start the search at the top of the list
Loop
{
    RowNumber := LV_GetNext(RowNumber) ; Resume the search at the row after that found by the previous iteration
    If NOT RowNumber
        Break
    ;LV_GetText(Text, RowNumber)
    ;MsgBox, The next selected row is #%RowNumber%, whose first field is "%Text%".
    _ScriptDIR:=_Process[LV_GetNext(RowNumber-1),2]
    Run, "%A_AHKPath%" /restart "%_ScriptDIR%"
    Sleep (500)
}
GoSub, ButtonRefresh
Return

ButtonEdit:
  If !LV_GetNext(0)
        Return
RowNumber = 0
Loop
{
    RowNumber := LV_GetNext(RowNumber)
    If NOT RowNumber
        Break
    _ScriptDIR:=_Process[LV_GetNext(RowNumber-1),2]
    Run, Notepad.exe %_ScriptDIR%
    Sleep (500)
}
Return

ButtonClose:
  If !LV_GetNext(0)
        Return
RowNumber = 0
Loop
{
    RowNumber := LV_GetNext(RowNumber)
    If NOT RowNumber
        Break
    Process, Close, % _Process[LV_GetNext(RowNumber-1),3]
    Sleep (500)
    Tray_Refresh()
}
GoSub, ButtonRefresh
Return

ButtonPause:
WM_COMMAND := 0x111
CMD_RELOAD := 65400
CMD_EDIT := 65401
CMD_PAUSE := 65403
CMD_SUSPEND := 65404
DetectHiddenWindows, On
  If !LV_GetNext(0)
        Return
RowNumber = 0
Loop
{
    RowNumber := LV_GetNext(RowNumber)
    If NOT RowNumber
        Break
GoSub, CMDP
    Sleep (500)
}
Return

CMDP:
Process, Exist
this_pid := _Process[LV_GetNext(RowNumber-1),3]
control_id := WinExist("ahk_class AutoHotkey ahk_pid " this_pid)
WinGet, id, list, ahk_class AutoHotkey
Loop, %id%
{
	this_id := id%A_Index%
    If (this_id = control_id)
	{
	PostMessage, WM_COMMAND, CMD_PAUSE,,, ahk_id %this_id%
	;PostMessage, WM_COMMAND, CMD_SUSPEND,,, ahk_id %this_id%
	}
}
Return

ButtonSuspend:
WM_COMMAND := 0x111
CMD_RELOAD := 65400
CMD_EDIT := 65401
CMD_PAUSE := 65403
CMD_SUSPEND := 65404
DetectHiddenWindows, On
  If !LV_GetNext(0)
        Return
RowNumber = 0
Loop
{
    RowNumber := LV_GetNext(RowNumber)
    If NOT RowNumber
        Break
GoSub, CMDS
    Sleep (500)
}
Return

CMDS:
Process, Exist
this_pid := _Process[LV_GetNext(RowNumber-1),3]
control_id := WinExist("ahk_class AutoHotkey ahk_pid " this_pid)
WinGet, id, list, ahk_class AutoHotkey
Loop, %id%
{
	this_id := id%A_Index%
    If (this_id = control_id)
	{
	;PostMessage, WM_COMMAND, CMD_PAUSE,,, ahk_id %this_id%
	PostMessage, WM_COMMAND, CMD_SUSPEND,,, ahk_id %this_id%
	}
}
Return

ListView:
If A_GuiEvent = DoubleClick
GoSub, ButtonEdit
Return

GuiContextMenu: 	 ; Launched in response to a right-click:
If A_GuiControl <> ListView 	 ; Display the menu only for clicks inside the ListView
Return

Menu, MyContextMenu, Show
Return

GuiControl,, Refresh,
GuiControl,, Reload,
GuiControl,, Close,
GuiControl,, Save,
GuiControl,, Edit,
GuiControl,, Pause,
GuiControl,, Suspend,
Return

Extract_Script_Name_From_CommandLine(P) {
    StringSplit,R,P,"
    SplitPath,R4,F
    Return F
}

Extract_Script_Path_From_CommandLine(P) {
    StringSplit,R,P,"
    Return R4
}






; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Gui Drag ---------------------------------------------∙ 
WM_LBUTTONDOWNdrag() { 	 ; Gui Drag Pt.2
   PostMessage, 0x00A1, 2, 0
} 
;∙---------------------- Gui Drag End ---------------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Reload/Exit Routine -------------------------------∙ 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
    Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
Tray_Refresh()
        ExitApp
Return
;∙---------------------- Reload/Exit Routine End -------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Script Updater -------------------------------------∙ 
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
;∘—— If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 2100, 100
Reload
;∙---------------------- Script Updater End --------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute Sub ----------------------------------∙ 
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
;∙---------------------- Auto-Execute Sub End ---------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- GoSubs Sub ----------------------------------------∙ 
;--------------------------------------------- 

;----------- 

;--------------------------------------------- 
;∙--------------------- GoSubs Sub End -----------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

