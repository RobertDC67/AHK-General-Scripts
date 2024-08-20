
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
» https://www.autohotkey.com/boards/viewtopic.php?f=6&t=7854#p46349
» Author:  jNizM
» 
» Monitor Configuration Functions
» https://learn.microsoft.com/en-us/windows/win32/monitor/monitor-configuration-functions
∙---------------------- NOTES END --------------------------------------∙
*/

;;----------------------- Auto-Execute ------------------------------------∙
Gosub, AutoExecute
;;-----------------------------------------------------------------------------∙
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙




/*∙=====∙***  HOTKEY LEGEND  ***∙===================================∙
-----------------IDENTIFY--------------------------------
(Ctrl+i) ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙ RETRIEVE and display all monitor identifiers.

∙-----------------RETRIEVE--------------------------------------------------------------------∙
(Ctrl+Numpad1) ∙∙∙∙∙ RETRIEVE monitor controls for primary monitor (DISPLAY1).
(Ctrl+Numpad2) ∙∙∙∙∙ RETRIEVE monitor controls for secondary monitor (DISPLAY2).

∙-----------------SET----------------------------------------------------------------------------∙
(Ctrl+Numpad3) ∙∙∙∙∙ SET monitor controls for primary monitor (DISPLAY1).
(Ctrl+Numpad4) ∙∙∙∙∙ SET monitor controls for secondary monitor (DISPLAY2).

∙-----------------RESTORE---------------------------------------------------------------------∙
(Ctrl+Numpad5) ∙∙∙∙∙ RESTORE monitor factory defaults for primary monitor (DISPLAY1).
(Ctrl+Numpad6) ∙∙∙∙∙ RESTORE monitor factory defaults for secondary monitor (DISPLAY2).
*/
;;∙================================================================∙

;;∙======∙SETTINGS∙================================================∙
;; Replace  "\\.\DISPLAY#"  with your specific display identifiers, which can be determined with hotkey (Ctrl+i)
;;∙---------------------------------∙
display1 := "\\.\DISPLAY10" 	;; <--- Change as needed.
display2 := "\\.\DISPLAY11" 	;; <--- Change as needed.
display3 := "\\.\DISPLAYxx" 	;; <--- Change as/if needed.
;;∙-----------------------------------------------------------------------------------------------∙
monitor := new Monitor() 	;; <--- Initialize monitor control class.
;;∙-----------------------------------------------------------------------------------------------∙
GuiColor1 := "ABCDEF" 	;; <--- Light Blue.
TextColor1 := "123456" 	;; <--- Medium Blue.
GuiColor2 := "123456" 	;; <--- Medium Blue.
TextColor2 := "ABCDEF" 	;; <--- Light Blue.
GuiColor3 := "D58500" 	;; <--- Orange.
TextColor3 := "D50000" 	;; <--- Red.
; TextColor3 := "D5D500" 	;; <--- Yellow.
maxWidth := 250 		;; <--- Gui text.
;;∙-----------------------------------------------------------------------------------------------∙
Bright1 := "55" 	;; <--- Set Brightness level for display 1.   (0-100)
Cont1 := "75" 	;; <--- Set Contrast level for display 1.   (0-100)
R1D1 := "100" 	;; <--- Set Red gamma level for display 1.   (0-255)
G1D1 := "100" 	;; <--- Set Green gamma level for display 1.   (0-255)
B1D1 := "80" 	;; <--- Set Blue gamma level for display 1.   (0-255)
;;∙-----------------------------------------------------------------------------------------------∙
Bright2 := "55" 	;; <--- Set Brightness level for display 2.   (0-100)
Cont2 := "75" 	;; <--- Set Contrast level for display 2.   (0-100)
R2D2 := "100" 	;; <--- Set Red gamma level for display 2.   (0-255)
G2D2 := "100" 	;; <--- Set Green gamma level for display 2.   (0-255)
B2D2 := "80" 	;; <--- Set Blue gamma level for display 2.   (0-255)
;;∙================================================================∙


