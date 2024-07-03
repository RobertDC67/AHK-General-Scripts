
/*
◘◘◘◘◘◘◘◘◘◘◘◘◘ ✎ NOTES ✎ ◘◘◘◘◘◘◘◘◘◘◘◘◘
•------------------------------------------------------------------------------• 
○-------------------------  Base Notes -------------------------○ 
» Refresh Script-------- Ctrl + [HOME] key rapidly clicked 2 times. 
» Exit Script------------- Ctrl + [Esc] key rapidly clicked 2 times. 

» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
•------------------------------------------------------------------------------• 
○--------------------  Script Specific Notes --------------------○ 
» SOURCE :  
» 
•------------------------------------------------------------------------------• 
○------ Further notes at script end ∙ ∙ ∙  Yes:   No: ✔ ------○
•------------------------------------------------------------------------------• 
◘◘◘◘◘◘◘◘◘◘◘ ✎ NOTES END ✎ ◘◘◘◘◘◘◘◘◘◘◘◘
*/

;•--------------------- Auto-Execute ---------------------------------------• 
Gosub, AutoExecute
;○--------------------- Auto-Execute End ---------------------------------○ 

;•-----------------------🔥 HotKey 🔥---------------------------------------•
^T:: 		 ; ⮘—— (Ctrl+T) 
  Gosub, IndicateDot1
Gui, Color, LIME 	 ; ← ← IndicateDot Color. 
  Gosub, IndicateDot2
;○--------------------🔥 HotKey End 🔥------------------------------------○ 




OnMessage(0x44, "MyMsgBox")
MsgBox 0x84, MsgBox, Testing text here., 3
OnMessage(0x44, "")

IfMsgBox Yes, { 		 ; Retry Button.
        Soundbeep, 1300, 150
            Soundbeep, 1500, 150
    } Else IfMsgBox No, { 	 ; Exit Button.
        Soundbeep, 1200, 150
    Soundbeep, 1000, 150
} Else IfMsgBox Timeout, { 	 ; If Timed Out.
        Soundbeep, 1250, 150
            Soundbeep, 1500, 150
        Soundbeep, 1250, 150
    Soundbeep, 1000, 150
}

MyMsgBox() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        hIcon := LoadPicture("comctl32.dll", "w32 Icon4", _)
        SendMessage 0x172, 1, %hIcon%, Static1 ; STM_SETIMAGE

        ControlSetText Button1, Retry
        hIcon := LoadPicture("imageres.dll", "h16 Icon142", _)
        SendMessage 0xF7, 1, %hIcon%, Button1

        ControlSetText Button2, Exit
        hIcon := LoadPicture("imageres.dll", "h16 Icon163", _)
        SendMessage 0xF7, 1, %hIcon%, Button2
    }
}
Return





;•--------------------- Gui Drag ---------------------------------------------• 
;-------------- Gui Drag Pt.1 ------------
;    OnMessage(0x0201, "WM_LBUTTONDOWN") 
;-------------- Gui Drag Pt.2 ------------
WM_LBUTTONDOWN() { 
   PostMessage, 0x00A1, 2, 0
} 
;○-------------------- Gui Drag End ----------------------------------------○ 

;•--------------------- Reload/Exit Routine -------------------------------• 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
        Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
        Gui, Destroy
        ExitApp
Return
;○------------------ Reload/Exit Routine End ----------------------------○ 

;•--------------------- Script Updater -------------------------------------• 
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
;∘—— If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
  Gosub, IndicateDot1
    Soundbeep, 2100, 100
Gui, Color, BLUE 	 ; ← ← IndicateDot Color.
  Gosub, IndicateDot2
Reload
;○------------------- Script Updater End ---------------------------------○ 

;•--------------------- Auto-Execute Sub ---------------------------------• 
AutoExecute: 
#NoEnv 				 ; Recommended for performance and future compatibility.
#Persistent 			 ; Keeps a script permanently running until user closes it or ExitApp is encountered.
#SingleInstance, Force 		 ; Determines whether a script is allowed to run again when it is already running.
DetectHiddenWindows, On 		 ; Determines whether invisible windows (scripts) are "seen" by the script.
SetBatchLines -1 			 ; Determines how fast script will run.
SetTimer, UpdateCheck, 500 		 ; Checks for script changes every 1/2 second. (Script Updater)
SetTitleMatchMode, 2 		 ; Window's title can contain WinTitle anywhere inside to be a match.
SetTitleMatchMode, RegEx 		 ; Changes WinTitle, WinText, ExcludeTitle, and ExcludeText to accept regular expressions.
Menu, Tray, Icon, imageres.dll, 98 	 ; Tray note icon.
; Menu, Tray, Icon, shell32.dll, 51 	 ; Tray blank icon.
Return
;○------------------ Auto-Execute Sub End ------------------------------○ 

;•----------------------- GoSubs -------------------------------------------• 
;--------------------------------------------- 
IndicateDot1:
Gui, Destroy
SysGet, MonitorWorkArea, MonitorWorkArea
SysGet, TaskbarPos, 4
Gui, +AlwaysOnTop -Caption +hwndHGUI +LastFound
Return
;----------- 
IndicateDot2:
Gui, Margin, 13, 13 	 ; ← ← Dot Size.
Gui, Show, Hide
WinGetPos, , , WinWidth, WinHeight, ahk_id %HGUI%
NewX := MonitorWorkAreaRight - 80
NewY := MonitorWorkAreaBottom - WinHeight - 5
R := Min(WinWidth, WinHeight) // 1 	 ; ← ← Set value of cornering. (0.5=Oval, 0=square, 1= round, 5=rounded corners).
WinSet, Region, 0-0 W%WinWidth% H%WinHeight% R%R%-%R%
Gui, Show, x%NewX% y%NewY%
Sleep, 150
Gui, Destroy
Return
;--------------------------------------------- 
;○--------------------- GoSubs End ---------------------------------------○ 

/* 
 •-------------------------------------------------------------------------------------------------• 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 •-------------------------------------------------------------------------------------------------• 
*/ 

