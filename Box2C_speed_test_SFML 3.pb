
XIncludeFile "Box2CEx.pbi"


Declare fps_timer_proc(*Value)
;Declare check_events_timer_proc(*Value)
;Declare animation_loop_proc(*Value)

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
;OpenConsole()


; setup the Box2D shape and SFML texture combinations
long_wall_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -7.5, -0.5, 7.5, -0.5, 7.5, 0.5, -7.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "platformx3.gif")
ground_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "platform.gif")
;body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.05, -0.05, 0.05, -0.05, 0.05, 0.05, -0.05, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, "smallest_triangle.gif")
body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.05, -0.05, 0.05, -0.05, 0.05, 0.05, -0.05, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, "smallest_triangle4.png")
;body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 3, -0.05, -0.05, 0.05, -0.05, 0.025, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "smallest_triangle4.png")
;body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.125, -0.125, 0.125, -0.125, 0.125, 0.125, -0.125, 0.125, 0, 0, 0, 0, 0, 0, 0, 0, "smallest_crate.gif")

; setup the Box2D body and SFML sprite combinations
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(1, 0, -3, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, long_wall_texture_index, 7.5, 0.5), long_wall_texture_index, 0, 0, 0.1)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(1, 7.0, -3, Radian(90), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5), ground_shape_texture_index, 0, 0, 0.1)
_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(1, -7.0, -3, Radian(90), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5), ground_shape_texture_index, 0, 0, 0.1)
;_Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 6, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.125, 0.125), body_shape_texture_index, 1, 0.3, 0.1)

; SFML stuff
_CSFML_Startup()


text_pos.sfVector2f
text_pos\x = 10
text_pos\y = 10

window = _CSFML_sfRenderWindow_create(mode, "fgh", 6, #Null)
window_hwnd.l = _CSFML_sfRenderWindow_getSystemHandle(window)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window, 0)


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
Global key_code.i = -1
frame_timer = ElapsedMilliseconds()
check_events_timer = ElapsedMilliseconds()
;fps_timer = ElapsedMilliseconds()
Global box_dropping_rate.i = 30
box_dropping_timer = ElapsedMilliseconds()
Global new_box_density.f = 0.00001 ;0.01
Global new_box_restitution.f = 0.6 ;0.3
Global new_box_friction.f = 0.0 ;0.0
walls_angular_velocity_max.f = 5
walls_angular_velocity.f = 8 ;walls_angular_velocity_max
walls_angular_velocity_rate.f = 0.1

CreateThread(@fps_timer_proc(), 1000)

b2body_setangularvelocity(pb_b2Body_sfSprite(0)\b2Body, Radian(walls_angular_velocity))


; The animation frame loop

While (_CSFML_sfRenderWindow_isOpen(window))
  
  ; every 50 ms check events and keyboard
  If (ElapsedMilliseconds() - check_events_timer) > 50
    
    check_events_timer = ElapsedMilliseconds()

    While (_CSFML_sfRenderWindow_pollEvent(window, event))
      
      If event\type = #sfEvtClosed
        
        _CSFML_sfRenderWindow_close(window)
      EndIf
      
      If event\type = #sfEvtKeyPressed
        
        key_code = event\key\code
      ;  Debug (key_code)
        
        Select key_code
            
          Case 16 ; q
            
            box_dropping_rate = box_dropping_rate + 10
            
          Case 22 ; w
            
            box_dropping_rate = box_dropping_rate - 10
            
            If box_dropping_rate < 0
              
              box_dropping_rate = 0
            EndIf
            
          Case 0  ; a
              
            new_box_density = new_box_density - 0.1
            
            If new_box_density < 0
              
              new_box_density = 0
            EndIf
            
          Case 18 ; s
            
            new_box_density = new_box_density + 0.1

          Case 25 ; z
            
            new_box_restitution = new_box_restitution - 0.1
            
            If new_box_restitution < 0
              
              new_box_restitution = 0
            EndIf

          Case 23 ; x
            
            new_box_restitution = new_box_restitution + 0.1
            
          Case 4 ; e
            
            new_box_friction = new_box_friction - 0.1
            
            If new_box_friction < 0
              
              new_box_friction = 0
            EndIf
            
          Case 17 ; r
            
            new_box_friction = new_box_friction + 0.1

        EndSelect
      EndIf
    Wend
  EndIf
  
  If (ElapsedMilliseconds() - box_dropping_timer) > (box_dropping_rate)
    
    box_dropping_timer = ElapsedMilliseconds()
    
    If num_bodies < 1000
      
;      _Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 6, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.125, 0.125), body_shape_texture_index, new_box_density, new_box_restitution, new_box_friction)
      _Box2C_b2Fixture_AddItem_SFML(_Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 6, Radian(0), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.05, 0.05), body_shape_texture_index, new_box_density, new_box_restitution, new_box_friction)
      num_bodies = num_bodies + 1
    EndIf
    
  EndIf

  ; every 16 ms (1 / 60th of a second) animate the frame
      
   ;  If (ElapsedMilliseconds() - frame_timer) > ((1 / 60) * 1000)
  If (ElapsedMilliseconds() - frame_timer) > (16)
