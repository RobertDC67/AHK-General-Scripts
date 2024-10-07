
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
ScriptID := "ColorBoard"    ;;∙------∙Need to also change in "MENU CALLS"
GoSub, AutoExecute
GoSub, TrayMenu
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙🔥 HotKey 🔥∙===========================================∙
; ^t::    ;;∙------∙(Ctrl+T) 
;    Soundbeep, 1100, 100
;;∙============================================================∙


/*

Most common pen styles for use with CreatePen: (penS)

PS_SOLID (0): A solid line (default in your script).
PS_DASH (1): A dashed line (e.g., -----).
PS_DOT (2): A dotted line (e.g., .......).
PS_DASHDOT (3): A dash-dot line (e.g., -.-.-).
PS_DASHDOTDOT (4): A dash-dot-dot line (e.g., -..-..-).
PS_NULL (5): No line at all (invisible).
PS_INSIDEFRAME (6): A solid line that is drawn inside the boundaries of the enclosing figure.

*/


penW := 2    ;;∙------∙Set pen width.
penS := 1    ;;∙------∙Set style width
penC := HexToRGB("00CFE6")    ;;∙------∙Full hexadecimal format without '0x' (RGB color).

OnMessage(0x0202, "WM_LBUTTONUP")    ;;∙------∙Handle left mouse button up event.
OnMessage(0x0201, "WM_LBUTTONDOWN")  ;;∙------∙Handle left mouse button down event.
OnMessage(0x0200, "WM_MOUSEMOVE")    ;;∙------∙Handle mouse move event.

XStart := 0    ;;∙------∙Initialize starting X position to 0.
YStart := 0    ;;∙------∙Initialize starting Y position to 0.
fDraw := false    ;;∙------∙Flag to check if drawing mode is active (initialized to false).

Gui, Color, 3B0094
Gui, +LastFound    ;;∙------∙Make GUI window the "last found" window for subsequent commands.
hwnd := WinExist()    ;;∙------∙Get handle (HWND) of the current GUI window.
Gui, Show, w800 h600, ColorBoard
Return

;; ▁▁▁▁▁▁▁▁▁▁ FUNCTIONS ▁▁▁▁▁▁▁▁▁▁ 

WM_LBUTTONDOWN() 
{
    global
    fDraw := true    ;;∙------∙Enable drawing mode when left mouse button is pressed.
    MouseGetPos, XStart, YStart, hwnd    ;;∙------∙Store current mouse position (X, Y) and window handle.
}

WM_LBUTTONUP() 
{
    global
    if (fDraw)
    {
        MouseGetPos, XEnd, YEnd, hwnd
        hdc := DllCall("user32.dll\GetDC", "ptr", hwnd, "ptr")
        ;;∙------∙Create a pen with solid style, 'x'-pixel width, and 6-digit hex color.
        hPen := DllCall("gdi32.dll\CreatePen", "int", penS, "int", penW, "uint", penC)    ;;∙------∙Pen Edits.
        hOldPen := DllCall("gdi32.dll\SelectObject", "ptr", hdc, "ptr", hPen)
        
        DllCall("gdi32.dll\MoveToEx", "ptr", hdc, "int", XStart, "int", YStart, "ptr", 0)
        DllCall("gdi32.dll\LineTo", "ptr", hdc, "int", XEnd, "int", YEnd)

        DllCall("gdi32.dll\SelectObject", "ptr", hdc, "ptr", hOldPen)
        DllCall("gdi32.dll\DeleteObject", "ptr", hPen)
        
        DllCall("user32.dll\ReleaseDC", "ptr", hWnd, "ptr", hdc)
    }
    fDraw := false
}

WM_MOUSEMOVE()
{
    global
    if (fDraw)
    {
        MouseGetPos, XEnd, YEnd, hwnd
        hdc := DllCall("user32.dll\GetDC", "ptr", hwnd, "ptr")
        ;;∙------∙Create a pen with solid style, 'x'-pixel width, and 6-digit hex color.
        hPen := DllCall("gdi32.dll\CreatePen", "int", penS, "int", penW, "uint", penC)    ;;∙------∙Pen Edits.
        hOldPen := DllCall("gdi32.dll\SelectObject", "ptr", hdc, "ptr", hPen)
        DllCall("gdi32.dll\MoveToEx", "ptr", hdc, "int", XStart, "int", YStart, "ptr", 0)
        DllCall("gdi32.dll\LineTo", "ptr", hdc, "int", XEnd, "int", YEnd)
        
        ;;∙------∙Restore the old pen and clean up.
        DllCall("gdi32.dll\SelectObject", "ptr", hdc, "ptr", hOldPen)
        DllCall("gdi32.dll\DeleteObject", "ptr", hPen)
        
        DllCall("user32.dll\ReleaseDC", "ptr", hWnd, "ptr", hdc)
        
        XStart := XEnd
        YStart := YEnd
    }
}

HexToRGB(hex) {
    return RGB2BGR("0x" hex)
}

RGB2BGR(rgb) {
    return ((rgb & 0xFF) << 16) | (rgb & 0xFF00) | ((rgb >> 16) & 0xFF)
}









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
ColorBoard:    ;;∙------∙Change as needed to match the 'ScriptID' variable in AutoExe section.
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

