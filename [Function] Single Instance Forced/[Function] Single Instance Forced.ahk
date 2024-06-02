
/*
▎▔▔▔▔▔▔▔▔▔▔▔▔▔▔✎ NOTES ✎▔▔▔▔▔▔▔▔▔▔▔▔▔▔▎ 
 •───────────────────────────────────────────────• 
➤∙ ∙ ∙ ∙ ∙ ∙ ∙ Base Notes ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ 
» Refresh Script ━━━━ Ctrl + HOME key rapidly clicked 2 times. (# TapCounts)
» Exit Script ━━━━━━━━ Ctrl + Escape key rapidly clicked 3 times. (# TapCounts)

» Script Updater: Auto-reload script upon saved changes.
    ⋗ If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.
 •───────────────────────────────────────────────• 
➤∙ ∙ ∙ ∙ ∙ ∙ ∙ Script Specific Notes ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ 
» SOURCE :  https://www.autohotkey.com/board/topic/56956-singleinstance-force-doesnt-work-sometimes/

 •───────────────────────────────────────────────• 
➤ Further notes at bottom of script∙∙∙∙∙∙∙ Yes:     No: ✔ 
▎▁▁▁▁▁▁▁▁▁▁▁▁▁▁ NOTES END ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▎
*/

;⯁═══════════════ Auto-Execute ═══════════════⯁
Gosub, AutoExecute
;○────────── Auto-Execute End ───────────○ 

;⯁══════════════════ Hotkey ══════════════════⯁ 
^T:: 	 ; ═════ (Ctrl + T) 
  Gosub, IndicateDot1
Gui, Color, LIME 	 ; ⬅ ⬅ IndicateDot Color. 
  Gosub, IndicateDot2
;○───────────── Hotkey End ────────────○ 





;;---------- Function Call:
SingleInstanceForcePerfect("YourTitleHere") 	 ; Must be set.



;;---------- Function:
SingleInstanceForcePerfect(WinTitle)
{
DetectHiddenWindows, On
IfWinExist , %WinTitle% 	 ;; If script already running.
WinClose, %WinTitle%
WinSetTitle, %A_ScriptFullPath%, , %WinTitle% 	 ;; The hidden window of the script default name starts with the full path of the script.
}






;⯁════════════ Reload/Exit Routine ════════════⯁ 
WM_LBUTTONDOWN() {
   PostMessage, 0x00A1, 2, 0
} 
RETURN

; ⮞━━━━━ RELOAD ━━━━ RELOAD ━━━━ RELOAD ━━━━━⮜ 
^Home:: 		 ; (Ctrl + ([Home] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 2) 	 ; ⬅ ⬅ Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, YELLOW 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
        Reload
} else {
        KeyWait, Esc
    }
}
Return

; ⮞━━━━━━ EXIT ━━━━━━━━ EXIT ━━━━━━━━ EXIT ━━━━━━━⮜ 
^Esc:: 		 ; (Ctrl + ([Esc] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 3) 	 ; ⬅ ⬅ Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, RED 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
        Gui, Destroy
        ExitApp
} else {
        KeyWait, Esc
    }
}
Return
;○───────── Reload/Exit Routine End ───────○ 


;⯁═══════════════ Script Updater ══════════════⯁
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
; 🠪 🠪 🠪 If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
  Gosub, IndicateDot1
Gui, Color, BLUE 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
Reload
;○────────── Script Updater End ──────────○ 


;⯁═════════════ Auto-Execute Sub ═════════════⯁
AutoExecute: 
#NoEnv ; Recommended for performance and future compatibility.
#Persistent ; Keeps a script permanently running until user closes it or ExitApp is encountered.
#SingleInstance, Force ; Determines whether a script is allowed to run again when it is already running.
SetBatchLines -1 ; Determines how fast script will run.
DetectHiddenWindows, On ; Determines whether invisible windows (scripts) are "seen" by the script.
SetTimer, UpdateCheck, 500 ; Checks for script changes every 1/2 second. (Script Updater)
SetKeyDelay, 250 ; Sets the TapCount. (tied to Reload/Exit routine, w/use for any hotkey)

FormatTime, TimeString, , hh:mm:ss tМ 
Menu, Tray, Tip, Script Start Time`n %TimeString%

; TEMP TRAY ICON 
Loop,
{
Menu, Tray, Icon, imageres.dll, 3
Sleep, 750
Menu, Tray, Icon, imageres.dll, 15
Sleep, 750
}

Return
;○───────── Auto-Execute Sub End ────────○ 


;⯁═════════════════ GoSubs ══════════════════⯁
; ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙ 
IndicateDot1:
Gui, Destroy
SysGet, MonitorWorkArea, MonitorWorkArea
SysGet, TaskbarPos, 4
Gui, +AlwaysOnTop -Caption +hwndHGUI +LastFound
Return
; ∙∙∙∙∙∙∙∙∙∙∙ 
IndicateDot2:
Gui, Margin, 13, 13 	 ; ⬅ ⬅ Dot Size.
Gui, Show, Hide
WinGetPos, , , WinWidth, WinHeight, ahk_id %HGUI%
NewX := MonitorWorkAreaRight - 80
NewY := MonitorWorkAreaBottom - WinHeight - 5
R := Min(WinWidth, WinHeight) // 1 	 ; ⬅ ⬅ Set value of cornering. (0.5=Oval, 0=square, 1= round, 5=rounded corners).
WinSet, Region, 0-0 W%WinWidth% H%WinHeight% R%R%-%R%
Gui, Show, x%NewX% y%NewY%
SoundGet, master_volume
SoundSet, 5
Soundbeep, 2100, 75
SoundSet, % master_volume
Sleep, 100
Gui, Destroy
Return
; ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙ 

;○──────────── GoSubs End ─────────────○ 

/*
____________________________________________________________ 
 ∘⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼∘ 
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ 
*/

