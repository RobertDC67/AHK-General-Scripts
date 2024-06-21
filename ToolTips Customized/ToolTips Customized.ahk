
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
» SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=84750#p371706
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

hToolTip := CustomToolTip(text, X + 5, Y + H - 5, title, 0,,, 0x000011, 0x4A96D9, "Calibri", "s12", true, 5000)

text = Hello
X-Coordinance
Y-Coordinance
Title = Message
Icon Parameter = 
	0 - for no icon.
	1 - for an Info icon.
	2 - for a Warning icon.
	3 - for an Error icon.
	4= - for custom icons (handles)
Transparent - set to false
Close Button - set to false
Background Color - 000011
Text Color - 4A96D9
Font Name - Calibri
Font Options - (Like in GUI)
IsBalloned - set to true
Timeout - 5000 miliseconds (5 seconds)
Max Width - set to 600

*/


WinGetPos, X, Y,, H, ahk_id %hEdit%

title := "Hello,"
text := "This is my custom ToolTip!`nIt will disappear in five seconds."

hToolTip := CustomToolTip(text, X + 5, Y + H - 5, title, 0,,, 0x000011, 0x4A96D9, "Calibri", "s12", true, 5000)




CustomToolTip( text, x := "", y := "", title := ""
             , icon := 0  ; can be 1 — Info, 2 — Warning, 3 — Error, if greater than 3 — hIcon
             , transparent := false
             , closeButton := false, backColor := "", textColor := 0
             , fontName := "", fontOptions := ""  ; like in GUI
             , isBallon := false, timeout := "", maxWidth := 600 )
{
   static ttStyles := (TTS_NOPREFIX := 2) | (TTS_ALWAYSTIP := 1), TTS_BALLOON := 0x40, TTS_CLOSE := 0x80
        , TTF_TRACK := 0x20, TTF_ABSOLUTE := 0x80
        , TTM_SETMAXTIPWIDTH := 0x418, TTM_TRACKACTIVATE := 0x411, TTM_TRACKPOSITION := 0x412
        , TTM_SETTIPBKCOLOR := 0x413, TTM_SETTIPTEXTCOLOR := 0x414
        , TTM_ADDTOOL        := A_IsUnicode ? 0x432 : 0x404
        , TTM_SETTITLE       := A_IsUnicode ? 0x421 : 0x420
        , TTM_UPDATETIPTEXT  := A_IsUnicode ? 0x439 : 0x40C
        , exStyles := (WS_EX_TOPMOST := 0x00000008) | (WS_EX_COMPOSITED := 0x2000000) | (WS_EX_LAYERED := 0x00080000)
        , WM_SETFONT := 0x30, WM_GETFONT := 0x31
   (transparent && exStyles |= WS_EX_TRANSPARENT := 0x20)
   dhwPrev := A_DetectHiddenWindows
   DetectHiddenWindows, On
   defGuiPrev := A_DefaultGui, lastFoundPrev := WinExist()
   hWnd := DllCall("CreateWindowEx", "UInt", exStyles, "Str", "tooltips_class32", "Str", ""
                                   , "UInt", ttStyles | TTS_CLOSE * !!CloseButton | TTS_BALLOON * !!isBallon
                                   , "Int", 0, "Int", 0, "Int", 0, "Int", 0, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")
   WinExist("ahk_id" . hWnd)
   if (textColor != 0 || backColor != "") {
      DllCall("UxTheme\SetWindowTheme", "Ptr", hWnd, "Ptr", 0, "UShortP", empty := 0)
      ByteSwap := Func("DllCall").Bind("msvcr100\_byteswap_ulong", "UInt")
      SendMessage, TTM_SETTIPBKCOLOR  , ByteSwap.Call(backColor << 8)
      SendMessage, TTM_SETTIPTEXTCOLOR, ByteSwap.Call(textColor << 8)
   }
   if (fontName || fontOptions) {
      Gui, New
      Gui, Font, % fontOptions, % fontName
      Gui, Add, Text, hwndhText
      SendMessage, WM_GETFONT,,,, ahk_id %hText%
      SendMessage, WM_SETFONT, ErrorLevel
      Gui, Destroy
      Gui, %defGuiPrev%: Default
   }
   if (x = "" || y = "")
      DllCall("GetCursorPos", "Int64P", pt)
   (x = "" && x := (pt & 0xFFFFFFFF) + 15), (y = "" && y := (pt >> 32) + 15)
   
   VarSetCapacity(TOOLINFO, sz := 24 + A_PtrSize*6, 0)
   NumPut(sz, TOOLINFO)
   NumPut(TTF_TRACK | TTF_ABSOLUTE * !isBallon, TOOLINFO, 4)
   NumPut(&text, TOOLINFO, 24 + A_PtrSize*3)
   
   SendMessage, TTM_SETTITLE      , icon, &title
   SendMessage, TTM_TRACKPOSITION ,     , x | (y << 16)
   SendMessage, TTM_SETMAXTIPWIDTH,     , maxWidth
   SendMessage, TTM_ADDTOOL       ,     , &TOOLINFO
   SendMessage, TTM_UPDATETIPTEXT ,     , &TOOLINFO
   SendMessage, TTM_TRACKACTIVATE , true, &TOOLINFO
   
   if timeout {
      Timer := Func("DllCall").Bind("DestroyWindow", "Ptr", hWnd)
      SetTimer, % Timer, % "-" . timeout
   }
   WinExist("ahk_id" . lastFoundPrev)
   DetectHiddenWindows, % dhwPrev
   Return hWnd
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

