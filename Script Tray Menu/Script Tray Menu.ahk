
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

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙



;;⮞--------------------- Tray Menu ------------------------------------------∙ 
Menu, Tray, Tip, Tray ToolTip
Menu, Tray, NoStandard
Menu, Tray, Click, 2
Menu, Tray, Color, ABCDEF
Menu, Tray, Add 
Menu, Tray, Add 
Menu, Tray, Add, MenuHeader
Menu, Tray, Icon, MenuHeader, ieframe.dll, 3		;; Blue Lined Bent Corner Paper.
Menu, Tray, Default, MenuHeader			;; Makes Bold.
Menu, Tray, Add 
;;-----------------SUBMENU1
Menu, SubMenu1, Add 
Menu, SubMenu1, Add, Menu1
Menu, SubMenu1, Icon, Menu1, compstui.dll, 60		;; Blank Bent Corner Paper.
Menu, SubMenu1, Add 
Menu, SubMenu1, Add 
    Menu, SubMenu1, Color, 8FFFDD ; (Mint) 
Menu, Tray, Add, SubMenu1, :SubMenu1
Menu, Tray, Icon, SubMenu1, imageres.dll, 255		;; Halved Bent Corner Paper.
Menu, Tray, Add 
;;-----------------SUBMENU2
Menu, SubMenu2, Add 
Menu, SubMenu2, Add, Menu2
Menu, SubMenu2, Icon, Menu2, compstui.dll, 60		;; Blank Bent Corner Paper.
Menu, SubMenu2, Add 
    Menu, SubMenu2, Color, FF8FDD ; (Pink) 
Menu, Tray, Add, SubMenu2, :SubMenu2
Menu, Tray, Icon, SubMenu2, imageres.dll, 255		;; Halved Bent Corner Paper.
Menu, Tray, Add 
;;-----------------SCRIPT OPTIONS
Menu, Tray, Add, ···················
Menu, Tray, Add 
Menu, Tray, Add, Script·Edit
Menu, Tray, Icon, Script·Edit, shell32.dll, 270		;; Edit Pencil Bent Corner Paper.
Menu, Tray, Add 
Menu, Tray, Add, Script·Reload
Menu, Tray, Icon, Script·Reload, mmcndmgr.dll, 47		;; Green Refresh Bent Corner Paper.
Menu, Tray, Add 
Menu, Tray, Add, Script·Exit
Menu, Tray, Icon, Script·Exit, shell32.dll, 272		;; Red X Bent Corner Paper.
Menu, Tray, Add 
Menu, Tray, Add 
Return

;;-----------------FUNCTION CALLS
MenuHeader:
    Soundbeep, 1400, 100
    Soundbeep, 1300, 100
    Soundbeep, 1500, 100
Return

;;-----------------
Menu1:
    Soundbeep, 1400, 100
Return

;;-----------------
Menu2:
    Soundbeep, 1400, 100
Return

;;-----------------
···················:
Return

;;----------------------------------


;;⮞--------------------- Tray Menu Position -------------------------------∙ 
NotifyTrayClick_205:
    CoordMode, Mouse, Screen
    CoordMode, Menu, Screen
    MouseGetPos, mx, my
    Menu, Tray, Show, % mx - 20, % my - 20
Return
;;⮞--------------------- Tray Menu Position Function ------------------∙ 
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
;;⮞-----------------------------------------------------------------------------∙ 



;;----------------------- 🔥 HotKey 🔥 -------------------------------------∙
^T::        ;; ⮘---(Ctrl+T) 
    Soundbeep, 1100, 100

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙



;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;----------------------- Reload / Exit -------------------------------------∙

Script·Edit:
    Edit
Return


RETURN
;;------ RELOAD --------- RELOAD -------∙
^Home:: 
Script·Reload:    ;; <--Menu Call.
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)        ;; Double-Tap in less than 200 milliseconds.
    Soundbeep, 1400, 75
    Reload
Return
;;------------ EXIT ------ EXIT -------------∙
^Esc:: 
Script·Exit:    ;; <--Menu Call.
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
Menu, Tray, Icon, mmcndmgr.dll, 42
Return
;;-----------------------------------------------------------------------------∙
; 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;     ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
