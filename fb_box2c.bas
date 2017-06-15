#inclib "Box2C"

' create this as a DLL with:
'   "\Program Files (x86)\FreeBASIC\fbc.exe" -dll fb_box2c.bas


type Vec2
    x as Single
    y as Single
end type


Declare Function b2world_constructor cdecl Alias "b2world_constructor" (byval gravity As Vec2, byval doSleep as Boolean) As integer Ptr
Declare Sub b2body_setlinearvelocity cdecl Alias "b2body_setlinearvelocity" (byval body as Long Ptr, byval velocity as Vec2)
Declare Sub b2body_settransform cdecl Alias "b2body_settransform" (byval body as Long Ptr, byval position as Vec2, byval angle as Single)

'Declare Function fb_b2world_constructor cdecl Alias "fb_b2world_constructor" () As Integer Ptr

'fb_b2world_constructor()

Public Sub fb_b2world_constructor cdecl Alias "fb_b2world_constructor" (byref world as Integer Ptr) Export

    Dim As Vec2 gravity => (0f, -10f)
    world = b2world_constructor(gravity, 1)
  '  Dim As Integer Ptr world_ptr = b2world_constructor(gravity, 1)
 '   dim as integer joe = cast(integer, world_ptr)
 '   print joe
 '   sleep

 ' Return( world_ptr )
End Sub

Public Sub fb_b2body_setlinearvelocity cdecl Alias "fb_b2body_setlinearvelocity" (byval body as Long Ptr, byval velocity as Vec2 ptr) Export

    b2body_setlinearvelocity (body, *velocity)
End Sub

Public Sub fb_b2body_settransform cdecl Alias "fb_b2body_settransform" (byval body as Long Ptr, byval position as Vec2 ptr, byval angle as Single) Export

    b2body_settransform (body, *position, angle)
End Sub



