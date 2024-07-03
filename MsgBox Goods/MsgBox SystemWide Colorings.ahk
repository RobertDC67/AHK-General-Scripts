
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
» SOURCE :  
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞-----------------------🔥 HotKey 🔥 
^T:: 		 ; ⮘—— (Ctrl+T) 
    Soundbeep, 1700, 100
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 




;;------------------------------------------------------------------------------------------ 
;;------*** Large spaces are neccessary. Do not remove them!! ***-------- 
;;------------------------------------------------------------------------------------------ 
global COLOR_CAPTIONTEXT				= 9
global COLOR_MENU						= 4
global COLOR_WINDOW						= 5
global COLOR_WINDOWTEXT					= 8

global defaultCOLOR_CAPTIONTEXT := 0x000000
global defaultCOLOR_MENU := 0xF0F0F0
global defaultCOLOR_WINDOW := 0xFFFFFF
global defaultCOLOR_WINDOWTEXT := 0x000000


dwct := Format("0x{:06X}", defaultCOLOR_CAPTIONTEXT)
dmc := Format("0x{:06X}", defaultCOLOR_MENU)
dwbgc := Format("0x{:06X}", defaultCOLOR_WINDOW)
dwtc := Format("0x{:06X}", defaultCOLOR_WINDOWTEXT)


;;-------------------------WARNING---------------------------- 
MsgBox, 3,, 
(
 %A_Space%	* ATTENTION * ATTENTION * ATTENTION *
       This Will Change System Colors For The Entire Pc!!!
   It Should Revert Them To Default Settings At Script End.

	Would You Like To Continue? 
	    Please Press...
		Yes - To Continue
		No - To Exit Script
		Cancel - To Stop Script
), 12
IfMsgBox Yes
    GoTo ContinueOn
IfMsgBox No
    ExitApp
IfMsgBox Cancel
Return


;;------------------------------------------------------------------ 
ContinueOn: 
    MsgBox,,, Default window text color is %dwtc%`nDefault window background color is %dwbgc%`nDefault caption text color is %dwct%`nDefault button menu bar color is %dmc%, 6
        Sleep, 750
    MsgBox,,, Starting Test, 3
        Sleep, 750
;;---------------------- Blue Text / Standard White Background
;;----------- First Test
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOWTEXT, UIntP,0xFF0000) ;BGR
    MsgBox,,, Blue Text`nStandard White Background, 3
        Sleep, 750
;;---------------------- White Text / Red Background / Red Caption Text
;;----------- Second Test
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_CAPTIONTEXT, UIntP,0x4855e6) ;BGR ;red caption text color
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOW, UIntP,0x4855e6) ;BGR ;red windows bg
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_MENU, UIntP, 0x4855e6) ; turns lower half red
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOWTEXT, UIntP,0xffffff) ;BGR ;white text
    MsgBox,,, White text`nRed background`nRed caption text, 3
        Sleep, 750
;;---------------------- White Text / Black Background / Red Caption Text
;;----------- Third Test
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOW, UIntP,0x000000) ;BGR ;black
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_MENU, UIntP, 0x000000)
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOWTEXT, UIntP,0xffffff) ;BGR ;white
    MsgBox,,, White text`nBlack background`nRed caption text, 3
        Sleep, 750
;;---------------------- White Text / Black Background / Red Caption Text / Green Button Bcckground
;; Fourth test
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOW, UIntP,0x000000) ;BGR ;black
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_MENU, UIntP, 0x00FF00) ; This colors the area where the button is
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOWTEXT UIntP,0xffffff) ;BGR ;white
    MsgBox,,, White text`nBlack background`nRed caption text`nGreen button background, 3
        Sleep, 750
;;---------------------- 
MsgBox,,, Resetting system colors to default!!, 3
ResetSystemColors()
MsgBox,,, System colors have been reset to default!!, 3
    ExitApp
Return
;;---------------------- 
ResetSystemColors()
{
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_CAPTIONTEXT, UIntP, defaultCOLOR_CAPTIONTEXT)
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_MENU, UIntP, defaultCOLOR_MENU)
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOW, UIntP, defaultCOLOR_WINDOW)
DllCall("user32\SetSysColors", Int,1, IntP, COLOR_WINDOWTEXT, UIntP, defaultCOLOR_WINDOWTEXT)
}
Return
;;------------------------------------------------------------------ 




; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Reload/Exit Routine -------------------------------∙ 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
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
#MaxThreadsPerHotkey 2
#NoEnv
; #NoTrayIcon
#Persistent
#SingleInstance, Force
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
Menu, Tray, Icon, compstui.dll, 55
Return
;∙---------------------- Auto-Execute Sub End ---------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- GoSubs ----------------------------------------------∙ 
;--------------------------------------------- 

;----------- 

;--------------------------------------------- 
;∙--------------------- GoSubs End -----------------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

