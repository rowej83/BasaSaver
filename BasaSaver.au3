;*****************************************
;BasaSaver.au3 by shizzot
;Created with ISN AutoIt Studio v. 0.95 BETA
;*****************************************

#include <String.au3>
#include <Array.au3>
#include <FileConstants.au3>
#include <StringConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <GuiButton.au3>
#include "Forms\Mainform.isf"
Opt("GUIOnEventMode", 1)
#NoTrayIcon

;Includes




; window handles
Global $mainwindow = "[Class:AutoIt v3 GUI;Title:BasaBots v1.9.6]"
Global $waypointwindow = "[Class:AutoIt v3 GUI;Title:Waypoints]"
Global $moblistwindow = "[Class:AutoIt v3 GUI;Title:Mob List]"
;end window handles

;control variables
Global $hplow = "[CLASS:Edit; INSTANCE:1]"
Global $mplow = "[CLASS:Edit; INSTANCE:2]"
Global $tplow = "[CLASS:Edit; INSTANCE:3]"
Global $castheal = "[CLASS:Edit; INSTANCE:4]" ;checkbox
Global $fightpurple = "[CLASS:Button; INSTANCE:4]" ;checkbox
Global $spelldamage = "[CLASS:Button; INSTANCE:5]" ;checkbox
Global $meleerange = "[CLASS:Button; INSTANCE:6]" ;checkbox
Global $healparty = "[CLASS:Button; INSTANCE:7]" ;checkbox
Global $attackstandstill = "[CLASS:Button; INSTANCE:8]" ;checkbox
Global $moochbutton = "[CLASS:Button; INSTANCE:26]" ;checkbox
Global $attackwpmovedelay = "[CLASS:Edit; INSTANCE:5]"
Global $fishingwpmovedelay = "[CLASS:Edit; INSTANCE:50]"
Global $gatheringsequence = "[CLASS:Edit; INSTANCE:51]"
Global $attacksequence = "[CLASS:Edit; INSTANCE:7]"
Global $cyclesequence = "[CLASS:Edit; INSTANCE:9]"
Global $sprintbetween = "[CLASS:Button; INSTANCE:35]" ;checkbox
Global $chickenout = "[CLASS:Button; INSTANCE:36]" ;checkbox
Global $enablerepair = "[CLASS:Button; INSTANCE:37]" ;checkbox
Global $enabledeath = "[CLASS:Button; INSTANCE:42]" ;checkbox
Global $enablemount = "[CLASS:Button; INSTANCE:38]" ;checkbox
Global $repairdelay = "[CLASS:Edit; INSTANCE:52]"
Global $attackradio = "[CLASS:Button; INSTANCE:1]" ;checkbox
Global $fateradio = "[CLASS:Button; INSTANCE:2]" ; checkbox
Global $assistradio = "[CLASS:Button; INSTANCE:3]" ; checkbox
Global $fatefightbetween = "[CLASS:Button; INSTANCE:11]";checkbox
;Global $fatestandstill = "[CLASS:Button; INSTANCE:8]" ;checkbox - removed, redundent . control shared with attackstandstill
Global $assistmount = "[CLASS:Button; INSTANCE:13]" ; checkbox
Global $followmember = "[CLASS:ComboBox; INSTANCE:1]" ; combobox
Global $disablemoblist = "[CLASS:Button; INSTANCE:1]" ;checkbox
Global $attackmoblist = "[CLASS:Button; INSTANCE:2]" ;checkbox
Global $ignoremoblist = "[CLASS:Button; INSTANCE:3]" ;checkbox
Global $attacknormal = "[CLASS:Edit; INSTANCE:1]"
Global $attackfate = "[CLASS:Edit; INSTANCE:2]"
Global $ignorenormal = "[CLASS:Edit; INSTANCE:3]"
Global $ignorefate = "[CLASS:Edit; INSTANCE:4]"
Global $waypoint1control = "[CLASS:Edit; INSTANCE:1]"
Global $waypoint2control = "[CLASS:Edit; INSTANCE:2]"
Global $waypoint3control = "[CLASS:Edit; INSTANCE:3]"
Global $repairbutton = "[CLASS:Button; INSTANCE:40]"
Global $deathwaypointbutton = "[CLASS:Button; INSTANCE:43]"
Global $repairmovedelay = "[CLASS:Edit; INSTANCE:52]"

