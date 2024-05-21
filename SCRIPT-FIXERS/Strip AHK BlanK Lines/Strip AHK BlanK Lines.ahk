
/*
; ╞═══════════ Notes ═══════════╡ 
» Drag-n-Drop AHK file onto Gui interface to strip all Blank Lines from the script.

» Refresh Script ════  Ctrl + HOME key rapidly clicked 2 times. (# TapCounts)
» Exit Script ════════  Ctrl + Escape key rapidly clicked 3 times. (# TapCounts)

» Script Updater: Auto-reload script upon saved changes.
    ─ If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.
; ╞──────── Notes End ────────╡ 
*/

; ╞═══════════ Auto-Execute ═══════════╡ 
Gosub, AutoExecute

; ╞──────── Auto-Execute End ────────╡ 

; ╞═══════════ Hotkeys ═══════════╡ 
; ^T:: 	 ; ═════ (Ctrl + T) 
  Gosub, IndicateDot1
Gui, Color, LIME 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2

; ╞────────  Hotkeys End ────────╡ 

Gui, 
    +AlwaysOnTop 
    -Border  
Gui, Margin, 5, 5
Gui, Font, s12 BOLD cBLACK q5, Segoe UI
Gui, Color, 6AA8D7 		 ; Blue (ready)
Gui, Add, Text, x-2 y-10 w270 h50 gGuiMove +Center, `nStrip Blank Lines 
Gui, Font, s10 c43FC43 q5, ARIAL 	 ; Green
Gui, Add, Text, xp y+0 h30 Wp gGuiMove vDrop +Center, Drop files and folders`n 

Gui, Add, Pic, x5 y15 icon2, %A_AhkPath%  
Gui, Add, Pic, x230 y15 icon2, %A_AhkPath%  
Gui, Show, w270 h70 NoActivate, Strip Blank Lines
Return  

GuiMove:  
   PostMessage, 0xA1, 2,,, A  
   Return  

GuiDropfiles:  
   Gui, Color, 6AA897 	 ; Green (completed)
   Gui, -E0x10  
   GuiControl, ,Dropped, Please wait . . . 
Loop, Parse, A_GuiEvent, `n, `r 
      Loop, % (D:=InStr(FileExist(A_Loopfield), "D")) ? A_LoopField "\*.ahk" : A_LoopField ,% D ? 1 : 0, % D ? 1 : 0  
         {  
         IfNotEqual, A_LoopFileExt,ahk, Continue  
         FileRead, Contents, %A_LoopFileFullPath% 
		 if not ErrorLevel 
		 Filepathname=%A_LoopFileFullPath% 
Loop,parse,Contents, `r, %A_Tab% 
{ 
StringLen, linenumber, A_LoopField 
If linenumber=0 
Continue 
If linenumber=1 
Continue 
stringreplace, Contents, A_LoopField, `r`n`r`n, `r`n, A 
StringReplace, BlFilepathname, Filepathname, .ahk, (Strip Blank Lines).ahk 
	  FileAppend, %Contents%, %BlFilepathname% 
	 }	  
	}   

   Gui, Color, Purple  
   GuiControl, ,Drop, Drop files and folders  
   Gui, +E0x10  
   Return  

   Gui, Color, Purple  
   GuiControl, ,Drop, Drop files and folders  
   Gui, +E0x10  
   Return  

GuiEscape:  
   ExitApp 

; ╞═══════════ Reload/Exit Routine ═══════════╡ 
RETURN

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ RELOAD  SCRIPT ◦ ◦ ◦ ◦ ◦ ◦ ◦ 

^Home:: 		  ; (Ctrl + ([Home] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 2) 	 ; ←←← Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, YELLOW 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2
        Reload
} else {
        KeyWait, Esc
    }
}
Return

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ EXIT SCRIPT ◦ ◦ ◦ ◦ ◦ ◦ ◦ 

^Esc:: 		; (Ctrl + ([Esc] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 3) 	 ; ←←← Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, RED 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2
        Gui, Destroy
        ExitApp
} else {
        KeyWait, Esc
    }
}
Return

; ╞──────── Reload/Exit Routine End ────────╡ 

; ╞═══════════ Script Updater ═══════════╡ 
UpdateCheck: 				 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
; ◦ ◦ ◦ ◦ ◦ ◦ If the modification timestamp has changed, reload the script.
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
  Gosub, IndicateDot1
Gui, Color, BLUE 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2
Reload

; ╞──────── Script Updater End ────────╡ 


; ╞═══════════ Auto-Execute Sub ═══════════╡ 
AutoExecute:
#SingleInstance, Force
#Persistent
SetBatchLines -1
DetectHiddenWindows, On
SetTimer, UpdateCheck, 500 		 ; Checks for script changes every 1/2 second. (Script Updater)
SetKeyDelay, 250 		 ; Sets the TapCount allowed delay time (milliseconds) for script Exit. (tied to Reload/Exit routine)
Menu, Tray, Icon, wmploc.dll, 99 ; Local White Star tray Icon.

; ╞──────── Auto-Execute Sub End ────────╡ 

; ╞═══════════ GoSubs ═══════════╡ 
IndicateDot1:
Gui, Destroy
SysGet, MonitorWorkArea, MonitorWorkArea
SysGet, TaskbarPos, 4
Gui, +AlwaysOnTop -Caption +hwndHGUI +LastFound
Return

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ 

IndicateDot2:
Gui, Margin, 13, 13 		 ; ←←← Dot Size.
Gui, Show, Hide
WinGetPos, , , WinWidth, WinHeight, ahk_id %HGUI%
NewX := MonitorWorkAreaRight - 80
NewY := MonitorWorkAreaBottom - WinHeight - 5
R := Min(WinWidth, WinHeight) // 1 	 ; ←←← Set value of cornering. (0.5=Oval, 0=square, 1= round, 5=rounded corners).
WinSet, Region, 0-0 W%WinWidth% H%WinHeight% R%R%-%R%
Gui, Show, x%NewX% y%NewY%
SoundGet, master_volume
SoundSet, 7
Soundbeep, 2100, 100
SoundSet, % master_volume
Sleep, 500
Gui, Destroy
Return

; ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ 

; ╞──────── GoSubs End ────────╡ 

; ╞──────────────────────────╡ 
; ╞═══════════ Script End ═══════════╡ 
; ╞──────────────────────────╡ 