;;∙======∙RETRIEVE & DISPLAY MONITOR IDENTIFIERS∙===================∙
^i::    ;; (Ctrl+i)
Soundbeep, 1100, 100
SysGet, MonitorCount, MonitorCount
MonitorInfo := ""
Loop, %MonitorCount%
{
    SysGet, MonitorID, MonitorName, %A_Index%
    MonitorInfo .= "Monitor " A_Index ": " MonitorID "`n"
}
MonitorInfo := RTrim(MonitorInfo, "`n")
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Loop, Parse, MonitorInfo, `n, `r
{
    Gui, Add, Text, w250 h20 Center BackgroundTrans +0x0200 0x00800000, %A_LoopField%
}
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, MonIDs, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
Return
;;∙================================================================∙


;;∙======∙RETRIEVE MONITOR CONTROLS (DISPLAY10)∙===================∙
^Numpad1::

;;∙--------∙BRIGHTNESS ---------------∙
Brightness := monitor.GetBrightness(Display1)
if (Brightness)
{
    MinBrightness := Brightness.Minimum
    MaxBrightness := Brightness.Maximum
    CurBrightness := Brightness.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Brightness Levels
Gui, Font, s10 Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Minimum Brightness:`t%MinBrightness%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Maximum Brightness:`t%MaxBrightness%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Current Brightness:`t%CurBrightness%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, BrightLevel, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve brightness settings., 10
}
Sleep, 5500

;;∙------∙CONTRAST∙-------------------∙
Contrast := monitor.GetContrast(Display1)
if (Contrast)
{
    MinContrast := Contrast.Minimum
    MaxContrast := Contrast.Maximum
    CurContrast := Contrast.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Contrast Levels
Gui, Font, s10 Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Minimum Contrast:`t%MinContrast%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Maximum Contrast:`t%MaxContrast%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Current Contrast:`t%CurContrast%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, ContrastLevel, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve Contrast settings., 10
}
Sleep, 5500

;;∙------∙RGB GAMMA RAMP∙--------∙
GammaRamp := monitor.GetGammaRamp(Display1)
if (GammaRamp)
{
    RedGamma   := GammaRamp.Red
    GreenGamma := GammaRamp.Green
    BlueGamma  := GammaRamp.Blue
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Gamma Ramp Levels
Gui, Font, s10 Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Red Gamma:`t%RedGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Green Gamma:`t%GreenGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Blue Gamma:`t%BlueGamma%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, GammaRamp, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve gamma ramp settings., 10
}
Sleep, 5500
Return
;;∙================================================================∙


;;∙======∙RETRIEVE MONITOR CONTROLS (DISPLAY11)∙===================∙
^Numpad2::

;;∙--------∙BRIGHTNESS∙---------------∙
Brightness := monitor.GetBrightness(Display2)
if (Brightness)
{
    MinBrightness := Brightness.Minimum
    MaxBrightness := Brightness.Maximum
    CurBrightness := Brightness.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Brightness Levels
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Minimum Brightness:`t%MinBrightness%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Maximum Brightness:`t%MaxBrightness%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Current Brightness:`t%CurBrightness%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, BrightLevel, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve brightness settings., 10
}
Sleep, 5500

;;------∙CONTRAST∙-------------------∙
Contrast := monitor.GetContrast(Display2)
if (Contrast)
{
    MinContrast := Contrast.Minimum
    MaxContrast := Contrast.Maximum
    CurContrast := Contrast.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Contrast Levels
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Minimum Contrast:`t%MinContrast%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Maximum Contrast:`t%MaxContrast%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Current Contrast:`t%CurContrast%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, ContrastLevel, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve Contrast settings., 10
}
Sleep, 5500

;;------∙RGB GAMMA RAMP∙--------∙
GammaRamp := monitor.GetGammaRamp(Display2)
if (GammaRamp)
{
    RedGamma   := GammaRamp.Red
    GreenGamma := GammaRamp.Green
    BlueGamma  := GammaRamp.Blue
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor1%
Gui, Font, s10 c%TextColor1%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Gamma Ramp Levels
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Red Gamma:`t%RedGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Green Gamma:`t%GreenGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Blue Gamma:`t%BlueGamma%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, GammaRamp, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to retrieve gamma ramp settings., 10
}
Sleep, 5500
Return
;;∙================================================================∙


