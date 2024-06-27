
/*
▎▔▔▔▔▔▔▔▔▔▔▔▔▔▔✎ NOTES ✎▔▔▔▔▔▔▔▔▔▔▔▔▔▔▎ 
 •───────────────────────────────────────────────• 
➤∙ ∙ ∙ ∙ ∙ ∙ ∙ Base Notes ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ 
» Refresh Script ━━━━ Ctrl + HOME key rapidly clicked 2 times. (# TapCounts)
» Exit Script ━━━━━━━━ Ctrl + Escape key rapidly clicked 3 times. (# TapCounts)

» Script Updater: Auto-reload script upon saved changes.
    ⋗ If you make any changes to the script file and save it, the script will automatically reload itself and continue running without manual intervention.
 •───────────────────────────────────────────────• 
➤∙ ∙ ∙ ∙ ∙ ∙ ∙ Script Specific Notes ∙ ∙ ∙ ∙ ∙ ∙ ∙ ∙ 
» 
 •───────────────────────────────────────────────• 
➤ Further notes at bottom of script∙∙∙∙∙∙∙ Yes:     No: ✔ 
▎▁▁▁▁▁▁▁▁▁▁▁▁▁▁ NOTES END ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▎
*/


;⯁═══════════════ Auto-Execute ═══════════════⯁
Gosub, AutoExecute
GDIP_Startup()
GDIP_Startup2()
Gdip_Startup3()
Gdip_Startup4()
;○────────── Auto-Execute End ───────────○ 

; ———————————————— 
MyButton1 := New Flat_Round_Switch_Type_1(x := 15 
 , y := 15 
 , w := 229 
 , Text := "I Am A Toggle Button" 
 , Font:="Arial"
 , FontSize:= "14 Bold" 
 , FontColor:="FFFFFF" 
 , Window := "1" 		 ; 🡰🡰 The name of the parent window that this control belongs to. ( default is 1 )
 , Background_Color:="1B1C1D"
 , State:=0 			 ; 🡰🡰 The default (starting) state. (0=Off / 1=On)
 , Label := "MyButton" ) 	 ; 🡰🡰 Setting the label that gets called when the switch is toggled.
; ———————————————— 
NewButton1 := New Flat_Round_Switch_Type_2(x := 15 
 , y := 45 
 , w := 229 
 , Text := "I Am Also A Toggle Button" 
 , Font:="Arial"
 , FontSize:= "14 Bold" 
 , FontColor:="FFFFFF" 
 , Window := "1" 		 ; 🡰🡰 The name of the parent window that this control belongs to. ( default is 1 )
 , Background_Color:="1B1C1D"
 , State:=1 			 ; 🡰🡰 The default (starting) state. (0=Off / 1=On)
 , Label := "NewButton" ) 	 ; 🡰🡰 Setting the label that gets called when the switch is toggled.
; ———————————————— 
; ———————————————— 
TheButton1 := New Flat_Round_Switch_Type_3(x := 15 
 , y := 75 
 , w := 229 
 , Text := "I Am Too But I Broke" 
 , Font:="Arial"
 , FontSize:= "14 Bold" 
 , FontColor:="FFFFFF" 
 , Window := "1" 		 ; 🡰🡰 The name of the parent window that this control belongs to. ( default is 1 )
 , Background_Color:="1B1C1D"
 , State:=1 			 ; 🡰🡰 The default (starting) state. (0=Off / 1=On)
 , Label := "TheButton" ) 	 ; 🡰🡰 Setting the label that gets called when the switch is toggled.
; ———————————————— 
; ———————————————— 
SlideButton4 := New Flat_Round_Switch_Type_4(x := 15 
 , y := 105 
 , w := 229 
 , Text := "I Am Also A Toggle Button" 
 , Font:="Arial"
 , FontSize:= "14 Bold" 
 , FontColor:="FFFFFF" 
 , Window := "1" 		 ; 🡰🡰 The name of the parent window that this control belongs to. ( default is 1 )
 , Background_Color:="1B1C1D"
 , State:=1 			 ; 🡰🡰 The default (starting) state. (0=Off / 1=On)
 , Label := "SlideButton4" ) 	 ; 🡰🡰 Setting the label that gets called when the switch is toggled.
