
/*
; ╞═══════════ Notes ═══════════╡ 
» Refresh AHK System Tray Icons. Removes 'Ghost' icons occasionally left behind upon closing.

» Refresh Script ════  Ctrl + HOME key rapidly clicked 2 times. (# TapCounts)
» Exit Script ════════  Ctrl + Escape key rapidly clicked 3 times. (# TapCounts)

» Script Updater: Auto-reload script upon saved changes.
    ─ If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.

» SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?t=19832
» Revision of: masato

» teadrinker's solution :  viewtopic.php?f=76&t=93964&p=416478&hilit=RemoveTrayIcon#p436590
; ╞──────── Notes End ────────╡
*/

; ╞═══════════ Auto-Execute ═══════════╡ 
Gosub, AutoExecute

; ╞──────── Auto-Execute End ────────╡ 

; ╞═══════════ Hotkeys ═══════════╡ 
^T:: 	 ; ═════ (Ctrl + T) 
  Gosub, IndicateDot1
Gui, Color, LIME 		 ; ←←← IndicateDot Color.
  Gosub, IndicateDot2

; ╞────────  Hotkeys End ────────╡ 



Tray_Refresh() 	 ; ←←← Place where wanted in script to call Function. 


; ╞═══════════ THE FUNCTION ═══════════╡ 
Tray_Refresh() {
    WM_MOUSEMOVE := 0x200
    detectHiddenWin := A_DetectHiddenWindows
    DetectHiddenWindows, On

    allTitles := ["ahk_class Shell_TrayWnd"
            , "ahk_class NotifyIconOverflowWindow"]
    allControls := ["ToolbarWindow321"
                ,"ToolbarWindow322"
                ,"ToolbarWindow323"
                ,"ToolbarWindow324"
                ,"ToolbarWindow325"
                ,"ToolbarWindow326"]
    allIconSizes := [24,32]

    for id, title in allTitles {
        for id, controlName in allControls
        {
            for id, iconSize in allIconSizes
            {
                ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
                y := htTray - 10
                While (y > 0)
                {
                    x := wdTray - iconSize/2
                    While (x > 0)
                    {
                        point := (y << 16) + x
                        PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
                        x -= iconSize/2
                    }
                    y -= iconSize/2
                }
            }
        }
    }
    DetectHiddenWindows, %detectHiddenWin%
}

; ╞═══════════ THE FUNCTION END ═══════════╡ 


/*
▎▞▞▞▞▞▞▞▞▞▞▎ EXAMPLE ▎▚▚▚▚▚▚▚▚▚▚▎

#SingleInstance, Off
#Persistent

Loop, %0% { 		 ; Command-Line Parameters
    param := %A_Index%
    if (param="/Secondary")
        isSecondary := true
}

if !(isSecondary) {
    AHK_PIDS := {}
    Progress, , ,Running multiple process of the script,Tray_Refresh
    Loop 5 { 		 ; Running instances
        Progress,% (100/5) * A_Index
        
        Run,% A_ScriptFullPath " /Secondary", , ,scriptPID
        AHK_PIDS.Push(scriptPID)
        Sleep 10
    }
    Progress, Off
    for id, pid in AHK_PIDS { 	 ; Closing instances
        Process, Close,% pid
    }
    Sleep 100
    MsgBox, 4096,Tray_Refresh,% "Close this box to remove all dead icons from the tray."
    Tray_Refresh() 		 ; ←←← FUNCTION CALL 
    ExitApp
}
Return

◘・・・・・・・・・・・・・・・・・・・ THE FUNCTION ・・・・・・・・・・・・・・・・・・・◘ 
Tray_Refresh() {
    WM_MOUSEMOVE := 0x200
    detectHiddenWin := A_DetectHiddenWindows
    DetectHiddenWindows, On

    allTitles := ["ahk_class Shell_TrayWnd"
            , "ahk_class NotifyIconOverflowWindow"]
    allControls := ["ToolbarWindow321"
                ,"ToolbarWindow322"
                ,"ToolbarWindow323"
                ,"ToolbarWindow324"]
    allIconSizes := [24,32]

    for id, title in allTitles {
        for id, controlName in allControls
        {
            for id, iconSize in allIconSizes
            {
                ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
                y := htTray - 10
                While (y > 0)
                {
                    x := wdTray - iconSize/2
                    While (x > 0)
                    {
                        point := (y << 16) + x
                        PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
                        x -= iconSize/2
                    }
                    y -= iconSize/2
                }
            }
        }
    }

    DetectHiddenWindows, %detectHiddenWin%
}

▎▞▞▞▞▞▞▞▞▎ EXAMPLE END ▎▚▚▚▚▚▚▚▚▚▎
*/


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

