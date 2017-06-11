
XIncludeFile "Box2C.pbi"
XIncludeFile "CSFML.pbi"


; #INDEX# =======================================================================================================================
; Title .........: Box2CEx
; FreeBasic Version : ?
; Language ......: English
; Description ...: Box2C Extended Functions.
; Author(s) .....: Sean Griffin
; Dlls ..........: csfml-system-2.dll, csfml-graphics-2.dll
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; ===============================================================================================================================

; #ENUMERATIONS# ===================================================================================================================
; ===============================================================================================================================



; #STRUCTURES# ===================================================================================================================
;Structure PB_b2Shape
;    b2ShapeArrIndex.i
;EndStructure

; A structure that combines Box2D Shapes and SFML Textures
;   The result is a texture with physical properties
;   created is a boolean indicating if the shape-texture has been created
Structure pb_b2Shape_sfTexture_struct
  created.i
  b2Shape.b2PolygonShapePortable
  sfTexture.l
EndStructure

; A structure that combines Box2D Bodies and SFML Sprites
;   The result is a sprite with physical properties
;   created is a boolean indicating if the body-sprite has been created
Structure pb_b2Body_sfSprite_struct
  created.i
  b2Body.l
  sfSprite.l
EndStructure

; ===============================================================================================================================

; #GLOBALS# ===================================================================================================================
Global world.l
Global window.l

Global Dim pb_b2Shape_sfTexture.pb_b2Shape_sfTexture_struct(1000)
Global Dim pb_b2Body_sfSprite.pb_b2Body_sfSprite_struct(1000)

Global Dim b2ShapeArr.b2PolygonShapePortable(1000)
Global Dim pb_b2ShapeArrCreated.i(1000)
Global Dim b2BodyPtrArr.l(1000)
;Global Dim b2BodyDefArr.b2BodyDef(1000)
;Global Dim b2BodyPtrArr.l(1000)
Global Dim pb_b2BodyArrCreated.i(1000)
; ===============================================================================================================================

; #LIBRARIES# ===================================================================================================================
; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================


; #MISCELLANEOUS FUNCTIONS# =====================================================================================================