;;∙========∙SET MONITOR 1 CONTROLS - (PRIMARY DISPLAY10)∙===========∙
^Numpad3::

;;∙--------∙BRIGHTNESS ---------------∙
Monitor.SetBrightness(Bright1, Display1)
    Brightness := monitor.GetBrightness(Display1)
if (Brightness)
{
    CurBrightness := Brightness.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Brightness
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Brightness set to: %CurBrightness%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, BrightSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change brightness settings., 10
}
Sleep, 5500

;;∙------∙CONTRAST∙-------------------∙
Monitor.SetContrast(Cont1, Display1)
Contrast := monitor.GetContrast(Display1)
if (Contrast)
{
    CurContrast := Contrast.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Contrast
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Contrast set to: %CurContrast%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, ContrastSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change contrast settings., 10
}
Sleep, 5500

;;∙------∙RGB GAMMA RAMP∙--------∙
Monitor.SetGammaRamp(R1D1, G1D1, B1D1, Display1)
GammaRamp := monitor.GetGammaRamp(Display1)
if (GammaRamp)
{
    RedGamma   := GammaRamp.Red
    GreenGamma := GammaRamp.Green
    BlueGamma  := GammaRamp.Blue
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, %A_Space% RGB Gamma values set to: 
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Red Gamma = `t%RedGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Green Gamma = `t%GreenGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Blue Gamma = `t%BlueGamma%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, RGBSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change contrast settings., 10
}
Sleep, 5500
RETURN
;;∙================================================================∙


;;∙========∙SET MONITOR 2 CONTROLS - (SECONDARY DISPLAY11)∙========∙
^Numpad4::

;;∙--------∙BRIGHTNESS ---------------∙
Monitor.SetBrightness(Bright2, Display2)
    Brightness := monitor.GetBrightness(Display2)
if (Brightness)
{
    CurBrightness := Brightness.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Brightness
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Brightness set to: %CurBrightness%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, BrightSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change brightness settings., 10
}
Sleep, 5500

;;∙------∙CONTRAST∙-------------------∙
Monitor.SetContrast(Cont2, Display2)
Contrast := monitor.GetContrast(Display2)
if (Contrast)
{
    CurContrast := Contrast.Current
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, Contrast
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Contrast set to: %CurContrast%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, ContrastSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change contrast settings., 10
}
Sleep, 5500

;;∙------∙RGB GAMMA RAMP∙--------∙
Monitor.SetGammaRamp(R2D2, G2D2, B2D2, Display2)
GammaRamp := monitor.GetGammaRamp(Display2)
if (GammaRamp)
{
    RedGamma   := GammaRamp.Red
    GreenGamma := GammaRamp.Green
    BlueGamma  := GammaRamp.Blue
Gui, +AlwaysOnTop -Caption +LastFound
Gui, +hwndHGUI +E0x02000000 +E0x00080000
Gui, Color, %GuiColor2%
Gui, Font, s10 c%TextColor2%, ARIAL
Gui, Margin, 10, 10
Gui, Font, Bold
Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200, %A_Space% RGB Gamma values set to: 
Gui, Font, Norm
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Red Gamma = `t%RedGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Green Gamma = `t%GreenGamma%
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, %A_Space% Blue Gamma = `t%BlueGamma%
Gui, Font, s8
Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
Gui, Font, s10
Gui, Show, Hide NA
WinGetPos, X, Y, W, H
R := Min(W, H) // 5
WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
Gui, Show, NA
    SetTimer, RGBSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to change contrast settings., 10
}
Sleep, 5500
RETURN
;;∙================================================================∙


