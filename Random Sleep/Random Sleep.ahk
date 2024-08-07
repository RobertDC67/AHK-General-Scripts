
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
» 
» 
∙---------------------- NOTES END --------------------------------------∙
*/


;;----------------------- Auto-Execute ------------------------------------∙
Gosub, AutoExecute
;;-----------------------------------------------------------------------------∙

;;----------------------- 🔥 HotKey 🔥 -------------------------------------∙
^T::        ;; ⮘---(Ctrl+T) 
    Soundbeep, 1100, 100
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙




RandSleep()    ;;---- Call the RandSleep function.


RandSleep()
{
    global RandomSleep    ;;---- Declare the RandomSleep variable as global.
    Random, RandomSleep, 10, 5000    ;;---- Generate a random number between 10 and 5000 milliseconds and store it in RandomSleep.
    Sleep %RandomSleep%    ;;---- Pause execution for the duration of RandomSleep (in milliseconds).
    RandomSleepSeconds := RandomSleep / 1000    ;;---- Convert RandomSleep from milliseconds to seconds for display.
    RandomSleepSecondsFormatted := Format("{:.2f}", RandomSleepSeconds)    ;;---- Format RandomSleepSeconds to 2 decimal places.
    ToolTip, This is a Random Sleep: %RandomSleepSecondsFormatted% seconds, , 450    ;;---- Display a tooltip with the formatted random sleep time.
        SetTimer, ToolTipGone, -5000    ;;---- Set a timer to remove the tooltip after 5 seconds.
    MsgBox, , , This is a Random Sleep: %RandomSleepSecondsFormatted% seconds, 5    ;;---- Display a message box with the formatted random sleep time.
}

ToolTipGone:    ;;---- Label to handle the timer event.
    ToolTip    ;;---- Remove the tooltip.
Return    ;;---- End the label.




;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;----------------------- Reload / Exit -------------------------------------∙
RETURN
;;------ RELOAD --------- RELOAD -------∙
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)        ;; Double-Tap in less than 200 milliseconds.
    Soundbeep, 1400, 75
    Reload
Return
;;------------ EXIT ------ EXIT -------------∙
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)        ;; Double-Tap in less than 200 milliseconds.
    Soundbeep, 1400, 75
        ExitApp
Return
;;-----------------------------------------------------------------------------∙

;;----------------------- Script Updater ----------------------------------∙
UpdateCheck:        ;; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 1700, 100
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

