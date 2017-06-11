
XIncludeFile "Box2CEx.pbi"


;If pb_b2ShapeArrIndex(0) = #Null
  
;  Debug "dude"  
;EndIf

;Input()

;OpenConsole()


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
;world.i
fb_b2world_constructor(@world)

;PrintN(Str(world))
;Debug(world)


; setup the ground Box2D shape and SFML texture combination
ground_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "platform.gif")

; setup the ground Box2D body and SFML sprite combination
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
ground_body_sprite_index.i = _Box2C_b2Body_sfSprite_AddItem_SFML(0, 0, -4, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, ground_shape_texture_index, 2.5, 0.5)



; setup the ground fixture
groundBodyFixture_ptr.i
;groundBodyFixture_ptr = b2body_createfixturefromshape(b2BodyPtrArr(ground_body_index), @b2ShapeArr(ground_shape_index), 0)
;groundBodyFixture_ptr = b2body_createfixturefromshape(b2BodyPtrArr(ground_body_index), @pb_b2Shape_sfTexture(ground_shape_texture_index)\b2Shape, 0)
groundBodyFixture_ptr = b2body_createfixturefromshape(pb_b2Body_sfSprite(ground_body_sprite_index)\b2Body, @pb_b2Shape_sfTexture(ground_shape_texture_index)\b2Shape, 0)
b2fixture_setrestitution(groundBodyFixture_ptr, 0.0)
b2fixture_setfriction(groundBodyFixture_ptr, 0.0)


; setup the body Box2D shape and SFML texture combination
body_shape_texture_index.i = _Box2C_b2Shape_sfTexture_AddItem_SFML(1, 4, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, "smaller_crate.gif")

; setup the body Box2D body and SFML sprite combination
; type, position_x, position_y, angle, linearVelocity_x, linearVelocity_y, angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, gravityScale)
body_sprite_index.i = _Box2C_b2Body_sfSprite_AddItem_SFML(2, 0, 4, Radian(-10), 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, body_shape_texture_index, 0.5, 0.5)



; setup the body fixture
bodyFixture_ptr.i
bodyFixture_ptr = b2body_createfixturefromshape(pb_b2Body_sfSprite(body_sprite_index)\b2Body, @pb_b2Shape_sfTexture(body_shape_texture_index)\b2Shape, 1)
b2fixture_setrestitution(bodyFixture_ptr, 0.3)
b2fixture_setfriction(bodyFixture_ptr, 0.0)

; SFML stuff

_CSFML_Startup()


text_pos.sfVector2f
text_pos\x = 10
text_pos\y = 10

window.l = _CSFML_sfRenderWindow_create(mode, "fgh", 6, #Null)
window_hwnd.l = _CSFML_sfRenderWindow_getSystemHandle(window)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window, 1)


font.l = _CSFML_sfFont_createFromFile("arial.ttf")
text.l = _CSFML_sfText_create()
_CSFML_sfText_setString(text, "hello")
_CSFML_sfText_setFont(text, font)
_CSFML_sfText_setCharacterSize(text, 12)
_CSFML_sfText_setPosition(text, text_pos)
_CSFML_sfText_setFillColor_rgba(text, 0, 0, 0, 255)
  
  
  
  
  
  
  
ground_pos.Vec2
*ground_pos_ptr = @ground_pos
ground_angle.f
ground_sprite_pos.sfVector2f
  
body_pos.Vec2
*body_pos_ptr = @body_pos
body_angle.f
body_sprite_pos.sfVector2f

    
b2body_getposition(pb_b2Body_sfSprite(ground_body_sprite_index)\b2Body, *ground_pos_ptr)
ground_angle = b2body_getangle(pb_b2Body_sfSprite(ground_body_sprite_index)\b2Body)
  

While (_CSFML_sfRenderWindow_isOpen(window))
  
  While (_CSFML_sfRenderWindow_pollEvent(window, event))
    
    If event\type = #sfEvtClosed
      
      _CSFML_sfRenderWindow_close(window)
    EndIf
  Wend
  
  b2world_step(world, (1.0 / 60.0), 6, 2)
    
  b2body_getposition(pb_b2Body_sfSprite(body_sprite_index)\b2Body, *body_pos_ptr)
  body_angle = b2body_getangle(pb_b2Body_sfSprite(body_sprite_index)\b2Body)
  
;  PrintN(StrF(position\x) + " " + StrF(position\y) + " " + Degree(angle))
  

  
  
;  _CSFML_sfRenderWindow_clear(window, white)
  _CSFML_sfRenderWindow_clear_rgba(window, 255, 255, 255, 255)
;  _CSFML_sfRenderWindow_clear_rgba(window, 0, 0, 0, 255)
  
  ground_sprite_pos\x = 400 - (ground_pos\x * 50)
  ground_sprite_pos\y = 300 - (ground_pos\y * 50)
  
  _CSFML_sfSprite_setPosition(pb_b2Body_sfSprite(ground_body_sprite_index)\sfSprite, ground_sprite_pos)
  _CSFML_sfSprite_setRotation(pb_b2Body_sfSprite(ground_body_sprite_index)\sfSprite, Degree(ground_angle))
  
  body_sprite_pos\x = 400 - (body_pos\x * 50)
  body_sprite_pos\y = 300 - (body_pos\y * 50)
  _CSFML_sfSprite_setPosition(pb_b2Body_sfSprite(body_sprite_index)\sfSprite, body_sprite_pos)
  _CSFML_sfSprite_setRotation(pb_b2Body_sfSprite(body_sprite_index)\sfSprite, Degree(body_angle))
  
  _CSFML_sfRenderWindow_drawText(window, text, #Null)
  _CSFML_sfRenderWindow_drawSprite(window, pb_b2Body_sfSprite(ground_body_sprite_index)\sfSprite, #Null)
  _CSFML_sfRenderWindow_drawSprite(window, pb_b2Body_sfSprite(body_sprite_index)\sfSprite, #Null)
  _CSFML_sfRenderWindow_display(window)
  
Wend


_CSFML_sfRenderWindow_destroy(window)
_CSFML_Shutdown()
_Box2C_Shutdown()



; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 74
; FirstLine = 50
; EnableUnicode
; EnableXP
; Executable = Box2C_hello2D - 2.exe