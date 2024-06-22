
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
» Monitors a specified directory for changes to AHK scripts and reloads them if they are modified.  
» See script end for summary...
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 


^F3:: 	 ; (Ctrl+F3)
MsgBox, , , This script ensures that any changes made`n`nto the AHK scripts in the specified directory`n`nare automatically detected and reloaded`n`nwithout manual intervention., 8
Return


;;--------------------------------------------- 

;;----------- SET THE POLLING INTERVAL.... (in milliseconds to check for changes)
pollingInterval := 1000

;;----------- SET THE DIRECTORY PATH.... (where your scripts are located)
scriptDirectory := "C:\Path\To\Scripts"

;;----------- SET THE FILE EXTENSION FOR YOUR SCRIPTS.... (default is .ahk)
scriptExtension := ".ahk"

;;----------- Create an array to store the modified timestamps of the scripts
lastModified := {}

;;--------------------------------------------- 

;;----------- Initialize the script
InitAutoReLoads()

;;--------------------------------------------- 

;;----------- Function to initialize the AutoReLoads script
InitAutoReLoads()
{
    ;----- Set a timer to call the CheckScripts function periodically
    SetTimer, CheckScripts, %pollingInterval%
}

;;----------- Function to check for modified scripts and reload them if necessary
CheckScripts()
{
    ;----- Get a list of running scripts
    scripts := GetRunningScripts()
    
    ;----- Loop through the running scripts
    for index, script in scripts
    {
        scriptName := GetScriptName(script)
        if (scriptName <> "")
        {
            ;----- Check if the script has been modified
            modified := IsScriptModified(scriptName)
            if (modified)
            {
                ;----- Reload the modified script
                ReloadScript(scriptName)
                lastModified[scriptName] := FileGetTime(scriptName, "M")
            }
        }
    }
    
    ;----- Check if the AutoReLoads script itself has been modified
    modified := IsScriptModified(A_ScriptFullPath)
    if (modified)
    {
        ;----- Reload the AutoReLoads script
        ReloadScript(A_ScriptFullPath)
        lastModified[A_ScriptFullPath] := FileGetTime(A_ScriptFullPath, "M")
    }
}

;;----------- Function to get a list of running scripts
GetRunningScripts()
{
    Process, Exist, AutoHotkey.exe
    processID := ErrorLevel
    Process, Close, AutoHotkey.exe
    
    scripts := []
    
    ;----- Loop through the running processes
    Loop, % processID
    {
        pid := A_LoopField
        script := GetScriptFromPID(pid)
        if (script <> "")
            scripts.Push(script)
    }
    
    return scripts
}

;;----------- Function to get the script path from a process ID
GetScriptFromPID(pid)
{
    for process in ComObjGet("winmgmts:").ExecQuery("SELECT ExecutablePath FROM Win32_Process WHERE ProcessId=" pid)
    {
        scriptPath := process.ExecutablePath
        if (InStr(scriptPath, scriptDirectory) = 1 && SubStr(scriptPath, -StrLen(scriptExtension)) = scriptExtension)
            return scriptPath
    }
    
    return ""
}

;;----------- Function to get the script name from the full script path
GetScriptName(scriptPath)
{
    return SubStr(scriptPath, InStr(scriptPath, "\", 0, -1) + 1)
}

;;----------- Function to check if a script has been modified
IsScriptModified(scriptName)
{
    currentModified := FileGetTime(scriptName, "M")
    lastModified := lastModified[scriptName]
    return (currentModified <> lastModified)
}

;;----------- Function to reload a script
ReloadScript(scriptName)
{
    Process, Close, % scriptName
    Run, % scriptName
}

;;----------- Function to get the modified timestamp of a file
FileGetTime(fileName, timeType)
{
    FileGetTime, modifiedTime, % fileName, % timeType
    return modifiedTime
}






; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Gui Drag ---------------------------------------------∙ 
;;-------------- Gui Drag Pt.1 ------------
;    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")    ; Gui Drag Pt.1
;;-------------- Gui Drag Pt.2 ------------ (keep towards script end)
WM_LBUTTONDOWNdrag() {    ; Gui Drag Pt.2
   PostMessage, 0x00A1, 2, 0
} 
;∙---------------------- Gui Drag End ---------------------------------------∙ 
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
#Persistent
#SingleInstance, Force
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
Menu, Tray, Icon, compstui.dll, 55
Return
;∙---------------------- Auto-Execute Sub End ---------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/*
⮞--------------------- Summary -------------------------------------------∙ 

This script ensures that any changes made to the AHK scripts in the specified directory are automatically detected and reloaded without manual intervention.

;----------- 

SETTINGS AND INITIALIZATION:
  • pollingInterval - Set to 1000 milliseconds (1 second) to check for script changes.
  • scriptDirectory - Specifies the directory path where the scripts are located.
  • scriptExtension - Set to ".ahk" for AutoHotkey scripts.
  • lastModified - An array to store the last modified timestamps of the scripts.

MAIN INITIALIZATION FUNCTION:
  • InitAutoReLoads() - Sets up a timer to call the CheckScripts function periodically based on the polling interval.

CHECKING AND RELOADING SCRIPTS:
  • CheckScripts():
      ∘ Retrieves a list of running scripts using GetRunningScripts().
      ∘ Iterates through each running script, checking if it has been modified using IsScriptModified(scriptName).
      ∘ Reloads the script if it has been modified using ReloadScript(scriptName).
      ∘ Updates the last modified timestamp in the lastModified array.
      ∘ Also checks if the AutoReLoads script itself has been modified and reloads it if necessary.

HELPER FUNCTIONS:
  • GetRunningScripts() - Retrieves a list of running scripts by checking running processes.
  • GetScriptFromPID(pid) - Gets the script path from a process ID, filtering scripts based on the directory and file extension.
  • GetScriptName(scriptPath) - Extracts the script name from the full script path.
  • IsScriptModified(scriptName) - Checks if a script has been modified by comparing the current and last modified timestamps.
  • ReloadScript(scriptName) - Closes and restarts the specified script.
  • FileGetTime(fileName, timeType) - Retrieves the modified timestamp of a file.

⮞--------------------- Summary End --------------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

