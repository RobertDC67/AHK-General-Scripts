


;;  Determine angle between two mouse clicks from horizontal x-axis.

; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 



    ; Reset variables
    clickCount := 0
    firstClickIgnored := false ; Flag to ignore the first click
    clickPoints := []

    ; Mouse click handler
    MouseClickHandler:
        ; If the first click has not been ignored yet, ignore this click
        if (!firstClickIgnored) {
            firstClickIgnored := true
            return
        }

        clickCount++
        MouseGetPos, clickX, clickY
        clickPoints[clickCount] := {x: clickX, y: clickY}

        ; If two clicks have been recorded, calculate the angle
        if (clickCount = 2) {
            ; Get the coordinates of the first and second click
            x1 := clickPoints[1].x
            y1 := clickPoints[1].y
            x2 := clickPoints[2].x
            y2 := clickPoints[2].y

            ; Calculate the difference in coordinates
            deltaX := x2 - x1
            deltaY := y2 - y1

            ; Calculate the angle in radians using vertical y-axis as zero
            angle := ATan(deltaX / -deltaY)

            ; Convert the angle to degrees
            angleDegrees := angle * (180 / 3.141592653589793)

            ; Adjust the angle based on quadrant
            if (deltaY > 0) {
                ; If the second point is below the first point
                angleDegrees += 180
            } else if (deltaX < 0) {
                ; If the second point is to the left of the first point
                angleDegrees += 360
            }

            ; Normalize the angle to 0-360 degrees
            if (angleDegrees >= 360) {
                angleDegrees -= 360
            }

            ; Round the angle
            roundedAngle := Round(angleDegrees, 2)

            ; Display the angle in a tooltip
            Tooltip, Angle: %roundedAngle%°

            Clipboard:= "Angle: "roundedAngle "°"

            ; Reset variables for next calculation
            clickCount := 0
            clickPoints := []
            SetTimer, RemoveTooltip, -3000 ; Remove tooltip after 3 seconds
        }

        return

    ; Set the mouse click handler
    ^LButton::Gosub, MouseClickHandler
    Return

    ; Timer to remove tooltip
    RemoveTooltip:
        Tooltip
        return







Home:: 
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

