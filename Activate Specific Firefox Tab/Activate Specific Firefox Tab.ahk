
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
» SOURCE :  
» 
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 




/*

Activates a specific tab in Firefox (YouTube in example) so long as the tab already exists.
If it does not exist, it will open it in your default browser.

*/



;;  By:  teadrinker
;;  SOURCE:  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=66263&hilit=MozillaTaskbarPreviewClass#p458317

; tabTextRegEx := ".*Linguee.*"  ; This is the tab title that is searched for.
; url := "www.linguee.de"        ; This is the website that is opend if it doesn't exist already

tabTextRegEx := ".*YouTube.*"  ; This is the tab title that is searched for.
url := "www.youtube.com"        ; This is the website that is opend if it doesn't exist already

F3::
SetBatchLines, -1
WinGet, list, List, ahk_class MozillaWindowClass ahk_exe firefox.exe
if !list
   throw "Firefox window not found"

accTab := ""
Loop % list {
   if !accFF := AccObjectFromWindow(hFF := list%A_Index%, OBJID_CLIENT := 0xFFFFFFFC)
      continue
   accTabList := SearchElement(accFF, {Role: ROLE_SYSTEM_PAGETABLIST := 0x3C})
   if accTab := SearchElement(accTabList, {Role: ROLE_SYSTEM_PAGETAB := 0x25, Name: tabTextRegEx})
      break
}
if !accTab
;;   Run, www.linguee.de  
   Run, % url
else {
   accTab.accDoDefaultAction(0)
   WinActivate, ahk_id %hFF%
}
Return

SearchElement(parentElement, params)
{
   found := true
   for k, v in params {
      try {
         if (k = "State")
            (!(parentElement.accState(0)    & v) && found := false)
         else if (k ~= "^(Name|Value)$")
            (!(parentElement["acc" . k](0) ~= v) && found := false)
         else if (k = "ChildCount")
            (parentElement["acc" . k]      != v  && found := false)
         else
            (parentElement["acc" . k](0)   != v  && found := false)
      }
      catch 
         found := false
   } until !found
   if found
      Return parentElement
   
   for k, v in AccChildren(parentElement)
      if obj := SearchElement(v, params)
         Return obj
}

AccObjectFromWindow(hWnd, idObject = 0)
{
   static IID_IDispatch   := "{00020400-0000-0000-C000-000000000046}"
        , IID_IAccessible := "{618736E0-3C3D-11CF-810C-00AA00389B71}"
        , OBJID_NATIVEOM  := 0xFFFFFFF0, VT_DISPATCH := 9, F_OWNVALUE := 1
        , h := DllCall("LoadLibrary", Str, "oleacc", Ptr)
        
   VarSetCapacity(IID, 16), idObject &= 0xFFFFFFFF
   DllCall("ole32\CLSIDFromString", Str, idObject = OBJID_NATIVEOM ? IID_IDispatch : IID_IAccessible, Ptr, &IID)
   if DllCall("oleacc\AccessibleObjectFromWindow", Ptr, hWnd, UInt, idObject, Ptr, &IID, PtrP, pAcc) = 0
      Return ComObject(VT_DISPATCH, pAcc, F_OWNVALUE)
}

AccChildren(Acc)  {
   Loop 1  {
      if ComObjType(Acc, "Name") != "IAccessible"  {
         error := "Invalid IAccessible Object"
         break
      }
      cChildren := Acc.accChildCount, Children := []
      VarSetCapacity(varChildren, cChildren*(8 + A_PtrSize*2), 0)
      if DllCall("oleacc\AccessibleChildren", Ptr, ComObjValue(Acc), Int, 0, Int, cChildren, Ptr, &varChildren, IntP, cChildren) != 0  {
         error := "AccessibleChildren DllCall Failed"
         break
      }
      Loop % cChildren  {
         i := (A_Index - 1)*(A_PtrSize*2 + 8) + 8
         child := NumGet(varChildren, i)
         Children.Insert( NumGet(varChildren, i - 8) = 9 ? AccQuery(child) : child )
         ( NumGet(varChildren, i - 8 ) = 9 && ObjRelease(child) )
      }
   }
   if error
      ErrorLevel := error
   else
      Return Children.MaxIndex() ? Children : ""
}

AccQuery(Acc)  {
   static IAccessible := "{618736e0-3c3d-11cf-810c-00aa00389b71}", VT_DISPATCH := 9, F_OWNVALUE := 1
   try Return ComObject(VT_DISPATCH, ComObjQuery(Acc, IAccessible), F_OWNVALUE)
}




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
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

