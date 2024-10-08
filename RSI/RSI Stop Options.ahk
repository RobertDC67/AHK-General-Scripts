﻿
/*

Refresh Script … …	Ctrl + HOME key rapidly clicked 2 times.
Exit Script … … … …	Ctrl + Escape key rapidly clicked 3 times.

- Script Updater: Auto-reload script upon saved changes.
  If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.

*/

; ==================================================
; ================= Auto-Execute ===================
; ==================================================
#SingleInstance, Force
#Persistent
SetBatchLines -1
DetectHiddenWindows, On
SetTimer, UpdateCheck, 500 
SetKeyDelay, 250 		 ; Sets the TapCount allowed delay time (milliseconds) for script Exit. (tied to Reload/Exit routine)

Menu, Tray, Icon, wmploc.dll, 99 		 ; Local White Star tray Icon.
; ===================================================
; =============== Auto-Execute End ==================
; ===================================================






;--------------------------------------------------------∙ 
F1::
;--------------∙ Globals
TargetProcess2 := "workpace.exe"
CheckInterval := 5000 		 ;; Runs every 5 seconds.
;--------------∙ Timer
SetTimer, CheckWP, %CheckInterval%
;--------------∙ Processing
CheckWP:
    If (ProcessExist(TargetProcess2)) { 	 ;; Check if process running.
    Sleep, 5000
        If (ProcessExist(TargetProcess2)) { 	 ;; Check if process still running.
            Process, Close, %TargetProcess2% 	 ;; If still running, terminate process
        } 
    }
Return
;--------------∙ Program Kill Function
ProcessExist(Name){
    Process, Exist, %Name%
    Return ErrorLevel
}
Return
;--------------------------------------------------------∙ 







;-------------------------------------------------------
^F2::
Process, Close, workpace.exe
Sleep, 750
Process, Close, RSIGuard.exe
Sleep, 750
Return

;--------------------------------------------------------∙ 
^F3::
Process, Close, RSIGuard.exe
Sleep, 750
    ExitApp
Return
;--------------------------------------------------------∙ 




;--------------------------------------------------------∙ 
;;------------- TERMINATOR - KEYED -------------∙ 
^T::
    Soundbeep, 1300, 100
    Process, Close, RSIGuard.exe
        Sleep, 750
    Process, Close, workpace.exe
        Sleep, 750
Return
;--------------------------------------------------------∙ 






;--------------------------------------------------------∙ 
;;------------- TERMINATOR - SENTRY ------------∙ 
;--------------∙ Globals
TargetProcess1 := "RSIGuard.exe"
TargetProcess2 := "workpace.exe"
CheckInterval := 5000 		 ;; Runs every 5 seconds.
;--------------∙ Timers
SetTimer, CheckRSI, %CheckInterval%
SetTimer, CheckWP, %CheckInterval%
;--------------∙ Processing
CheckRSI:
    If (ProcessExist(TargetProcess1)) { 	 ;; Check if process running.
    Sleep, 5000
        If (ProcessExist(TargetProcess1)) { 	 ;; Check if process still running.
            Process, Close, %TargetProcess1% 	 ;; If still running, terminate process
        } 
    }
Return
;-------∙ 
CheckWP:
    If (ProcessExist(TargetProcess2)) {
    Sleep, 5000
        If (ProcessExist(TargetProcess2)) {
            Process, Close, %TargetProcess2%
        } 
    }
Return

;--------------∙ Is Process Present Function
ProcessExist(Name){
    Process, Exist, %Name%
    Return ErrorLevel
}
Return
;--------------------------------------------------------∙ 














; ===================================================
; =============== Reload/Exit Routine ===============
; ===================================================
RETURN

; … … … …  RELOAD  SCRIPT  … … … … … … … … … … 

^Home:: 		  ; … …  [Home Button]
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 2) 	 ; <<<<---- Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, YELLOW 		 ; <<<<-----IndicateDot Color.
  Gosub, IndicateDot2
        Reload
} else {
        KeyWait, Esc
    }
}
Return

; … … … …  EXIT SCRIPT  … … … … … … … … … … … 

^Esc:: 		; … …  Ctrl + ((Esc) times (# of TapCounts))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 3) 	 ; <<<<---- Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, RED 		 ; <<<<-----IndicateDot Color.
  Gosub, IndicateDot2
        Gui, Destroy
        ExitApp
} else {
        KeyWait, Esc
    }
}
Return

; … … … …  Script Updater … … … … … … … … … …

UpdateCheck: 				 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%

; … … … … If the modification timestamp has changed, reload the script.
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
  Gosub, IndicateDot1