;;∙========∙RESTORE MONITOR BRIGHTNESS & CONTRAST DEFAULTS∙======∙
^Numpad5::    ;;------ Display1
Soundbeep, 1500, 300
if (Monitor.RestoreFactoryDefault(display1))
{
    Gui, +AlwaysOnTop -Caption +LastFound
    Gui, +hwndHGUI +E0x02000000 +E0x00080000
    Gui, Color, %GuiColor3%
    Gui, Font, s10 c%TextColor3%, ARIAL
    Gui, Margin, 10, 10
    Gui, Font, Bold
    Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Factory Defaults Have Been Set
    Gui, Font, s8Norm
    Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display1%  •  Monitor1  •
    Gui, Font, s10
    Gui, Show, Hide NA
    WinGetPos, X, Y, W, H
    R := Min(W, H) // 5
    WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
    Gui, Show, NA
    SetTimer, DefaultSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to restore factory defaults., 10
}
Sleep, 5500
RETURN

;;∙--------------------------------------------∙
^Numpad6::    ;;------ Display2
Soundbeep, 1500, 300
if (Monitor.RestoreFactoryDefault(display2))
{
    Gui, +AlwaysOnTop -Caption +LastFound
    Gui, +hwndHGUI +E0x02000000 +E0x00080000
    Gui, Color, %GuiColor3%
    Gui, Font, s10 c%TextColor3%, ARIAL
    Gui, Margin, 10, 10
    Gui, Font, Bold
    Gui, Add, Text, w%maxWidth% h20 Center BackgroundTrans +0x0200 0x00800000, Factory Defaults Have Been Set
    Gui, Font, s8Norm
    Gui, Add, Text, y+5 w%maxWidth% h20 Center BackgroundTrans +0x0200, •  %display2%  •  Monitor2  •
    Gui, Font, s10
    Gui, Show, Hide NA
    WinGetPos, X, Y, W, H
    R := Min(W, H) // 5
    WinSet, Region, 0-0 W%W% H%H% R%R%-%R%
    Gui, Show, NA
    SetTimer, DefaultSet, -5000
    OnMessage(0x0201, "WM_LBUTTONDOWNdrag")
}
else
{
    MsgBox, 16, Error, Unable to restore factory defaults., 10
}
Sleep, 5500
RETURN
;;∙================================================================∙


;;∙========∙SETTIMER CALLS∙=========================================∙
MonIDs:
BrightLevel:
ContrastLevel:
GammaRamp:
BrightSet:
ContrastSet:
RGBSet:
DefaultSet:
    Gui, Destroy
RETURN
;;∙================================================================∙

WM_LBUTTONDOWNdrag() {
   PostMessage, 0x00A1, 2, 0
    }
Return

;;∙================================================================∙
;;∙====∙CLASS∙==∙by:jNizM====∙
;;∙=======∙SOURCE∙==========∙
;; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=7854#p46349
;;∙================================================================∙

class Monitor
{
;;∙========∙PUBLIC METHODS∙========∙
    GetBrightness(Display := "")
    {
        if (hMonitor := this.GetMonitorHandle(Display))
        {
            PhysicalMonitors := this.GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
            hPhysicalMonitor := this.GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitors, PHYSICAL_MONITOR)
            Brightness := this.GetMonitorBrightness(hPhysicalMonitor)
            this.DestroyPhysicalMonitors(PhysicalMonitors, PHYSICAL_MONITOR)
            return Brightness
        }
        return false
    }
;;∙--------------------------------------------∙
    GetContrast(Display := "")
    {
        if (hMonitor := this.GetMonitorHandle(Display))
        {
            PhysicalMonitors := this.GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
            hPhysicalMonitor := this.GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitors, PHYSICAL_MONITOR)
            Contrast := this.GetMonitorContrast(hPhysicalMonitor)
            this.DestroyPhysicalMonitors(PhysicalMonitors, PHYSICAL_MONITOR)
            return Contrast
        }
        return false
    }
