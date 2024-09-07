;;  WORKING COPY
/*∙=====∙NOTES∙===============================================∙
∙--------∙Script∙Defaults∙---------------∙
» Reload Script ∙---------∙ DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script ∙-------------∙ DoubleTap--⮚ Ctrl + [Esc] 
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
» 
∙--------∙Source∙-------------------------∙
» 
» Author:  
∙=============================================================∙
*/

;;∙------------------------------------------------------------------------------------------∙
ScriptName := "AlwaysOnTop"
;;∙------------------------------------------------------------------------------------------∙

;;∙======∙Auto-Execute∙==========================================∙
GoSub, AutoExecute
GoSub, TrayMenu
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙🔥 HotKey 🔥∙===========================================∙
^t::    ;; ⮘--(Ctrl+T) 
    Soundbeep, 1100, 100
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙============================================================∙




Sleep 300    ;;----Prevent accidental doubletap.
{
    WinSet, AlwaysOnTop, Toggle, A
    WinGet, ExStyle, ExStyle, A
    if !(WinExist("A"))
        {
            SoundBeep, 1100, 400
            MsgBox, , Error, No active window found!, 5000
            return
        }

    ;;====== VARIABLES ======
    GuiW := 215		;; Gui Width.
    GuiH := 30		;; Gui Height.
    GuiColor := "000000"	;; Gui Color.

    fnt := "Arial"				;; Font.
    fSize := "10"				;; Font Size.
    text1 := "ꜛ   ꜛ  AlwaysOnTop Active  ꜛ   ꜛ"		;; Active Text.
    textColor1 := "c08FF00"			;; Active Text Color.
    text2 := " ꜜ  ꜜ AlwaysOnTop is Disabled ꜜ  ꜜ"	;; Inactive Text.
    textColor2 := "cFF0000"			;; Inactive Text Color.
    ;;--------------------------------

    if (ExStyle & 0x8)    ;;----Active.
        {
            SoundBeep, 1000, 175
            text := text1
            textColor := textColor1
            Gui, +AlwaysOnTop -Caption +Owner
            Gui, Color, %GuiColor%
            Gui, Font, s%fSize% W400 Q5, %fnt%
            Gui, Add, Text, +0x0200 CEnter vMyTextSection1 w%GuiW% h%GuiH% CEnter %textColor%, %text%
            GuiControl, Move, MyTextSection1, x0 y0 w%GuiW% h%GuiH%
        }
    else    ;;----Inactive.
        {
            SoundBeep, 800, 175
            text := text2
            textColor := textColor2
            Gui, +AlwaysOnTop -Caption +Owner
            Gui, Color, %GuiColor%
            Gui, Font, s%fSize% W400 Q5, %fnt%
            Gui, Add, Text, +0x0200 CEnter vMyTextSection2 w%GuiW% h%GuiH% CEnter %textColor%, %text%
            GuiControl, Move, MyTextSection2, x0 y0 w%GuiW% h%GuiH%
        }
    WinGetPos, x, y, w,, A
    Gui, Show, % "NoActivate x" x + w - GuiW - 10 " y" y + 15 " w" GuiW " h" GuiH
    SetTimer, CloseTheGui, -1500
}
return


CloseTheGui:
    Gui, Destroy
return




;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙EDIT \ RELOAD / EXIT∙===================================∙
;;----------------------- EDIT \ RELOAD / EXIT --------------------------∙
Return
;;∙-------∙EDIT∙-------∙EDIT∙------------∙
Script·Edit:
    Edit
Return
;;∙------∙RELOAD∙----∙RELOAD∙-------∙
^Home:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;; Double-Tap.
    Script·Reload:    ;;----Menu Call.
    ; Soundbeep, 1200, 75
        ; Soundbeep, 1400, 100
    Reload
Return
;;-------∙EXIT∙------∙EXIT∙--------------∙
^Esc:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;; Double-Tap.
    Script·Exit:    ;;----Menu Call.
        ; Soundbeep, 1400, 75
    ; Soundbeep, 1200, 100
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
UpdateCheck:        ;; Check if the script file has been modified.
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
#MaxThreadsPerHotkey 1
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
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Tray Menu∙============================================∙
TrayMenu:
; Menu, Tray, Tip, AlwaysOnTop    ;;----Suspends hotkeys then pauses script.
Menu, Tray, Tip, %ScriptName%
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
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙MENU CALLS∙==========================================∙
TEMPLATE:
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

