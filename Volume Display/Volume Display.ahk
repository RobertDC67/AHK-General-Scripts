
/*
;⮞--------------------- NOTES ----------------------------------------------∙ 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
∙--------------∙ Base Notes ∙--------------∙ 
» Reload Script-------- DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script------------- DoubleTap--⮚ Ctrl + [Esc] 
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
∙--------------∙ Script Specific Notes ∙--------------∙ 
» SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=128178#p566161
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 




SWide := A_ScreenWidth - 53
SHigh := A_ScreenHeight - 40
GWidth := 48
GHeight := 41

TaskbarAreaX := A_ScreenWidth - 153  ; 400 pixels from the right side of the screen
TaskbarAreaY := A_ScreenHeight - 39  ; 50 pixels from the bottom of the screen


SetTimer, ShowVol, 500 	 ;; Keeps above taskbar in z-order.
SetTimer, RefreshTime, 15000


Gui, 
    +AlwaysOnTop
    -Caption
;    +E0x20 			 ;; Comment out to stop click-through ability.
    +LastFound
    +ToolWindow
 WinSet Transparent, 255 	 ;; Full Opaqueness

Gui, Color, 1B1F21
GUI, Margin, 3, 2

Gui, Font, s6 w600 cAQUA q5, VERDANA 		 ;; Aqua Volume.
Gui, Add, Text, x3 y6 gVolume, VOLUME

Gui, Font, s12 w400 cLIME q5, CALIBRI 		 ;; Lime % Volume Value.
Gui, Add, Text, x5 y16 w%GWidth% BackgroundTrans vVolumeText, 

Gui, Show, x%SWide% y%SHigh% w%GWidth% h%GHeight% NA, Vol-Level
    SetTimer, UpdateVolume, 500
Return

;;------------------ 
UpdateVolume:
    SoundGet, Volume
    VolumePercentage := Round(Volume)
    if (Volume == 0) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s6 w600 cC0C0C0 q5, VERDANA 	 ;; SILVER > MUTED VOLUME.
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, MUTE 		 ;; MUTED VOLUME.  BOLD
    }
    else if (Volume == 100) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s10 w600 cFF0000 q5, VERDANA 	;; RED > MAX VOLUME.
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, MAX 		 ;; MAXED VOLUME.  BOLD
    }
    else if (Volume >= 25 && Volume <= 35) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cBFFF00 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Lime/Yellow Zone.	25-35
    }
    else if (Volume >= 35 && Volume <= 50) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cFFFF00 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Yellow Zone.	35-50
    }
    else if (Volume >= 50 && Volume <= 65) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cFFBE00 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Yellow/Orange Zone.	50-65
    }
    else if (Volume >= 65 && Volume <= 80) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cFF8000 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Orange Zone.	65-80
    }
    else if (Volume >= 80 && Volume <= 90) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cFF5500 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Orange/Red Zone.	80-90
    }
    else if (Volume >= 90 && Volume <= 99) {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cFF1111 q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Red Zone.	90-99
    }
    else {
        GuiControl, -Redraw, VolumeText
            Gui, Font, s12 w400 cLIME q5, CALIBRI 
            GuiControl, Font, VolumeText
        GuiControl, +Redraw, VolumeText
        GuiControl,, VolumeText, %VolumePercentage%`% 	 ;; Lime > Comfort Zone Volume. 1-24
    }
Return

ShowVol:
Gui, Show, NA, Vol-Level
Return

Volume:
SoundSet, 1
Return

;;+++++++VOLUME HOVER+++++++ 
;;==========UP=========== 
~WheelUp:: 		 ; ~ = When the hotkey fires, its key's native function will not be blocked (hidden from the system).
CoordMode, Mouse, Screen
MouseGetPos, xPos, yPos

if (xPos >= TaskbarAreaX && yPos >= TaskbarAreaY && xPos <= (TaskbarAreaX + 150) && yPos <= (TaskbarAreaY + 40))
{
SoundSet +2
}
Return
;;========DOWN========= 
~WheelDown:: 		 ; ~ = When the hotkey fires, its key's native function will not be blocked (hidden from the system).
CoordMode, Mouse, Screen
MouseGetPos, xPos, yPos

if (xPos >= TaskbarAreaX && yPos >= TaskbarAreaY && xPos <= (TaskbarAreaX + 150) && yPos <= (TaskbarAreaY + 40))
{
SoundSet -2
}
Return
;;+++++++   ∙   +++++++   ∙   +++++++


RefreshTime:
    Reload
Return

; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
WM_LBUTTONDOWNdrag() { 	 ; Gui Drag Pt.2
   PostMessage, 0x00A1, 2, 0
} 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Reload/Exit Routine -------------------------------∙ 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
    Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
        ExitApp
Return
;∙---------------------- Reload/Exit Routine End -------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Script Updater -------------------------------------∙ 
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
;∘—— If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 2100, 100
Reload
;∙---------------------- Script Updater End --------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute Sub ----------------------------------∙ 
AutoExecute: 
#NoEnv 
#NoTrayIcon
#Persistent 
#SingleInstance, Force 
SetBatchLines -1 
SetTimer, UpdateCheck, 500 
SetTitleMatchMode, 2 
SoundGet, master_volume
; Menu, Tray, Icon, shell32.dll, 249
Return
;∙---------------------- Auto-Execute Sub End ---------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- GoSubs Sub ----------------------------------------∙ 
;--------------------------------------------- 

;----------- 

;--------------------------------------------- 
;∙--------------------- GoSubs Sub End -----------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