Gui, Color, BLUE 		 ; <<<<-----IndicateDot Color.
  Gosub, IndicateDot2
Reload

; … … … …  SCRIPT GoSubs  … … … … … … … … … … 

IndicateDot1:
Gui, Destroy
SysGet, MonitorWorkArea, MonitorWorkArea
SysGet, TaskbarPos, 4
Gui, +AlwaysOnTop -Caption +hwndHGUI +LastFound
Return

; … … … … … … … … … … … … … 

IndicateDot2:
Gui, Margin, 13, 13 		 ; <<<<-----Dot Size.
Gui, Show, Hide
WinGetPos, , , WinWidth, WinHeight, ahk_id %HGUI%
NewX := MonitorWorkAreaRight - 80
NewY := MonitorWorkAreaBottom - WinHeight - 5
R := Min(WinWidth, WinHeight) // 1 	 ; <<<<-----  Set value of cornering. (0.5=Oval, 0=square, 1= round, 5=rounded corners).
WinSet, Region, 0-0 W%WinWidth% H%WinHeight% R%R%-%R%
Gui, Show, x%NewX% y%NewY%
SoundGet, master_volume
SoundSet, 7
Soundbeep, 2100, 100
SoundSet, % master_volume
Sleep, 500
Gui, Destroy
Return

; … … … … … … … … … … … … … … … … … … … … … 

; ===================================================
; ==================== Script End ===================
; ===================================================

