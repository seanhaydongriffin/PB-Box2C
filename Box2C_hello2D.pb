
Structure Vec2 Align #PB_Structure_AlignC
  x.f
  y.f 
EndStructure

Structure b2BodyDef Align #PB_Structure_AlignC
    type.i
    position.Vec2
    angle.f
    linearVelocity.Vec2
    angularVelocity.f
    linearDamping.f
    angularDamping.f
    allowSleep.l
    awake.l
    fixedRotation.l
    bullet.l
    active.l
    *userData
    gravityScale.f
EndStructure


Structure b2PolygonShapePortable Align #PB_Structure_AlignC
    m_type.i
    m_radius.f
    m_centroid.Vec2
    m_vertice.Vec2[8]
    m_normal.Vec2[8]
    m_vertexCount.i
EndStructure


OpenConsole()


; a box2c wrapper, built in freebasic, that works around the feature gap in purebasic for passing structures by value
;   and retrieving structures by value

If OpenLibrary(0, "Box2C.dll") And OpenLibrary(1, "fb_box2c.dll")
        
  ; freebasic wrapped library declarations
  PrototypeC Protofb_b2world_constructor(*world)
  fb_b2world_constructor.Protofb_b2world_constructor = GetFunction(1, "fb_b2world_constructor")
  
  ; direct box2c library declarations
  ;PrototypeC.i Protob2world_constructor(*gravity.Vec2, doSleep.l)
  PrototypeC.i Protob2world_createbody(*world, *bodyDef)
  b2world_createbody.Protob2world_createbody = GetFunction(0, "b2world_createbody")
  PrototypeC Protob2body_setawake(*body, vec.l)
  b2body_setawake.Protob2body_setawake = GetFunction(0, "b2body_setawake")
  PrototypeC.i Protob2body_createfixturefromshape(*body, *shape, density.f)
  b2body_createfixturefromshape.Protob2body_createfixturefromshape = GetFunction(0, "b2body_createfixturefromshape")
  PrototypeC Protob2world_step(*world, hz.f, velocityIterations.i, positionIterations.i)
  b2world_step.Protob2world_step = GetFunction(0, "b2world_step")
  PrototypeC Protob2body_getposition(*body, *outPtr.Vec2)
  b2body_getposition.Protob2body_getposition = GetFunction(0, "b2body_getposition")
  PrototypeC Protob2world_setgravity(*world, *gravity.Vec2)
  b2world_setgravity.Protob2world_setgravity = GetFunction(0, "b2world_setgravity")
  PrototypeC.l Protob2world_getgravity(*world)
  b2world_getgravity.Protob2world_getgravity = GetFunction(0, "b2world_getgravity")

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
  groundBodyDef\position\y = -10
  groundBodyDef\angle = 0
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
  groundBox.b2PolygonShapePortable 
  groundBox\m_type = 1
  groundBox\m_radius = 0.01
  groundBox\m_centroid\x = 0
  groundBox\m_centroid\y = 0
  groundBox\m_vertice[0]\x = -50
  groundBox\m_vertice[0]\y = -10
  groundBox\m_vertice[1]\x = 50
  groundBox\m_vertice[1]\y = -10
  groundBox\m_vertice[2]\x = 50
  groundBox\m_vertice[2]\y = 10
  groundBox\m_vertice[3]\x = -50
  groundBox\m_vertice[3]\y = 10
  groundBox\m_vertice[4]\x = 0
  groundBox\m_vertice[4]\y = 0
  groundBox\m_vertice[5]\x = 0
  groundBox\m_vertice[5]\y = 0
  groundBox\m_vertice[6]\x = 0
  groundBox\m_vertice[6]\y = 0
  groundBox\m_vertice[7]\x = 0
  groundBox\m_vertice[7]\y = 0
  groundBox\m_normal[0]\x = 0
  groundBox\m_normal[0]\y = -1
  groundBox\m_normal[1]\x = 1
  groundBox\m_normal[1]\y = 0
  groundBox\m_normal[2]\x = 0
  groundBox\m_normal[2]\y = 1
  groundBox\m_normal[3]\x = -1
  groundBox\m_normal[3]\y = 0
  groundBox\m_normal[4]\x = 0
  groundBox\m_normal[4]\y = 0
  groundBox\m_normal[5]\x = 0
  groundBox\m_normal[5]\y = 0
  groundBox\m_normal[6]\x = 0
  groundBox\m_normal[6]\y = 0
  groundBox\m_normal[7]\x = 0
  groundBox\m_normal[7]\y = 0
  groundBox\m_vertexCount = 4
  *groundBox_ptr.b2PolygonShapePortable = @groundBox
  
  ; setup the ground fixture
  groundBodyFixture_ptr.i
  groundBodyFixture_ptr = b2body_createfixturefromshape(groundBody, *groundBox_ptr, 0)
  
  ; setup the body definition
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
  
  ; setup the body body
  body.i
  body = b2world_createbody(world, *bodyDef_ptr)
  b2body_setawake(body, 1)
  
  ; setup the body shape
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

  ; setup the body fixture
  bodyFixture_ptr.i
  bodyFixture_ptr = b2body_createfixturefromshape(body, *dynamicBox_ptr, 1)

  position.Vec2
  *position_ptr = @position
  
  output.s
  
  ; animate the world
  For i = 1 To 60
    
    b2world_step(world, (1.0 / 60.0), 6, 2)
    
    b2body_getposition(body, *position_ptr)
    
 ;   Debug (position\y)
    PrintN(StrF(position\y))
    
  Next
  
  Input()

  
EndIf

CloseLibrary(1)
CloseLibrary(0)

; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 1
; EnableUnicode
; EnableXP
; Executable = Box2C_hello2D.exe