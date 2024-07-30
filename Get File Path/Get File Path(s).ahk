
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
» https://www.autohotkey.com/board/topic/100983-how-can-we-retrieve-the-name-of-a-file-selected/
» By :  Jackie Sztuk _Blackholyman
» Retrieves the file paths for multiple files.
∙---------------------- NOTES END --------------------------------------∙
*/


;;----------------------- Auto-Execute ------------------------------------∙
Gosub, AutoExecute
;;-----------------------------------------------------------------------------∙




;;---------------🔥 HotKey 🔥
^g:: 		 ; ⮘—— (Ctrl+g) or (Ctrl+g+g)
    Soundbeep, 1700, 100
Switch, Morse() {
    Case "0": GoSub, SINGLE_FILE    ;; Single Tap Single File Hotkey.    (Ctrl+g)
    Case "00": GoSub, MULTIPLE_FILES    ;; Double Tap Multiple Files Hotkey.    (Ctrl+g+g)
}
Return

;;------------------------------- Single Tap Single File Hotkey.
SINGLE_FILE:
hwnd := WinExist("A")
for Window in ComObjCreate("Shell.Application").Windows  
    if (window.hwnd==hwnd) {
        Selection := Window.Document.SelectedItems
    for Items in Selection
        Get_File_Path := Items.path
    }
    Clipboard:= Get_File_Path          ;; Optional line.
;    MsgBox,,, % Get_File_Path, 3    ;; Optional line.
    Tooltip, % Get_File_Path             ;; Optional line.
        SetTimer, RemoveToolTip, -3000
Return

;;------------------------------- Double Tap Multiple Files Hotkey.
MULTIPLE_FILES:
selectedFiles := Explorer_GetSelection()
    Clipboard:= selectedFiles
;    MsgBox % selectedFiles
    Tooltip, % selectedFiles
        SetTimer, RemoveToolTip, -3000
Return
;;------
Explorer_GetSelection(hwnd="") {
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (process = "explorer.exe")
        if (class ~= "Progman|WorkerW") {
            ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
            Loop, Parse, files, `n, `r
                ToReturn .= A_Desktop "\" A_LoopField "`n"
        } else if (class ~= "(Cabinet|Explore)WClass") {
            for window in ComObjCreate("Shell.Application").Windows
                if (window.hwnd==hwnd)
                    sel := window.Document.SelectedItems
            for item in sel
                ToReturn .= item.path "`n"
        }
    return Trim(ToReturn,"`n")
}
Return

;;------------------------------------------------ 
Morse(Timeout = 400) {
    Global Pattern := ""
    RegExMatch(A_ThisHotkey, "\W$|\w*$", Key)
    While, !ErrorLevel {
        T := A_TickCount
        KeyWait %Key%
        Pattern .= A_TickCount-T > Timeout
        KeyWait %Key%,% "DT" Timeout/1000
    } Return Pattern
}
Return

;;------------------------------------------------ 
RemoveToolTip:
ToolTip
Return




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