Procedure _Box2C_b2World_Animate_SFML(text)
  
  ;  _CSFML_sfRenderWindow_clear(window, white)
  _CSFML_sfRenderWindow_clear_rgba(window, 255, 255, 255, 255)
  ;  _CSFML_sfRenderWindow_clear_rgba(window, 0, 0, 0, 255)
    
  _CSFML_sfRenderWindow_drawText(window, text, #Null)

  body_pos.Vec2
  *body_pos_ptr = @body_pos
  body_angle.f
  body_sprite_pos.sfVector2f

  For i = 0 To ArraySize(pb_b2Body_sfSprite())
    
    If pb_b2Body_sfSprite(i)\created = 1
      
      b2body_getposition(pb_b2Body_sfSprite(i)\b2Body, *body_pos_ptr)
      body_angle = b2body_getangle(pb_b2Body_sfSprite(i)\b2Body)
      body_sprite_pos\x = 400 + (body_pos\x * 50)
      body_sprite_pos\y = 300 - (body_pos\y * 50)
      _CSFML_sfSprite_setPosition(pb_b2Body_sfSprite(i)\sfSprite, body_sprite_pos)
      _CSFML_sfSprite_setRotation(pb_b2Body_sfSprite(i)\sfSprite, -Degree(body_angle))
      _CSFML_sfRenderWindow_drawSprite(window, pb_b2Body_sfSprite(i)\sfSprite, #Null)
    EndIf
    
  Next
  
  _CSFML_sfRenderWindow_display(window)

  
EndProcedure
  

Procedure _Box2C_b2Fixture_AddItem_SFML(body_sprite_index.i, shape_texture_index.i, density.f, restitution.f, friction.f)
  
  fixture_ptr.l
  fixture_ptr = b2body_createfixturefromshape(pb_b2Body_sfSprite(body_sprite_index)\b2Body, @pb_b2Shape_sfTexture(shape_texture_index)\b2Shape, density)
  b2fixture_setrestitution(fixture_ptr, restitution)
  b2fixture_setfriction(fixture_ptr, friction)

EndProcedure



Procedure _Box2C_b2Body_sfSprite_AddItem_SFML(type.i, position_x.f, position_y.f, angle.f, linearVelocity_x.f, linearVelocity_y.f, angularVelocity.f, linearDamping.f, angularDamping.f, allowSleep.l, awake.l, fixedRotation.l, bullet.l, active.l, gravityScale.f, shape_texture_index.i, body_origin_x.f, body_origin_y.f)
  
  i.i = 0
  
  While i < 1000 And pb_b2Body_sfSprite(i)\created <> #Null
    
    i = i + 1
  Wend
    
  pb_b2Body_sfSprite(i)\created = 1
  
  ; b2Body stuff
  
  tmpBodyDef.b2BodyDef
  tmpBodyDef\type = type
  tmpBodyDef\position\x = position_x
  tmpBodyDef\position\y = position_y
  tmpBodyDef\angle = angle
  tmpBodyDef\linearVelocity\x = linearVelocity_x
  tmpBodyDef\linearVelocity\y = linearVelocity_y
  tmpBodyDef\angularVelocity = angularVelocity
  tmpBodyDef\linearDamping = linearDamping
  tmpBodyDef\angularDamping = angularDamping
  tmpBodyDef\allowSleep = allowSleep
  tmpBodyDef\awake = awake
  tmpBodyDef\fixedRotation = fixedRotation
  tmpBodyDef\bullet = bullet
  tmpBodyDef\active = active
  tmpBodyDef\userData = 0
  tmpBodyDef\gravityScale = gravityScale
  
  pb_b2Body_sfSprite(i)\b2Body = b2world_createbody(world, @tmpBodyDef)
  b2body_setawake(pb_b2Body_sfSprite(i)\b2Body, 1)
  
  ; sfSprite stuff
  
  
  pb_b2Body_sfSprite(i)\sfSprite = _CSFML_sfSprite_create()
  _CSFML_sfSprite_setTexture(pb_b2Body_sfSprite(i)\sfSprite, pb_b2Shape_sfTexture(shape_texture_index)\sfTexture, 1)
  ground_sprite_origin.sfVector2f
;  ground_sprite_origin\x = 2.5 * 50
;  ground_sprite_origin\y = 0.5 * 50
  ground_sprite_origin\x = body_origin_x * 50
  ground_sprite_origin\y = body_origin_y * 50
  _CSFML_sfSprite_setOrigin(pb_b2Body_sfSprite(i)\sfSprite, ground_sprite_origin)

  
  
  ProcedureReturn i
  
EndProcedure



; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2ShapeArr_AddItem_SFML
; Description ...: 
; Syntax.........: _Box2C_b2ShapeArr_AddItem_SFML
; Parameters ....: 
; Return values .: 
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......: _CSFML_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Procedure _Box2C_b2Shape_sfTexture_AddItem_SFML(m_type.i, m_vertexCount.i, m_vertice0_x.f, m_vertice0_y.f, m_vertice1_x.f, m_vertice1_y.f, m_vertice2_x.f, m_vertice2_y.f, m_vertice3_x.f, m_vertice3_y.f, m_vertice4_x.f, m_vertice4_y.f, m_vertice5_x.f, m_vertice5_y.f, m_vertice6_x.f, m_vertice6_y.f, m_vertice7_x.f, m_vertice7_y.f, texture_filename.s)
  
  i.i = 0
  
  While i < 1000 And pb_b2Shape_sfTexture(i)\created <> #Null
    
    i = i + 1
  Wend
    
  pb_b2Shape_sfTexture(i)\created = 1
  
  ; setup the ground shape
;     groundBox.b2PolygonShapePortable 
  pb_b2Shape_sfTexture(i)\b2Shape\m_type = 1
  pb_b2Shape_sfTexture(i)\b2Shape\m_radius = 0.01
  pb_b2Shape_sfTexture(i)\b2Shape\m_centroid\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_centroid\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[0]\x = m_vertice0_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[0]\y = m_vertice0_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[1]\x = m_vertice1_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[1]\y = m_vertice1_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[2]\x = m_vertice2_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[2]\y = m_vertice2_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[3]\x = m_vertice3_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[3]\y = m_vertice3_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[4]\x = m_vertice4_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[4]\y = m_vertice4_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[5]\x = m_vertice5_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[5]\y = m_vertice5_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[6]\x = m_vertice6_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[6]\y = m_vertice6_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[7]\x = m_vertice7_x
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertice[7]\y = m_vertice7_y
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[0]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[0]\y = -1
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[1]\x = 1
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[1]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[2]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[2]\y = 1
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[3]\x = -1
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[3]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[4]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[4]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[5]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[5]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[6]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[6]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[7]\x = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_normal[7]\y = 0
  pb_b2Shape_sfTexture(i)\b2Shape\m_vertexCount = 4
;     *groundBox_ptr.b2PolygonShapePortable = @groundBox
  
  
  pb_b2Shape_sfTexture(i)\sfTexture = _CSFML_sfTexture_createFromFile(texture_filename, #Null)

  
  
  ProcedureReturn i
  
  
EndProcedure









; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2ShapeArr_AddItem_SFML
; Description ...: 
; Syntax.........: _Box2C_b2ShapeArr_AddItem_SFML
; Parameters ....: 
; Return values .: 
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......: _CSFML_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Procedure _Box2C_b2ShapeArr_AddItem_SFML(m_type.i, m_vertexCount.i, m_vertice0_x.f, m_vertice0_y.f, m_vertice1_x.f, m_vertice1_y.f, m_vertice2_x.f, m_vertice2_y.f, m_vertice3_x.f, m_vertice3_y.f, m_vertice4_x.f, m_vertice4_y.f, m_vertice5_x.f, m_vertice5_y.f, m_vertice6_x.f, m_vertice6_y.f, m_vertice7_x.f, m_vertice7_y.f)
  
  i.i = 0
  
  While i < 1000 And pb_b2ShapeArrCreated(i) <> #Null
    
    i = i + 1
  Wend
    
  pb_b2ShapeArrCreated(i) = 1
  
  ; setup the ground shape
;     groundBox.b2PolygonShapePortable 
  b2ShapeArr(i)\m_type = 1
  b2ShapeArr(i)\m_radius = 0.01
  b2ShapeArr(i)\m_centroid\x = 0
  b2ShapeArr(i)\m_centroid\y = 0
  b2ShapeArr(i)\m_vertice[0]\x = m_vertice0_x
  b2ShapeArr(i)\m_vertice[0]\y = m_vertice0_y
  b2ShapeArr(i)\m_vertice[1]\x = m_vertice1_x
  b2ShapeArr(i)\m_vertice[1]\y = m_vertice1_y
  b2ShapeArr(i)\m_vertice[2]\x = m_vertice2_x
  b2ShapeArr(i)\m_vertice[2]\y = m_vertice2_y
  b2ShapeArr(i)\m_vertice[3]\x = m_vertice3_x
  b2ShapeArr(i)\m_vertice[3]\y = m_vertice3_y
  b2ShapeArr(i)\m_vertice[4]\x = m_vertice4_x
  b2ShapeArr(i)\m_vertice[4]\y = m_vertice4_y
  b2ShapeArr(i)\m_vertice[5]\x = m_vertice5_x
  b2ShapeArr(i)\m_vertice[5]\y = m_vertice5_y
  b2ShapeArr(i)\m_vertice[6]\x = m_vertice6_x
  b2ShapeArr(i)\m_vertice[6]\y = m_vertice6_y
  b2ShapeArr(i)\m_vertice[7]\x = m_vertice7_x
  b2ShapeArr(i)\m_vertice[7]\y = m_vertice7_y
  b2ShapeArr(i)\m_normal[0]\x = 0
  b2ShapeArr(i)\m_normal[0]\y = -1
  b2ShapeArr(i)\m_normal[1]\x = 1
  b2ShapeArr(i)\m_normal[1]\y = 0
  b2ShapeArr(i)\m_normal[2]\x = 0
  b2ShapeArr(i)\m_normal[2]\y = 1
  b2ShapeArr(i)\m_normal[3]\x = -1
  b2ShapeArr(i)\m_normal[3]\y = 0
  b2ShapeArr(i)\m_normal[4]\x = 0
  b2ShapeArr(i)\m_normal[4]\y = 0
  b2ShapeArr(i)\m_normal[5]\x = 0
  b2ShapeArr(i)\m_normal[5]\y = 0
  b2ShapeArr(i)\m_normal[6]\x = 0
  b2ShapeArr(i)\m_normal[6]\y = 0
  b2ShapeArr(i)\m_normal[7]\x = 0
  b2ShapeArr(i)\m_normal[7]\y = 0
  b2ShapeArr(i)\m_vertexCount = 4
;     *groundBox_ptr.b2PolygonShapePortable = @groundBox

  ProcedureReturn i
  
  
EndProcedure


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2ShapeArr_AddItem_SFML
; Description ...: 
; Syntax.........: _Box2C_b2ShapeArr_AddItem_SFML
; Parameters ....: 
; Return values .: 
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......: _CSFML_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Procedure _Box2C_b2BodyArr_AddItem_SFML(type.i, position_x.f, position_y.f, angle.f, linearVelocity_x.f, linearVelocity_y.f, angularVelocity.f, linearDamping.f, angularDamping.f, allowSleep.l, awake.l, fixedRotation.l, bullet.l, active.l, gravityScale.f)
  
  i.i = 0
  
  While i < 1000 And pb_b2BodyArrCreated(i) <> #Null
    
    i = i + 1
  Wend
    
  pb_b2BodyArrCreated(i) = 1
  
  groundBodyDef.b2BodyDef
  groundBodyDef\type = type
  groundBodyDef\position\x = position_x
  groundBodyDef\position\y = position_y
  groundBodyDef\angle = angle
  groundBodyDef\linearVelocity\x = linearVelocity_x
  groundBodyDef\linearVelocity\y = linearVelocity_y
  groundBodyDef\angularVelocity = angularVelocity
  groundBodyDef\linearDamping = linearDamping
  groundBodyDef\angularDamping = angularDamping
  groundBodyDef\allowSleep = allowSleep
  groundBodyDef\awake = awake
  groundBodyDef\fixedRotation = fixedRotation
  groundBodyDef\bullet = bullet
  groundBodyDef\active = active
  groundBodyDef\userData = 0
  groundBodyDef\gravityScale = gravityScale
  ;*groundBodyDef_ptr.b2BodyDef = @groundBodyDef
  
  ; setup the ground body
;  groundBody.i
  b2BodyPtrArr(i) = b2world_createbody(world, @groundBodyDef)
  b2body_setawake(b2BodyPtrArr(i), 1)
  
  ProcedureReturn i

  
EndProcedure

; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 92
; FirstLine = 75
; Folding = --
; EnableUnicode
; EnableXP