;  If (ElapsedMilliseconds() - frame_timer) > (50)
    
    frame_timer = ElapsedMilliseconds()

  ;  b2world_step(world, (1.0 / 60.0), 6, 2)
;     b2world_step(world, (1.0 + (num_bodies / 900)) / 60.0, 6, 2)
   ;    b2world_step(world, (1 + (num_bodies / 400)) / 60.0, 6, 2)
   ;    b2world_step(world, (1.2 + (num_bodies / 300)) / 60.0, 6, 2)
;     b2world_step(world, (1.4 + (num_bodies / 100)) / 60.0, 6, 2)
;     b2world_step(world, (1.4 + (num_bodies / 100)) / 60.0, 8, 3)
;    b2world_step(world, (1 / 60.0), 1, 1)
    
 ;   If num_bodies > 700
      
      b2world_step(world, (1 / 60.0), 1, 1)
  ;  Else
      
   ;   b2world_step(world, (1 / 60.0), 1, 1)
   ; EndIf
      
    tmp_body_pos.Vec2
    *tmp_body_pos_ptr = @tmp_body_pos

    b2body_getposition(pb_b2Body_sfSprite(0)\b2Body, *tmp_body_pos_ptr)
    
;    Debug(Str(tmp_body_pos\x) + " " + Str(tmp_body_pos\y))
     
     
    ground_angle.f = b2body_getangle(pb_b2Body_sfSprite(0)\b2Body)
  ;              Debug (Degree(ground_angle.f))
    
    If ground_angle.f < Radian(-20)
      

      fb_b2body_settransform(pb_b2Body_sfSprite(0)\b2Body, tmp_body_pos, Radian(-20))
      walls_angular_velocity = -walls_angular_velocity
      b2body_setangularvelocity(pb_b2Body_sfSprite(0)\b2Body, Radian(walls_angular_velocity))
    EndIf
    
    If ground_angle.f > Radian(20)
      

      fb_b2body_settransform(pb_b2Body_sfSprite(0)\b2Body, tmp_body_pos, Radian(20))
      walls_angular_velocity = -walls_angular_velocity
      b2body_setangularvelocity(pb_b2Body_sfSprite(0)\b2Body, Radian(walls_angular_velocity))
    EndIf
     
;    b2body_setangularvelocity(pb_b2Body_sfSprite(0)\b2Body, Radian(walls_angular_velocity))
    
;    walls_angular_velocity = walls_angular_velocity - walls_angular_velocity_rate
    
;    If walls_angular_velocity < -walls_angular_velocity_max Or walls_angular_velocity > walls_angular_velocity_max
      
;      walls_angular_velocity_rate = -walls_angular_velocity_rate
;    EndIf
    
  ;  fb_b2body_settransform(pb_b2Body_sfSprite(0)\b2Body, tmp_body_pos, Radian(10))
    
 ;   tmp_body_pos\x = 10
 ;   tmp_body_pos\y = 10
    
  ;  fb_b2body_setlinearvelocity(pb_b2Body_sfSprite(0)\b2Body, tmp_body_pos)
    
    _Box2C_b2World_Animate_SFML(info_text)
    
    

    
    num_frames = num_frames + 1
  EndIf    
   
Wend


_CSFML_sfRenderWindow_destroy(window)
_CSFML_Shutdown()
_Box2C_Shutdown()


Procedure fps_timer_proc(*Value)
  
  fps_timer = ElapsedMilliseconds()

  While (_CSFML_sfRenderWindow_isOpen(window))
  
    If (ElapsedMilliseconds() - fps_timer) > 1000
      
      fps_timer = ElapsedMilliseconds()
      fps = num_frames + 1
      num_frames = 0
      
     ; Debug("fps = " + Str(fps) + ", number of bodies = " + Str(num_bodies))
      _CSFML_sfText_setString(info_text, "Keys" + Chr(10) + 
                                         "----" + Chr(10) + 
                                         "press 'Q' or 'W' to adjust the rate of new boxes" + Chr(10) + 
                                         "press 'A' or 'S' to adjust the density of the new boxes" + Chr(10) + 
                                         "press 'Z' or 'X' to adjust the restitution of the new boxes" + Chr(10) + 
                                         "press 'E' or 'R' to adjust the friction of the new boxes" + Chr(10) + 
                                         "" + Chr(10) + 
                                         "Info" + Chr(10) + 
                                         "----" + Chr(10) + 
                                         "Rate of new boxes = " + Str(box_dropping_rate) + " ms" + Chr(10) + 
                                         "density of the new boxes = " + StrF(new_box_density, 2) + " kg/m squared" + Chr(10) + 
                                         "restitution of the new boxes = " + StrF(new_box_restitution, 2) + Chr(10) + 
                                         "friction of the new boxes = " + StrF(new_box_friction, 2) + Chr(10) + 
                                         "number of bodies = " + Str(num_bodies) + Chr(10) + 
                                         "fps = " + Str(fps))
      
    EndIf
  Wend


EndProcedure


; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 194
; FirstLine = 166
; Folding = -
; EnableUnicode
; EnableXP
; Executable = Box2C_speed_test_SFML 3.exe