;;∙--------------------------------------------∙
    GetGammaRamp(Display := "")
    {
        if (DisplayName := this.GetDisplayName(Display))
        {
            if (hDC := this.CreateDC(DisplayName))
            {
                GammaRamp := this.GetDeviceGammaRamp(hDC)
                this.DeleteDC(hDC)
                return GammaRamp
            }
            this.DeleteDC(hDC)
        }
        return false
    }
;;∙--------------------------------------------∙
    RestoreFactoryDefault(Display := "")
    {
        if (hMonitor := this.GetMonitorHandle(Display))
        {
            PhysicalMonitors := this.GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
            hPhysicalMonitor := this.GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitors, PHYSICAL_MONITOR)
            this.RestoreMonitorFactoryDefaults(hPhysicalMonitor)
            this.DestroyPhysicalMonitors(PhysicalMonitors, PHYSICAL_MONITOR)
            return true
        }
        return false
    }
;;∙--------------------------------------------∙
    SetBrightness(Brightness, Display := "")
    {
        if (hMonitor := this.GetMonitorHandle(Display))
        {
            PhysicalMonitors := this.GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
            hPhysicalMonitor := this.GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitors, PHYSICAL_MONITOR)
            GetBrightness    := this.GetMonitorBrightness(hPhysicalMonitor)
            Brightness := (Brightness < GetBrightness["Minimum"]) ? GetBrightness["Minimum"]
                        : (Brightness > GetBrightness["Maximum"]) ? GetBrightness["Maximum"]
                        : (Brightness)
            this.SetMonitorBrightness(hPhysicalMonitor, Brightness)
            this.DestroyPhysicalMonitors(PhysicalMonitors, PHYSICAL_MONITOR)
            return Brightness
        }
        return false
    }
;;∙--------------------------------------------∙
    SetContrast(Contrast, Display := "")
    {
        if (hMonitor := this.GetMonitorHandle(Display))
        {
            PhysicalMonitors := this.GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
            hPhysicalMonitor := this.GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitors, PHYSICAL_MONITOR)
            GetContrast      := this.GetMonitorContrast(hPhysicalMonitor)
            Contrast := (Contrast < GetContrast["Minimum"]) ? GetContrast["Minimum"]
                      : (Contrast > GetContrast["Maximum"]) ? GetContrast["Maximum"]
                      : (Contrast)
            this.SetMonitorContrast(hPhysicalMonitor, Contrast)
            this.DestroyPhysicalMonitors(PhysicalMonitors, PHYSICAL_MONITOR)
            return Contrast
        }
        return false
    }
;;∙--------------------------------------------∙
    SetGammaRamp(Red, Green, Blue, Display := "")
    {
        if (DisplayName := this.GetDisplayName(Display))
        {
            if (hDC := this.CreateDC(DisplayName))
            {
                this.SetDeviceGammaRamp(hDC, Red, Green, Blue)
                this.DeleteDC(hDC)
                return true
            }
            this.DeleteDC(hDC)
        }
        return false
    }
    
;;∙========∙PRIVATE METHODS∙========∙
    CreateDC(DisplayName)
    {
        if (hDC := DllCall("gdi32\CreateDC", "str", DisplayName, "ptr", 0, "ptr", 0, "ptr", 0, "ptr"))
            return hDC
        return false
    }
;;∙--------------------------------------------∙
    DeleteDC(hDC)
    {
        if (DllCall("gdi32\DeleteDC", "ptr", hDC))
            return true
        return false
    }
;;∙--------------------------------------------∙
    DestroyPhysicalMonitors(PhysicalMonitorArraySize, PHYSICAL_MONITOR)
    {
        if (DllCall("dxva2\DestroyPhysicalMonitors", "uint", PhysicalMonitorArraySize, "ptr", &PHYSICAL_MONITOR))
            return true
        return false
    }
