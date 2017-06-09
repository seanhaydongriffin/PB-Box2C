
Structure Vec2
  x.f
  y.f 
EndStructure

;PrototypeC.i Protob2world_constructor(*gravity, doSleep.l)
PrototypeC.i Protob2world_constructor(*gravity.Vec2, doSleep.l)
;PrototypeC.i Protob2world_constructor(*gravity, doSleep.l)
;PrototypeC.i Protob2world_constructor(*gravity, doSleep.l)

PrototypeC.i Protofb_b2world_constructor(*gravity.Vec2)



If OpenLibrary(0, "fb_box2c.dll")
  
  b2world_constructor.Protob2world_constructor = GetFunction(0, "b2world_constructor")
  fb_b2world_constructor.Protofb_b2world_constructor = GetFunction(0, "fb_b2world_constructor")
  b2world_createbody.Protob2world_createbody = GetFunction(0, "b2world_createbody")
  b2body_setawake.Protob2body_setawake = GetFunction(0, "b2body_setawake")
  b2body_createfixturefromshape.Protob2body_createfixturefromshape = GetFunction(0, "b2body_createfixturefromshape")
  b2world_step.Protob2world_step = GetFunction(0, "b2world_step")
  b2body_getposition.Protob2body_getposition = GetFunction(0, "b2body_getposition")
  b2world_setgravity.Protob2world_setgravity = GetFunction(0, "b2world_setgravity")
  b2world_getgravity.Protob2world_getgravity = GetFunction(0, "b2world_getgravity")
  
  Global gravity.Vec2
  gravity\x = 0.0
  gravity\y = -10.0
  
  Define.i *p = AllocateMemory(SizeOf(Vec2))
  CopyStructure(@gravity, *p, Vec2)
  
  *gravity_ptr.Vec2 = @gravity
  
 ; Debug(@p\y)
  
  world.i
  world = b2world_constructor(p, 1)
 ; world = b2world_constructor(@gravity, 1)
 ; fb_b2world_constructor(1)
  
  ;PrintN(Str(world))
  Debug(world)
  
 ; b2world_setgravity(world, *gravity_ptr)
 ; b2world_setgravity(world, *p)
  
 ; gravity.Vec2 = b2world_getgravity(world)
  
  ;groundBodyDef.b2BodyDef
  ;groundBodyDef\type = 0
  ;groundBodyDef\position\x = 0
  ;groundBodyDef\position\y = -10
  ;groundBodyDef\angle = 0
  ;groundBodyDef\linearVelocity\x = 0
  ;groundBodyDef\linearVelocity\y = 0
  ;groundBodyDef\angularVelocity = 0
  ;groundBodyDef\linearDamping = 0
  ;groundBodyDef\angularDamping = 0
  ;groundBodyDef\allowSleep = 1
  ;groundBodyDef\awake = 1
  ;groundBodyDef\fixedRotation = 0
  ;groundBodyDef\bullet = 0
  ;groundBodyDef\active = 1
  ;groundBodyDef\userData = 0
  ;groundBodyDef\gravityScale = 1
  ;*groundBodyDef_ptr.b2BodyDef = @groundBodyDef
  
 ; Debug(@groundBodyDef)
 ; Debug(*groundBodyDef_ptr)
  
  
  
 ; PrintN(Str(groundBodyDef_ptr))
  
  ;groundBody.i
  ;groundBody = b2world_createbody(world, *groundBodyDef_ptr)
  ;b2body_setawake(groundBody, 1)
  
  
  
  ;groundBox.b2PolygonShapePortable 
  ;groundBox\m_type = 1
  ;groundBox\m_radius = 0.01
  ;groundBox\m_centroid\x = 0
  ;groundBox\m_centroid\y = 0
  ;groundBox\m_vertice[0]\x = -50
  ;groundBox\m_vertice[0]\y = -10
  ;groundBox\m_vertice[1]\x = 50
  ;groundBox\m_vertice[1]\y = -10
  ;groundBox\m_vertice[2]\x = 50
  ;groundBox\m_vertice[2]\y = 10
  ;groundBox\m_vertice[3]\x = -50
  ;groundBox\m_vertice[3]\y = 10
  ;groundBox\m_vertice[4]\x = 0
  ;groundBox\m_vertice[4]\y = 0
  ;groundBox\m_vertice[5]\x = 0
  ;groundBox\m_vertice[5]\y = 0
  ;groundBox\m_vertice[6]\x = 0
  ;groundBox\m_vertice[6]\y = 0
  ;groundBox\m_vertice[7]\x = 0
  ;groundBox\m_vertice[7]\y = 0
  ;groundBox\m_normal[0]\x = 0
  ;groundBox\m_normal[0]\y = -1
  ;groundBox\m_normal[1]\x = 1
  ;groundBox\m_normal[1]\y = 0
  ;groundBox\m_normal[2]\x = 0
  ;groundBox\m_normal[2]\y = 1
  ;groundBox\m_normal[3]\x = -1
  ;groundBox\m_normal[3]\y = 0
  ;groundBox\m_normal[4]\x = 0
  ;groundBox\m_normal[4]\y = 0
  ;groundBox\m_normal[5]\x = 0
  ;groundBox\m_normal[5]\y = 0
  ;groundBox\m_normal[6]\x = 0
  ;groundBox\m_normal[6]\y = 0
  ;groundBox\m_normal[7]\x = 0
  ;groundBox\m_normal[7]\y = 0
  ;groundBox\m_vertexCount = 4
  ;*groundBox_ptr.b2PolygonShapePortable = @groundBox
  
  ;groundBodyFixture_ptr.i
  ;groundBodyFixture_ptr = b2body_createfixturefromshape(groundBody, *groundBox_ptr, 0)
  
  
  bodyDef.b2BodyDef
  bodyDef\type = 2
  bodyDef\position\x = 0
  bodyDef\position\y = 4
  bodyDef\angle = 0
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
  
  body.i
  body = b2world_createbody(world, *bodyDef_ptr)
  b2body_setawake(body, 1)
  
    
  dynamicBox.b2PolygonShapePortable 
  dynamicBox\m_type = 1
  dynamicBox\m_radius = 0.01
  dynamicBox\m_centroid\x = 0
  dynamicBox\m_centroid\y = 0
  dynamicBox\m_vertice[0]\x = -1
  dynamicBox\m_vertice[0]\y = -1
  dynamicBox\m_vertice[1]\x = 1
  dynamicBox\m_vertice[1]\y = -1
  dynamicBox\m_vertice[2]\x = 1
  dynamicBox\m_vertice[2]\y = 1
  dynamicBox\m_vertice[3]\x = -1
  dynamicBox\m_vertice[3]\y = 1
  dynamicBox\m_vertice[4]\x = 0
  dynamicBox\m_vertice[4]\y = 0
  dynamicBox\m_vertice[5]\x = 0
  dynamicBox\m_vertice[5]\y = 0
  dynamicBox\m_vertice[6]\x = 0
  dynamicBox\m_vertice[6]\y = 0
  dynamicBox\m_vertice[7]\x = 0
  dynamicBox\m_vertice[7]\y = 0
  dynamicBox\m_normal[0]\x = 0
  dynamicBox\m_normal[0]\y = -1
  dynamicBox\m_normal[1]\x = 1
  dynamicBox\m_normal[1]\y = 0
  dynamicBox\m_normal[2]\x = 0
  dynamicBox\m_normal[2]\y = 1
  dynamicBox\m_normal[3]\x = -1
  dynamicBox\m_normal[3]\y = 0
  dynamicBox\m_normal[4]\x = 0
  dynamicBox\m_normal[4]\y = 0
  dynamicBox\m_normal[5]\x = 0
  dynamicBox\m_normal[5]\y = 0
  dynamicBox\m_normal[6]\x = 0
  dynamicBox\m_normal[6]\y = 0
  dynamicBox\m_normal[7]\x = 0
  dynamicBox\m_normal[7]\y = 0
  dynamicBox\m_vertexCount = 4
  *dynamicBox_ptr.b2PolygonShapePortable = @dynamicBox

  ;bodyFixture_ptr.i
  ;bodyFixture_ptr = b2body_createfixturefromshape(body, *dynamicBox_ptr, 1)

  position.Vec2
  *position_ptr = @position
  
  For i = 1 To 60
    
    b2world_step(world, (1.0 / 60.0), 6, 2)
    
    b2body_getposition(body, *position_ptr)
    
    Debug (position\y)
    
  Next
  
    
    
  
  ;  Input()
  
  EndIf
  
EndIf

; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 11
; EnableUnicode
; EnableXP