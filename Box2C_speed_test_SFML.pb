
XIncludeFile "Box2CEx.pbi"


Declare fps_timer_proc(*Value)
Declare check_events_timer_proc(*Value)

; a box2c wrapper, built in freebasic, that works around the feature gap in purebasic for passing structures by value
;   and retrieving structures by value

  
; freebasic wrapped library declarations

; direct box2c library declarations
;PrototypeC.i Protob2world_constructor(*gravity.Vec2, doSleep.l)

; setup gravity
Global gravity.Vec2
gravity\x = 0.0
gravity\y = -10.0
*gravity_ptr.Vec2 = @gravity

; setup the world
fb_b2world_constructor(@world)

;PrintN(Str(world))


; setup the Box2D shape and SFML texture combinations
ground_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "platform.gif")
body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.125, -0.125, 0.125, -0.125, 0.125, 0.125, -0.125, 0.125, 0, 0, 0, 0, 0, 0, 0, 0, "smallest_crate.gif")

; setup the Box2D body and SFML sprite combinations
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(0, 0, -4, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5), ground_shape_texture_index, 0, 0, 0.1)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(0, 4.5, -2, Radian(45), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5), ground_shape_texture_index, 0, 0, 0.1)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(0, -4.5, -2, Radian(-45), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5), ground_shape_texture_index, 0, 0, 0.1)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 4, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.125, 0.125), body_shape_texture_index, 1, 0.3, 0.1)

; setup the Box2D fixtures
; body-sprite index, shape-texture index, density, restitution, friction


; setup the body Box2D shape and SFML texture combination

; setup the body Box2D body and SFML sprite combination
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)

; setup the body Box2D fixture
; body-sprite index, shape-texture index, density, restitution, friction


; SFML stuff
_CSFML_Startup()


text_pos.sfVector2f
text_pos\x = 10
text_pos\y = 10

window = _CSFML_sfRenderWindow_create(mode, "fgh", 6, #Null)
window_hwnd.l = _CSFML_sfRenderWindow_getSystemHandle(window)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window, 1)


font.l = _CSFML_sfFont_createFromFile("arial.ttf")
Global info_text.l = _CSFML_sfText_create()
_CSFML_sfText_setString(info_text, "")
_CSFML_sfText_setFont(info_text, font)
_CSFML_sfText_setCharacterSize(info_text, 12)
_CSFML_sfText_setPosition(info_text, text_pos)
_CSFML_sfText_setFillColor_rgba(info_text, 0, 0, 0, 255)

Global num_bodies = 1
Global num_frames.i = 0
Global fps.i = 0
frame_timer = ElapsedMilliseconds()
;frame_timer = GetTickCount_()
fps_timer = ElapsedMilliseconds()
check_events_timer = ElapsedMilliseconds()



; The animation frame loop

While (_CSFML_sfRenderWindow_isOpen(window))
  
  If (ElapsedMilliseconds() - check_events_timer) > 100
    
;    CreateThread(@check_events_timer_proc(), 100)
    
    
    While (_CSFML_sfRenderWindow_pollEvent(window, event))
      
      If event\type = #sfEvtClosed
        
        _CSFML_sfRenderWindow_close(window)
      EndIf
      
      If event\type = #sfEvtKeyPressed
        
        Select event\key\code
            
          Case 0  ; a key
            
        ;    Debug ("aa")
            _Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 4, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.125, 0.125), body_shape_texture_index, 1, 0.3, 0.1)
            num_bodies = num_bodies + 1
            
        EndSelect
        
      EndIf
  
    Wend

    check_events_timer = ElapsedMilliseconds()

  EndIf
  
  If (ElapsedMilliseconds() - fps_timer) > 1000
    
    CreateThread(@fps_timer_proc(), 1000)
    
    fps_timer = ElapsedMilliseconds()

  EndIf
        
;  If (ElapsedMilliseconds() - frame_timer) > ((1 / 60) * 1000)
  If (ElapsedMilliseconds() - frame_timer) > (16)
;  If (GetTickCount_() - frame_timer) > ((1 / 60) * 1000)
;  If (GetTickCount_() - frame_timer) > (16)
    
    ;b2world_step(world, (1.0 / 60.0), 6, 2)
;    b2world_step(world, (1 + (num_bodies / 400)) / 60.0, 6, 2)
;    b2world_step(world, (1.2 + (num_bodies / 300)) / 60.0, 6, 2)
    b2world_step(world, (1.4 + (num_bodies / 300)) / 60.0, 6, 2)

    
    _Box2C_b2World_Animate_SFML(info_text)
    
    num_frames = num_frames + 1
    frame_timer = ElapsedMilliseconds()
;    frame_timer = GetTickCount_()
  EndIf
  
Wend


_CSFML_sfRenderWindow_destroy(window)
_CSFML_Shutdown()
_Box2C_Shutdown()


Procedure fps_timer_proc(*Value)
  
  fps = num_frames
  num_frames = 0
  
  _CSFML_sfText_setString(info_text, "press 'A' to add a box" + Chr(10) + "fps = " + Str(fps) + ", number of bodies = " + Str(num_bodies))

EndProcedure

Procedure check_events_timer_proc(*Value)
  

EndProcedure


; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 158
; FirstLine = 128
; Folding = -
; EnableUnicode
; EnableXP
; Executable = Box2C_speed_test_SFML.exe