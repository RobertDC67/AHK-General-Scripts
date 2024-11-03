﻿
/*∙=====∙NOTES∙===============================================∙
∙--------∙Script∙Defaults∙---------------∙
» Reload Script∙----------∙DoubleTap∙------∙(Ctrl + [HOME])
» Exit Script∙--------------∙DoubleTap∙------∙(Ctrl + [Esc])
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
» 
∙--------∙Origins∙-------------------------∙
» Author:  
» Source:  
» 
∙=============================================================∙
*/
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Auto-Execute∙==========================================∙
ScriptID := "TEMPLATE"    ;;∙------∙Also change in 'MENU CALLS' at script end.
GoSub, AutoExecute
GoSub, TrayMenu
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙🔥 HotKey 🔥∙===========================================∙
; ^t::    ;;∙------∙(Ctrl+T) 
;    Soundbeep, 1100, 100
;;∙============================================================∙




guiColor := ""
guiFont := "Courier New"
guiFontSize := "16"
guiFontColor := "17C8FE"


Gui, +AlwaysOnTop +Border -Caption +Disabled -SysMenu +Owner 
Gui, Color, Black
Gui, Font, s%guiFontSize% c%guiFontColor% w400 q5, %guiFont%
Gui, Add, Text, Center  hwndTxt, IT IS A QUARTER PAST TWELVE O'CLOCK    ;;∙------∙Begin with long text.
Gui, Show, X1418 Y991, clock, NoActivate
;;∙------------------------∙
minuteKeys := [0
	,5
	,10
	,15
	,20
	,30
	,40
	,45
	,50
	,55
	,60]
;;∙------∙
minuteWords := ["O'CLOCK"
	,"FIVE"
	,"TEN"
	,"A QUARTER"
	,"TWENTY"
	,"HALF"
	,"TWENTY"
	,"A QUARTER"
	,"TEN"
	,"FIVE"
	,"O'CLOCK"]
;;∙------------------------∙
hourKeys := [1
	,2
	,3
	,4
	,5
	,6
	,7
	,8
	,9
	,10
	,11
	,12] 
;;∙------∙
HourWords := ["ONE"
	,"TWO"
	,"THREE"
	,"FOUR"
	,"FIVE"
	,"SIX"
	,"SEVEN"
	,"EIGHT"
	,"NINE"
	,"TEN"
	,"ELEVEN"
	,"TWELVE"
	,"ONE"]    ;;∙------∙Add "ONE" at end to prevent 'out of bounds' when clock is 12:36+.
;;∙------------------------∙

Gosub, wc
SetTimer, wc, % 1000*30    ;;∙------∙Update every 30 seconds.
Return

wc:
    This_Min := A_Min    ;;∙------∙Save current time to ensure all checks are against same time.
    FormatTime, This_Hour , A_Hour, h ; 1-12 hour format
    minute := ""
    hour := ""
Loop, 10    ;;∙------∙Loop intervals of minuteKeys.
    {
        lb := minuteKeys[A_Index]    ;;∙------∙Lower Bound.
        ub := minuteKeys[A_Index+1]    ;;∙------∙Upper Bound.
        if This_Min between %lb% and %ub%
            {
            minute := (ub-This_Min < This_Min-lb) ? minuteWords[A_Index+1]:minuteWords[A_Index]    ;;∙------∙Choose minute to be the closet end point on the interval [lb,ub].
    break
            }
	}
	if (Minute="O'CLOCK")
	{
	hour := hourWords[This_Hour+(This_Min>30)]    ;;∙------∙Take closest whole hour.

	TimeString := "IT IS " . hour . " " minute
	}
	else
	{
	pastOrTo := This_Min>35 ? "TO" : "PAST"    ;;∙------∙It is 'past' until it is 'twenty to'

	hour := hourWords[This_Hour+(This_Min>35)]    ;;∙------∙If it is 'To' take the next hour.

	TimeString := "IT IS " minute " " pastOrTo " " hour
	}
	GuiControl, , %Txt%, %TimeString%
Return




;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙EDIT \ RELOAD / EXIT∙===================================∙
;;∙-----------------------∙EDIT \ RELOAD / EXIT∙--------------------------∙
RETURN
;;∙-------∙EDIT∙-------∙EDIT∙------------∙
Script·Edit:    ;;∙------∙Menu Call.
    Edit