;end control variables



;controltoinivariables
Global $hplowvalue
Global $mplowvalue
Global $tplowvalue
Global $casthealvalue
Global $fightpurplevalue
Global $spelldamagevalue
Global $meleerangevalue
Global $healpartyvalue
Global $attackstandstillvalue
Global $moochbuttonvalue
Global $attackwpmovedelayvalue
Global $fishingwpmovedelayvalue
Global $gatheringsequencevalue
Global $attacksequencevalue
Global $cyclesequencevalue
Global $sprintbetweenvalue
Global $chickenoutvalue
Global $enablerepairvalue
Global $enabledeathvalue
Global $enablemountvalue
Global $repairdelayvalue
Global $attackradiovalue
Global $fateradiovalue
Global $assistradiovalue
Global $fatefightbetweenvalue
Global $fatestandstillvalue
Global $assistmountvalue
Global $followmembervalue
Global $disablemoblistvalue
Global $attackmoblistvalue
Global $ignoremoblistvalue
Global $attacknormalvalue
Global $attackfatevalue
Global $ignorenormalvalue
Global $ignorefatevalue
Global $waypoint1value
Global $waypoint2value
Global $waypoint3value


;end control to inivariables

;ini sections
Global $inimainwindow = "Main Window"
Global $iniwaypointwindow = "WayPoint Window"
Global $inimoblistwindow = "MobList Window"
;end ini sections

$debug = 0
If Not WinExists($mainwindow) And $debug == 0 Then
	
	MsgBox(16, "BasaSaver v1.0 ", "BasaBot v1.9.6 must be running in order for this program to work. Please start BasaBot and restart this program.", 0)

	Exit
EndIf

GUISetState(@SW_SHOW, $Mainform)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $Mainform)



;;get values to populate before saving

