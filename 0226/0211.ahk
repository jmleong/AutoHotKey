;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;MsgBox print messge
;MsgBox please press win + s



;#s::


/*
MsgBox, 4, , Would you like to continue?
IfMsgBox, No
    return
; Otherwise, the user picked yes.

;Run Notepad.exe  ;this is the comment
;MsgBox  this is the print

*/

;   Please add the code below




; Create the sub-menus for the menu bar:
Menu, FileMenu, Add, &Load_wfm_Path, FileLoad_wfm_Path
Menu, FileMenu, Add, &Load_RMT_Path, FileLoad_RMT_Path
Menu, FileMenu, Add, &Load_NVME_Path, FileLoad_NVME_Path


; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, &File, :FileMenu


; Attach the menu bar to the window:
Gui, Menu, MyMenuBar

Gui, Color, White
Gui, Add, Picture, x0 y0 h350 w450, sigtest_path=C:\"Program Files (x86)"\"SigTest 3.2.11"\
Gui, Add, Button, Default xp+20 yp+250, Start PCI_SIG
Gui, Add, Button, Default xp+80 yp+0, Start RMT
Gui, Add, Button, Default xp+65 yp+0, Start NVME
Gui, Add, Text,Default x150 y280, US Hardware Team Auto Tool
Gui, Add, Picture, x350 y270 , %A_WorkingDir%\logo1.PNG
;Gui, Add, Progress, vMyProgress w416Gui, Add, Text, vMyText wp  ; wp means "use width of previous".
Gui, Show
return


FileLoad_wfm_Path:

Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFolder, OutputVar, , 3

if OutputVar =
    MsgBox, You didn't select a folder, Please load the file again.

else
{
    Gui, Add, Picture, x0 y20 h300 w450, wfm_path = %OutputVar%

    EnvSet, WaveformPath, %OutputVar%

    RMT_PATH = %OutputVar%


    ;MsgBox, You selected folder "%RMT_PATH%".

    InputBox, UserInput, slot Number, Please enter the Slot number., , 440, 180
    if ErrorLevel{
   	 MsgBox, CANCEL was pressed.
	 return
	}
    else
   	; MsgBox, You entered "%UserInput%"
    	 
	 EnvSet, SlotNumber, %UserInput%
      	

}
return

FileLoad_RMT_Path:

Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFolder, OutputVar, , 3

if OutputVar =
    MsgBox, You didn't select a folder, Please load the file again.

else
{
    Gui, Add, Picture, x0 y20 h300 w450, RMT_path = %OutputVar%

    
    RMT_PATH = %OutputVar%


    ;MsgBox, You selected folder "%RMT_PATH%".


}
return

FileLoad_NVME_Path:

Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFolder, OutputVar, , 3

if OutputVar =
    MsgBox, You didn't select a folder, Please load the file again.

else
{
    Gui, Add, Picture, x0 y20 h300 w450, wfm_path = %OutputVar%

    EnvSet, WaveformPath, %OutputVar%

    RMT_PATH = %OutputVar%


    ;MsgBox, You selected folder "%RMT_PATH%".

    InputBox, UserInput, port Number, Please enter the Port number., , 440, 180
    if ErrorLevel{
   	 MsgBox, CANCEL was pressed.
	 return
	}
    else
   	 ;MsgBox, You entered "%UserInput%"
    	 
	 EnvSet, PortNumber, %UserInput%
      	

}
return

ButtonStartPCI_SIG:

    Run, %comspec% /c TEST_Jordan_NVME_and_Tx.bat

Loop, %A_WinDir%\*.*{



    if A_Index > 100
        break
    GuiControl,, MyProgress, %A_Index%
    GuiControl,, MyText, %A_LoopFileName%
    Sleep 50
}
GuiControl,, MyText, Bar finished.
return


ButtonStartRMT:

;WinWaitActive, ahk_class CabinetWClass
;ControlGetText, Path, Edit1, A
;Msgbox, %Path%


PY_Path=%RMT_PATH%


FileAppend,%PY_Path%,%A_ScriptDir%\path.txt

Run test.py, %Path%

Return

ButtonStartNVME:

    Run, %comspec% /c TEST_Jordan_NVME_and_Tx.bat

Loop, %A_WinDir%\*.*{



    if A_Index > 100
        break
    GuiControl,, MyProgress, %A_Index%
    GuiControl,, MyText, %A_LoopFileName%
    Sleep 50
}
GuiControl,, MyText, Bar finished.
return


GuiClose:
ExitApp


return
