﻿
/*
∙--------------------- NOTES ----------------------------------------------∙
∙------∙ SCRIPT DEFAULTS ∙------∙
» Reload Script-------- DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script------------- DoubleTap--⮚ Ctrl + [Esc] 
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
» 
∙------∙ SOURCE ∙------------------∙
» https://www.autohotkey.com/boards/viewtopic.php?t=6436#p38487
» Coco
∙---------------------- NOTES END --------------------------------------∙
*/

;;∙======∙Auto-Execute∙==============================================∙
Gosub, AutoExecute
;;∙================================================================∙

;;∙======∙🔥 HotKey 🔥∙==============================================∙
; ^T::        ;; ⮘---(Ctrl+T) 
;    Soundbeep, 1100, 100
;;∙================================================================∙

;;∙======∙Tray Menu∙================================================∙
Menu, Tray, Tip, TEMPLATE    ;;----Suspends hotkeys then pauses script.
Menu, Tray, NoStandard
Menu, Tray, Click, 2
Menu, Tray, Color, ABCDEF
Menu, Tray, Add
Menu, Tray, Add
Menu, Tray, Add, TEMPLATE
Menu, Tray, Icon, TEMPLATE, Imageres.dll, 65
Menu, Tray, Default, TEMPLATE    ;; Makes Bold.
Menu, Tray, Add
;;∙------∙  ∙--------------------------------∙

;;∙------∙Script∙Options∙---------------∙
Menu, Tray, Add
Menu, Tray, Add, Script·Edit
Menu, Tray, Icon, Script·Edit, shell32.dll, 270
Menu, Tray, Add
Menu, Tray, Add, Script·Reload
Menu, Tray, Icon, Script·Reload, mmcndmgr.dll, 47
Menu, Tray, Add
Menu, Tray, Add, Script·Exit
Menu, Tray, Icon, Script·Exit, shell32.dll, 272
Menu, Tray, Add
Menu, Tray, Add
; Return
;;∙================================================================∙
;;∙================================================================∙



;;∙======∙GuiTip∙===================================================∙
Gui New
Gui Font, s10, Segoe UI
Gui Margin, 5, 5

    Gui Add, Text, HwndhText gBeepBeep,`tTime To Get Beepy With It!!
        GuiTip(hText, "      Beep Beep`nI'm A Gui ToolTip")
;            GuiControl -g, %hText%

Gui, Show, w300 h150
Return


BeepBeep: 
    Loop, 3 {
        Soundbeep, 1400, 150
        Soundbeep, 1500, 150
        Soundbeep, 1600, 150
        Soundbeep, 1500, 150
    }
    GuiTip(hText, "      Beep Beep`nI'm A Gui ToolTip")    ;;----Reapplies tooltip.
Return

GuiClose:
    ExitApp
Return
;;∙================================================================∙


;;∙======∙GuiTip Function∙==============================================∙
GuiTip(hCtrl, text:="")
{
    hGui := text!="" ? DlLCall("GetParent", "Ptr", hCtrl) : hCtrl
    static hTip
    if !hTip
    {
        hTip := DllCall("CreateWindowEx", "UInt", 0x8, "Str", "tooltips_class32"
             ,  "Ptr", 0, "UInt", 0x80000002 ;// WS_POPUP:=0x80000000|TTS_NOPREFIX:=0x02
             ,  "Int", 0x80000000, "Int",  0x80000000, "Int", 0x80000000, "Int", 0x80000000
             ,  "Ptr", hGui, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")

        ; TTM_SETMAXTIPWIDTH = 0x0418
        DllCall("SendMessage", "Ptr", hTip, "Int", 0x0418, "Ptr", 0, "Ptr", 0)

        if (A_OsVersion == "WIN_XP")
            GuiTip(hGui)
    }

    static sizeof_TOOLINFO := 24 + (6 * A_PtrSize)
    VarSetCapacity(TOOLINFO, sizeof_TOOLINFO, 0)
    , NumPut(sizeof_TOOLINFO, TOOLINFO, 0, "UInt")
    , NumPut(0x11, TOOLINFO, 4, "UInt") ; TTF_IDISHWND:=0x0001|TTF_SUBCLASS:=0x0010
    , NumPut(hGui, TOOLINFO, 8, "Ptr")
    , NumPut(hCtrl, TOOLINFO, 8 + A_PtrSize, "Ptr")
    , NumPut(&text, TOOLINFO, 24 + (3 * A_PtrSize), "Ptr")

    static TTM_ADDTOOL := A_IsUnicode ? 0x0432 : 0x0404
    return DllCall("SendMessage", "Ptr", hTip, "Int", TTM_ADDTOOL, "Ptr", 0, "Ptr", &TOOLINFO)
}
;;∙================================================================∙






;;∙================================================================∙
;;∙======∙MENU CALLS∙==============================================∙
TEMPLATE:
    Suspend
    Soundbeep, 700, 100
    Pause
Return
;;∙================================================================∙


;;∙======∙TRAY MENU POSITION∙======================================∙
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
;;∙================================================================∙


;;∙======∙EDIT \ RELOAD / EXIT∙=======================================∙
;;----------------------- EDIT \ RELOAD / EXIT --------------------------∙
RETURN
;;------------ EDIT ------ EDIT -------------∙
Script·Edit:
    Edit
Return
;;------ RELOAD --------- RELOAD -------∙
^Home:: 
    Script·Reload:    ;;----Menu Call.
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;; Double-Tap.
;;    Soundbeep, 1200, 75
;;    Soundbeep, 1400, 100
    Reload
Return
;;------------ EXIT ------ EXIT -------------∙
^Esc:: 
    Script·Exit:    ;;----Menu Call.
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;; Double-Tap.
;;    Soundbeep, 1400, 75
;;    Soundbeep, 1200, 100
        ExitApp
Return
;;∙================================================================∙


;;∙======∙Gui Drag Pt 2∙==============================================∙
WM_LBUTTONDOWNdrag() {
   PostMessage, 0x00A1, 2, 0
}
;;∙================================================================∙


;;∙======∙Script Updater∙=============================================∙
UpdateCheck:        ;; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 1700, 100
Reload
;;∙================================================================∙


;;∙======∙Auto-Execute Sub∙==========================================∙
AutoExecute:
#MaxThreadsPerHotkey 3
#NoEnv
;;  #NoTrayIcon
#Persistent
#SingleInstance, Force
OnMessage(0x0201, "WM_LBUTTONDOWNdrag")    ;; Gui Drag Pt 1.
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
SetWinDelay 0
Menu, Tray, Icon, Imageres.dll, 65
Return
;;∙================================================================∙

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;     ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
