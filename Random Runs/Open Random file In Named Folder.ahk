
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


;;  F3::SelectRandomItem(RanPen := "C:\YourFolderPath")


^F3::SelectRandomItem(RanPen := "C:\Users\rjcof\Downloads\AHK WIP\Random Runs")
Return

;-------------------------
SelectRandomItem(folderPath) {
    ; Create a Shell application object
    shell := ComObjCreate("Shell.Application")
    
    ; Retrieve the folder object
    try folder := shell.Namespace(folderPath)
    catch {
        MsgBox, 16, Error, Could not open folder: %folderPath%
        Return
    }
    
    ; Check if folder is valid
    if (!folder) {
        MsgBox, 16, Error, Invalid folder: %folderPath%
        Return
    }
    
    ; Get the items in the folder
    items := folder.Items
    itemCount := items.Count
    
    ; Check if the folder contains any items
    if (itemCount = 0) {
        MsgBox, 16, Error, No items found in folder: %folderPath%
        Return
    }
    
    ; Generate a random number within the range of items in the folder
    Random, itemIndex, 0, itemCount-1
    
    ; Get the randomly selected item
    selectedItem := items.Item(itemIndex)
    
    ; Invoke the default action for the selected item (Open/Execute)
    selectedItem.InvokeVerb("open")
    
    ; Clean up
    shell := ""
    folder := ""
    items := ""
    selectedItem := ""
}



^F1:: 
    MsgBox % RanPen






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

