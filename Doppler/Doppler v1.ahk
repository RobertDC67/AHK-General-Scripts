
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
» SOURCE :  https://www.autohotkey.com/boards/viewtopic.php?f=22&t=126206#p559711
» By garry  (v2 to v1 convert)
∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;∙---------------------- NOTES END ----------------------------------------∙ 
*/
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞--------------------- Auto-Execute ---------------------------------------∙ 
Gosub, AutoExecute
;∙---------------------- Auto-Execute End ---------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
;⮞-----------------------🔥 HotKey 🔥 
^T:: 		 ; ⮘—— (Ctrl+T) 
    Soundbeep, 1700, 100
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 


/*
Upon the 1st run the script will request the Latitude and Longitude, then open the weather map to that location.
Thereafter, the script will just go straight to the map when ran.
Also added a Clear Registry Settings hotkey (^-  or ^NumpadSub) in case a change in coordinates is wanted.
*/


/*    ADDITIONAL MAPS
Asia ; https://earth.nullschool.net/#current/wind/surface/level/orthographic=123.04,23.45,1821/loc=124.879,13.692
USA ; https://earth.nullschool.net/#current/wind/surface/level/orthographic=-93.17,32.94,1821/loc=124.879,13.692
Europe ; https://earth.nullschool.net/#current/wind/surface/level/orthographic=-5.39,44.57,1821/loc=124.879,13.692
Asia Warnings ; https://www.metoc.navy.mil/jtwc/jtwc.html
WeatherRadar PT ; https://www.accuweather.com/en/pt/national/weather-radar
Ship sea ; https://map.openseamap.org/
Airplane ; https://www.flightradar24.com/60,15/6
AirTraffic ; https://globe.theairtraffic.com/
Train Germany ; https://tracker.geops.ch/?z=15&s=1&x=940661.1131&y=6358612.4752&l=transport
Ship Germany ; https://www.marinetraffic.com/de/ais/home/centerx:8.458/centery:49.505/zoom:13
Weather ; https://www.timeanddate.com/weather/china/suzhou
Time & Date ; https://www.timeanddate.com/time/map/
*/


;;------Define the registry key and value names.
regKey := "HKEY_CURRENT_USER\Software\AutoHotkeyMap"
regValueNameLatitude := "Latitude"
regValueNameLongitude := "Longitude"

;;------Check if the registry values exist.
RegRead, latitude, %regKey%, %regValueNameLatitude%
RegRead, longitude, %regKey%, %regValueNameLongitude%

if (ErrorLevel)    ;;------If either of the values do not exist.
{
    ;;------Prompt the user to enter their latitude and longitude.
    InputBox, latitude, Enter Latitude, Please enter your latitude:  
    if (ErrorLevel)    ;;------User cancelled the input box.
    {
        MsgBox, You did not enter latitude.`nExiting script.
        ExitApp
    }

    InputBox, longitude, Enter Longitude, Please enter your longitude:  
    if (ErrorLevel)    ;;------User cancelled the input box.
    {
        MsgBox, You did not enter longitude.`nExiting script.
        ExitApp
    }

    ;;------Save the latitude and longitude to the registry.
    RegWrite, REG_SZ, %regKey%, %regValueNameLatitude%, %latitude%
    RegWrite, REG_SZ, %regKey%, %regValueNameLongitude%, %longitude%

    ;;------Display a message using the stored latitude and longitude.
    MsgBox,,, Your saved location is...`nLatitude:  %latitude%`nLongitude:  %longitude%, 3
}

flnm := A_Desktop . "\doppler.html"
var := "
(
<!doctype html><html lang='en-US'>
<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1'></head>
<body style='background-color:black;'>
<div style='width:100%; height:950px;'>
<wx-widget type='map' latitude='" latitude "' longitude='" longitude "' menuitems='0001' mapid='0002' memberid='1384' zoomlevel='8' fullscreen='true' animate='true'></wx-widget>
<script async defer type='text/javascript' src='https://widgets.media.weather.com/wxwidget.loader.js?cid=878507589'></script>
</div></body></html>
)"

if FileExist(flnm)
{
    FileDelete, %flnm%
}
FileAppend, %var%, %flnm%, utf-8
Run, %flnm%
Return

;;------Hotkeys to clear stored latitude and longitude.
^-::
^NumpadSub::
    RegDelete, %regKey%, %regValueNameLatitude%
    RegDelete, %regKey%, %regValueNameLongitude%
    MsgBox,,, Latitude and Longitude have been cleared., 3
Return







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
;⮞--------------------- GoSubs ----------------------------------------------∙ 
;--------------------------------------------- 

;----------- 

;--------------------------------------------- 
;∙--------------------- GoSubs End -----------------------------------------∙ 
; ∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙=∙ 
/* 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
	  ∘﹤⪻⋘⪡⫷⫷⫷⫷⫷⫷ SCRIPT END ⫸⫸⫸⫸⫸⫸⪢⋙⪼﹥∘ 
 ⮞-------------------------------------------------------------------------------------------------⮜ 
*/ 

