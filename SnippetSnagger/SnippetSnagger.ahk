
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




;;======Set Paths============================
;;------ Keep the Back\Slash and change the Folder and File names between the "quotes".
;;------    ~  Same Folder\File as script  ~
;FolderPath := A_ScriptDir "\FolderName"
FolderPath := A_ScriptDir "\Snagged"

;FilePath := FolderPath "\FileName.txt"
FilePath := FolderPath "\Snips.txt"

;;------    ~  Separate folder\file located elsewhere  ~ *Use for full Folder and File paths.
; FolderPath := "C:\Full\Path\To\Your\Folder"
; FilePath := "C:\Full\Path\To\Your\File.txt"
;;==========================================

;;====== 🔥 HotKey 🔥 ======
^+c::        ;; ⮘---(Ctrl+Shift+c)
    Soundbeep, 1100, 100

;;====== Store then clear current clipboard content.
ClipSaved := ClipboardAll
    Sleep, 100
Clipboard := ""

;;====== Save currently highlighted text to clipboard.
Send, ^c
ClipWait, 2
    if ErrorLevel
    {
        MsgBox,,, Copy text to clipboard has failed., 3
        return
    }

;;====== Ensure the directory exists.
if !FileExist(FolderPath)
    {
        FileCreateDir, %FolderPath%
    }

;;====== Check if the file exists and its size.
fileContent := ""    ;;------ Store file content.
fileSize := 0
    if FileExist(FilePath)
    {
        FileGetSize, fileSize, %FilePath%
        if (fileSize > 0)
        {
            File := FileOpen(FilePath, "r", "UTF-8")    ;;------ Open file in read mode.
            if !File
            {
                MsgBox,,, % "Unable to open file for reading:n" TruncatedPath(FilePath), 3
                Clipboard := TruncatedPath(FilePath)
                return
            }
            fileContent := File.Read()    ;;------ Read file content.
            File.Close()
        }
    }

;;====== Append the clipboard contents to the file.
File := FileOpen(FilePath, "a", "UTF-8")
if !File
    {
        MsgBox,,, % "Unable to open or create file:n" TruncatedPath(FilePath), 3
        Clipboard := TruncatedPath(FilePath)
        return
    }

;;====== Write new line first if file is not empty.
if RegExMatch(fileContent, "\S")    ;;------ Check for non-whitespace characters.
    {
        File.Write("`n")
    }

;;====== Write clipboard contents.
File.Write(Clipboard)
File.Close()

;;====== Activate Notepad and ensure it's the correct Notepad instance. ======
if WinExist("ahk_class Notepad")
{
    WinActivate
    WinWaitActive, ahk_class Notepad
    Sleep, 100

    ; Ensure the correct file is active in Notepad
    WinGetTitle, NotepadTitle
    If (NotepadTitle = "Log Entries.txt - Notepad")
    {
        Send, ^{End}
            Sleep, 100
        Send, {Enter}
            Sleep, 100
        Send, ^v
            Sleep, 100
        Send, ^s
    }
    else
    {
        MsgBox,,, % "The active Notepad window is not 'Log Entries.txt'.", 3
    }
}
else
{
    Soundbeep, 1700, 75
    Sleep, 200
;    Run, notepad.exe "%FilePath%"    ;;------ Leave Run commented for silent 'txt' file updating.
}

;;====== Restore previous clipboard contents.
Clipboard := ClipSaved
Return

;;====== View 'txt' file ========================
^F1::
    Run, notepad.exe "%FilePath%"
Return

;;====== Truncate Function ===================
TruncatedPath(Path) {
    Drive := SubStr(Path, 1, InStr(Path, "\") - 1)
    Path := SubStr(Path, InStr(Path, "\") + 1)
    LastFolder := RegExReplace(Path, ".*\\(.*)\\[^\\]*$", "$1")
    FileName := RegExReplace(Path, ".*\\([^\\]*)$", "$1")
    TruncedPath := Drive . "\...\\" . LastFolder . "\" . FileName
    return TruncedPath
}
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

