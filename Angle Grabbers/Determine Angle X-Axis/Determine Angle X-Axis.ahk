﻿

;; SOURCE:  Self
;;  Determine angle between two mouse clicks from horizontal x-axis.

; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 


clickCount := 0    ;; Reset variables.
clickPoints := []
firstClickIgnored := false    ;; Flag to ignore the first click.

MouseClickHandler:    ;; If the first click has not been ignored yet, ignore this click.
    if (firstClickIgnored) {
    clickCount++
    MouseGetPos, clickX, clickY
    clickPoints[clickCount] := {x: clickX, y: clickY}

    if (clickCount = 2) {    ;; If two clicks have been recorded, calculate the angle.
        x1 := clickPoints[1].x    ;; Get the coordinates of the first and second click.
        y1 := clickPoints[1].y
        x2 := clickPoints[2].x
        y2 := clickPoints[2].y

        deltaX := x2 - x1    ;; Calculate the difference in coordinates.
        deltaY := y2 - y1

angle := ATan(-deltaY / deltaX)    ;; Calculate the angle in radians using horizontal x-axis as zero.

angleDegrees := angle * (180 / 3.141592653589793)    ;; Convert the angle to degrees.
    if (deltaX > 0 and deltaY < 0) {    ;; Adjust the angle based on quadrant.
            
angleDegrees := Abs(angleDegrees)    ;; First quadrant (0 to 90 degrees)
    } else if (deltaX < 0) {
        angleDegrees += 180    ;; Second and third quadrants (90 to 270 degrees)
    } else if (deltaX > 0 and deltaY > 0) {
        angleDegrees := 360 + angleDegrees    ;; Fourth quadrant (270 to 360 degrees)
    }

roundedAngle := Round(angleDegrees, 2)        ;; Round the angle.
    Tooltip, Angle: %roundedAngle%°    ;; Display the angle in a tooltip.
    Clipboard:= "Angle: "roundedAngle "°"    ;; Copy angle to clipboard.

    clickCount := 0    ;; Reset variables for next calculation.
    clickPoints := []
    SetTimer, RemoveTooltip, -3000 ;; Remove tooltip after 3 seconds.
        }
    } else {
        firstClickIgnored := true
    }
Return

^LButton::Gosub, MouseClickHandler    ;; HOTKEY trigger.
Return

RemoveTooltip:
    Tooltip
Return




^Home:: 
Soundbeep, 1700, 75
Reload
Return
;--------------- EXIT ------------ EXIT --------- EXIT ------------ 
^Esc:: 
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
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

