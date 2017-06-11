
XIncludeFile "Box2CEx.pbi"
XIncludeFile "CSFML.pbi"


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
world.i
fb_b2world_constructor(@world)

;PrintN(Str(world))
;Debug(world)

; setup the ground definition
groundBodyDef.b2BodyDef
groundBodyDef\type = 0
groundBodyDef\position\x = 0
groundBodyDef\position\y = -4
groundBodyDef\angle = Radian(5)
groundBodyDef\linearVelocity\x = 0
groundBodyDef\linearVelocity\y = 0
groundBodyDef\angularVelocity = 0
groundBodyDef\linearDamping = 0
groundBodyDef\angularDamping = 0
groundBodyDef\allowSleep = 1
groundBodyDef\awake = 1
groundBodyDef\fixedRotation = 0
groundBodyDef\bullet = 0
groundBodyDef\active = 1
groundBodyDef\userData = 0
groundBodyDef\gravityScale = 1
*groundBodyDef_ptr.b2BodyDef = @groundBodyDef

; setup the ground body
groundBody.i
groundBody = b2world_createbody(world, *groundBodyDef_ptr)
b2body_setawake(groundBody, 1)

; setup the ground shape
ground_shape_index.i = _Box2C_b2ShapeArr_AddItem_SFML(1, 4, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0)
;Debug ground_shape_index



; setup the ground fixture
groundBodyFixture_ptr.i
groundBodyFixture_ptr = b2body_createfixturefromshape(groundBody, @b2ShapeArr(ground_shape_index), 0)
b2fixture_setrestitution(groundBodyFixture_ptr, 0.0)
b2fixture_setfriction(groundBodyFixture_ptr, 0.0)

; setup the body definition
bodyDef.b2BodyDef
bodyDef\type = 2
bodyDef\position\x = 0
bodyDef\position\y = 4
bodyDef\angle = Radian(-10)
bodyDef\linearVelocity\x = 0
bodyDef\linearVelocity\y = 0
bodyDef\angularVelocity = 0
bodyDef\linearDamping = 0
bodyDef\angularDamping = 0
bodyDef\allowSleep = 1
bodyDef\awake = 1
bodyDef\fixedRotation = 0
bodyDef\bullet = 0
bodyDef\active = 1
bodyDef\userData = 0
bodyDef\gravityScale = 1
*bodyDef_ptr.b2BodyDef = @bodyDef

; setup the body body
body.i
body = b2world_createbody(world, *bodyDef_ptr)
b2body_setawake(body, 1)

; setup the body shape
body_shape_index.i = _Box2C_b2ShapeArr_AddItem_SFML(1, 4, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0)
;Debug body_shape_index


; setup the body fixture
bodyFixture_ptr.i
bodyFixture_ptr = b2body_createfixturefromshape(body, @b2ShapeArr(body_shape_index), 1)
b2fixture_setrestitution(bodyFixture_ptr, 0.3)
b2fixture_setfriction(bodyFixture_ptr, 0.0)

; SFML stuff

_CSFML_Startup()

;  sprite_pos\x = 100
;  sprite_pos\y = 100

text_pos.sfVector2f
text_pos\x = 10
text_pos\y = 10

window.l = _CSFML_sfRenderWindow_create(mode, "fgh", 6, #Null)
window_hwnd.l = _CSFML_sfRenderWindow_getSystemHandle(window)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window, 1)

ground_texture.l = _CSFML_sfTexture_createFromFile("platform.gif", #Null)
ground_sprite.l = _CSFML_sfSprite_create()
_CSFML_sfSprite_setTexture(ground_sprite, ground_texture, 1)
ground_sprite_origin.sfVector2f
ground_sprite_origin\x = 2.5 * 50
ground_sprite_origin\y = 0.5 * 50
_CSFML_sfSprite_setOrigin(ground_sprite, ground_sprite_origin)

body_texture.l = _CSFML_sfTexture_createFromFile("smaller_crate.gif", #Null)
body_sprite.l = _CSFML_sfSprite_create()
_CSFML_sfSprite_setTexture(body_sprite, body_texture, 1)
body_sprite_origin.sfVector2f
body_sprite_origin\x = 0.5 * 50
body_sprite_origin\y = 0.5 * 50
_CSFML_sfSprite_setOrigin(body_sprite, body_sprite_origin)

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

    
b2body_getposition(groundBody, *ground_pos_ptr)
ground_angle = b2body_getangle(groundBody)
  

While (_CSFML_sfRenderWindow_isOpen(window))
  
  While (_CSFML_sfRenderWindow_pollEvent(window, event))
    
    If event\type = #sfEvtClosed
      
      _CSFML_sfRenderWindow_close(window)
    EndIf
  Wend
  
  b2world_step(world, (1.0 / 60.0), 6, 2)
    
  b2body_getposition(body, *body_pos_ptr)
  body_angle = b2body_getangle(body)
  
;  PrintN(StrF(position\x) + " " + StrF(position\y) + " " + Degree(angle))
  

  
  
;  _CSFML_sfRenderWindow_clear(window, white)
  _CSFML_sfRenderWindow_clear_rgba(window, 255, 255, 255, 255)
;  _CSFML_sfRenderWindow_clear_rgba(window, 0, 0, 0, 255)
  
  ground_sprite_pos\x = 400 - (ground_pos\x * 50)
  ground_sprite_pos\y = 300 - (ground_pos\y * 50)
  _CSFML_sfSprite_setPosition(ground_sprite, ground_sprite_pos)
  _CSFML_sfSprite_setRotation(ground_sprite, Degree(ground_angle))
  
  body_sprite_pos\x = 400 - (body_pos\x * 50)
  body_sprite_pos\y = 300 - (body_pos\y * 50)
  _CSFML_sfSprite_setPosition(body_sprite, body_sprite_pos)
  _CSFML_sfSprite_setRotation(body_sprite, Degree(body_angle))
  
  _CSFML_sfRenderWindow_drawText(window, text, #Null)
  _CSFML_sfRenderWindow_drawSprite(window, ground_sprite, #Null)
  _CSFML_sfRenderWindow_drawSprite(window, body_sprite, #Null)
  _CSFML_sfRenderWindow_display(window)
  
Wend


_CSFML_sfRenderWindow_destroy(window)
_CSFML_Shutdown()
_Box2C_Shutdown()



; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 104
; FirstLine = 77
; EnableUnicode
; EnableXP
; Executable = Box2C_hello2D - 2.exe