;;∙--------------------------------------------∙
    EnumDisplayMonitors(hMonitor := "")
    {
        static EnumProc := RegisterCallback(Monitor.EnumProc)
        static DisplayMonitors := {}

        if (MonitorNumber = "")
            DisplayMonitors := {}

        if (DisplayMonitors.MaxIndex() = "")
            if (DllCall("user32\EnumDisplayMonitors", "ptr", 0, "ptr", 0, "ptr", EnumProc, "ptr", &DisplayMonitors, "uint"))
                return (MonitorNumber = "") ? DisplayMonitors : DisplayMonitors.HasKey(MonitorNumber) ? DisplayMonitors[MonitorNumber] : false
        return false
    }
;;∙--------------------------------------------∙
    EnumProc(hDC, RECT, ObjectAddr)
    {
        DisplayMonitors := Object(ObjectAddr)
        MonitorInfo := Monitor.GetMonitorInfo(this)
        DisplayMonitors.Push(MonitorInfo)
        return true
    }
;;∙--------------------------------------------∙
    GetDeviceGammaRamp(hMonitor)
    {
        VarSetCapacity(GAMMA_RAMP, 1536, 0)
        if (DllCall("gdi32\GetDeviceGammaRamp", "ptr", hMonitor, "ptr", &GAMMA_RAMP))
        {
            GammaRamp := []
            GammaRamp["Red"]   := NumGet(GAMMA_RAMP,        2, "ushort") - 128
            GammaRamp["Green"] := NumGet(GAMMA_RAMP,  512 + 2, "ushort") - 128
            GammaRamp["Blue"]  := NumGet(GAMMA_RAMP, 1024 + 2, "ushort") - 128
            return GammaRamp
        }
        return false
    }
;;∙--------------------------------------------∙
    GetDisplayName(Display := "")
    {
        DisplayName := ""
        if (Enum := this.EnumDisplayMonitors()) && (Display != "")
        {
            for k, Mon in Enum
                if (InStr(Mon["Name"], Display))
                    DisplayName := Mon["Name"]
        }
        if (DisplayName = "")
            if (hMonitor := this.MonitorFromWindow())
                DisplayName := this.GetMonitorInfo(hMonitor)["Name"]

        return DisplayName
    }
;;∙--------------------------------------------∙
    GetMonitorBrightness(hMonitor)
    {
        if (DllCall("dxva2\GetMonitorBrightness", "ptr", hMonitor, "uint*", Minimum, "uint*", Current, "uint*", Maximum))
            return { "Minimum": Minimum, "Current": Current, "Maximum": Maximum }
        return false
    }
;;∙--------------------------------------------∙
    GetMonitorContrast(hMonitor)
    {
        if (DllCall("dxva2\GetMonitorContrast", "ptr", hMonitor, "uint*", Minimum, "uint*", Current, "uint*", Maximum))
            return { "Minimum": Minimum, "Current": Current, "Maximum": Maximum }
        return false
    }
;;∙--------------------------------------------∙
    GetMonitorHandle(Display := "")
    {
        hMonitor := 0

        if (Enum := this.EnumDisplayMonitors()) && (Display != "")
        {
            for k, Mon in Enum
                if (InStr(Mon["Name"], Display))
                    hMonitor := Mon["Handle"]
        }
        if !(hMonitor)
            hMonitor := this.MonitorFromWindow()

        return hMonitor
    }