/*

 … … … … … … … … … … … … … … … … … … … …  … … … … … … … … … … … … … … … … … … … … … 
    ↓↓↓ --→→ Remove All Below Commented Section From Completed Scripts ←←-- ↓↓↓
 … … … … … … … … … … … … … … … … … … … …  … … … … … … … … … … … … … … … … … … … … … 

  … … … … … … … … … NOTES  … … … … … … … … 
   … … … … … … … … … … … … … … … … … … … … 

  … … … … DIRECTIVES … … … … 
Use #Persistent and #SingleInstance with a parameter (force|ignore|off)
to over ride the default behavior of running #Persistent by itself.

#Persistent ; Keeps a script permanently running until user closes it or ExitApp is encountered.
#SingleInstance, Force ; Determines whether a script is allowed to run again when it is already running.
#NoEnv ; Recommended for performance and future compatibility.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
; #Include (FileOrDirName/<LibName>) ; Causes script to behave as if specified file's contents are at this exact position.
; #If [Expression]; Creates context-sensitive hotkeys and hotstrings. Use simple #If to turn off context sensitivity.
; #InstallMouseHook ; Forces the unconditional installation of the mouse hook.
; #InstallKeybdHook ; Forces the unconditional installation of the keyboard hook.
; #UseHook, On ; Forces the use of the hook to implement all or some keyboard hotkeys. (On|Off)
; #NoTrayIcon ; Disables the showing of a tray icon.
; #Warn ; Indicates a errors, such as a typo or missing Global declaration.
; SetBatchlines, -1 ; Determines how fast script will run. Use -1 to never sleep/run max speed. (affects CPU utilization)
; SetTitleMatchMode, 2 ; A window's title can contain WinTitle anywhere inside it.
; SetWinDelay, 0 ; Use -1 for no delay at all and 0 for smallest possible delay. If unset, default delay is 100.

  … … … … … … … … … … … … … … … … … … … … 

  … … … … Hotkey Modifiers … … … … 
#	← Windows logo
!	← Alt
^	← Ctrl
+	← Shift
&	← Used between any two keys or mouse buttons to combine them into a custom hotkey.
~	← Tilde 
<	← Use the left key of the pair.
>	← Use the right key of the pair.
*	← Wildcard: Fire the hotkey even if extra modifiers are being held down.
UP 	← Cause the hotkey to fire upon release of the key
$	← Used in conjunction with Send commands-Prefix hotkeys to prevent triggering when same key is sent.
;  	← Symbol used for commenting inside script 

  … … … … … … … … … … … … … … … … … … … … 

  … … … … Gui Options & Styles … … … … 
+AlwaysOnTop ; Removes the window (if it exists) and all its controls.
+Border ; Provides a thin-line border around the window.
-Caption ;  Removes title bar and a thick window border/edge. When removing the caption from a window that will use WinSet TransColor, remove it only after setting the TransColor.
-Disabled ; 
-DPIScale ; 
+E0x20 ; Click through a GUI. (WS_EX_CLICKTHROUGH Style)
+E0x02000000 +E0x00080000 ; WS_EX_COMPOSITED & WS_EX_LAYERED => Double Buffer to prevent flicker.
-0xC00000 ; equivalent of -Caption
+0x40000 ; equivalent of +Resize.
+HwndhGui ; Retrieves the window handle (HWND) of the Gui.
+LastFound ; Sets the window to be the last found window.
+MaximizeBox ; Enables the maximize button in the title bar.
+MinimizeBox ; Enables the minimize button in the title bar.
+MinSize ; Determines the minimum size of the window, such as when the user drags its edges to resize it.
+MaxSize ; Determines the maximum size of the window, such as when the user drags its edges to resize it.
+Owner ; Avoids a taskbar button.
+Parent1 ; assigns the second gui to the first gui.
+Resize ; Makes the window resizable and enables its maximize button in the title bar.
-SysMenu ; Omits system menu and icon in the window's upper left corner. Also omits the min, max, & close buttons in the title bar.
+ToolWindow ; Provides narrower title bar with no taskbar button. Always hides the max & min buttons.
  … … … … Example of use: … … … … 
  … … (Gui New, +LastFound +AlwaysOnTop -Caption +ToolWindow) … … … … 

  … … … … … … … … … … … … … … … … … … … … 

  … … … … Make Gui transparent example … … … … 
Gui, Color, EEAA99 		 ; Determines color to make transparent.
Gui +LastFound 		 ; Make the GUI window the last found window for use by the line below.
WinSet, TransColor, EEAA99 	 ; Sets Gui color as transparent.

  … … … … … … … … … … … … … … … … … … … … 

  … … … … Local Tray Icons … … … … 
Menu, Tray, Icon, mmcndmgr.dll, 55 		 ; Yellow ?
Menu, Tray, Icon, mmcndmgr.dll, 7 		 ; Plus (+) sign icon.
Menu, Tray, Icon, mmcndmgr.dll, 113 		 ; Yellow Star tray Icon.
Menu, Tray, Icon, wmploc.dll, 99 		 ; White Star tray Icon.
Menu, Tray, Icon, imageres.dll, 93 		 ; White 'x'
Menu, Tray, Icon, ieframe.dll, 40 		 ; Sm Green 'x'
Menu, Tray, Icon, ieframe.dll, 41 		 ; Lg Green Check
Menu, Tray, Icon, netshell.dll, 101 		 ; Lg Orange Check
Menu, Tray, Icon, ieframe.dll, 42 		 ; Sm Red 'x'
Menu, Tray, Icon, ieframe.dll, 39 		 ; Lg Red 'x'
Menu, Tray, Icon, ieframe.dll, 43 		 ; Sm Orange RightArrow
Menu, Tray, Icon, moricons.dll, 43 		 ; Urgent Note
Menu, Tray, Icon, netshell.dll, 80 		 ; Green Approval Check
Menu, Tray, Icon, netshell.dll, 103 		 ; Green Antenna
Menu, Tray, Icon, netshell.dll, 122 		 ; Red ?
Menu, Tray, Icon, mmcndmgr.dll, 45 		 ; Magnifier
Menu, Tray, Icon, compstui.dll, 7 		 ; Blue Fade Plus

  … … … … … … … … … … … … … … … … … … … … 

  … … … … Color Hex Codes … … … … 
BLACK	    - - -     #	000000
M. Grey	    - - -     #	676767
ML Grey	    - - -     #	808080
SILVER	    - - -     #	C0C0C0
WHITE	    - - -     #	FFFFFF

MAROON	    - - -     #	800000
RED	    - - -     #	FF0000
Red Cherry   - - -     #	670104
PURPLE	    - - -     #	800080 
Purple	    - - -     #	8000FF
FUSHIA	    - - -     #	FF00FF

GREEN	    - - -     #	008000
Green	    - - -     #	00FF00
LIME	    - - -     #	00FF00
Olive	    - - -     #	808000

YELLOW	    - - -     #	FFFF00
Orange	    - - -     #	FF8000

NAVY	    - - -     #	000080
BLUE	    - - -     #	0000FF
Ice Blue	    - - -     #	B4F0FF
TEAL	    - - -     #	008080
AQUA	    - - -     #	00FFFF

  … … … … … … … … … … … … … … … … … … … … 

 … … … … … … … … … … … … … … … … … … … …  … … … … … … … … … … … … … … … … … … … … … … 
    ↑↑↑ --→→ Remove All Above Commented Section From Completed Scripts ←←-- ↑↑↑
 … … … … … … … … … … … … … … … … … … … …  … … … … … … … … … … … … … … … … … … … … … … 

*/