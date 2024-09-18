
/*∙=====∙NOTES∙===============================================∙
∙--------∙Script∙Defaults∙---------------∙
» Reload Script∙----------∙DoubleTap∙------∙(Ctrl + [HOME])
» Exit Script∙--------------∙DoubleTap∙------∙(Ctrl + [Esc])
» Script Updater: Auto-reload script upon saved changes.
    ▹ If you make any changes to the script file and save it, 
          the script will automatically reload itself and continue
          running without manual intervention.
» 
∙--------∙Origins∙-------------------------∙
» Author:  emmanuel d
» https://www.autohotkey.com/boards/viewtopic.php?f=6&t=133076#p584585
» Original Author:  gwarble
» https://www.autohotkey.com/board/topic/44870-notify-multiple-easy-tray-area-notifications-v04991/
∙=============================================================∙
*/
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Auto-Execute∙==========================================∙
ScriptID := "TEMPLATE"    ;;∙------∙Need to also change in "MENU CALLS"
GoSub, AutoExecute
GoSub, TrayMenu
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙🔥 HotKey 🔥∙===========================================∙
^t::    ;;∙------∙(Ctrl+T) 
    Soundbeep, 1100, 100
;;∙============================================================∙


/*∙===========================================================∙
∙--------------------------------------------------------------------------------------------∙
∙=======∙Options And How To Use∙================================∙
FORMAT:   Notify(P_TitleOrhGui , P_Msg:="" , P_Duration:="" , P_Options:="" , P_Image:="")
- - - - - - - - - - - - - - - - -
EASY READ FORMAT:   Notify("Title Text" , "Message Text" , "Duration" , "Options" , A_ScriptDir "\path\to\image")
------------------------------------------------------


EXAMPLE:  Notify("Title Text" , "Message Text" , "Duration" , "Options" , A_ScriptDir "\path\to\image")
- - - - - - - - - - - - - - - - -
DEFINITIONS:
• P_TitleOrhGui:  Some text or "" to omit title line.
    	The Title of the notification or, if passed as a handle (an integer), it is used to close an existing notification. 
* This is "Title Text" in the example above.

• P_Msg: [""]  Some text or "" to omit message line.
    	The Message displayed in the notification. 
* This is "Message Text" in the example above.

• P_Duration:  The Duration for which the notification should be displayed. 
    	If empty, the default value will be used. If zero or negative, remains visible until manually closed or, until you call Notify and pass the handle  "Wait". If set, it waits until you click before returning. 
* This is "Duration" in the example above.

• P_Options: [""]  String of options:  "ImageWidth=80 ImageNr=5"
                                                Or Object:  {ImageWidth:80,ImageNr:5}
    	Additional Settings that control how the notification is displayed, such as the font, size, or color. 
* This is "Options" in the example above.

• P_Image:  [""]  Image file name/library.
                                Return value - A Handle of the GUI
                                0 if failed (too many open), ErrorLevel is set
    	The path to an Image or Icon to be shown alongside the notification text. This is the concatenation of A_ScriptDir (which holds the directory of the currently executing script) and a placeholder for a file path.
* This is "A_ScriptDir "\path\to\image" in the example above.
;;∙============================================================∙
*/


;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙FORMAT REMINDER∙====================================∙
;   Notify("Title Text" , "Message Text" , "Duration" , "Options" , A_ScriptDir "\path\to\image")


;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙An EXAMPLE∙==========================================∙
^Numpad1::
    Notify("Title Header Text","Display for:`t10 sec`nIcon number:`t42`nIcon width:`t32"    ;;∙------∙Title and text.
            ,10,"ImageNr=42 ImageWidth=32 MsgFontSize=10 MsgFontWeight=400 TitleFontSize=14","Shell32.dll")    ;;∙------∙The parameters.
Return