;;∙--------------------------------------------∙
    GetMonitorInfo(hMonitor)
    {
        NumPut(VarSetCapacity(MONITORINFOEX, 40 + (32 << !!A_IsUnicode)), MONITORINFOEX, 0, "uint")
        if (DllCall("user32\GetMonitorInfo", "ptr", hMonitor, "ptr", &MONITORINFOEX))
        {
            MONITORINFO := []
            MONITORINFO["Handle"]   := hMonitor
            MONITORINFO["Name"]     := Name := StrGet(&MONITORINFOEX + 40, 32)
            MONITORINFO["Number"]   := RegExReplace(Name, ".*(\d+)$", "$1")
            MONITORINFO["Left"]     := NumGet(MONITORINFOEX,  4, "int")
            MONITORINFO["Top"]      := NumGet(MONITORINFOEX,  8, "int")
            MONITORINFO["Right"]    := NumGet(MONITORINFOEX, 12, "int")
            MONITORINFO["Bottom"]   := NumGet(MONITORINFOEX, 16, "int")
            MONITORINFO["WALeft"]   := NumGet(MONITORINFOEX, 20, "int")
            MONITORINFO["WATop"]    := NumGet(MONITORINFOEX, 24, "int")
            MONITORINFO["WARight"]  := NumGet(MONITORINFOEX, 28, "int")
            MONITORINFO["WABottom"] := NumGet(MONITORINFOEX, 32, "int")
            MONITORINFO["Primary"]  := NumGet(MONITORINFOEX, 36, "uint")
            return MONITORINFO
        }
        return false
    }
;;∙--------------------------------------------∙
    GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor)
    {
        if (DllCall("dxva2\GetNumberOfPhysicalMonitorsFromHMONITOR", "ptr", hMonitor, "uint*", NumberOfPhysicalMonitors))
            return NumberOfPhysicalMonitors
        return false
    }
;;∙--------------------------------------------∙
    GetPhysicalMonitorsFromHMONITOR(hMonitor, PhysicalMonitorArraySize, ByRef PHYSICAL_MONITOR)
    {
        VarSetCapacity(PHYSICAL_MONITOR, (A_PtrSize + 256) * PhysicalMonitorArraySize, 0)
        if (DllCall("dxva2\GetPhysicalMonitorsFromHMONITOR", "ptr", hMonitor, "uint", PhysicalMonitorArraySize, "ptr", &PHYSICAL_MONITOR))
            return NumGet(PHYSICAL_MONITOR, 0, "ptr")
        return false
    }
;;∙--------------------------------------------∙
    MonitorFromWindow(hWindow := 0)
    {
        static MONITOR_DEFAULTTOPRIMARY := 0x00000001

        if (hMonitor := DllCall("user32\MonitorFromWindow", "ptr", hWindow, "uint", MONITOR_DEFAULTTOPRIMARY))
            return hMonitor
        return false
    }
;;∙--------------------------------------------∙
    RestoreMonitorFactoryDefaults(hMonitor)
    {
        if (DllCall("dxva2\RestoreMonitorFactoryDefaults", "ptr", hMonitor))
            return false
        return true
    }
;;∙--------------------------------------------∙
    SetDeviceGammaRamp(hMonitor, Red, Green, Blue)
    {
        loop % VarSetCapacity(GAMMA_RAMP, 1536, 0) / 6
        {
            NumPut((r := (red   + 128) * (A_Index - 1)) > 65535 ? 65535 : r, GAMMA_RAMP,        2 * (A_Index - 1), "ushort")
            NumPut((g := (green + 128) * (A_Index - 1)) > 65535 ? 65535 : g, GAMMA_RAMP,  512 + 2 * (A_Index - 1), "ushort")
            NumPut((b := (blue  + 128) * (A_Index - 1)) > 65535 ? 65535 : b, GAMMA_RAMP, 1024 + 2 * (A_Index - 1), "ushort")
        }
        if (DllCall("gdi32\SetDeviceGammaRamp", "ptr", hMonitor, "ptr", &GAMMA_RAMP))
            return true
        return false
    }
;;∙--------------------------------------------∙
    SetMonitorBrightness(hMonitor, Brightness)
    {
        if (DllCall("dxva2\SetMonitorBrightness", "ptr", hMonitor, "uint", Brightness))
            return true
        return false
    }
;;∙--------------------------------------------∙
    SetMonitorContrast(hMonitor, Contrast)
    {
        if (DllCall("dxva2\SetMonitorContrast", "ptr", hMonitor, "uint", Contrast))
            return true
        return false
    }
}
Return
;;∙================================================================∙



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
Menu, Tray, Icon, setupapi.dll, 32
Return
;;-----------------------------------------------------------------------------∙

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙
;;     ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙

