
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
» SOURCE :  https://www.autohotkey.com/board/topic/29570-function-custom-msgbox-custom-buttons/
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




/*
Usage:
Answer := CMsgBox( title, text, buttons, icon="", owner=0 )
Where:
    title   = The title of the message box.
    text    = The text to display.
    buttons = Pipe-separated (|) list of buttons. Putting an asterisk in front of a button will make it the default.
    icon    = If blank, we will use an info icon (222).
              If a number, we will take this icon from Shell32.dll
              If a letter ("I", "E" or "Q") we will use some predefined icons...
              ...("InfoChat", "BlueCircle", "QuestionMark", "ErrorSign") respectively from Shell32.dll (Info, Question, or Error).
    owner   = If 0, this will be a standalone dialog. If you want this dialog to be owned by another GUI, place its number here.
-------------------------------------------------- 
*/

; --- EXAMPLE - Comment out the entire section when including. -------------
#SingleInstance Force

;;------Simple example.
Pressed := CMsgbox("Hello World", "Are you sure you want to say hello to the world?`n`nWarning! This operation is irreversible.", "&Yes|*Not &Sure|&Not at All|&HELP!", "E")
Msgbox 32,,"%Pressed%" was pressed

;;------Custom icon.
Pressed := CMsgbox("Where Is It?", "Do you want to find the holy grail?`n`n   (Custom icons from Shell32.dll)", "*&Yes Please|&Not Today|Not &Ever", "23")
Msgbox 32,,"%Pressed%" was pressed

;;------Example for msgbox that is owned by our own GUI.
Gui Add, Text, w200, This is my GUI and I'll cry if I want to.
Gui Add, Button, wp, Cry
Gui Show, x200 y200

Pressed := CMsgbox("Owned", "I am owned by GUI 1", "*&Ok|&Whatever", "", 1)
Msgbox 32,,"%Pressed%" was pressed

Return
; --- EXAMPLE END ---------------------------------------------------------------

CMsgBox(title, text, buttons, icon="", owner=0) {
    Global _CMsg_Result
    GuiID := 9  ; If you change, also change the subroutines below.
    StringSplit, Button, buttons, |
    if (owner <> 0) {
        Gui %owner%:+Disabled
        Gui %GuiID%:+Owner%owner%
    }
    Gui %GuiID%:+Toolwindow +AlwaysOnTop
    MyIcon := (icon = "I" or icon = "") ? 222 : (icon = "Q") ? 24 : (icon = "E") ? 110 : icon
    Gui %GuiID%:Add, Picture, Icon%MyIcon%, Shell32.dll
    Gui %GuiID%:Add, Text, x+12 yp w180 r8 section, %text%
    Loop %Button0%
        Gui %GuiID%:Add, Button, % (A_Index=1 ? "x+12 ys " : "xp y+3 ") . (InStr(Button%A_Index%, "*") ? "Default " : " ") . "w100 gCMsgButton", % RegExReplace(Button%A_Index%, "\*")
    Gui %GuiID%:Show,,%title%
    Loop
        if (_CMsg_Result)
            Break
    if (owner <> 0)
        Gui %owner%:-Disabled
    Gui %GuiID%:Destroy
    Result := _CMsg_Result
    _CMsg_Result := ""
    Return Result
}

9GuiEscape:
9GuiClose:
    _CMsg_Result := "Close"
Return

CMsgButton:
    StringReplace, _CMsg_Result, A_GuiControl, &, , All
Return




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

