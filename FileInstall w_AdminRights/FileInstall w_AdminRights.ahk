
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
^T:: 	 ; ⮘----(Ctrl+T) 
;○--------------------🔥 HotKey End 🔥------------------------------------○ 



/*
EXAMPLE --> 	FileInstall,  TheFile.txt,  %A_WorkingDir%\NewFileName.txt,  1

MY SAMPLE --> 	FileInstall, TESTING.png, %A_WorkingDir%\TESTED.png, 1 


FileInstall, A, B, C
    A = Extract from Source:  file to be in same directory...or full path name.
    B = Extract to Destination: extracted to %A_WorkingDir% if absolute path not specified.
    C = Overwrite: (Blank or 0 = Do not overwrite existing files.) (1 = Overwrite existing files.)

*/



full_command_line := DllCall("GetCommandLine", "str")


if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}


FileInstall, TESTING.png, %A_WorkingDir%\TESTED.png, 1 
; FileInstall, TESTING.png, C:\Windows\System32\TESTED.png, 1

Return






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
    Soundbeep, 2100, 100
Reload
;○------------------- Script Updater End ---------------------------------○ 

;•--------------------- Auto-Execute Sub ---------------------------------• 
AutoExecute: 
#MaxThreadsPerHotkey, 3
#NoEnv 
#Persistent 
#SingleInstance, Force 
SetBatchLines -1 			 ; Determines how fast script will run.
SetTimer, UpdateCheck, 500 		 ; Checks for script changes every 1/2 second. (Script Updater)
SetTitleMatchMode, 2 		 ; Window's title can contain WinTitle anywhere inside to be a match.
Menu, Tray, Icon, imageres.dll, 98 	 ; Tray note icon.
Return
;○------------------ Auto-Execute Sub End ------------------------------○ 

/* 
 •-------------------------------------------------------------------------------------------------• 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 •-------------------------------------------------------------------------------------------------• 
*/ 

