
/*
; ╞═══════════ Pre-Notes ═══════════╡ 
Source: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=116694
; ╞──────── Pre-Notes End ────────╡ 
*/

; ╞═══════════ Auto-Execute ═══════════╡ 
#Persistent ; Keeps a script permanently running until user closes it or ExitApp is encountered.
#SingleInstance, Force ; Determines whether a script is allowed to run again when it is already running.
#NoEnv ; Recommended for performance and future compatibility.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
Menu, Tray, Icon, wmploc.dll, 99 ; White Star tray Icon.
SetKeyDelay, 250 ; ←←← Set the tap delay time (milliseconds) for script Exit. (Tied to Reload/Exit routine)

; ╞──────── Auto-Execute End ────────╡ 

; ╞═══════════ Hotkeys ═══════════╡ 
 
#IF GetKeyState("Ctrl", "P") 	 ; Ctrl + (1 + 2) 
1 & 2::
2 & 1::
#IF

; ╞────────  Hotkeys End ────────╡ 

MsgBox, , , You Pressed...`nCtrl + 1 + 2`nIn The Required Time., 3

/*
    Gui, 
        +AlwaysOnTop
        -Caption
        +LastFound
        +Owner
    Gui, Color, BLUE, Practice Piece
    Gui, Font, s16 w700 q5, Segoe UI
    Gui, Add, Text, cYELLOW, Practice Gui
    Gui, Show, Center
*/


; ╞═══════════ Reload/Exit Routine ═══════════╡ 
RETURN

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ RELOAD  SCRIPT ◦ ◦ ◦ ◦ ◦ ◦ ◦ 
GuiEscape:
     Reload

^Home::
    Reload 		 ; Ctrl + [Home]

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ EXIT SCRIPT ◦ ◦ ◦ ◦ ◦ ◦ ◦ 

^Esc:: 		; ←←← (Ctrl + ([Esc] x # of TapCounts))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 2) 	 ; ←←← Set TapCount to # of key taps wanted.
{
    SoundBeep, 2200, 75
        Gui, Destroy
        ExitApp
} else {
        KeyWait, Esc
    }
}
Return

; ╞──────── Reload/Exit Routine End ────────╡ 

