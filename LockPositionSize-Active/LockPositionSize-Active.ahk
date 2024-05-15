
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
» SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=127411#p563958
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 





; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Lock App Position & Size -------------------------∙ 
Gui, -Caption -SysMenu +ToolWindow +HwndDetector
Gui, Show
WinHide, ahk_id %Detector%
DllCall("RegisterShellHookWindow", "UInt", Detector)
Messenger := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")
OnMessage(Messenger, "Recipient"), XY := {}
;--------------------------------------------------------------------------------∙ 
^L:: 	; 🔥 HotKey 🔥
;--------------------------------------------------------------------------------∙ 
    Toggle := !Toggle
        if (Toggle = 1) {
            Soundbeep, 1400, 100
            WinGetPos, X, Y, W, H, A
            XY[ID:=WinExist("A"),1]:=X, XY[ID,2]:=Y, XY[ID,3]:=W, XY[ID,4]:=H
        } else {
            Soundbeep, 1700, 100
            XY.Delete(WinExist("A"))
            Recipient(wParam, lParam){
                Global XY
                For ID, YX in XY {
                    WinMove, ahk_id %ID%,, YX[1], YX[2], YX[3], YX[4]
                    WinActivate, ahk_id %ID%
                }
            }
        }
Return

;∙---------------------- Lock App Position & Size End -------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 





; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Reload/Exit Routine -------------------------------∙ 
RETURN
;------------ RELOAD ------- RELOAD ------- RELOAD ---------  
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)      ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
    Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)      ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Gui, Destroy
        SoundSet, % master_volume
        ExitApp
Return
;∙---------------------- Reload/Exit Routine End -------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Script Updater -------------------------------------∙ 
UpdateCheck:      ; Check if the script file has been modified.
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

