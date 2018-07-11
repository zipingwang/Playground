example. "in order entry, requerst code is material which it has varialbes, on save order entry, get popup screaan to fill varialbes"
spmv_edt.p
/*design UI, dynamic add widget, dynamic adjust frame height, call gp_dlg*/

FORM .... "here DEFINE your widget" WITH FRAME xxx.

/*dynamic create widget*/
CREATE FILL-IN ExtraInfoWidget
            ASSIGN
                FRAME = FRAME DLG_Frame:HANDLE
                FGCOLOR = {&FillinForeGround}
                BGCOLOR = {&FillinBackGround}
                SUBTYPE = "NATIVE":U
                ROW = NextRow
                COLUMN = 57
                WIDTH-CHARS = { gp_wsys.i 17 80 }
                FORMAT = "X(255)":U
                VISIBLE = YES.
 
/*when create a widget in frame, the size of frame should be adjusted*/                
FRAME DLG_Frame:HEIGHT-CHARS =
                    FRAME DLG_Frame:HEIGHT-CHARS +
                    ChoiceWidget:HEIGHT-CHARS + RowSkip
/*
FRAME has also  VIRTUAL-HEIGHT-CHARS, it IS the whole HEIGHT including NOT visiable part, WHEN HEIGHT-CHARS IS smaller then
VIRTUAL-HEIGHT-CHARS, a SCROLL bar will appear.*/
/*For a non-scrollable frame, VIRTUAL-HEIGHT-CHARS has the same value as the HEIGHT-CHARS attribute. 
For a scrollable frame, VIRTUAL-HEIGHT-CHARS specifies the height of the entire frame while HEIGHT-CHARS specifies the height of the visible portion of the frame. */
FRAME DLG_Frame:HEIGHT-PIXELS    
FRAME DLG_Frame:VIRTUAL-HEIGHT-PIXELS               
FRAME DLG_Frame:VIRTUAL-HEIGHT-CHARS =
                                               

RUN gp_dlg PERSISTENT SET GenericDialog(THIS-PROCEDURE, THIS-PROCEDURE,
    ParentProcedure, FRAME DLG_Frame:HANDLE, "Specimen variables":T60,
    ?, "OK":T12, ?, ?, YES /*modal or not(only in current workflow form)*/, "Initialize":U, "Externalize":U, ?, "CleanUp":U,
    "OnGo":U, "OnEndKey":U).