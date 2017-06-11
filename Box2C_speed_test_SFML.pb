
XIncludeFile "Box2CEx.pbi"


Declare fps_timer_proc(*Value)

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


; setup the ground Box2D shape and SFML texture combination
ground_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "platform.gif")

; setup the ground Box2D body and SFML sprite combination
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
ground_body_sprite_index.i = _Box2C_b2Body_sfSprite_AddItem_SFML(0, 0, -4, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5)

; setup the ground Box2D fixture
; body-sprite index, shape-texture index, density, restitution, friction
_Box2C_b2Fixture_AddItem_SFML(ground_body_sprite_index, ground_shape_texture_index, 0, 0, 0.1)


; setup the body Box2D shape and SFML texture combination
body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "smaller_crate.gif")

; setup the body Box2D body and SFML sprite combination
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
body_sprite_index.i = _Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 4, Radian(-10), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.5, 0.5)

; setup the body Box2D fixture
; body-sprite index, shape-texture index, density, restitution, friction
_Box2C_b2Fixture_AddItem_SFML(body_sprite_index, body_shape_texture_index, 1, 0.3, 0.1)


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
_CSFML_sfText_setString(info_text, "hello")
_CSFML_sfText_setFont(info_text, font)
_CSFML_sfText_setCharacterSize(info_text, 12)
_CSFML_sfText_setPosition(info_text, text_pos)
_CSFML_sfText_setFillColor_rgba(info_text, 0, 0, 0, 255)
  
Global num_frames.i = 0
Global fps.i = 0
frame_timer = ElapsedMilliseconds()
fps_timer = ElapsedMilliseconds()


; The animation frame loop

While (_CSFML_sfRenderWindow_isOpen(window))
  
  If (ElapsedMilliseconds() - fps_timer) > 1000
    
    CreateThread(@fps_timer_proc(), 5000)
    
    fps_timer = ElapsedMilliseconds()

  EndIf
        
  If (ElapsedMilliseconds() - frame_timer) > ((1 / 60) * 1000)
  
    While (_CSFML_sfRenderWindow_pollEvent(window, event))
      
      If event\type = #sfEvtClosed
        
        _CSFML_sfRenderWindow_close(window)
      EndIf
      
      If event\type = #sfEvtKeyPressed
        
     ;   key_code.i = event\key\code
     ;   Debug(event\key\code)
        
        Select event\key\code
            
          Case 2  ; c key
            
            new_body_sprite_index.i = _Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 4, Radian(-10), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.5, 0.5)
            _Box2C_b2Fixture_AddItem_SFML(new_body_sprite_index, body_shape_texture_index, 1, 0.3, 0.1)
            
        EndSelect
        
      EndIf

    Wend
    
    b2world_step(world, (1.0 / 60.0), 6, 2)
    
    _Box2C_b2World_Animate_SFML(info_text)
    
    num_frames = num_frames + 1
    frame_timer = ElapsedMilliseconds()
  EndIf
  
Wend


_CSFML_sfRenderWindow_destroy(window)
_CSFML_Shutdown()
_Box2C_Shutdown()


Procedure fps_timer_proc(*Value)
  
  fps = num_frames
  num_frames = 0
  
  _CSFML_sfText_setString(info_text, Str(fps))

 ; Debug(fps)
;Repeat
;Delay(x) ; Will execute every X millisecond.
;do stuff
;ForEver
EndProcedure


; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 109
; FirstLine = 97
; Folding = -
; EnableUnicode
; EnableXP
; Executable = Box2C_hello2D - 2.exe