Func getValues()
	If Not WinExists($mainwindow) Then
		
		MsgBox(16, "BasaSaver v1.0 ", "BasaBot v1.9.6 must be running in order for this program to work. Please start BasaBot and restart this program.", 0)

		Exit
	EndIf


	;mainwindowcontrols
	
	$hplowvalue = ControlGetText($mainwindow, "", $hplow)
	
	$mplowvalue = ControlGetText($mainwindow, "", $mplow)

	$tplowvalue = ControlGetText($mainwindow, "", $tplow)
	
	$casthealvalue = ControlGetText($mainwindow, "", $castheal)
	
	$fightpurplevalue = _IsChecked($mainwindow, $fightpurple)
	
	$spelldamagevalue = _IsChecked($mainwindow, $spelldamage)

	$meleerangevalue = _IsChecked($mainwindow, $meleerange)

	$healpartyvalue = _IsChecked($mainwindow, $healparty)
	
	$attackstandstillvalue = _IsChecked($mainwindow, $attackstandstill)
	
	$moochbuttonvalue = _IsChecked($mainwindow, $moochbutton)

	$attackwpmovedelayvalue = ControlGetText($mainwindow, "", $attackwpmovedelay)

	$fishingwpmovedelayvalue = ControlGetText($mainwindow, "", $fishingwpmovedelay)
	
	$gatheringsequencevalue = multitosingleline(ControlGetText($mainwindow, "", $gatheringsequence))

	$attacksequencevalue = multitosingleline(ControlGetText($mainwindow, "", $attacksequence))
	
	$cyclesequencevalue = multitosingleline(ControlGetText($mainwindow, "", $cyclesequence))

	$sprintbetweenvalue = _IsChecked($mainwindow, $sprintbetween)

	$chickenoutvalue = _IsChecked($mainwindow, $chickenout)

	$enablerepairvalue = _IsChecked($mainwindow, $enablerepair)
	
	$enabledeathvalue = _IsChecked($mainwindow, $enabledeath)

	$enablemountvalue = _IsChecked($mainwindow, $enablemount)

	$repairdelayvalue = ControlGetText($mainwindow, "", $repairdelay)
	
	$attackradiovalue = _IsChecked($mainwindow, $attackradio)

	$fateradiovalue = _IsChecked($mainwindow, $fateradio)

	$assistradiovalue = _IsChecked($mainwindow, $assistradio)
	
	$fatefightbetweenvalue = _IsChecked($mainwindow, $fatefightbetween)
	
	; $fatestandstillvalue = _IsChecked($mainwindow, $fatestandstill) - removed, control shares with attackstand still
	
	$assistmountvalue = _IsChecked($mainwindow, $assistmount)

	$followmembervalue = ControlGetText($mainwindow, "", $followmember)
	

	;mob list window start
	WinActivate($moblistwindow)

	$disablemoblistvalue = _IsChecked($moblistwindow, $disablemoblist)

	$attackmoblistvalue = _IsChecked($moblistwindow, $attackmoblist)
	
	$ignoremoblistvalue = _IsChecked($moblistwindow, $ignoremoblist)
	
	$attacknormalvalue = multitosingleline(ControlGetText($moblistwindow, "", $attacknormal))
	
	$attackfatevalue = multitosingleline(ControlGetText($moblistwindow, "", $attackfate))

	$ignorenormalvalue = multitosingleline(ControlGetText($moblistwindow, "", $ignorenormal))

	$ignorefatevalue = multitosingleline(ControlGetText($moblistwindow, "", $ignorefate))
	
	;mob list window end

	;waypoint window
	WinActivate($waypointwindow)

	
	$waypoint1value = multitosingleline(ControlGetText($waypointwindow, "", $waypoint1control))

	$waypoint2value = multitosingleline(ControlGetText($waypointwindow, "", $waypoint2control))

	$waypoint3value = multitosingleline(ControlGetText($waypointwindow, "", $waypoint3control))

	;end waypoint window
	;end controls

	



EndFunc   ;==>getValues








;;
Func _help()
	MsgBox(32, "BasaSaver v1.0 - Help", "This program will save ALL your settings except those in the crafting tab in your currently active and open window of Basabot." & @CRLF & "" & @CRLF & "To use it " & @CRLF & "" & @CRLF & "First set up your waypoints, attack sequence, HP/TP/MP percentages etc.. then within BasaSaver click Save Config. It will ask you for a file name which you decide. Afterwards, you can instantly re-populate the saved fields after you start BasaBot and click Load Config and selecting your previously saved file." & @CRLF & "" & @CRLF & "The real thanks goes to Basa for this awesome bot! - shizzot  ", 0)
	;getValues()
	
EndFunc   ;==>_help

Func _Exit()
	Exit
EndFunc   ;==>_Exit


;;save button function
Func saveconfig()
	; Create a constant variable in Local scope of the message to display in FileSaveDialog.
	If Not WinExists($mainwindow) Then
		
		MsgBox(16, "BasaSaver v1.0 ", "BasaBot v1.9.6 must be running in order for this program to work. Please start BasaBot and restart this program.", 0)

		Exit
	EndIf
	Local Const $sMessage = "Choose a filename."

	; Display a save dialog to select a file.
	Local $sFileSaveDialog = FileSaveDialog($sMessage, "::{450D8FBA-AD25-11D0-98A8-0800361B1103}", "BasaSave File (*.bss)", $FD_PATHMUSTEXIST)
	If @error Then
		
		MsgBox($MB_SYSTEMMODAL, "", "No file was saved.")
	Else
		
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSE, -1))

		
		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSE)

		
		If $iExtension Then
			
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".bss") Then $sFileSaveDialog &= ".bss"
		Else
			; If no period (dot) was found then append to the end of the file.
			$sFileSaveDialog &= ".bss"
		EndIf

		; Display the saved file. $sFileSaveDialog is chosen saved file name
		getValues()
		dosave($sFileSaveDialog)
		MsgBox($MB_SYSTEMMODAL, "Save Complete", "You saved the following file:" & @CRLF & $sFileSaveDialog)
	EndIf