; ———————————————— 

; ———————————————————————————————— 
Gui,1: Color, 1B1C1D
Gui,1: Margin, 25, 5
Gui,1: Show, w250 h150 Hide,
WinGetPos, X, Y, W, H
R := Min(W, H) // 5 			 ; <<<<-----  Set value to amount of cornering. (0.5=Oval, 0=square, 1= capsule, 5=rounded corners).
WinSet, Region, 0-0 W%W% H%H% R%R%-%R% 	  ; <<<<-----  Cornering math.

Gui,1: Show, w250 h150, Switch Demo
OnMessage(0x0201, "WM_LBUTTONDOWN")

Return 		 ; 🡰🡰 End of Auto-Execute Section

GuiClose: 		 ; 🡰🡰 Closing the window
*ESC::ExitApp 	 ; 🡰🡰 Exit hotkey
; ———————————————————————————————— 
MyButton: 	 ; 🡰🡰 Gets called when you toggle the switch.
    if( MyButton1.State = 0 ){

        ; ✖✖ Your actions if the switch is ON ✖✖
        ; MsgBox, Hello World
        Soundbeep, 1500, 75        

    }else{
    
        ; ✖✖ Your actions if the switch is OFF ✖✖
        SoundBeep, 1700, 75
        
    }

        ; ✖✖ Any other actions to take  ✖✖
    ;....
;        SoundBeep, 2200, 175
;        SoundBeep, 2200, 175
    ;..
    ;.
    Return
; ———————————————————————————————— 
NewButton: 	 ; 🡰🡰 Gets called when you toggle the switch.
    if( NewButton1.State = 0 ){

        ; ✖✖ Your actions if the switch is ON ✖✖
        ; MsgBox, Hello World
        Soundbeep, 1500, 75        

    }else{
    
        ; ✖✖ Your actions if the switch is OFF ✖✖
        SoundBeep, 1700, 75
        
    }

        ; ✖✖ Any other actions to take  ✖✖
    ;....
;        SoundBeep, 2200, 175
;        SoundBeep, 2200, 175
    ;..
    ;.
    Return
; ———————————————————————————————— 
TheButton: 	 ; 🡰🡰 Gets called when you toggle the switch.
    if( TheButton1.State = 0 ){

        ; ✖✖ Your actions if the switch is ON ✖✖
        ; MsgBox, Hello World
        Soundbeep, 1500, 75        

    }else{
    
        ; ✖✖ Your actions if the switch is OFF ✖✖
        SoundBeep, 1700, 75
        SoundBeep, 1700, 75
    }

        ; ✖✖ Any other actions to take  ✖✖
    ;....
;        SoundBeep, 2200, 175
;        SoundBeep, 2200, 175
    ;..
    ;.
    Return
; ———————————————————————————————— 
SlideButton4: 	 ; 🡰🡰 Gets called when you toggle the switch.
    if( SlideButton4.State = 0 ){

        ; ✖✖ Your actions if the switch is ON ✖✖
        ; MsgBox, Hello World
        Soundbeep, 1500, 75        

    }else{
    
        ; ✖✖ Your actions if the switch is OFF ✖✖
        SoundBeep, 1700, 75
        SoundBeep, 1700, 75
    }
Return



;************************************************************************** 
 class Flat_Round_Switch_Type_1  {
    __New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:=""){
        This.State:=State
        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=21
        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize
        This.FontColor:= "0xFF" FontColor
        This.Background_Color:= "0xFF" Background_Color
        This.Window:=Window
        This.Create_Off_Bitmap()
        This.Create_On_Bitmap()
        This.Create_Trigger()
        This.Label:=Label
        sleep,20
        if(This.State)
            This.Draw_On()
        else
            This.Draw_Off()
    }
    Create_Trigger(){
        Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
        This.Hwnd:=hwnd
        BD := THIS.Switch_State.BIND( THIS ) 
        GUICONTROL +G , % This.Hwnd , % BD
    }
; ——————————————— 
    Create_Off_Bitmap(){ 					  ; SLIDER SWITCH OFF
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF7F0000" , 1 ) 			 ; Slider off ring bottom shadow. (Med Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFFEE0000" , 1 ) 			 ; Slider off ring over edge. (Bright Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
        Brush := Gdip_BrushCreateSolid( "0xFF272822" ) 		 ; Slider off ring under edge. (Dark Gray)
        Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF370000" ) 		 ; Slider off back surface. (Dark Red)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x88FF4C00" ) 		 ;  Slider button background shadow. (Orange)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF430000" ) 		 ; Slider button off ring edge. ( XX Dark Red)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFCA0000" , "0xFF5D0000" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring.
        Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFA40000" , "0xFF720000" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ; Button Main Center.
        Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.Off_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
; ——————————————— 
    Create_On_Bitmap(){ 					 ; SLIDER SWITCH ON 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF01600F" , 1 ) 			 ; Slider surface bottom shadow. (Green)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 ) 			 ; Slider ring edge. (Gray)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
; On Background Colors
        Brush := Gdip_BrushCreateSolid( "0xFF5CBEFF" ) 		 ; Slider surface edge. (Light Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF007DD1" ) 		 ; Slider front surface. (Med Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x8827282B" ) 		 ; Slider button background shadow. (Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" ) 		 ; Slider button ring edge. ( XX Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF104DB8" , "0xFF0A2E6E" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF0D3F97" , "0xFF092C69" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ;  Button Main Center. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.On_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
    Switch_State(){
        (This.State:=!This.State)?(This.Draw_On()):(This.Draw_Off())
        if(This.Label)  
            gosub,% This.Label
    }
    Draw_Off(){
        SetImage( This.Hwnd , This.Off_Bitmap )
    }
    Draw_On(){
        SetImage( This.Hwnd , This.On_Bitmap )
    }
} 

; ——————————————— Gdip LITE ——————————————— 
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdi32\BitBlt", Ptr, dDC, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
}
; ——————————————— 
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if (Matrix&1 = "")
        ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
    else if (Matrix != 1)
        ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
    if(sx = "" && sy = "" && sw = "" && sh = ""){
        if(dx = "" && dy = "" && dw = "" && dh = ""){
            sx := dx := 0, sy := dy := 0
            sw := dw := Gdip_GetImageWidth(pBitmap)
            sh := dh := Gdip_GetImageHeight(pBitmap)
        }else   {
            sx := sy := 0,sw := Gdip_GetImageWidth(pBitmap),sh := Gdip_GetImageHeight(pBitmap)
        }
    }
    E := DllCall("gdiplus\GdipDrawImageRectRect", Ptr, pGraphics, Ptr, pBitmap, "float", dx, "float", dy, "float", dw, "float", dh, "float", sx, "float", sy, "float", sw, "float", sh, "int", 2, Ptr, ImageAttr, Ptr, 0, Ptr, 0)
    if ImageAttr
        Gdip_DisposeImageAttributes(ImageAttr)
    return E
}
Gdip_SetImageAttributesColorMatrix(Matrix){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    VarSetCapacity(ColourMatrix, 100, 0)
    Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
    StringSplit, Matrix, Matrix, |
    Loop, 25
    {
        Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
        NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
    }
    DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
    DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
    return ImageAttr
}
Gdip_GetImageWidth(pBitmap){
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}
Gdip_GetImageHeight(pBitmap){
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
Gdip_DeletePen(pPen){
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}
Gdip_DeleteBrush(pBrush){
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}
Gdip_DisposeImage(pBitmap){
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
Gdip_DeleteGraphics(pGraphics){
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_DisposeImageAttributes(ImageAttr){
    return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}
Gdip_DeleteFont(hFont){
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}
Gdip_DeleteStringFormat(hFormat){
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}
Gdip_DeleteFontFamily(hFamily){
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
SelectObject(hdc, hgdiobj){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
DeleteObject(hObject){
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
GetDC(hwnd=0){
    return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
GetDCEx(hwnd, flags=0, hrgnClip=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}
ReleaseDC(hdc, hwnd=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
DeleteDC(hdc){
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
Gdip_SetClipRegion(pGraphics, Region, CombineMode=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    hdc2 := hdc ? hdc : GetDC()
    VarSetCapacity(bi, 40, 0)
    NumPut(w, bi, 4, "uint"), NumPut(h, bi, 8, "uint"), NumPut(40, bi, 0, "uint"), NumPut(1, bi, 12, "ushort"), NumPut(0, bi, 16, "uInt"), NumPut(bpp, bi, 14, "ushort")
    hbm := DllCall("CreateDIBSection", Ptr, hdc2, Ptr, &bi, "uint", 0, A_PtrSize ? "UPtr*" : "uint*", ppvBits, Ptr, 0, "uint", 0, Ptr)
    if !hdc
        ReleaseDC(hdc2)
    return hbm
}
Gdip_GraphicsFromImage(pBitmap){
    DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_GraphicsFromHDC(hdc){
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_GetDC(pGraphics){
    DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
    return hdc
}
 
; ——————————————— 
Gdip_Startup(){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
        DllCall("LoadLibrary", "str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
    return pToken
}
Return
;************************************************************************** 
 class Flat_Round_Switch_Type_2  {
    __New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:=""){
        This.State:=State
        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=21
        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize
        This.FontColor:= "0xFF" FontColor
        This.Background_Color:= "0xFF" Background_Color
        This.Window:=Window
        This.Create_Off_Bitmap2()
        This.Create_On_Bitmap2()
        This.Create_Trigger2()
        This.Label:=Label
        sleep,20
        if(This.State)
            This.Draw_On2()
        else
            This.Draw_Off2()
    }
    Create_Trigger2(){
        Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
        This.Hwnd:=hwnd
        BD := THIS.Switch_State2.BIND( THIS ) 
        GUICONTROL +G , % This.Hwnd , % BD
    }
; ——————————————— 
    Create_Off_Bitmap2(){ 					  ; SLIDER SWITCH OFF
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF7F0000" , 1 ) 			 ; Slider off ring bottom shadow. (Med Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFFEE0000" , 1 ) 			 ; Slider off ring over edge. (Bright Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
        Brush := Gdip_BrushCreateSolid( "0xFF272822" ) 		 ; Slider off ring under edge. (Dark Gray)
        Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF370000" ) 		 ; Slider off back surface. (Dark Red)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x88FF4C00" ) 		 ;  Slider button background shadow. (Orange)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF430000" ) 		 ; Slider button off ring edge. ( XX Dark Red)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFCA0000" , "0xFF5D0000" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring.
        Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFA40000" , "0xFF720000" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ; Button Main Center.
        Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.Off_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
; ——————————————— 
    Create_On_Bitmap2(){ 					 ; SLIDER SWITCH ON 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF01600F" , 1 ) 			 ; Slider surface bottom shadow. (Green)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 ) 			 ; Slider ring edge. (Gray)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
; On Background Colors
        Brush := Gdip_BrushCreateSolid( "0xFF56CF00" ) 		 ; Slider surface edge. (Light Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFFA0DD1D" ) 		 ; Slider front surface. (Med Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x8827282B" ) 		 ; Slider button background shadow. (Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" ) 		 ; Slider button ring edge. ( XX Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFEFE943" , "0xFFE4CA25" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFF1EC5F" , "0xFFDCB91C" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ;  Button Main Center. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.On_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
    Switch_State2(){
        (This.State:=!This.State)?(This.Draw_On2()):(This.Draw_Off2())
        if(This.Label)  
            gosub,% This.Label
    }
    Draw_Off2(){
        SetImage( This.Hwnd , This.Off_Bitmap2 )
    }
    Draw_On2(){
        SetImage( This.Hwnd , This.On_Bitmap2 )
    }
} 

; ——————————————— Gdip LITE ——————————————— 
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; ——————————————— 
Gdip_Startup2(){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
        DllCall("LoadLibrary", "str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
    return pToken
}
; ——————————————— 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
Return
;************************************************************************** 
 class Flat_Round_Switch_Type_3  {
    __New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:=""){
        This.State:=State
        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=21
        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize
        This.FontColor:= "0xFF" FontColor
        This.Background_Color:= "0xFF" Background_Color
        This.Window:=Window
        This.Create_Off_Bitmap3()
        This.Create_On_Bitmap3()
        This.Create_Trigger3()
        This.Label:=Label
        sleep,20
        if(This.State)
            This.Draw_On3()
        else
            This.Draw_Off3()
    }
    Create_Trigger3(){
        Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
        This.Hwnd:=hwnd
        BD := THIS.Switch_State3.BIND( THIS )  		 ; <<<<<
        GUICONTROL +G , % This.Hwnd , % BD
    }
; ——————————————— 
    Create_Off_Bitmap3(){ 					  ; SLIDER SWITCH OFF
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF7F0000" , 1 ) 			 ; Slider off ring bottom shadow. (Med Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFFEE0000" , 1 ) 			 ; Slider off ring over edge. (Bright Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
        Brush := Gdip_BrushCreateSolid( "0xFF272822" ) 		 ; Slider off ring under edge. (Dark Gray)
        Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF370000" ) 		 ; Slider off back surface. (Dark Red)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x88FF4C00" ) 		 ;  Slider button background shadow. (Orange)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF430000" ) 		 ; Slider button off ring edge. ( XX Dark Red)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFCA0000" , "0xFF5D0000" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring.
        Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFA40000" , "0xFF720000" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ; Button Main Center.
        Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.Off_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
; ——————————————— 
    Create_On_Bitmap3(){ 					 ; SLIDER SWITCH ON 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF01600F" , 1 ) 			 ; Slider surface bottom shadow. (Green)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 ) 			 ; Slider ring edge. (Gray)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
; On Background Colors
        Brush := Gdip_BrushCreateSolid( "0xFF76007A" ) 		 ; Slider surface edge. (Light Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFFB400B9" ) 		 ; Slider front surface. (Med Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x8827282B" ) 		 ; Slider button background shadow. (Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" ) 		 ; Slider button ring edge. ( XX Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFC500CC" , "0xFF540057" , 1 , 1 ) 	 ; "0xFF60646A" , "0xFF393B3F"  ; Button Ring. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFCB06C8" , "0xFF450047" , 1 , 1 ) 	 ; "0xFF4D5055" , "0xFF36383B"  ;  Button Main Center. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.On_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap)
        Gdip_DisposeImage(pBitmap)
    }
    Switch_State3(){
        (This.State:=!This.State)?(This.Draw_On3()):(This.Draw_Off3())
        if(This.Label)  
            gosub,% This.Label
    }
    Draw_Off3(){
        SetImage( This.Hwnd , This.Off_Bitmap2 )
    }
    Draw_On3(){
        SetImage( This.Hwnd , This.On_Bitmap2 )
    }
} 

; ——————————————— Gdip LITE ——————————————— 
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; ——————————————— 
Gdip_Startup3(){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
        DllCall("LoadLibrary", "str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
    return pToken
}


; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
Return
;************************************************************************** 
 class Flat_Round_Switch_Type_4  { 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
    __New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:=""){
        This.State:=State
        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=21
        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize
        This.FontColor:= "0xFF" FontColor
        This.Background_Color:= "0xFF" Background_Color
        This.Window:=Window
        This.Create_Off_Bitmap4() 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        This.Create_On_Bitmap4() 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        This.Create_Trigger4() 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        This.Label:=Label
        sleep,20
        if(This.State)
            This.Draw_On4() 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        else
            This.Draw_Off4() 	 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
    }
    Create_Trigger4(){
        Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
        This.Hwnd:=hwnd
        BD := THIS.Switch_State4.BIND( THIS )  		 ; <<<<<⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        GUICONTROL +G , % This.Hwnd , % BD
    }
; ——————————————— 
    Create_Off_Bitmap4(){ 		;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 	  ; SLIDER SWITCH OFF
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF7F0000" , 1 ) 			 ; Slider off ring bottom shadow. (Med Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFFEE0000" , 1 ) 			 ; Slider off ring over edge. (Bright Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
        Brush := Gdip_BrushCreateSolid( "0xFF272822" ) 		 ; Slider off ring under edge. (Dark Gray)
        Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF370000" ) 		 ; Slider off back surface. (Dark Red)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x88FF4C00" ) 		 ;  Slider button background shadow. (Orange)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF430000" ) 		 ; Slider button off ring edge. ( XX Dark Red)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFCA0000" , "0xFF5D0000" , 1 , 1 ) 	 ; "0xFF00E0BB" , "0xFF009980"  ; Button Ring.
        Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFA40000" , "0xFF720000" , 1 , 1 ) 	 ; "0xFF00E6BF" , "0xFF008A73"  ; Button Main Center.
        Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )
        This.Off_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap) 	;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        Gdip_DisposeImage(pBitmap)
    }
; ——————————————— 
    Create_On_Bitmap4(){ 		;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 	 ; SLIDER SWITCH ON 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF01600F" , 1 ) 			 ; Slider surface bottom shadow. (Green)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 ) 			 ; Slider ring edge. (Gray)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
; ———————————————————————————— 
; On Background Colors
        Brush := Gdip_BrushCreateSolid( "0xFF76007A" ) 		 ; Slider surface edge. (Light Blue)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFFB400B9" ) 		 ; Slider front surface. (Med Blue)
; ———————————————————————————— 
Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x8827282B" ) 		 ; Slider button background shadow. (Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" ) 		 ; Slider button ring edge. ( XX Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFFC500CC" , "0xFF540057" , 1 , 1 ) 	 ; "0xFF00EBC4" , "0xFF007A66"  ; Button Ring. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFFCB06C8" , "0xFF450047" , 1 , 1 ) 	 ; "0xFF05FFD5" , "0xFF008A73"  ;  Button Main Center. (Med Dark Blue/Dark Blue)
        Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
        Gdip_DeleteBrush( Brush )
; Adding text
        Brush := Gdip_BrushCreateSolid( This.FontColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )

        This.On_Bitmap2 := Gdip_CreateHBITMAPFromBitmap(pBitmap) 	; ⮜—⮜— 
        Gdip_DisposeImage(pBitmap)
    }
    Switch_State4(){  		 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        (This.State:=!This.State)?(This.Draw_On4()):(This.Draw_Off4()) 	 ;;⮜—⮜— CHANGE NUMBERSs ⮜—⮜— 
        if(This.Label)  
            gosub,% This.Label
    }
    Draw_Off4(){ 		 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        SetImage( This.Hwnd , This.Off_Bitmap2 ) 
    }
    Draw_On4(){ 		 ;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
        SetImage( This.Hwnd , This.On_Bitmap2 ) 
    }
} 

; ——————————————— Gdip LITE ——————————————— 
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; ——————————————— 




; ———————————————
Gdip_Startup4(){ 		;;⮜—⮜— CHANGE NUMBER ⮜—⮜— 
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
        DllCall("LoadLibrary", "str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
    return pToken
}


; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 

;⯁════════════════════════════════════════════════════⯁ 
;⯁════════════════════════════════════════════════════⯁
; ——————————————— 
Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0){
    IWidth := Width, IHeight:= Height
    RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
    RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
    RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
    RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
    RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
    RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
    RegExMatch(Options, "i)NoWrap", NoWrap)
    RegExMatch(Options, "i)R(\d)", Rendering)
    RegExMatch(Options, "i)S(\d+)(p*)", Size)
    if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
        PassBrush := 1, pBrush := Colour2
    if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
        return -1
    Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
    Loop, Parse, Styles, |
    {
        if RegExMatch(Options, "\b" A_loopField)
        Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
    }
    Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
    Loop, Parse, Alignments, |
    {
        if RegExMatch(Options, "\b" A_loopField)
            Align |= A_Index//2.1      ; 0|0|1|1|2|2
    }
    xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
    ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
    Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
    Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
    if !PassBrush
        Colour := "0x" (Colour2 ? Colour2 : "ff000000")
    Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
    Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12
    hFamily := Gdip_FontFamilyCreate(Font)
    hFont := Gdip_FontCreate(hFamily, Size, Style)
    FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
    hFormat := Gdip_StringFormatCreate(FormatStyle)
    pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
    if !(hFamily && hFont && hFormat && pBrush && pGraphics)
        return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
    CreateRectF(RC, xpos, ypos, Width, Height)
    Gdip_SetStringFormatAlign(hFormat, Align)
    Gdip_SetTextRenderingHint(pGraphics, Rendering)
    ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
    if vPos
    {
        StringSplit, ReturnRC, ReturnRC, |
        if (vPos = "vCentre") || (vPos = "vCenter")
            ypos += (Height-ReturnRC4)//2
        else if (vPos = "Top") || (vPos = "Up")
            ypos := 0
        else if (vPos = "Bottom") || (vPos = "Down")
            ypos := Height-ReturnRC4
        CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
        ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
    }
    if !Measure
        E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)
    if !PassBrush
        Gdip_DeleteBrush(pBrush)
    Gdip_DeleteStringFormat(hFormat)
    Gdip_DeleteFont(hFont)
    Gdip_DeleteFontFamily(hFamily)
    return E ? E : ReturnRC
}
; ——————————————— 
Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if (!A_IsUnicode)
    {
        nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
        VarSetCapacity(wString, nSize*2)
        DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
    }
    return DllCall("gdiplus\GdipDrawString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, pBrush)
}
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
    DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
    return LGpBrush
}
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1){
    CreateRectF(RectF, x, y, w, h)
    DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
    return LGpBrush
}
Gdip_CloneBrush(pBrush){
    DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
    return pBrushClone
}
Gdip_FontFamilyCreate(Font){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if (!A_IsUnicode)
    {
        nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
        VarSetCapacity(wFont, nSize*2)
        DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
    }
    DllCall("gdiplus\GdipCreateFontFamilyFromName", Ptr, A_IsUnicode ? &Font : &wFont, "uint", 0, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
    return hFamily
}
Gdip_SetStringFormatAlign(hFormat, Align){
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}
Gdip_StringFormatCreate(Format=0, Lang=0){
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}
Gdip_FontCreate(hFamily, Size, Style=0){
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}
Gdip_CreatePen(ARGB, w){
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}
Gdip_CreatePenFromBrush(pBrush, w){
    DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
    return pPen
}
Gdip_BrushCreateSolid(ARGB=0xff000000){
    DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
    return pBrush
}
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0){
    DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
    return pBrush
}
CreateRectF(ByRef RectF, x, y, w, h){
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}
Gdip_SetTextRenderingHint(pGraphics, RenderingHint){
    return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}
Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    VarSetCapacity(RC, 16)
    if !A_IsUnicode
    {
        nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
        VarSetCapacity(wString, nSize*2)
        DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
    }
    DllCall("gdiplus\GdipMeasureString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, &RC, "uint*", Chars, "uint*", Lines)
    return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}
CreateRect(ByRef Rect, x, y, w, h){
    VarSetCapacity(Rect, 16)
    NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
CreateSizeF(ByRef SizeF, w, h){
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
}
CreatePointF(ByRef PointF, x, y){
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
}
Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipDrawArc", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipDrawLine", Ptr, pGraphics, Ptr, pPen, "float", x1, "float", y1, "float", x2, "float", y2)
}
Gdip_DrawLines(pGraphics, pPen, Points){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    StringSplit, Points, Points, |
    VarSetCapacity(PointF, 8*Points0)
    Loop, %Points0%
    {
        StringSplit, Coord, Points%A_Index%, `,
        NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
    }
    return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
}
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipFillRectangle", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r){
    Region := Gdip_GetClipRegion(pGraphics)
    Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
    E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
    Gdip_SetClipRegion(pGraphics, Region, 0)
    Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
    Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
    Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
    Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
    Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
    Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
    Gdip_SetClipRegion(pGraphics, Region, 0)
    Gdip_DeleteRegion(Region)
    return E
}
Gdip_GetClipRegion(pGraphics){
    Region := Gdip_CreateRegion3()
    DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
    return Region
}
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0){
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}
Gdip_SetClipPath(pGraphics, Path, CombineMode=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}
Gdip_ResetClip(pGraphics){
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRegion(pGraphics, pBrush, Region){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}
Gdip_FillPath(pGraphics, pBrush, Path){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}
Gdip_CreateRegion3(){
    DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
    return Region
}
Gdip_DeleteRegion(Region){
    return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}
Gdip_CreateBitmap(Width, Height, Format=0x26200A){
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode){
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}
Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r){
    Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
    Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
    E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
    Gdip_ResetClip(pGraphics)
    Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
    Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
    Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
    Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
    Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
    Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
    Gdip_ResetClip(pGraphics)
    return E
}
Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
    DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
    return hbm
}
SetImage(hwnd, hBitmap){
    SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
    E := ErrorLevel
    DeleteObject(E)
    return E
}
Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0){
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    StringSplit, Points, Points, |
    VarSetCapacity(PointF, 8*Points0)
    Loop, %Points0%
    {
        StringSplit, Coord, Points%A_Index%, `,
        NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
    }
    return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
}
; ———————————————————————————— 
; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
   return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}
;⯁════════════════════════════════════════════════════⯁ 
;⯁════════════════════════════════════════════════════⯁

;⯁════════════ Reload/Exit Routine ════════════⯁ 
WM_LBUTTONDOWN() {
   PostMessage, 0x00A1, 2, 0
} 
RETURN

; ⮞━━━━━ RELOAD ━━━━ RELOAD ━━━━ RELOAD ━━━━━⮜ 
^Home:: 		 ; (Ctrl + ([Home] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 2) 	 ; ⬅ ⬅ Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, YELLOW 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
        Reload
} else {
        KeyWait, Esc
    }
}
Return

; ⮞━━━━━━ EXIT ━━━━━━━━ EXIT ━━━━━━━━ EXIT ━━━━━━━⮜ 
^Esc:: 		 ; (Ctrl + ([Esc] times (# of TapCounts)))
if (A_TimeSincePriorHotkey > 250) 
{
    TapCount := 1
    KeyWait, Esc
} else {
    TapCount++
    if (TapCount = 3) 	 ; ⬅ ⬅ Set TapCount to # of key taps wanted.
    {
  Gosub, IndicateDot1
Gui, Color, RED 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
        Gui, Destroy
        ExitApp
} else {
        KeyWait, Esc
    }
}
Return
;○───────── Reload/Exit Routine End ───────○ 


;⯁═══════════════ Script Updater ══════════════⯁
UpdateCheck: 	 ; Check if the script file has been modified.
    oldModTime := currentModTime
FileGetTime, currentModTime, %A_ScriptFullPath%
; 🠪 🠪 🠪 If the modification timestamp has changed, reload the script. 
    if  (oldModTime = currentModTime) Or (oldModTime = "")
        Return
  Gosub, IndicateDot1
Gui, Color, BLUE 	 ; ⬅ ⬅ IndicateDot Color.
  Gosub, IndicateDot2
Reload
;○────────── Script Updater End ──────────○ 


;⯁═════════════ Auto-Execute Sub ═════════════⯁
AutoExecute: 
#NoEnv ; Recommended for performance and future compatibility.
#Persistent ; Keeps a script permanently running until user closes it or ExitApp is encountered.
#SingleInstance, Force ; Determines whether a script is allowed to run again when it is already running.
SetBatchLines -1 ; Determines how fast script will run.
DetectHiddenWindows, On ; Determines whether invisible windows (scripts) are "seen" by the script.
SetTimer, UpdateCheck, 500 ; Checks for script changes every 1/2 second. (Script Updater)
SetKeyDelay, 250 ; Sets the TapCount. (tied to Reload/Exit routine, w/use for any hotkey)
Menu, Tray, Icon, accessibilitycpl.dll, 15
;○───────── Auto-Execute Sub End ────────○ 


;⯁═════════════════ GoSubs ══════════════════⯁
; ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙ 
IndicateDot1:
Gui, Destroy
SysGet, MonitorWorkArea, MonitorWorkArea
SysGet, TaskbarPos, 4
Gui, +AlwaysOnTop -Caption +hwndHGUI +LastFound
Return
; ∙∙∙∙∙∙∙∙∙∙∙ 
IndicateDot2:
Gui, Margin, 13, 13 	 ; ⬅ ⬅ Dot Size.
Gui, Show, Hide
WinGetPos, , , WinWidth, WinHeight, ahk_id %HGUI%
NewX := MonitorWorkAreaRight - 80
NewY := MonitorWorkAreaBottom - WinHeight - 5
R := Min(WinWidth, WinHeight) // 1 	 ; ⬅ ⬅ Set value of cornering. (0.5=Oval, 0=square, 1= round, 5=rounded corners).
WinSet, Region, 0-0 W%WinWidth% H%WinHeight% R%R%-%R%
Gui, Show, x%NewX% y%NewY%
SoundGet, master_volume
SoundSet, 5
Soundbeep, 2100, 75
SoundSet, % master_volume
Sleep, 100
Gui, Destroy
Return
; ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙ 

;○──────────── GoSubs End ─────────────○ 

/*
____________________________________________________________ 
 ∘⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼∘ 
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ 
*/