;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙THE FUNCTION∙========================================∙
Notify(P_TitleOrhGui,P_Msg:="",P_Duration:="",P_Options:="",P_Image:=""){
;;∙------∙Global G_oLNG    ;;∙------∙To overwrite with another language.
    Static S_oLNG   :={ Notify_Desc  : "Creates a Tray like notification"
        , Notify_Arg_1 : "The title of the notification. Or a handle of the gui we want to close otherwise "
        , Notify_Arg_2 : "The message to display"
        , Notify_Arg_3 : "The duration of how long before it goes away, use """" to wait untill you click on it, 0 or less to close it manualy later"
        , Notify_Arg_4 : "the options, in the form of key=value pairs, sepperated by a space. Or a array"
        , Notify_Err_1 : "Already maximum Guis shown: "            
        , Notify_Err_2 : "UnKnown or invalid Option Key Passed: "       
        , Notify_Err_3 : "UnKnown or invalid Option Passed: "       
        , Notify_Err_4 : "You sir are messed up, what did you pass as the duration?: "       
        , Notify_Ex__1 : "Example goes here"          }
;;∙------∙Static S_Init   :=  (L_Fl:= "Func_List",IsFunc(L_Fl) ? %L_Fl%("Notify",S_oLNG))    ;;∙------∙Register itself and pass the default language, that function is dynamically called to avoid warning AND auto include.
    Static S_GuiCount := 0
    Static S_MaxGui := 10    ;;∙------∙Maximum number of GUI allowed.
    Static S_oOpt   :={ AnimateSpeed    :     300    ;;∙------∙Miliseconds.
    , Duration        :       5    ;;∙------∙Can be defined in P_Duration or P_Options, but P_Duration will be used If there.
    , GuiColor        : "Black"    ;;∙------∙Gui Color   /   (ie: Don't use GF<=Gui#<=GL)
    , GuiRadius       :      10    ;;∙------∙Gui Radius   /   Elsewhere in your script.
    , GuiMargin       :       5   
    , ImageNr         :       1    ;;∙------∙Image Icon Number. (from Image)
    , ImageWidth      :      32    ;;∙------∙Image Width.
    , MsgFontColor    :    "Aqua"  
    , MsgFontFace     :  "Calibri"  
    , MsgFontSize     :      12   
    , MsgFontWeight   :     625   
    , TextWidth       :     200   
    , TitleFontColor  :  "5196D6"  
    , TitleFontFace   :  "Calibri"  
    , TitleFontSize   :      12   
    , TitleFontWeight :     625 } 

;;∙======∙Handle Second Function Instance Calls∙====================∙
If ((P_TitleOrhGui+0) && !WinExist("ahk_id " P_TitleOrhGui) && P_Msg="" && P_Duration="" && P_Image="")    ;;∙------∙called externaly after the notification was dismissed.
    Return    ;;∙------∙Called Externally: Notify(hGUI)    ;;∙------∙All other params should be blank.
If ((P_TitleOrhGui+0) && WinExist("ahk_id " P_TitleOrhGui)) {    ;;∙------∙Clicked on notification or called externaly, when still exist.
;;∙------∙Called by glabel:  Notify(hGUI,hCtrl,GuiEvent,EventInfo,ErrLevel).
;;∙------∙Called Externally: Notify(hGUI)    ;;∙------∙All other params should be blank, but no need to check as the window exists.
If S_oOpt.AnimateSpeed 
    DllCall("AnimateWindow","UInt",P_TitleOrhGui,"Int",S_oOpt.AnimateSpeed,"UInt","0x00050001")    ;;∙------∙Animate to the right.
        Try Gui,%P_TitleOrhGui%:Destroy
        S_GuiCount--
    Return,1
    }

;;∙======∙Get a different language If Globally defined∙================∙
L_oLNG := S_oLNG.Clone()    ;;∙------∙We dont want to overwrite the static variables.
If IsSet(G_oLNG)    ;;∙------∙Avoid warning If not used by random script.
    For L_Key,L_Value in S_oLNG    ;;∙------∙Only look for keys that this function knows.
        L_oLNG[L_Key] := ( G_oLNG[L_Key] ? G_oLNG[L_Key] : S_oLNG[L_Key])    ;;∙------∙Get another language If available.

;;∙======∙Check maximum gui nr's∙================================∙
If (S_GuiCount = S_MaxGui)    ;;∙------∙Already maximum Guis shown.
    Return,0,Errorlevel := A_ThisFunc "(1) " L_oLNG[A_ThisFunc "_Err_1"] S_GuiCount

;;∙======∙Check Parameters∙=====================================∙
L_oOpt    := S_oOpt.Clone()    ;;∙------∙Set the default options, we dont want to overwrite the static ones.
If IsObject(P_Options) {    ;;∙------∙We passed a array.
    For L_Key,L_Value in S_oOpt    ;;∙------∙Only check predefined keys.
        L_oOpt[L_Key] := ( P_Options[L_Key] ? P_Options[L_Key] : S_oOpt[L_Key])    ;;∙------∙Note that 0 or "" is never valid, and will use S_oOpt[L_Key]).
    }
Else {    ;;∙------∙we passed a string or "".
    Loop,Parse,P_Options,%A_Space%    ;;∙------∙If P_Options are passed. (space separated)
        {
        L_oArray := StrSplit(A_LoopField,"=",,2)    ;;∙------∙Split the Key=Value pair.
        If (L_oArray.MaxIndex()=2){    ;;∙------∙That array should always contain 2 items.
            If S_oOpt.HasKey(L_oArray[1])    ;;∙------∙We don't want to add whatever, only predefined keys.
            L_oOpt[L_oArray[1]] := L_oArray[2]    ;;∙------∙Overwrite the default item.
        Else Return,0,Errorlevel := A_ThisFunc "(2) " L_oLNG[A_ThisFunc "_Err_2"] L_oArray[1]    ;;∙------∙No predefined key found.
        }
    Else Return,0,Errorlevel := A_ThisFunc "(3) " L_oLNG[A_ThisFunc "_Err_3"] A_LoopField    ;;∙------∙There was no key value pair.
        }
    }
If (P_Duration!="")    ;;∙------∙If this parameter is explicetly set.
    L_oOpt["Duration"] := P_Duration    ;;∙------∙use it.
P_Image := LoadPicture(P_Image,"w" L_oOpt.ImageWidth " h-1 Icon" L_oOpt.ImageNr)    ;;∙------∙The handle version..
;;∙------∙P_Image := P_Image && FileExist(P_Image) ? P_Image : ""    ;;∙------∙Check image exist.

;;∙======∙Create the GUI∙========================================∙
Gui,New   ,+HwndL_hGui -Caption +ToolWindow +AlwaysOnTop -Border,%A_ThisFunc%    ;;∙------∙ -DPIScale a new unnamed and unnumbered GUI will be created.
Gui,Color ,% L_oOpt.GuiColor
Gui,Margin,% L_oOpt.GuiMargin ,% L_oOpt.GuiMargin    ;;∙------∙X, Y.
    S_GuiCount++
If (P_Image) {
    ;;∙------∙Gui,Add,Pic,%  "w" L_oOpt.ImageWidth  
        ;;∙------∙. " h-1"    ;;∙------∙Autosize to scale properly with the width.
        ;;∙------∙. " Icon" L_oOpt.ImageNr, % P_Image    ;;∙------∙Real picture version.
    Gui,Add,Pic,%  "w" L_oOpt.ImageWidth 
        . " h-1"    ;;∙------∙Autosize to scale properly with the width.
        , % "HBITMAP:*" P_Image    ;;∙------∙The handle version.
    }
If (P_TitleOrhGui !=""){ 
    Gui,Font ,%  "w" L_oOpt.TitleFontWeight 
        . " s" L_oOpt.TitleFontSize 
        . " c" L_oOpt.TitleFontColor
        ,      L_oOpt.TitleFontFace
    Gui,Add, Text, % "w"  L_oOpt.TextWidth    ;;∙------∙Don't set a Height then it will wrap with the width.
        . P_Image ? "x+m" : "xm"
        , % P_TitleOrhGui
    }
If (P_Msg !=""){
    Gui,Font ,%  "w" L_oOpt.MsgFontWeight 
        . " s" L_oOpt.MsgFontSize 
        . " c" L_oOpt.MsgFontColor
        ,      L_oOpt.MsgFontFace
    Gui,Add, Text,% ( P_TitleOrhGui ? "xp" : P_Image ? "x+m" : "xm")
        . ( P_TitleOrhGui ? " y+m" : " ym" )
        . " w"  L_oOpt.TextWidth
        , % P_Msg
    }
Gui, Show, Hide    ;;∙------∙To get the dimensions.
Gui, +LastFound    ;;∙------∙We need this because WinGetPos can't handle ahk_id %L_hGui%.
    WinGetPos,,,L_GuiW,L_GuiH   ;;∙------∙,ahk_id %L_hGui%    ;;∙------∙Get the dimensions of the hidden gui...manual says: ahk_id %L_hGui% should work on hidden GUI's.
Gui,Add,Text,x0 y0 w%L_GuiW% h%L_GuiH% hwndL_hCtrl BackgroundTrans    ;;∙------∙Make a control that will make the whole gui clickable.
If (L_oOpt.GuiRadius)
    WinSet,Region, % "0-0 w" L_GuiW " h" L_GuiH " R" L_oOpt.GuiRadius "-" L_oOpt.GuiRadius
    L_oFunc := Func(A_ThisFunc).Bind(L_hGui)    ;;∙------∙Create Function object !!! see coment below.
    GuiControl,+g,%L_hCtrl%, %L_oFunc%    ;;∙------∙This will also bind those: CtrlEvent(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="").
;;∙======∙Find other Gui's And recalculate position∙===================∙
DetectHiddenWindows Off    ;;∙------∙Not looking for hidden GUI's.
SetTitleMatchMode   3    ;;∙------∙3: A window's title must exactly match WinTitle to be a match.
WinGetPos,L_OtherX,L_OtherY,,,%A_ThisFunc%    ;;∙------∙<=== Change this to a loop for all open notifications??
SysGet,L_Workspace, MonitorWorkArea    ;;∙------∙Get the Monitor's available dimensions.
    L_NewX := L_WorkspaceRight-L_GuiW-5    ;;∙------∙Calculate the new x Position.
    If (L_OtherY)    ;;∙------∙We found another GUI.
        L_NewY := L_OtherY-L_GuiH-5    ;;∙------∙Place Above other gui.
    Else L_NewY := L_WorkspaceBottom-L_GuiH-5    ;;∙------∙Show at the bottom above the Taskbar.
    If (L_NewY < L_WorkspaceTop)    ;;∙------∙If Above monitor.
        L_NewY := L_WorkspaceBottom-L_GuiH-5    ;;∙------∙Show at the bottom above the Taskbar.
Gui, Show,hide x%L_NewX% y%L_NewY%    ;;∙------∙Set the new location of the gui.

;;∙======∙Show the GUI∙=========================================∙
If L_oOpt.AnimateSpeed
    DllCall("AnimateWindow","UInt",L_hGui,"Int",L_oOpt.AnimateSpeed,"UInt","0x00040008")    ;;∙------∙Animate up. AnimateWindow does not activate it.
Else Gui,Show,NoActivate

;;∙======∙Handle Duration∙=======================================∙
If (L_oOpt["Duration"] <= 0)    ;;∙------∙We dont want to auto close it.
    Return,L_hGui     ;;∙------∙All Is Well, Return the handle
Else If (L_oOpt["Duration"] >  0)    ;;∙------∙We do want to auto close it.
    SetTimer,%L_oFunc%,% "-" L_oOpt["Duration"] *1000
Else If (L_oOpt["Duration"] = "Wait")
    WinWaitClose,ahk_Id %L_hGui%    ;;∙------∙Wait for it to close.
Else Return,0,Errorlevel := A_ThisFunc "(3) " L_oLNG[A_ThisFunc "_Err_4"] L_oOpt["Duration"]
    Return,1    ;;∙------∙All Is Well.
    }
Return




;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙EDIT \ RELOAD / EXIT∙===================================∙
;;∙-----------------------∙EDIT \ RELOAD / EXIT∙--------------------------∙
RETURN
;;∙-------∙EDIT∙-------∙EDIT∙------------∙
Script·Edit:    ;;∙------∙Menu Call.
    Edit
Return
;;∙------∙RELOAD∙----∙RELOAD∙-------∙
^Home:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;;∙--∙Double-Tap.
    Script·Reload:    ;;∙------∙Menu Call.
        Soundbeep, 1200, 75
        Soundbeep, 1400, 100
    Reload
Return
;;-------∙EXIT∙------∙EXIT∙--------------∙
^Esc:: 
    If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)    ;;∙--∙Double-Tap.
    Script·Exit:    ;;∙------∙Menu Call.
        Soundbeep, 1400, 75
        Soundbeep, 1200, 100
    ExitApp
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Gui Drag Pt 2∙==========================================∙
WM_LBUTTONDOWNdrag() {
   PostMessage, 0x00A1, 2, 0
}
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Script Updater∙=========================================∙
UpdateCheck:    ;;∙------Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
    Soundbeep, 1700, 100
Reload
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Auto-Execute Sub∙======================================∙
AutoExecute:
#MaxThreadsPerHotkey 3
#NoEnv
;;∙------∙#NoTrayIcon
#Persistent
#SingleInstance, Force
OnMessage(0x0201, "WM_LBUTTONDOWNdrag")    ;; Gui Drag Pt 1.
SetBatchLines -1
SetTimer, UpdateCheck, 500
SetTitleMatchMode 2
SetWinDelay 0
Menu, Tray, Icon, Imageres.dll, 65
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙Tray Menu∙============================================∙
TrayMenu:
Menu, Tray, Tip, %ScriptID%    ;;∙------∙Suspends hotkeys then pauses script.
Menu, Tray, NoStandard
Menu, Tray, Click, 2
Menu, Tray, Color, ABCDEF
Menu, Tray, Add
Menu, Tray, Add
Menu, Tray, Add, %ScriptID%
Menu, Tray, Icon, %ScriptID%, Imageres.dll, 65
Menu, Tray, Default, %ScriptID%    ;;∙------∙Makes Bold.
Menu, Tray, Add
;;∙------∙  ∙--------------------------------∙

;;∙------∙Script∙Options∙---------------∙
Menu, Tray, Add
Menu, Tray, Add, Script·Edit
Menu, Tray, Icon, Script·Edit, shell32.dll, 270
Menu, Tray, Add
Menu, Tray, Add, Script·Reload
Menu, Tray, Icon, Script·Reload, mmcndmgr.dll, 47
Menu, Tray, Add
Menu, Tray, Add, Script·Exit
Menu, Tray, Icon, Script·Exit, shell32.dll, 272
Menu, Tray, Add
Menu, Tray, Add
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙MENU CALLS∙==========================================∙
TEMPLATE:    ;;∙------∙Change as needed to match the 'ScriptID' variable in AutoExe section.
    Suspend
    Soundbeep, 700, 100
    Pause
Return
;;∙============================================================∙
;;∙------------------------------------------------------------------------------------------∙
;;∙======∙TRAY MENU POSITION∙==================================∙
NotifyTrayClick_205:
    CoordMode, Mouse, Screen
    CoordMode, Menu, Screen
    MouseGetPos, mx, my
    Menu, Tray, Show, % mx - 20, % my - 20
Return
;;∙======∙TRAY MENU POSITION FUNTION∙======∙
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
;;∙============================================================∙

;;∙------------------------------------------------------------------------------------------∙
;;∙========================∙SCRIPT END∙=========================∙
;;∙------------------------------------------------------------------------------------------∙