EndFunc   ;==>saveconfig

;;load button function
Func loadconfig()
	Local Const $sMessage = "Select a BasaBot saved file."

	; Display an open dialog to select a file.
	Local $sFileOpenDialog = FileOpenDialog($sMessage, @ScriptDir & "\saves", "BasaSave File (*.bss)", $FD_FILEMUSTEXIST)
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No file was selected.")

		; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
		FileChangeDir(@ScriptDir)
	Else
		; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
		FileChangeDir(@ScriptDir)

		; Replace instances of "|" with @CRLF in the string returned by FileOpenDialog.
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)

		; Display the selected file.
		;  MsgBox($MB_SYSTEMMODAL, "", "You chose the following file:" & @CRLF & $sFileOpenDialog)
		
		$loadresult = MsgBox(4132, "BasaBot Saver v1.0 ", "Are you sure you want to load " & $sFileOpenDialog & "?", 0)

		Switch $loadresult

			Case 6 ;YES
				;Your code here...  load basabot
				doload($sFileOpenDialog)
				
			Case 7 ;NO
				;Your code here...
				MsgBox(0, "BasaBot Saver v1.0 - Operation Canceled", $sFileOpenDialog & " will not be loaded.");
		EndSwitch

	EndIf

EndFunc   ;==>loadconfig



;;takes the controls text( attack sequence textbox ) etc and turns it into single line string to be stored in bss file
Func multitosingleline($inputstring)
	If Not StringStripWS($inputstring, 8) = "" Then
		Local $stringarray = StringSplit($inputstring, @LF)

		$stringarray = _RemoveEmptyArrayElements($stringarray)

		Local $returnstring = _ArrayToString($stringarray, "&&", 1) ; combines array elements with &&
		$returnstring = StringReplace($returnstring, @CR, "") ; removes unneeded spaces
		Return $returnstring
	Else
		Return ""
	EndIf
EndFunc   ;==>multitosingleline

;;takes single line string and converts it in multiline to be  used in attack sequence textbox
Func singlelinetomulti($windowname, $controlname, $inputstring)
	ControlSetText($windowname, "", $controlname, "")
	If Not StringStripWS($inputstring, 8) = "" Then
		Local $explodedstring = _StringExplode($inputstring, "&&")
		For $ii = 0 To UBound($explodedstring) - 1
			If $ii < UBound($explodedstring) - 1 Then
				ControlSend($windowname, "", $controlname, $explodedstring[$ii] & @LF)
			Else
				ControlSend($windowname, "", $controlname, $explodedstring[$ii])
			EndIf
		Next
	Else
		Return
	EndIf
EndFunc   ;==>singlelinetomulti

Func handlechecked($windowname, $controlname, $checked, $defaultvalue)
	;check if the checkbox's/radio button are already clicked or not and will change as needed
	;$checked is supplied by the isChecked status method
	;$defaultvalue is passed during the functions call
	;;If Not $checked = $defaultvalue Then
	If $checked = $defaultvalue Then
		;do nothing ..already checked
	Else
		;If $checked = 1 Then
		ControlClick($windowname, "", $controlname)
		;EndIf
	EndIf
EndFunc   ;==>handlechecked

;checks if a radio/check box is checked..if it is then it returns a 1, 0 if it isnt checked.
Func _IsChecked($windowname, $controlname)
	Return ControlCommand($windowname, "", $controlname, "IsChecked")
EndFunc   ;==>_IsChecked



