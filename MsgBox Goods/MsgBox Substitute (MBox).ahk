
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
» SOURCE :  SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?t=15787#p80109
» Further notes at script end.
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




ReStart:

MBox(,"There's a retry button.`nPress the button?",5,0,1,,,,,,,"cRED s14 w600","YELLOW")    ;   A plain question, the user press Retry or NO. Default answer is "Retry" with <Enter> key

;;*********************************************** 

MBox(Tit = "HEADER", Mess="Pause", NBut=1,TOut=3, DefL=1, Text1L:="Retry", Text2L = "No", Text3L="Cancel", Text4L="Extra", Text5L = "Plus"
         , FontL="Calibri", FontOpt="cBlue w500 s12",WindowColor="85DEFF", CallerGui="")

{
    Static ETimeOut   ; Variable shared with timeout section
    Local RetLoc, HasGui, NInd, MaxBut=5

    ETimeOut := false
    RetLoc := 1
    HasGui := (CallerGui<>"")
    Labels := ["Retry","No","Canc","Xtra","Plus"]
            
    if (HasGui)
       Gui,  %CallerGui%:+Disabled

    Gui, MBox:Destroy
    Gui, MBox:Color,%WindowColor%
    
    Gui, MBox:Font,%FontOpt%,%FontL%
    Gui, MBox:Add,Text,,%Mess%
    Gui, MBox:Font
    
    GuiControlGet,Text, MBox:Pos,Static1

    if (TOut<>0)  ; Prepare for default answer also in timeout event
      if (DefL<=1)  
        RetLoc := DefL=0 ? -1 : 1    ; Return -1 (No default) or 1 (OK)
      else   
        Loop % MaxBut-1  {
          NInd := A_Index+1   ; Return 0 (2 buttons and default 2nd Button) or (Button Number-1) if Default 3nd button and so on
          if ( DefL=NInd and NBut>=NInd ) 
            RetLoc := ( DefL=2 ? 0 : NInd-1 )
        }
      
    if (TOut<>0)    ; Prepare for default answer also in timeout event
      RetLoc  :=  DefL=0 ? -1 :  ( DefL=1 ?  1  :  (DefL = 2 and NBut>=2 ?  0 : ( DefL = 3 and NBut=3  ? 2 : DefL ) ) )
    
    Loop % NBut {
      if ( (Text1L = "Retry") and  (NBut=1) )
        Text1L := "OK"
      if (A_Index=1)          ; TextW: Non-documented variable that stores text width
        Gui, MBox:Add,Button,%  (DefL=1 or NBut=1 ? "Default " :  "") . "y+10 w75 gRetry xp+" (TextW / 2) - 38 * NBut , %Text1L% 
      else
        Gui, MBox:Add,Button,%  (DefL=A_Index ? "Default " :  "") . "yp+0 w75 g" .  Labels[A_Index] . " x+" 10, % Text%A_Index%L  
    }
    
    Gui, MBox:-SysMenu +OwnDialogs +AlwaysOnTop   ; Clean and modal window message. No Minimize, maximize, close icon and AHK icon.
    Gui, MBox:Show,,%Tit%
    
    If (TOut<>0)  ; TimeOut in seconds
      SetTimer TimeOut, % TOut*1000
    
    Gui, MBox:+LastFound   ;  Last selected window
    WinWaitClose        ;  Wait for the GUI window closes. Make it strictly modal.
    
    if (HasGui)
      Gui,  %CallerGui%:-Disabled   ; Enable caller GUI back 

    SetTimer TimeOut, Off
    return RetLoc

 Retry:     ; First button
    Gui, MBox:Destroy
    RetLoc := 1
Soundbeep, 1400, 200
GoSub ReStart
Return
     
 No:    ; Second button
    Gui, MBox:Destroy
    RetLoc := 0
Soundbeep, 900, 200
    Reload
Return
    
Canc:   ; Third button
    Gui, MBox:Destroy
    RetLoc := 2
Return

XTra:   ; Fourth button
    Gui, MBox:Destroy
    RetLoc := 3
Return

Plus:   ; Fifth button
    Gui, MBox:Destroy
    RetLoc := 4
Return

 TimeOut:  ; Timeout section
    Gui, MBox:Destroy  
    ETimeOut := True     ; Share just static variables with enclosing function
    return
}
Return




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
;⮞--------------------- NOTES ----------------------------------------------∙ 
/*
;⮞--------------------- ADDITIONAL NOTES -----------------------------∙ 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
                                        MBox
Minimalist modal MsgBox replacement with font settings, background color, optional timeout and allowing use of 5 buttons. 
With more than 1 button, return selected button values...
    (1-Retry  - also true for 2 buttons | 0-No  - also false for 2 buttons | 2-Cancel for 3 buttons | 3-Extra for 4 buttons | 4-Plus for 5 buttons )
*********************************************** 

Some Examples:

MBox(,"It's a big mistake")  ;   Just a normal message with "OK" button
MBox(,"Continue?",2,0,0)    ;   A plain question, the user press Retry or NO. No default answer
MBox(,"Continue?",2,0,1)    ;   A plain question, the user press Retry or NO. Default answer is "Retry" with <Enter> key
MBox(,"Continue?",3,0,0)    ;   A question with 3 buttons ("Retry", "No, "Cancel") with no default, returns 1 (1nd),0 (2nd) or 2 (3nd)
MBox(,"Select",3,0,1,"One","Two","Three")    ;   A selection with 3 buttons ("One", "Two", "Three"), default 1st button, same returns.
MBox(,"Continue?",2,0,1,,,,,,,"cred s10")    ;   A plain question, the user press Retry or NO, font is red with size 10.
MBox(,"Continue?",2,0,1,,,,,,,"cwhite bold s10","black")    ;   A plain question, the user press Retry or NO, font is white, bold, size 10 with black background.
MBox(,"Continue?",2,0,1,,,,,,,,,"ParentGUI")    ;   A plain question, the user press Retry or NO, standard font and background, called from modal GUI ParentGUI.
MBox(,"Select",5,5,1,"One","Two","Three","Four","Five")    ;  A selection with 5 buttons ("One", "Two", "Three", "Four","Five"), default 1st button, 
                                                                                             ; return 1 for "One", 0 for "Two", 2 for "Three", 3 for "Four" and 4 for "Five", with  timeout of 5 seconds.


*********************************************** 
Tit - Window title. Default "HEADER".
Mess- Message with 1 or more lines (using 'r'n (CR/LF) inside string to change line)
NBut - Default 1 button, but accept until 5 buttons. 
TOut - Timeout in seconds, default 0 (No Timeout)
DefL - Default button number from 1 to NBut buttons. Default 1. <Enter> return default button. 0 no default, in that case <Enter> does nothing
Text1L - 1nd Button text. Default "OK" with 1 button or "Retry" with 2  buttons or more - Return 1
Text2L - 2nd Button text. Default "No" - Return 0
Text3L - 3nd Button text. Default "Cancel" - Return 2
Text4L - 4nd Button text. Default "Extra" - Return 3
Text5L - 5nd Button text. Default "Plus" - Return 4
FontL - Font name (default "Lucida Console")
FontOpt - Font options,  default is blue with weight 500 (more than normal less than bold). One can specify "italic", "bold", "underline", etc.
Window Color - Default: light silver, can be any color like "black", "blue", etc.
CallerGui  - If that message was started from a caller Modal GUI, it demands to be disabled at the beginning and enabled again at the end.

*/
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- ADDITIONAL NOTES END -----------------------∙ 
*/

/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

