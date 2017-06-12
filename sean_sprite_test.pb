;
; ------------------------------------------------------------
;
;   PureBasic - Windowed Screen example file
;
;    (c) Fantaisie Software
;
; ------------------------------------------------------------
;

If InitSprite() = 0 Or InitKeyboard() = 0 Or InitMouse() = 0
  
  Debug("bad")
  End
EndIf

If OpenWindow(0, 0, 0, 800, 600, "Gadget and sprites!", #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_ScreenCentered) = 0
  
  Debug("bad")
  End
EndIf

If OpenWindowedScreen(WindowID(0), 0, 0, 800, 600, 0, 0, 0, #PB_Screen_NoSynchronization) = 0
  
  Debug("bad")
  End
EndIf
  
; setup sprites
LoadSprite(0, #PB_Compiler_Home + "examples/sources/Data/PureBasicLogo.bmp")

direction = 1
playerX = 1
playerY = 1

; main loop

Repeat
  
  ; check events
  
  Repeat
    
    ; Always process all the events to flush the queue at every frame
    Event = WindowEvent()
    
    Select Event
        
      Case #PB_Event_CloseWindow
        
        Quit = 1
    EndSelect
  Until Event = 0 ; Quit the event loop only when no more events are available
  
  ; check keyboard
  
  ExamineKeyboard()
  
  If KeyboardReleased(#PB_Key_A)
    
    Debug("A")
  EndIf
  
  If KeyboardPushed(#PB_Key_Up)    And playerY > 0   : playerY -3 : EndIf  
  If KeyboardPushed(#PB_Key_Down)  And playerY < 280 : playerY +3 : EndIf  
  If KeyboardPushed(#PB_Key_Left)  And playerX > 0   : playerX -3 : EndIf  
  If KeyboardPushed(#PB_Key_Right) And playerX < 300 : playerX +3 : EndIf  
  
  ; Clear the screen and draw our sprites
  
  ClearScreen(RGB(0,0,0))
  DisplaySprite(0, x, 100)

  x + direction
  If x > 300 : direction = -1 : EndIf   ; moving back to the left with negative value
  If x < 0   : direction =  1 : EndIf   ; moving to the right with positive value
    
  FlipBuffers()       ; Inverse the buffers (the back become the front (visible)... and we can do the rendering on the back

Until  Quit Or KeyboardPushed(#PB_Key_Escape)

    



; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 27
; FirstLine = 4
; EnableUnicode
; EnableXP