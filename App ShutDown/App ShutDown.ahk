
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
» See Summary At Script End.
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;;∙---------------------- NOTES END ----------------------------------------∙ 
*/
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;;∙---------------------- Auto-Execute End ---------------------------------∙ 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 




;;================================================
;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;∙--------------∙ Globals ∙--------------∙
AppChoice1 := "AppExample.exe" 	 ;; App to close.   "RSIGuard.exe"
CheckTimer := 3000 			 ;; Runs every 3 seconds.
MaxChecks := 24 			 ;; Maximum number of checks before exit.
CheckCount := 0 			 ;; Counter for checks.

;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;∙--------------∙ Check Timer ∙--------------∙
SetTimer, CheckAPP, %CheckTimer%
;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;∙--------------∙ Attempt To Close If Stubborn ∙--------------∙
Sleep 33000    ;; Wait 35 seconds and
loop, 3        ;; attempt closing if timer has failed.
{
    if WinExist(AppChoice1) {
        WinWait, %AppChoice1%    ;; Allow app time to accept commands.
        WinClose, %AppChoice1%   ;; Close app.
    }
    Sleep, 100
}
loop, 3        ;; Last ditch effort if app still active.
{
    if WinExist(AppChoice1) {
        WinWait, %AppChoice1%    ;; Allow app time to accept commands.
        WinKill, %AppChoice1%    ;; Terminate!
    }
    Sleep, 100
}
ExitApp
Return
;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;∙--------------∙ Close If Present Function ∙--------------∙
CheckAPP:
CheckCount++
If (ProcessExist(AppChoice1)) {    ;; Check if process running.
    Sleep, 5000
    If (ProcessExist(AppChoice1)) {    ;; Check if process still running.
        Process, Close, %AppChoice1%    ;; If still running, terminate process.
        Sleep, 100
        Menu, Tray, Icon, netshell.dll, 123    ;; Small Red 'X' (lower left)
        Sleep, 400
        ExitApp
    }
} else if (CheckCount >= MaxChecks) {  ;; If max checks reached and process not found
    ExitApp
}
Return
;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;∙--------------∙ Is Process Present Function ∙--------------∙
ProcessExist(Name) {
    Process, Exist, %Name%
    Return ErrorLevel
}
Return
;;∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙-∙∙
;;================================================




; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Reload/Exit Routine -------------------------------∙ 
RETURN
;∙--------------∙ RELOAD ------- RELOAD ------- RELOAD ---------∙ 
^Home:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
    Reload
Return
;∙--------------∙ EXIT ------------ EXIT --------- EXIT ------------∙
^Esc:: 
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200) 	 ; ←←← Double-Tap in less than 200 milliseconds.
    Soundbeep, 1700, 75
        ExitApp
Return
;;∙--------------∙ Reload/Exit Routine End -------------------------∙ 
;; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;;∙--------------∙ Script Updater -------------------------------------∙ 
UpdateCheck: 	 ;; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
;;∘—— If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 2100, 100
Reload
;;∙--------------∙ Script Updater End --------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;;∙--------------∙ Auto-Execute Sub ----------------------------------∙ 
AutoExecute:
#MaxThreadsPerHotkey 2
#NoEnv
;; #NoTrayIcon
#Persistent
#SingleInstance, Force
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
Menu, Tray, Icon, imageres.dll, 93 	 ;; Small Gray 'X' (lower left)
Return
;;∙--------------∙ Auto-Execute Sub End ---------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 



/*  		***  SUMMARY  ***

This AutoHotkey (AHK) script is designed to manage and ensure the closure of a specific application noted by "AppChoice1" at beginning of script.
Below is an in-depth summary of its functionality and structure.

Global Variables...
    1. AppChoice1:	Specifies the application to be closed, set to "AppExample.exe".
    2. CheckTimer:	Interval (in milliseconds) for the timer to run, set to 3000 ms (3 seconds).
    3. MaxChecks:	Maximum number of checks to be performed before the script exits, set to 24.
    4. CheckCount:	Counter for the number of checks performed, initialized to 0.

Main Workflow...
    1. Set Timer:
	• A timer named CheckAPP is set to trigger every 3 seconds (%CheckTimer%).

    2. Attempt To Close If Stubborn:
	• The script waits for 33 seconds before starting a loop.
	• In the first loop (3 iterations), it checks if the application window exists and attempts to close it using WinClose.
	• If the application still exists, a second loop (3 iterations) attempts to forcefully terminate it using WinKill.

Exit Script: 
	• The script then exits using ExitApp.

CheckAPP Timer Function...
    • Increment Check Count:
	• The CheckCount is incremented each time the function is called.

    • Check If Process Exists:
	•  The function ProcessExist is called to determine if AppExample.exe is running.
	• If the process is found, the script waits 5 seconds and checks again to confirm persistence.
	• If the process is still running after the second check, it is closed using Process, Close.
	• The system tray icon is briefly changed to indicate action taken.
	• The script then exits using ExitApp.

    • Maximum Checks Reached:
		• If CheckCount reaches MaxChecks without finding the process, the script exits.

ProcessExist Function...
    • Check Process:
	• This function checks for the existence of a process by its name.
	• Process, Exist, %Name% sets the ErrorLevel to the process ID if it exists, otherwise ErrorLevel is set to 0.
	• The function returns ErrorLevel.


Summary Of Script Flow...
    1. Initialization:
	• Sets global variables.
	• Starts a timer to run CheckAPP every 3 seconds.

    2. CheckAPP Execution:
	• Increments the check counter.
	• Checks if the process AppExample.exe is running.
	• If the process is running, waits 5 seconds and checks again.
	• If still running, tries to close the process.
	• If CheckCount exceeds MaxChecks without detecting the process, exits.

    3. Post-Delay Attempts:
	• After 33 seconds, loops to close the application window if it still exists.
	• If closing fails, forcefully kills the process.

    4. Exit:
	• Exits the script.


Intended Functionality...
    The script is designed to:
	• Regularly check if AppExample.exe is running.
	• Attempt to close the application gracefully.
	• If the application is stubborn and remains open, forcefully terminate it.
	• Ensure that these operations are performed within a specified number of checks to avoid running indefinitely.
	• This script automates the process of managing the specified application, ensuring it is closed or terminated within a structured timeframe.

*/