Return
;;∙------∙RELOAD∙----∙RELOAD∙-------∙
^Home:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;;∙--∙Double-Tap.
    Script·Reload:    ;;∙------∙Menu Call.
        SoundBeep, 1100, 75
        Soundbeep, 1200, 100
    Reload
Return
;;-------∙EXIT∙------∙EXIT∙--------------∙
^Esc:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;;∙--∙Double-Tap.
    Script·Exit:    ;;∙------∙Menu Call.
        Soundbeep, 1100, 75
        Soundbeep, 1000, 100
    ExitApp
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Gui Drag Pt 2∙==========================================∙
WM_LBUTTONDOWNdrag() {
   PostMessage, 0x00A1, 2, 0
}
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Script Updater∙=========================================∙
UpdateCheck:    ;;∙------Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 1700, 100
Reload
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Auto-Execute Sub∙======================================∙
AutoExecute:
#MaxThreadsPerHotkey 3
#NoEnv
;;∙------∙#NoTrayIcon
#Persistent
#SingleInstance, Force
OnMessage(0x0201, "WM_LBUTTONDOWNdrag")    ;; Gui Drag Pt 1.
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
SetWinDelay 0
Menu, Tray, Icon, imageres.dll, 3
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Tray Menu∙============================================∙
TrayMenu:
Menu, Tray, Tip, %ScriptID%
Menu, Tray, NoStandard
Menu, Tray, Click, 2
Menu, Tray, Color, ABCDEF
Menu, Tray, Add
Menu, Tray, Add
Menu, Tray, Add, Suspend / Pause, %ScriptID%    ;;∙------∙Script Header.
Menu, Tray, Icon, Suspend / Pause, shell32, 28  ;  Imageres.dll, 65
Menu, Tray, Default, Suspend / Pause    ;;∙------∙Makes Bold.
Menu, Tray, Add
;;------------------------------------------∙

;;∙------∙Script∙Options∙---------------∙
Menu, Tray, Add
Menu, Tray, Add, Script Edit, Script·Edit
Menu, Tray, Icon, Script Edit, imageres.dll, 247
Menu, Tray, Add
Menu, Tray, Add, Script Reload, Script·Reload
Menu, Tray, Icon, Script Reload, mmcndmgr.dll, 47
Menu, Tray, Add
Menu, Tray, Add, Script Exit, Script·Exit
Menu, Tray, Icon, Script Exit, shell32.dll, 272
Menu, Tray, Add
Menu, Tray, Add
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙MENU CALLS∙==========================================∙
TEMPLATE:    ;;∙------∙Suspends hotkeys then pauses script. (Script Header)
    Suspend
    Soundbeep, 700, 100
    Pause
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙TRAY MENU POSITION∙==================================∙
NotifyTrayClick_205:
    CoordMode, Mouse, Screen
    CoordMode, Menu, Screen
    MouseGetPos, mx, my
    Menu, Tray, Show, % mx - 20, % my - 20
Return
;;∙======∙TRAY MENU POSITION FUNTION∙======∙
NotifyTrayClick(P*) { 
Static Msg, Fun:="NotifyTrayClick", NM:=OnMessage(0x404,Func(Fun),-1),  Chk,T:=-250,Clk:=1
  If ( (NM := Format(Fun . "_{:03X}", Msg := P[2])) && P.Count()<4 )
     Return ( T := Max(-5000, 0-(P[1] ? Abs(P[1]) : 250)) )
  Critical
  If ( ( Msg<0x201 || Msg>0x209 ) || ( IsFunc(NM) || Islabel(NM) )=0 )
     Return
  Chk := (Fun . "_" . (Msg<=0x203 ? "203" : Msg<=0x206 ? "206" : Msg<=0x209 ? "209" : ""))
  SetTimer, %NM%,  %  (Msg==0x203        || Msg==0x206        || Msg==0x209)
    ? (-1, Clk:=2) : ( Clk=2 ? ("Off", Clk:=1) : ( IsFunc(Chk) || IsLabel(Chk) ? T : -1) )
Return True
}
;;∙============================================================∙

;;∙------------------------------------------------------------------------------------------∙
;;∙========================∙SCRIPT END∙=========================∙
;;∙------------------------------------------------------------------------------------------∙

