#inclib "Box2C"


type Vec2
    x as Single
    y as Single
end type


Declare Function b2world_constructor cdecl Alias "b2world_constructor" (byval gravity As Vec2, byval doSleep as Boolean) As integer Ptr

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


