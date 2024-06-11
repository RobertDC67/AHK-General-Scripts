
;; Make transparent all but the active window.

#SingleInstance,Force
SetWinDelay,0
SetBatchLines,-1

applicationname=TransOther

OnExit,STOP
Gosub,READINI
Gosub,TRAYMENU

START:
WinGet,id_,List,,,Program Manager
Loop,%id_%
{
  StringTrimRight,id,id_%A_Index%,0
  WinSet,Transparent,%trans%,ahk_id %id%
}
id:=0

Loop
{
  WinWaitNotActive,ahk_id %id%
  WinGet,id,Id,A
  WinGetClass,class,ahk_id %id%
  WinGetClass,oldclass,ahk_id %oldid%
  parent:=DllCall("GetParent","UInt",id)
  parent+=0
  If (id<>oldid)
  {
    If (class="Shell_TrayWnd") ; And oldclass="Progman")
      WinSet,Transparent,255,ahk_id %id%
    Else
      WinSet,Transparent,Off,ahk_id %id%
    If (parent<>oldid)
      WinSet,Transparent,%trans%,ahk_id %oldid%
    oldid:=id
  }
  Sleep,100
}


STOP:
WinGet,id_,List,,,Program Manager
Loop,%id_%
{
  StringTrimRight,id,id_%A_Index%,0
  WinSet,Transparent,Off,ahk_id %id%
}
WinSet,Transparent,Off,ahk_class Progman
Goto,EXIT


READINI:
IfNotExist,%applicationname%.ini
{
  ini=`;[Settings]
  ini=%ini%`n`;trans=200              `;0-255  Degree of transparency
  ini=%ini%`n
  ini=%ini%`n[Settings]
  ini=%ini%`ntrans=200
  FileAppend,%ini%,%applicationname%.ini
  ini=
}
IniRead,trans,%applicationname%.ini,Settings,trans
Return


TRAYMENU:
Menu,Tray,DeleteAll
Menu,Tray,NoStandard
Menu,Tray,Icon, imageres.dll, 255
Menu,Tray,Add,
Menu,Tray,Add,
Menu,Tray,Add,Reload
Menu,Tray,Icon, Reload, imageres.dll, 288
Menu,Tray,Add,
Menu,Tray,Add,Exit
Menu,Tray,Icon, Exit, shell32.dll, 272
Menu,Tray,Add,
Menu,Tray,Add,
Menu,Tray,Tip,%applicationname%
Return


SETTINGS:
    Gosub,READINI
        RunWait,%applicationname%.ini
    Reload
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static8,Static12,Static16
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return

Reload:
    Reload
Return

EXIT:
    ExitApp
Return