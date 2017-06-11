
XIncludeFile "Box2C.pbi"


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
; ===============================================================================================================================

; #GLOBALS# ===================================================================================================================
Global Dim b2ShapeArr.b2PolygonShapePortable(1000)
Global Dim pb_b2ShapeArrCreated.i(1000)
; ===============================================================================================================================

; #LIBRARIES# ===================================================================================================================
; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================


; #MISCELLANEOUS FUNCTIONS# =====================================================================================================


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


; IDE Options = PureBasic 5.40 LTS (Windows - x86)
; CursorPosition = 99
; FirstLine = 72
; Folding = -
; EnableUnicode
; EnableXP