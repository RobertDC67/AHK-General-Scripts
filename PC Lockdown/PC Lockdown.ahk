
/* 	NOTES:
• Press Ctrl+F11 to Block keyboard/mouse inputs.
• Press Ctrl+F12 to Unblock keyboard/mouse inputs.
*/

;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 

;⮞--------------------- Globals ----------------------------------------------∙ 
global AllKeys := get_AllKeys()
global Message1 := "This computer is in use`nKeyboard and mouse are locked!"
global Message2 := "Welcome Back`nSystem Is Now Unlocked"
;∙---------------------- Globals End ----------------------------------------∙ 

;⮞--------------------- TRAY MENU -----------------------------------------∙ 
Menu, Tray, Tip, PC Lockdown
Menu, Tray, NoStandard 	 ; Eliminates original menu.
Menu, Tray, Click, 2
Menu, Tray, Color, C7E2FF
;∙-------∙
Menu, Tray, Add 
Menu, Tray, Add 
Menu, Tray, Add, PC_Lockdown
Menu, Tray, Icon, PC_Lockdown, wmploc.dll, 95 	 ; White Lock Icon.
Menu, Tray, Default, PC_Lockdown 		 ; Makes Bold.
;∙-------∙
Menu, Tray, Add 
Menu, Tray, Add, Script·Reload
Menu, Tray, Icon, Script·Reload, imageres.dll, 288 	 ; Return Sheet Icon
Menu, Tray, Add 
Menu, Tray, Add, Script·Exit
Menu, Tray, Icon, Script·Exit, shell32.dll, 272 	 ; Exit Sheet Icon
Menu, Tray, Add 
Menu, Tray, Add 
Return
;⮞--------------------- Tray Menu Header --------------------------------∙ 
PC_Lockdown:
MsgBox, , Keyboard/Mouse, 	
(
How to use this script: 

• Press Ctrl+F11 to Block keyboard/mouse inputs.
• Press Ctrl+F12 to Unblock keyboard/mouse inputs.
), 5
Return
;⮞--------------------- Tray Menu Position -------------------------------∙ 
NotifyTrayClick_205:
    CoordMode, Mouse, Screen
    CoordMode, Menu, Screen
    MouseGetPos, mx, my
    Menu, Tray, Show, % mx - 20, % my - 20
Return
;⮞--------------------- Tray Menu Position Function ------------------∙ 
NotifyTrayClick(P*) { 
Static Msg, Fun:="NotifyTrayClick", NM:=OnMessage(0x404,Func(Fun),-1),  Chk,T:=-250,Clk:=1
  If ( (NM := Format(Fun . "_{:03X}", Msg := P[2])) && P.Count()<4 )
     Return ( T := Max(-5000, 0-(P[1] ? Abs(P[1]) : 250)) )
  Critical
  If ( ( Msg<0x201 || Msg>0x209 ) || ( IsFunc(NM) || Islabel(NM) )=0 )
     Return
  Chk := (Fun . "_" . (Msg<=0x203 ? "203" : Msg<=0x206 ? "206" : Msg<=0x209 ? "209" : ""))
  SetTimer, %NM%,  %  (Msg==0x203        || Msg==0x206        || Msg==0x209)
    ? (-1, Clk:=2) : ( Clk=2 ? ("Off", Clk:=1) : ( IsFunc(Chk) || IsLabel(Chk) ? T : -1) )
Return True
}
;∙---------------------- TRAY MENU END ----------------------------------∙ 

;⮞--------------------- Lock Keyboard/Mouse ---------------------------∙ 
DisableKeyboardAndMouseLOCK: 
    ^F1:: Disable_Keys(True)                         ; Disable keys.  *** The (^) represents the Ctrl key. ***
    ^F2:: Disable_Keys(False)                        ; Enable keys.   *** This can be changed to (!) = Alt key and (#) = Windows key. ***
;--------∙ 
get_AllKeys() {                                     ; Return a pipe delimited list of all keys.
    Keys := "NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins"
    Loop, 254
        If KeyName := GetKeyName(Format("VK{:X}", A_Index))
            Keys .= "|" KeyName
    For key, val in {Control: "Ctrl", Escape: "Esc"}
        Keys := StrReplace(Keys, key, val)
    Return, Keys
}
;--------∙ 
Disable_Keys(BOOL := False) {                      ; (En/Dis) -able all keys
    global Block := BOOL ? "On" : "Off"

    For each, KeyName in StrSplit(AllKeys, "|")
        Hotkey, *%KeyName%, Block_Input, %Block% UseErrorLevel
;--------∙ 
    Block_Input:
        If (Block = "On") {
Menu, Tray, Icon, wmploc.dll, 66 	 ; Gold Lock Icon.
            Progress, B1 ZH0 ZY15 CW000000 CTE30000, %Message1%
            Sleep, 1500
            Progress, Off
        }
    else
        If (Block = "Off") {
Menu, Tray, Icon, wmploc.dll, 95 	 ; White Lock Icon.
            Progress, B1 ZH0 ZY15 CW000000 CT00E300, %Message2%
            Sleep, 1500
            Progress, Off
}
    Return
}
Return
;∙---------------------- Lock Keyboard/Mouse End ---------------------∙

;⮞--------------------- Auto-Execute Sub ----------------------------------∙
AutoExecute: 
#MaxThreadsPerHotkey, 2
#NoEnv 
#NoTray Icon
#Persistent 
#SingleInstance, Force 
SetBatchLines -1 
Menu, Tray, Icon, wmploc.dll, 95
Return
;∙---------------------- Auto-Execute Sub End ----------------------------∙ 

;⮞--------------------- Relaod/Exit Routine -------------------------------∙
^Home::
Script·Reload:
    Soundbeep, 1100,75
    Soundbeep, 1200,75
    Soundbeep, 1300,75
    Reload
Return

^Esc::
Script·Exit:
    Soundbeep, 1300,100
    Soundbeep, 1000,100
    ExitApp
Return

