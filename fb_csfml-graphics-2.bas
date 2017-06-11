#inclib "csfml-graphics"
#include once "windows.bi"

' create this as a DLL with:
'   "\Program Files (x86)\FreeBASIC\fbc.exe" -dll fb_csfml-graphics-2.bas

type sfVideoMode
    width2 As uinteger
    height2 As uinteger
    bitsPerPixel2 As uinteger
end type

type sfColor
    r as ubyte
    g as ubyte
    b as ubyte
    a as ubyte
end type

type sfVector2f
    x as Single
    y as Single
end type


'Declare Function b2world_constructor cdecl Alias "b2world_constructor" (byval gravity As Vec2, byval doSleep as Boolean) As integer Ptr
Declare Function sfRenderWindow_create cdecl Alias "sfRenderWindow_create" (byval mode As sfVideoMode, byval title as ZString ptr, byval style as uinteger, byval settings as long ptr) As Long ptr
Declare Sub sfRenderWindow_clear cdecl Alias "sfRenderWindow_clear" (byval renderWindow As Long Ptr, byval color2 as sfColor)
Declare Sub sfSprite_setPosition cdecl Alias "sfSprite_setPosition" (byval sprite as long ptr, byval position as sfVector2f)
Declare Sub sfSprite_setOrigin cdecl Alias "sfSprite_setOrigin" (byval sprite as long ptr, byval origin as sfVector2f)
Declare Sub sfText_setPosition cdecl Alias "sfText_setPosition" (byval text as long ptr, byval position as sfVector2f)


'Public Function fb_sfRenderWindow_create cdecl Alias "fb_sfRenderWindow_create" (byval width2 As uinteger, byval height2 As uinteger, byval bitsPerPixel2 As uinteger, byval title as zstring ptr, byval style as uinteger, byval settings as long ptr) As Long ptr Export
Public Function fb_sfRenderWindow_create cdecl Alias "fb_sfRenderWindow_create" (byval mode as sfVideoMode ptr, byval title as zstring ptr, byval style as uinteger, byval settings as long ptr) As Long ptr Export


 '   dim as sfVideoMode mode => (width2, height2, bitsPerPixel2)
    
'    dim mode as sfVideoMode
'    mode.width2 = 800
'    mode.height2 = 600
'    mode.bitsPerPixel2 = 16

 '   dim title as string
 '   title = "ddd"
    
 '   dim style as uinteger
 '   style = 6
    
 '   dim settings as long ptr
 '   settings = 0
    
    Dim As Long Ptr fred = sfRenderWindow_create (*mode, title, style, settings)
    return(fred)
End Function

Public Sub fb_sfRenderWindow_clear cdecl Alias "fb_sfRenderWindow_clear" (byval renderWindow As Long Ptr, byval color2 as sfColor ptr) Export

    sfRenderWindow_clear (renderWindow, *color2)

End Sub

Public Sub fb_sfRenderWindow_clear_rgba cdecl Alias "fb_sfRenderWindow_clear_rgba" (byval renderWindow As Long Ptr, byval red2 as uinteger, byval green2 as uinteger, byval blue2 as uinteger, byval alpha2 as uinteger) Export

    dim as sfColor color2 => (red2, green2, blue2, alpha2)
    sfRenderWindow_clear (renderWindow, color2)

End Sub

Public Sub fb_sfSprite_setOrigin cdecl Alias "fb_sfSprite_setOrigin" (byval sprite as long ptr, byval origin as sfVector2f ptr) Export

    sfSprite_setOrigin (sprite, *origin)
End Sub

Public Sub fb_sfSprite_setPosition cdecl Alias "fb_sfSprite_setPosition" (byval sprite as long ptr, byval position as sfVector2f ptr) Export

    sfSprite_setPosition (sprite, *position)
End Sub

Public Sub fb_sfText_setPosition cdecl Alias "fb_sfText_setPosition" (byval text as long ptr, byval position as sfVector2f ptr) Export

    sfText_setPosition (text, *position)
End Sub
