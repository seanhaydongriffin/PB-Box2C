


; #INDEX# =======================================================================================================================
; Title .........: Box2C
; FreeBasic Version : ?
; Language ......: English
; Description ...: Box2C Functions.
; Author(s) .....: Sean Griffin
; Dlls ..........: csfml-system-2.dll, csfml-graphics-2.dll
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
#__epsilon = 0.00001
; ===============================================================================================================================

; #ENUMERATIONS# ===================================================================================================================
Enumeration Box2C_b2Shape_m_type
    #Box2C_e_circle
    #Box2C_e_edge
    #Box2C_e_polygon
    #Box2C_e_chain
    #Box2C_e_typeCount
EndEnumeration

Enumeration Box2C_b2Body_type
    #Box2C_b2_staticBody
    #Box2C_b2_kinematicBody
    #Box2C_b2_dynamicBody
EndEnumeration
; ===============================================================================================================================


; #STRUCTURES# ===================================================================================================================
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
; ===============================================================================================================================

; #GLOBALS# ===================================================================================================================
;Global sfBool.i
; ===============================================================================================================================

; #LIBRARIES# ===================================================================================================================
OpenLibrary(0, "Box2C.dll")
OpenLibrary(1, "fb_box2c.dll")
; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================


; #MISCELLANEOUS FUNCTIONS# =====================================================================================================


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_Startup
; Description ...: 
; Syntax.........: _Box2C_Startup
; Parameters ....: 
; Return values .: 
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......: _CSFML_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Procedure _Box2C_Startup()



EndProcedure

; #FUNCTION# ====================================================================================================================
; Name...........: _CSFML_Shutdown
; Description ...: Unloads the CSFML DLLs
; Syntax.........: _CSFML_Shutdown()
; Parameters ....:
; Return values .: None
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......: _CSFML_Startup
; Link ..........:
; Example .......:
; ===============================================================================================================================
Procedure _Box2C_Shutdown()

  ; unload the DLLs
  CloseLibrary(1)
  CloseLibrary(0)

EndProcedure


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2World_Constructor
; Description ...: Constructs a b2World structure.
; Syntax.........: _Box2C_b2World_Constructor($gravity, $doSleep)
; Parameters ....: $gravity - gravity
;				   $doSleep - ?
; Return values .: Success - a pointer (PTR) to the b2World structure (PTR).
;				   Failure - 0
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protofb_b2world_constructor(*world)
Global fb_b2world_constructor.Protofb_b2world_constructor = GetFunction(1, "fb_b2world_constructor")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2World_CreateBody
; Description ...: Creates a body in a world from a body definition
; Syntax.........: _Box2C_b2World_CreateBody($world_ptr, $bodyDef_ptr)
; Parameters ....: $world_ptr - a pointer (PTR) to the world (b2World) to create the body within
;				   $bodyDef_ptr - a pointer (PTR) to the definition of the body (b2BodyDef)
; Return values .: Success - a pointer (PTR) to the body (b2Body) structure (STRUCT)
;				   Failure - 0
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.i Protob2world_createbody(*world, *bodyDef)
Global b2world_createbody.Protob2world_createbody = GetFunction(0, "b2world_createbody")

; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_SetAwake
; Description ...: Sets the awake state of a body (b2Body)
; Syntax.........: _Box2C_b2Body_SetAwake($body_ptr, $awake)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
;				   $awake - True for awake, False for sleep
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2body_setawake(*body, vec.l)
Global b2body_setawake.Protob2body_setawake = GetFunction(0, "b2body_setawake")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2World_CreateFixtureFromShape
; Description ...: Creates a fixture for a shape and body combination
; Syntax.........: _Box2C_b2World_CreateFixtureFromShape($body_ptr, $shape_ptr, $density)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
;				   $shape_ptr - a pointer to the shape (b2...)
;				   $density -
; Return values .: Success - a pointer (PTR) to the fixture (b2Fixture) structure
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.i Protob2body_createfixturefromshape(*body, *shape, density.f)
Global b2body_createfixturefromshape.Protob2body_createfixturefromshape = GetFunction(0, "b2body_createfixturefromshape")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2World_Step
; Description ...: Creates a fixture for a shape and body combination
; Syntax.........: _Box2C_b2World_Step($world_ptr, $timeStep, $velocityIterations, $positionIterations)
; Parameters ....: $world_ptr - a pointer to the body (b2Body)
;				   $timeStep - a pointer to the shape (b2...)
;				   $velocityIterations -
;				   $positionIterations -
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2world_step(*world, hz.f, velocityIterations.i, positionIterations.i)
Global b2world_step.Protob2world_step = GetFunction(0, "b2world_step")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_GetPosition
; Description ...: Gets the position (vector) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_GetPosition($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: A vector (2D element array) of the position of the body (b2Body)
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2body_getposition(*body, *outPtr.Vec2)
Global b2body_getposition.Protob2body_getposition = GetFunction(0, "b2body_getposition")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_GetAngle
; Description ...: Gets the angle (radians) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_GetAngle($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: The angle (radians) of the body (b2Body)
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.f Protob2body_getangle(*body)
Global b2body_getangle.Protob2body_getangle = GetFunction(0, "b2body_getangle")

;Function _Box2C_b2Body_GetAngle(byval body_ptr As long ptr) As single
    
;	Dim As single fred3 = b2body_getangle(body_ptr)
;    print "angle=" & fred3
;	Return fred3
;End function



; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_SetGravity
; Description ...: Gets the position (vector) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_SetGravity($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: A vector (2D element array) of the position of the body (b2Body)
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2world_setgravity(*world, *gravity.Vec2)
Global b2world_setgravity.Protob2world_setgravity = GetFunction(0, "b2world_setgravity")



; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_GetGravity
; Description ...: Gets the position (vector) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_GetGravity($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: A vector (2D element array) of the position of the body (b2Body)
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.l Protob2world_getgravity(*world)
Global b2world_getgravity.Protob2world_getgravity = GetFunction(0, "b2world_getgravity")



; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Fixture_SetRestitution
; Description ...: Sets the restitution of a fixture (b2Fixture)
; Syntax.........: _Box2C_b2Fixture_SetRestitution($fixture_ptr, $value)
; Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
;				   $value - the restitution value
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2fixture_setrestitution(*fixture, value.f)
Global b2fixture_setrestitution.Protob2fixture_setrestitution = GetFunction(0, "b2fixture_setrestitution")
  
;  Sub _Box2C_b2Fixture_SetRestitution(byval fixture_ptr As Long Ptr, byval value As single)
	
;	b2fixture_setrestitution(fixture_ptr, value)
;End Sub


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Fixture_SetFriction
; Description ...: Sets the friction of a fixture (b2Fixture)
; Syntax.........: _Box2C_b2Fixture_SetFriction($fixture_ptr, $value)
; Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
;				   $value - the friction value
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2fixture_setfriction(*fixture, value.f)
Global b2fixture_setfriction.Protob2fixture_setfriction = GetFunction(0, "b2fixture_setfriction")


;Sub _Box2C_b2Fixture_SetFriction(byval fixture_ptr As Long Ptr, byval value As single)
	
;	b2fixture_setfriction(fixture_ptr, value)
;End Sub



; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_GetLinearVelocity
; Description ...: Gets the linear velocity of a body (b2Body)
; Syntax.........: _Box2C_b2Body_GetLinearVelocity($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: Success - the linear velocity as a two dimensional array
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2body_getlinearvelocity(*body, *outPtr.Vec2)
Global b2body_getlinearvelocity.Protob2body_getlinearvelocity = GetFunction(0, "b2body_getlinearvelocity")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_SetLinearVelocity
; Description ...: Sets the velocity (vector) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_SetLinearVelocity($body_ptr, $x, $y)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
;				   $x - the horizontal velocity / vector
;				   $y - the vertical velocity / vector
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protofb_b2body_setlinearvelocity(*sprite, *velocity)
Global fb_b2body_setlinearvelocity.Protofb_b2body_setlinearvelocity = GetFunction(1, "fb_b2body_setlinearvelocity")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_GetAngularVelocity
; Description ...: Gets the angular velocity of a body (b2Body)
; Syntax.........: _Box2C_b2Body_GetAngularVelocity($body_ptr)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
; Return values .: Success - the linear velocity as a two dimensional array
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.f Protob2body_getangularvelocity(*body)
Global b2body_getangularvelocity.Protob2body_getangularvelocity = GetFunction(0, "b2body_getangularvelocity")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_SetAngularVelocity
; Description ...: Sets the angular velocity (radians) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_SetAngularVelocity($body_ptr, $angular_velocity)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
;				   $angular_velocity - the angular velocity (radians)
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2body_setangularvelocity(*body, velocity.f)
Global b2body_setangularvelocity.Protob2body_setangularvelocity = GetFunction(0, "b2body_setangularvelocity")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Body_SetAngle
; Description ...: Sets the angle (radians) of a body (b2Body)
; Syntax.........: _Box2C_b2Body_SetAngle($body_ptr, $angle)
; Parameters ....: $body_ptr - a pointer to the body (b2Body)
;				   $angle - the angle (radians)
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protofb_b2body_settransform(*body, *position, angle.f)
Global fb_b2body_settransform.Protofb_b2body_settransform = GetFunction(1, "fb_b2body_settransform")


; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Fixture_GetDensity
; Description ...: Gets the density of a fixture (b2Fixture)
; Syntax.........: _Box2C_b2Fixture_GetDensity($fixture_ptr)
; Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
; Return values .: Success - the density
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC.f Protob2fixture_getdensity(*fixture)
Global b2fixture_getdensity.Protob2fixture_getdensity = GetFunction(0, "b2fixture_getdensity")

; #FUNCTION# ====================================================================================================================
; Name...........: _Box2C_b2Fixture_SetDensity
; Description ...: Sets the density of a fixture (b2Fixture)
; Syntax.........: _Box2C_b2Fixture_SetDensity($fixture_ptr, $value)
; Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
;				   $value - the density value
; Return values .: Success - True
;				   Failure - False
; Author ........: Sean Griffin
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
PrototypeC Protob2fixture_setdensity(*fixture, value.f)
Global b2fixture_setdensity.Protob2fixture_setdensity = GetFunction(0, "b2fixture_setdensity")


; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 456
; FirstLine = 437
; Folding = -
; EnableUnicode
; EnableXP