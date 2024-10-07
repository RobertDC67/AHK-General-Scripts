#include Gdip_All.ahk

HBitmapFromScreen(X, Y, W, H) {
   HDC := DllCall("GetDC", "Ptr", 0, "UPtr")
   HBM := DllCall("CreateCompatibleBitmap", "Ptr", HDC, "Int", W, "Int", H, "UPtr")
   PDC := DllCall("CreateCompatibleDC", "Ptr", HDC, "UPtr")
   DllCall("SelectObject", "Ptr", PDC, "Ptr", HBM)
   DllCall("BitBlt", "Ptr", PDC, "Int", 0, "Int", 0, "Int", W, "Int", H
                   , "Ptr", HDC, "Int", X, "Int", Y, "UInt", 0x00CC0020)
   DllCall("DeleteDC", "Ptr", PDC)
   DllCall("ReleaseDC", "Ptr", 0, "Ptr", HDC)
   Return HBM
}

; Ctrl+T
^t::
	SysGet, xPrimary, 76  ; Get the X coordinates in the upper left corner of the home screen.
	SysGet, yPrimary, 77  ; Get the Y coordinates in the upper left corner of the home screen.
	SysGet, wScreen, 78   ; Get the width of the screen.
	SysGet, hScreen, 79   ; Get the height of the  screen.

	pToken := Gdip_Startup()
	mskSize = 5

	; Take a screenshot of the entire screen
	hBitmap := HBitmapFromScreen(xPrimary, yPrimary, wScreen, hScreen)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
	pBitmapOut := Gdip_CreateBitmap(wScreen, hScreen)
	Gdip_PixelateBitmap(pBitmap, pBitmapOut, mskSize)

	Gui, Msk:New, +LastFound +AlwaysOnTop +ToolWindow -Caption
	Gui, Msk:Show, x0 y0 w%wScreen% h%hScreen%, Mosaic
	hWnd := WinExist()
	hdc := GetDC(hWnd)

	; Draw a bitmap to the window after mosaicing.
	graphics := Gdip_GraphicsFromHDC(hdc)
	Gdip_DrawImage(graphics, pBitmapOut, 0, 0, wScreen, hScreen)
return

#IfWinActive, Mosaic ahk_class AutoHotkeyGUI
	WheelUp::
		mskSize := (mskSize - 5 < 5) ? 5 : mskSize - 5
		Gdip_PixelateBitmap(pBitmap, pBitmapOut, mskSize)
		Gdip_DrawImage(graphics, pBitmapOut, 0, 0, wScreen, hScreen)
		return
	WheelDown::
		mskSize := mskSize + 5 > 50 ? 50 : mskSize + 5
		Gdip_PixelateBitmap(pBitmap, pBitmapOut, mskSize)
		Gdip_DrawImage(graphics, pBitmapOut, 0, 0, wScreen, hScreen)
	return
#If

MskGuiEscape:
MskGuiClose:
MskGuiCancel:
	Gdip_DeleteGraphics(graphics)
	Gdip_DisposeImage(pBitmapOut)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
	DeleteObject(hBitmap)
	Gui, Destroy
	return

^Esc:: 
    If WinExist("Mosaic ahk_class AutoHotkeyGUI")
        Gui, Destroy  ; This will close the pixelated GUI
    Return


