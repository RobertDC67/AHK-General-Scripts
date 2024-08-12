

;; -------------⮚   PARTS TO SCRIPT  =  2   ⮘------------- 


;  PART 1  ∙=∙=∙=∙Timer∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
SetTimer, RefreshTime1, On
SetTimer, RefreshTime2, On
;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 



;  PART 2  ∙=∙=∙=∙Run Code∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;--------∙ Auto-Refresh 1
RefreshTime1:
    FormatTime, CurrentTime,, HH:mm
    If (CurrentTime >= "07:15" && CurrentTime <= "07:16") { 	 ; 7:15 AM 
Soundbeep, 1700, 75
    Sleep, 62000
        Reload
    }
Return
;--------∙ Auto-Refresh 2
RefreshTime2:
    FormatTime, CurrentTime,, HH:mm
    If (CurrentTime >= "13:15" && CurrentTime <= "13:16") { 	 ; 1:15 PM 
Soundbeep, 1700, 75
    Sleep, 62000
        Reload
    }
Return

;;∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 

/*
SetTimer, RefreshTime, 15000

RefreshTime:
    Reload
Return
*/


