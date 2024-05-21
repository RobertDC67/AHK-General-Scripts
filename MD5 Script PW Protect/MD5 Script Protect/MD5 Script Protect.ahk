
/*
; ╞═══════════ Notes ═══════════╡ 
⫸Use MD5 Hasher.ahk script to generate Hash IDs for User and Pass. 

⫸Place the following at beginning of Script near Auto-Execute section. Uses MD5 Hash encryption to protect password.
    Both will need changed and set as needed!!
        ⋗ User = MD5 Hash # 	 (example username: Myself) 
        ⋗ Pass = MD5 Hash # 	 (example password: Pa$$word1) 

» Refresh Script ════  Ctrl + HOME key rapidly clicked 2 times. (# TapCounts)
» Exit Script ════════  Ctrl + Escape key rapidly clicked 3 times. (# TapCounts)

» Script Updater: Auto-reloads script upon saved changes.
    ⋗ If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.

» SOURCE : https://www.autohotkey.com/board/topic/50988-password-protect-a-script/
; ╞──────── Notes End ────────╡ 
*/

; ╞═══════════ Auto-Execute ═══════════╡ 
Gosub, AutoExecute

; ╞──────── Auto-Execute End ────────╡ 


User := "3E9531210F2FE7F1204055F5264B0226" ; This is the hashed version of "User Name" (Myself)
Pass := "15360BE2C32496E865DB6C1AA2A5064F" ; This is the hashed version of "Password" (Pa$$word1)


; ╞═══════════ Hotkeys ═══════════╡ 
^Numpad2:: 	 ; ═════ (Ctrl + NumberPad2) [MD5 Hasher.ahk script uses Ctrl + NumberPad1]
  Gosub, IndicateDot1
Gui, Color, LIME 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2
; ╞────────  Hotkeys End ────────╡ 


InputBox, CapUser, Please Enter User Name
InputBox, CapPass, Please Enter Password
If ( MD5(CapUser, StrLen(CapUser)) != User ) OR ( MD5(CapPass, StrLen(CapPass)) != Pass )
{
   MsgBox, 16, , Incorrect Credentials!`nExiting Now!`nGoodbye!!, 3
   ExitApp
}
MsgBox, Credentials Verified!
Return

; ╞═══════════ MD5 Function 
    MD5( ByRef V, L=0 ) { 	 ; www.autohotkey.com/forum/viewtopic.php?p=275910#275910
 VarSetCapacity( MD5_CTX,104,0 ), DllCall( "advapi32\MD5Init", Str,MD5_CTX )
 DllCall( "advapi32\MD5Update", Str,MD5_CTX, Str,V, UInt,L ? L : VarSetCapacity(V) )
 DllCall( "advapi32\MD5Final", Str,MD5_CTX )
 Loop % StrLen( Hex:="123456789ABCDEF0" )
  N := NumGet( MD5_CTX,87+A_Index,"Char"), MD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)
Return MD5
}

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
Menu, Tray, Icon, compstui.dll, 97

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