Func dosave($filename)
	;acttually saves the values from controls (getvalues()) and saves them to bss file ($filename)

	;main window section
	IniWrite($filename, $inimainwindow, "hplowvalue", $hplowvalue)
	IniWrite($filename, $inimainwindow, "mplowvalue", $mplowvalue)
	IniWrite($filename, $inimainwindow, "tplowvalue", $tplowvalue)
	IniWrite($filename, $inimainwindow, "casthealvalue", $casthealvalue)
	IniWrite($filename, $inimainwindow, "fightpurplevalue", $fightpurplevalue)
	IniWrite($filename, $inimainwindow, "spelldamagevalue", $spelldamagevalue)
	IniWrite($filename, $inimainwindow, "meleerangevalue", $meleerangevalue)
	IniWrite($filename, $inimainwindow, "healpartyvalue", $healpartyvalue)
	IniWrite($filename, $inimainwindow, "attackstandstillvalue", $attackstandstillvalue)
	IniWrite($filename, $inimainwindow, "moochbuttonvalue", $moochbuttonvalue)
	IniWrite($filename, $inimainwindow, "attackwpmovedelayvalue", $attackwpmovedelayvalue)
	IniWrite($filename, $inimainwindow, "fishingwpmovedelayvalue", $fishingwpmovedelayvalue)
	IniWrite($filename, $inimainwindow, "gatheringsequencevalue", $gatheringsequencevalue)
	IniWrite($filename, $inimainwindow, "attacksequencevalue", $attacksequencevalue)
	IniWrite($filename, $inimainwindow, "cyclesequencevalue", $cyclesequencevalue)
	IniWrite($filename, $inimainwindow, "sprintbetweenvalue", $sprintbetweenvalue)
	IniWrite($filename, $inimainwindow, "chickenoutvalue", $chickenoutvalue)
	IniWrite($filename, $inimainwindow, "enablerepairvalue", $enablerepairvalue)
	IniWrite($filename, $inimainwindow, "enabledeathvalue", $enabledeathvalue)
	IniWrite($filename, $inimainwindow, "enablemountvalue", $enablemountvalue)
	IniWrite($filename, $inimainwindow, "repairdelayvalue", $repairdelayvalue)
	IniWrite($filename, $inimainwindow, "attackradiovalue", $attackradiovalue)
	IniWrite($filename, $inimainwindow, "fateradiovalue", $fateradiovalue)
	IniWrite($filename, $inimainwindow, "assistradiovalue", $assistradiovalue)
	IniWrite($filename, $inimainwindow, "fatefightbetweenvalue", $fatefightbetweenvalue)
	;	IniWrite($filename, $inimainwindow, "fatestandstillvalue", $fatestandstillvalue) - removed, redundent.. control shares with attackstandstill
	IniWrite($filename, $inimainwindow, "assistmountvalue", $assistmountvalue)
	IniWrite($filename, $inimainwindow, "followmembervalue", $followmembervalue)
	;end main window section
	
	
	;moblist window start
	IniWrite($filename, $inimoblistwindow, "disablemoblistvalue", $disablemoblistvalue)
	IniWrite($filename, $inimoblistwindow, "attackmoblistvalue", $attackmoblistvalue)
	IniWrite($filename, $inimoblistwindow, "ignoremoblistvalue", $ignoremoblistvalue)
	IniWrite($filename, $inimoblistwindow, "attacknormalvalue", $attacknormalvalue)
	IniWrite($filename, $inimoblistwindow, "attackfatevalue", $attackfatevalue)
	IniWrite($filename, $inimoblistwindow, "ignorenormalvalue", $ignorenormalvalue)
	IniWrite($filename, $inimoblistwindow, "ignorefatevalue", $ignorefatevalue)
	
	;moblist window end
	
	
	;waypoint window start
	IniWrite($filename, $iniwaypointwindow, "waypoint1value", $waypoint1value)
	IniWrite($filename, $iniwaypointwindow, "waypoint2value", $waypoint2value)
	IniWrite($filename, $iniwaypointwindow, "waypoint3value", $waypoint3value)
	;waypoint window end
EndFunc   ;==>dosave



Func doload($filename)
	getValues()
	GUISetState(@SW_MINIMIZE, $mainform)
	WinActivate($mainwindow)
	;main window section
	Local $iniattackradio = IniRead($filename, $inimainwindow, "attackradiovalue", "error");checkbox
	If $iniattackradio = 1 Then
		;ControlCommand($mainwindow, "", $attackradio, "Click")
		ControlClick($mainwindow, "", $attackradio)
	EndIf
	;handlechecked($mainwindow, $attackradio, $iniattackradio, $attackradiovalue)
	Local $iniassistradio = IniRead($filename, $inimainwindow, "assistradiovalue", "error");checkbox
	;handlechecked($mainwindow, $assistradio, $iniassistradio, $assistradiovalue)
	If $iniassistradio = 1 Then
		;ControlCommand($mainwindow, "", $assistradio, "Click")
		ControlClick($mainwindow, "", $assistradio)
	EndIf
	If $iniassistradio = 1 Then MsgBox(0, "Please note", "For the assist bot you must manually set the Follow Member drop box value.")
	
	
	Local $inifateradio = IniRead($filename, $inimainwindow, "fateradiovalue", "error");checkbox
	;handlechecked($mainwindow, $fateradio, $inifateradio, $fateradiovalue)
	If $inifateradio = 1 Then
		;ControlCommand($mainwindow, "", $fateradio, "Click")
		ControlClick($mainwindow, "", $fateradio)
	EndIf
	Local $inihplow = IniRead($filename, $inimainwindow, "hplowvalue", "error")
	ControlSetText($mainwindow, "", $hplow, $inihplow)
	Local $inimplow = IniRead($filename, $inimainwindow, "mplowvalue", "error")
	ControlSetText($mainwindow, "", $mplow, $inimplow)
	Local $initplow = IniRead($filename, $inimainwindow, "tplowvalue", "error")
	ControlSetText($mainwindow, "", $tplow, $initplow)
	Local $inicastheal = IniRead($filename, $inimainwindow, "casthealvalue", "error")
	ControlSetText($mainwindow, "", $castheal, $inicastheal)
	Local $inifightpurple = IniRead($filename, $inimainwindow, "fightpurplevalue", "error") ; checkbox
	handlechecked($mainwindow, $fightpurple, $inifightpurple, $fightpurplevalue)
	Local $inispelldamage = IniRead($filename, $inimainwindow, "spelldamagevalue", "error") ; checkbox
	handlechecked($mainwindow, $spelldamage, $inispelldamage, $spelldamagevalue)
	Local $inimeleerange = IniRead($filename, $inimainwindow, "meleerangevalue", "error") ;checkbox
	handlechecked($mainwindow, $meleerange, $inimeleerange, $meleerangevalue)
	Local $inihealparty = IniRead($filename, $inimainwindow, "healpartyvalue", "error") ;checkbox
	handlechecked($mainwindow, $healparty, $inihealparty, $healpartyvalue)
	Local $iniattackstandstill = IniRead($filename, $inimainwindow, "attackstandstillvalue", "error");checkbox
	handlechecked($mainwindow, $attackstandstill, $iniattackstandstill, $attackstandstillvalue)
	Local $inimoochbutton = IniRead($filename, $inimainwindow, "moochbuttonvalue", "error");checkbox
	handlechecked($mainwindow, $moochbutton, $inimoochbutton, $moochbuttonvalue)
	Local $iniattackwpmovedelay = IniRead($filename, $inimainwindow, "attackwpmovedelayvalue", "error")
	ControlSetText($mainwindow, "", $attackwpmovedelay, $iniattackwpmovedelay)
	Local $inifishingwpmovedelay = IniRead($filename, $inimainwindow, "fishingwpmovedelayvalue", "error")
	ControlSetText($mainwindow, "", $fishingwpmovedelay, $inifishingwpmovedelay)
	Local $inigatheringsequence = IniRead($filename, $inimainwindow, "gatheringsequencevalue", "error")
	ControlSetText($mainwindow, "", $gatheringsequence, $inigatheringsequence)
	Local $iniattacksequence = IniRead($filename, $inimainwindow, "attacksequencevalue", "error");multiline
	singlelinetomulti($mainwindow, $attacksequence, $iniattacksequence)
	Local $inicyclesequence = IniRead($filename, $inimainwindow, "cyclesequencevalue", "error");multiline
	singlelinetomulti($mainwindow, $cyclesequence, $inicyclesequence)
	Local $inisprintbetween = IniRead($filename, $inimainwindow, "sprintbetweenvalue", "error");checkbox
	handlechecked($mainwindow, $sprintbetween, $inisprintbetween, $sprintbetweenvalue)
	Local $inichickenout = IniRead($filename, $inimainwindow, "chickenoutvalue", "error");checkbox default
	handlechecked($mainwindow, $chickenout, $inichickenout, $chickenoutvalue)
	Local $inienablerepair = IniRead($filename, $inimainwindow, "enablerepairvalue", "error");checkbox
	handlechecked($mainwindow, $enablerepair, $inienablerepair, $enablerepairvalue)
	If ($inienablerepair = 1) Then
		togglerepair(1)
	Else
		togglerepair(0)
	EndIf
	Local $inirepairdelay = IniRead($filename, $inimainwindow, "repairdelayvalue", "error") ; enable if enablerepair=1
	ControlSetText($mainwindow, "", $repairdelay, $inirepairdelay)
	Local $inienabledeath = IniRead($filename, $inimainwindow, "enabledeathvalue", "error");checkbox
	handlechecked($mainwindow, $enabledeath, $inienabledeath, $enabledeathvalue)
	If ($inienabledeath = 1) Then
		toggledeath(1)
	Else
		toggledeath(0)
	EndIf
	Local $inienablemount = IniRead($filename, $inimainwindow, "enablemountvalue", "error");checkbox
	handlechecked($mainwindow, $enablemount, $inienablemount, $enablemountvalue)
	
	
	Local $inifatefightbetween = IniRead($filename, $inimainwindow, "fatefightbetweenvalue", "error");checkbox
	handlechecked($mainwindow, $fatefightbetween, $inifatefightbetween, $fatefightbetweenvalue)
	;Local $inifatestandstill = IniRead($filename, $inimainwindow, "fatestandstillvalue", "error");checkbox -removed, shares with attack so is redundent
	;handlechecked($mainwindow, $fatestandstill, $inifatestandstill, $fatestandstillvalue)
	Local $iniassistmount = IniRead($filename, $inimainwindow, "assistmountvalue", "error");checkbox
	handlechecked($mainwindow, $assistmount, $iniassistmount, $assistmountvalue)
	Local $inifollowmember = IniRead($filename, $inimainwindow, "followmembervalue", "error")
	ControlSetText($mainwindow, "", $followmember, $inifollowmember)
	;end main window section
	
	WinActivate($moblistwindow)
	;moblist window start
	Local $inidisablemoblist = IniRead($filename, $inimoblistwindow, "disablemoblistvalue", "error");checkbox default 1
	If $inidisablemoblist = 1 Then
		ControlClick($moblistwindow, "", $disablemoblist)
	EndIf
	;handlechecked($moblistwindow, $disablemoblist, $inidisablemoblist, $disablemoblistvalue)
	Local $iniattackmoblist = IniRead($filename, $inimoblistwindow, "attackmoblistvalue", "error");checkbox
	;	handlechecked($moblistwindow, $attackmoblist, $iniattackmoblist, $attackmoblistvalue)
	Local $iniignoremoblist = IniRead($filename, $inimoblistwindow, "ignoremoblistvalue", "error");checkbox
	;handlechecked($moblistwindow, $ignoremoblist, $iniignoremoblist, $ignoremoblistvalue)
	If $iniattackmoblist = 1 Then
		ControlClick($moblistwindow, "", $attackmoblist)
		ControlEnable($moblistwindow, "", $attacknormal)
		ControlEnable($moblistwindow, "", $attackfate)
		Local $iniattacknormal = IniRead($filename, $inimoblistwindow, "attacknormalvalue", "error");must enable if attackmoblist=1
		singlelinetomulti($moblistwindow, $attacknormal, $iniattacknormal)
		Local $iniattackfate = IniRead($filename, $inimoblistwindow, "attackfatevalue", "error");must enable if attackmoblist=1
		singlelinetomulti($moblistwindow, $attackfate, $iniattackfate)
	Else
		ControlSetText($moblistwindow, "", $attacknormal, "")
		ControlSetText($moblistwindow, "", $attackfate, "")
		ControlDisable($moblistwindow, "", $attacknormal)
		ControlDisable($moblistwindow, "", $attackfate)
	EndIf

	If $iniignoremoblist = 1 Then
		ControlClick($moblistwindow, "", $ignoremoblist)
		ControlEnable($moblistwindow, "", $ignorenormal)
		ControlEnable($moblistwindow, "", $ignorefate)
		Local $iniignorenormal = IniRead($filename, $inimoblistwindow, "ignorenormalvalue", "error");must enable if ignore=1
		singlelinetomulti($moblistwindow, $ignorenormal, $iniignorenormal)
		Local $iniignorefate = IniRead($filename, $inimoblistwindow, "ignorefatevalue", "error");must enable if ignorelist=1
		singlelinetomulti($moblistwindow, $ignorefate, $iniignorefate)
	Else
		ControlSetText($moblistwindow, "", $ignorenormal, "")
		ControlSetText($moblistwindow, "", $ignorefate, "")
		ControlDisable($moblistwindow, "", $ignorenormal)
		ControlDisable($moblistwindow, "", $ignorefate)
	EndIf

	
	;moblist window end
	
	WinActivate($waypointwindow)
	;waypoint window start
	Local $iniwaypoint1 = IniRead($filename, $iniwaypointwindow, "waypoint1value", "error") ;multiline
	singlelinetomulti($waypointwindow, $waypoint1control, $iniwaypoint1)
	Local $iniwaypoint2 = IniRead($filename, $iniwaypointwindow, "waypoint2value", "error");multiline
	singlelinetomulti($waypointwindow, $waypoint2control, $iniwaypoint2)
	Local $iniwaypoint3 = IniRead($filename, $iniwaypointwindow, "waypoint3value", "error");multiline
	singlelinetomulti($waypointwindow, $waypoint3control, $iniwaypoint3)
	;waypoint window end
	GUISetState(@SW_RESTORE, $Mainform)
	MsgBox(0, "Load Complete", "Finished loading: " & $filename)

EndFunc   ;==>doload



;;end of get values


Func _RemoveEmptyArrayElements($_Array)
	Local $_Item
	For $_Element In $_Array
		If StringStripWS($_Element, 8) = '' Then
			_ArrayDelete($_Array, $_Item)
		Else
			$_Item += 1
		EndIf
	Next
	Return ($_Array)
EndFunc   ;==>_RemoveEmptyArrayElements

Func togglerepair($x)
	;if $x=1 then enable repair button , else disable
	If $x = 1 Then
		ControlEnable($mainwindow, "", $repairbutton)
		ControlEnable($mainwindow, "", $enablemount)
		ControlEnable($mainwindow, "", $repairmovedelay)
	Else
		ControlDisable($mainwindow, "", $repairbutton)
		ControlDisable($mainwindow, "", $enablemount)
		ControlDisable($mainwindow, "", $repairmovedelay)
	EndIf
EndFunc   ;==>togglerepair

Func toggledeath($x)
	;if $x=1 then enable death button , else disable
	If $x = 1 Then
		ControlEnable($mainwindow, "", $deathwaypointbutton)

	Else
		ControlDisable($mainwindow, "", $deathwaypointbutton)

	EndIf
EndFunc   ;==>toggledeath


;main while loop
While 1
	Sleep(20)
WEnd