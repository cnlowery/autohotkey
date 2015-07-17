/*
About

move/resize your active window with a simple keyboard shortcut
currently only works when all monitors report positive numbers to SysGet (i.e. primary monitor must be Mon1 with Mon2 sitting to the right of it)

Requirements:
install autohotkey - http://www.autohotkey.com/
numlock = ON

Instructions:
Left Control + NumpadX to align on your left monitor
Left Alt + NumpadX to align on your right monitor
For NumpadX, X is assigned as such
 4 = left half
 6 = right half
 5 = full screen
 7 = upper left quarter
 9 = upper right quarter
 1 = lower left quarter
 3 = lower right quarter
 2 = center with current height and width

Script author: Nick Lowery
https://github.com/cnlowery/autohotkey/blob/master/DualMonitorWindowPlacement.ahk

ResizeWin method by - http://www.howtogeek.com/howto/28663/create-a-hotkey-to-resize-windows-to-a-specific-size-with-autohotkey/
*/
;****************************************************************
;START get monitor dimensions

SysGet, Mon1, MonitorWorkArea, 1
Left1 = %Mon1Left%
Top1 = %Mon1Top%
Right1 = %Mon1Right%
Bottom1 = %Mon1Bottom%

SysGet, Mon2, MonitorWorkArea, 2
Left2 = %Mon2Left%
Top2 = %Mon2Top%
Right2 = %Mon2Right%
Bottom2 = %Mon2Bottom%

;END monitor dimension
;****************************************************************
;START Resize Window

ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  If %Width% = 0
    Width := W

  If %Height% = 0
    Height := H

  WinMove,A,,%X%,%Y%,%Width%,%Height%
}

;END Resize Window
;****************************************************************
;START Monitor Variables

;Primary Monitor Variables
PrimaryResizeHalfHeight := Bottom1
PrimaryResizeHalfWidth := Right1//2
PrimaryResizeQuarterHeight := Bottom1//2
PrimaryResizeQuarterWidth := Right1//2
PrimaryMiddleHeight := Bottom1//2
PrimaryMiddleWidth := Right1//2

;Secondary Monitor Variables
SecondaryFullWidth := Right2-Right1
SecondaryHalfWidth := (Right2-Right1)//2
SecondaryHalfHeight := Bottom2//2
SecondaryHalfPosition := (Right2-Right1)//2+Right1

;END Monitor Variables
;****************************************************************
;START primary monitor window placement

;Center window
LCtrl & Numpad2::
WinGetPos,,, Width, Height, A
Winmove, A,, (A_ScreenWidth/2)-(Width/2), (Bottom1-Height)//2
return

;Full Screen
LCtrl & Numpad5::
Winmove, A,, Left1, Top1
ResizeWin(Right1,Bottom1)
return

;Left Tall
LCtrl & Numpad4::
Winmove, A,, Left1, Top1
ResizeWin(PrimaryResizeHalfWidth,PrimaryResizeHalfHeight)
return

;Right Tall
LCtrl & Numpad6::
Winmove, A,, PrimaryMiddleWidth, Top1
ResizeWin(PrimaryResizeHalfWidth,PrimaryResizeHalfHeight)
return

;Upper Left
LCtrl & Numpad7::
Winmove, A,, Left1, Top1
ResizeWin(PrimaryResizeQuarterWidth,PrimaryResizeQuarterHeight)
return

;Upper Right
LCtrl & Numpad9::
Winmove, A,, PrimaryMiddleWidth, Top1
ResizeWin(PrimaryResizeQuarterWidth,PrimaryResizeQuarterHeight)
return

;Lower Left
LCtrl & Numpad1::
Winmove, A,, Left1, PrimaryMiddleHeight
ResizeWin(PrimaryResizeQuarterWidth,PrimaryResizeQuarterHeight)
return

;Lower Right
LCtrl & Numpad3::
Winmove, A,, PrimaryMiddleWidth, PrimaryMiddleHeight
ResizeWin(PrimaryResizeQuarterWidth,PrimaryResizeQuarterHeight)
return

;END primary monitor window placement
;****************************************************************
;START secondary monitor window placement

;Center window
LAlt & Numpad2::
WinGetPos,,, Width, Height, A
Winmove, A,, Right1+((Right2-Right1)-Width)//2,(Bottom2-Height)//2
return

;Full Screen
LAlt & Numpad5::
Winmove, A,, Left2, Top2
ResizeWin(SecondaryFullWidth,Bottom2)
return

;Left Tall
LAlt & Numpad4::
Winmove, A,, Left2, Top2
ResizeWin(SecondaryHalfWidth,Bottom2)
return

;Right Tall
LAlt & Numpad6::
Winmove, A,, SecondaryHalfPosition, Top2
ResizeWin(SecondaryHalfWidth,Bottom2)
return

;Upper Left
LAlt & Numpad7::
Winmove, A,, Left2, Top2
ResizeWin(SecondaryHalfWidth,SecondaryHalfHeight)
return

;Upper Right
LAlt & Numpad9::
Winmove, A,, SecondaryHalfPosition, Top2
ResizeWin(SecondaryHalfWidth,SecondaryHalfHeight)
return

;Lower Left
LAlt & Numpad1::
Winmove, A,, Left2, SecondaryHalfHeight
ResizeWin(SecondaryHalfWidth,SecondaryHalfHeight)
return

;Lower Right
LAlt & Numpad3::
Winmove, A,, SecondaryHalfPosition, SecondaryHalfHeight
ResizeWin(SecondaryHalfWidth,SecondaryHalfHeight)
return

;END secondary monitor window placement
;****************************************************************
