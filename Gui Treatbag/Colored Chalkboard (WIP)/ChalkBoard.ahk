
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
» 
∙=============================================================∙
*/
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Auto-Execute∙==========================================∙
ScriptID := "TEMPLATE"    ;;∙------∙Need to also change in "MENU CALLS"
GoSub, AutoExecute
GoSub, TrayMenu
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙🔥 HotKey 🔥∙===========================================∙
; ^t::    ;;∙------∙(Ctrl+T) 
;    Soundbeep, 1100, 100
;;∙============================================================∙


guiX := "860"    ;;∙-------∙Gui x-axis.
guiY := "200"    ;;∙-------∙Gui y-axis.
guiW := "700"    ;;∙-------∙Gui Width.
guiH := "550"    ;;∙-------∙Gui Height.

guiTopColor := "013C1E"    ;;∙-------∙Green.
guiBottomColor := "6C4E2E"    ;;∙-------∙Brown.

guiTopFont := "ARIAL"
guiTopFontSize := "18"
guiTopFontColor := "DEDE00"    ;;∙-------∙Yellow.

guiBottomFont := "CALIBRI"
guiBottomFontSize := "16"
guiBottomFontColor := "1616DE"    ;;∙-------∙PINK

; Create the Bottom GUI
Gui, Bottom: NEW
Gui, Bottom: +AlwaysOnTop -Caption
Gui, Bottom: Color, %guiBottomColor%
Gui, Bottom: Font, s%guiBottomFontSize% c%guiBottomFontColor%, %guiBottomFont%
Gui, Bottom: Add, Text,, Bottom Gui
Gui, Bottom: Add, Edit, vEdit2
guiX2 := guiX-15 , guiY2 := guiY-15 , guiW2 := guiW+30 , guiH2 := guiH+30
Gui, Bottom: Show, x%guiX2% y%guiY2% w%guiW2% h%guiH2%

; Create the Top GUI
Gui, Top: NEW
Gui, Top: +AlwaysOnTop -Caption +LastFound
Gui, Top: Color, %guiTopColor%
Gui, Top: Font, s%guiTopFontSize% c%guiTopFontColor%, %guiTopFont%
Gui, Top: Add, Text,, Top Gui
Gui, Top: Add, Edit, vEdit1
Gui, Top: Show, x%guiX% y%guiY% w%guiW% h%guiH%

; Get the handle for the Top GUI (needed for dragging)
Gui, Top: +LastFound
topGuiHwnd := WinExist()

; Detect dragging the Top GUI
OnMessage(0x201, "WM_LBUTTONDOWN")   ;;∙-------∙Detects left mouse button down.
Return

; Left mouse button down event to start dragging
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    global topGuiHwnd
    if (hwnd = topGuiHwnd) {
        ; If the top GUI is clicked, initiate dragging
        PostMessage, 0xA1, 2  ;;∙-------∙Initiates a drag for the top GUI.
        SetTimer, MoveBottomGui, 10  ;;∙-------∙Start moving the bottom GUI.
    }
}

; Move the bottom GUI to follow the top GUI
MoveBottomGui:
    global guiX, guiY, guiX2, guiY2, guiW2, guiH2
    ; Get the new position of the Top GUI
    WinGetPos, guiX, guiY,,, ahk_id %topGuiHwnd%
    ; Adjust the Bottom GUI position to match the Top GUI
    guiX2 := guiX - 15
    guiY2 := guiY - 15
    Gui, Bottom: Show, x%guiX2% y%guiY2%
Return

; Stop moving the bottom GUI once the mouse button is released
~LButton Up::
    SetTimer, MoveBottomGui, Off
Return

1GuiClose:    ;;∙-------∙This label called when the 1st Gui is closed.
2GuiClose:    ;;∙-------∙This label called when the 2nd Gui is closed.
    Reload









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
        Soundbeep, 1200, 75
        Soundbeep, 1400, 100
    Reload
Return
;;-------∙EXIT∙------∙EXIT∙--------------∙
^Esc:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;;∙--∙Double-Tap.
    Script·Exit:    ;;∙------∙Menu Call.
        Soundbeep, 1400, 75
        Soundbeep, 1200, 100
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
Menu, Tray, Icon, Imageres.dll, 65
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Tray Menu∙============================================∙
TrayMenu:
Menu, Tray, Tip, %ScriptID%    ;;∙------∙Suspends hotkeys then pauses script.
Menu, Tray, NoStandard
Menu, Tray, Click, 2
Menu, Tray, Color, ABCDEF
Menu, Tray, Add
Menu, Tray, Add
Menu, Tray, Add, %ScriptID%
Menu, Tray, Icon, %ScriptID%, Imageres.dll, 65
Menu, Tray, Default, %ScriptID%    ;;∙------∙Makes Bold.
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
TEMPLATE:    ;;∙------∙Change as needed to match the 'ScriptID' variable in AutoExe section.
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

