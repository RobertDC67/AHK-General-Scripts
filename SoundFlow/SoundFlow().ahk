
/*
∙--------------------- NOTES ----------------------------------------------∙
∙------∙ SCRIPT DEFAULTS ∙------∙
» Reload Script-------- DoubleTap--⮚ Ctrl + [HOME] 
» Exit Script------------- DoubleTap--⮚ Ctrl + [Esc] 
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
» 
∙------∙ SOURCE ∙------------------∙
» Defines a set of sound notifications through different beep tones. Each notification corresponds to a specific use case.
» Each case plays distinct beeps with varying frequencies and durations based on the selected rhythm.
∙---------------------- NOTES END --------------------------------------∙
*/


;;----------------------- Auto-Execute ------------------------------------∙
Gosub, AutoExecute
;;-----------------------------------------------------------------------------∙



/*
Use Cases...
    ▹ SoundFlow(UP)  	Low/High
    ▹ SoundFlow(DOWN)  	High/Low
    ▹ SoundFlow(STOP)  	Low/Low
    ▹ SoundFlow(ANNC)  	High/High
    ▹ SoundFlow(PING)  	High+
*/



;;---------------------------------------------------
UP := "1", DOWN := "2", STOP := "3", ANNC := "4", PING := "5"

^t::    ;;------ Use Case Examples...
    SoundFlow(UP)
        Sleep, 750
    SoundFlow(STOP)
        Sleep, 750
    SoundFlow(PING)
Return


;;---------------------------------------------------
SoundFlow(rhythm) {
    Switch (rhythm) {
        Case "1":                ;; Ascending Up Notification. (LowTone/Short - HighTone/Long)
            SoundBeep, 1200, 100
            SoundBeep, 1400, 75
        Case "2":                ;; Descending Down Notification. (HighTone/Short - LowTone/Long)
            SoundBeep, 1400, 75
            SoundBeep, 1200, 100
        Case "3":                ;; Rescinding (Stop) Alert Notification. (LowTone/Long - LowTone/Long)
            SoundBeep, 1200, 200
            SoundBeep, 1200, 200
        Case "4":                ;; Announcing Notification. (HighTone/Short - HighTone/Short)
            SoundBeep, 1400, 100
            SoundBeep, 1400, 100
        Case "5":                ;; Pinging Acknowledgement Notification. (HighTone/Medium)
            SoundBeep, 1500, 150
    }
}
Return







;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;----------------------- Reload / Exit -------------------------------------∙
RETURN
;;------ RELOAD --------- RELOAD -------∙
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)        ;; Double-Tap in less than 200 milliseconds.
;    Soundbeep, 1400, 75
    Reload
Return
;;------------ EXIT ------ EXIT -------------∙
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)        ;; Double-Tap in less than 200 milliseconds.
;    Soundbeep, 1400, 75
        ExitApp
Return
;;-----------------------------------------------------------------------------∙

;;----------------------- Script Updater ----------------------------------∙
UpdateCheck:        ;; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
;    Soundbeep, 1700, 100
Reload
;;-----------------------------------------------------------------------------∙

;;----------------------- Auto-Execute Sub ------------------------------∙
AutoExecute:
#MaxThreadsPerHotkey 3
#NoEnv
;;  #NoTrayIcon
#Persistent
#SingleInstance, Force
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
Menu, Tray, Icon, compstui.dll, 55
Return
;;-----------------------------------------------------------------------------∙

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;     ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙

