
;⯁══════════════════════════════════════════════════⯁ 
;⯁══════════════════════════════════════════════════⯁ 

⯁ Replace '✖' with button number to copy/paste the ~4 sections to add additional buttons. 
Section 3 contains button fine color settings.

⯁ "Template" to edit then copy over new slider buttons with individual color options per button. 

;⯁══════════════════════════════════════════════════⯁ 
;⯁══════════════════════════════════════════════════⯁ 

;⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝ 
;▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ 
;▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ PART 1 ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ 
;▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ 
;⯁────────────────────▏▔▔BUTTON ✖▔▔▏──Pt. 1──────────────────⯁ 

SlideButton✖ := New Flat_Round_Switch_Type_✖(x := 10 	 ; ⬅⬅ CHANGE BOTH NUMBERSs ⬅(⌗⌗)⬅ 
 , y := 20 
 , w := 140
 , Text := "My SlideButton ✖" 			; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
 , Font:="Arial"
 , FontSize:= "12 Bold" 
 , FontColor:="FFFFFF" 
 , Window := "1" 		 ; ⇽⇽ The name of the parent window that this control belongs to. ( default is 1 )
 , Background_Color:="1B1C1D"
 , State:=1 			 ; ⇽⇽ The default (starting) state.
 , Label := "SlideButton✖" ) 	 ; ⇽⇽ Setting the label that gets called when the switch is toggled. 	 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 

;⯁────────────────▏▁▁BUTTON ✖▁▁▏──Pt. 1──▏▁END▁▏────────────⯁ 

;⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝ 



;▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃ 
;▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ 
; ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ PART 2 ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ 
;▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ 
;⯁────────────────────▏▔▔BUTTON ✖▔▔▏──Pt. 2──────────────────⯁ 

SlideButton✖: 	 ; ⇽⇽ Gets called when you toggle the switch. 	 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
    if( SlideButton✖.State = 1 ){ 		; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
; • • • Your actions if the switch is ON • • •
        ; MsgBox, Hello World
        Soundbeep, 1700, 75        
    }else{ 
; • • • Your actions if the switch is OFF • • •
        SoundBeep, 1400, 75
    }
; • • • Any other potential actions to take regardless of On or OFF. • • •
    ; Soundbeep, 1500, 800
Return

;⯁────────────────▏▁▁BUTTON ✖▁▁▏──Pt. 2──▏▁END▁▏────────────⯁ 
;▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃ 



;⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝ 
;▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ 
; ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ PART 3 ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏
;▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ 
;⯁────────────────────▏▔▔BUTTON ✖▔▔▏──Pt. 3──────────────────⯁ 
class Flat_Round_Switch_Type_✖  { 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
    __New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:=""){
        This.State:=State
        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=21 		 ; ⇽⇽ Looking for height??
        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize
        This.FontColor:= "0xFF" FontColor
        This.Background_Color:= "0xFF" Background_Color
        This.Window:=Window
        This.Create_Off_Bitmap✖() 	 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        This.Create_On_Bitmap✖() 	 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        This.Create_Trigger✖() 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        This.Label:=Label
        sleep,20
        if(This.State)
            This.Draw_On✖() 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅  
        else
            This.Draw_Off✖() 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
    }
    Create_Trigger✖(){ 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
        This.Hwnd:=hwnd
        BD := THIS.Switch_State✖.BIND( THIS ) 	 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        GUICONTROL +G , % This.Hwnd , % BD
    } 
;⯁——————————————— 
    Create_Off_Bitmap✖(){ 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 	 ; SLIDER SWITCH OFF 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF300000" , 1 ) 		 ; Slider off ring bottom shadow. (Med Red) 
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF7C0000" , 1 ) 		 ; Slider off ring over edge. (Bright Red)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
        Brush := Gdip_BrushCreateSolid( "0xFF262728" ) 	 ; Slider off ring under edge. (Dark Gray)
        Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF370000" ) 	 ; Slider off back surface. (Dark Red)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x88B30000" ) 	 ; Slider button background shadow. (Orange)
        Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF430000" ) 	 ; Slider button off ring edge. ( XX Dark Red) 
        Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 ) 	 ; Button Ring.
        Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF4D5055" , "0xFF36383B" , 1 , 1 ) 	 ; Button Main Center.
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
;⯁——————————————— 
    Create_On_Bitmap✖(){ 		 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 	 ; SLIDER SWITCH ON 
; Bitmap Created Using: HB Bitmap Maker
        pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
         G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 2 )
        Brush := Gdip_BrushCreateSolid( This.Background_Color )
        Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
        Gdip_DeleteBrush( Brush )
        Pen := Gdip_CreatePen( "0xFF01600F" , 1 ) 		 ; Slider surface bottom shadow. (Green)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
        Gdip_DeletePen( Pen )
        Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 ) 		 ; Slider ring edge. (Keep Gray)
        Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
        Gdip_DeletePen( Pen )
;⯁———————————————————————————— 
; On Background Colors
        Brush := Gdip_BrushCreateSolid( "0xFF00AD00" ) 	 ; Slider surface edge. (Green)
        Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF005200" ) 	 ; Slider front surface. (Drk Green)
;⯁———————————————————————————— 
        Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0x880027EB" ) 		 ; Slider button bottom highlight. (Green)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" ) 		 ; Slider button ring edge. (Keep XX Dark Gray)
        Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF002447" , "0xFF000099" , 1 , 1 ) 	 ; Button Ring. (Green)
        Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
        Gdip_DeleteBrush( Brush )
        Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF0055FF" , "0xFF003399" , 1 , 1 ) 	 ; Button Blend Center. (Green)
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
    Switch_State✖(){ 			 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅ 
        (This.State:=!This.State)?(This.Draw_On✖()):(This.Draw_Off✖()) 		 ; ⬅⬅ CHANGE BOTH NUMBERSs ⬅(⌗⌗)⬅
        if(This.Label)  
            gosub,% This.Label
    }
    Draw_Off✖(){ 			 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅
        SetImage( This.Hwnd , This.Off_Bitmap )
    }
    Draw_On✖(){ 			 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅
        SetImage( This.Hwnd , This.On_Bitmap )
    }
} 
;⯁────────────────▏▁▁BUTTON ✖▁▁▏──Pt. 3──▏▁END▁▏────────────⯁ 
;⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝⊚⃝ 




;▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃ 
;▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ 
; ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏ PART 4 ▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏╳▏
;▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ 
;⯁────────────────────▏▔▔BUTTON ✖▔▔▏──Pt. 4──────────────────⯁ 
; ───☛ Gdip_Startups Section...Edit as seen in script ☚─── 
;⯁──────────────────────────────────────────────⯁⯁ 
Gdip_Startup✖(){ 			 ; ⬅⬅ CHANGE NUMBER ⬅(⌗)⬅
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
        DllCall("LoadLibrary", "str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
    DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
    return pToken
}
;⯁──────────────────────────────────────────────⯁⯁ 
;⯁────────────────▏▁▁BUTTON ✖▁▁▏──Pt. 4──▏▁END▁▏────────────⯁ 
;▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃ 


;⯁══════════════════════════════════════════════════⯁ 
;⯁══════════════════════════════════════════════════⯁ 
;⯁══════════════════════════════════════════════════⯁ 
