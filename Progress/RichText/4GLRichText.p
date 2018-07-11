DEFINE VARIABLE SpecimenInfo AS CHARACTER NO-UNDO INITIAL ?.
DEFINE VARIABLE SpecimenInfo2 AS CHARACTER NO-UNDO INITIAL ?.

CURRENT-WINDOW:WIDTH = 320.
CURRENT-WINDOW:HEIGHT = 45.

DEFINE FRAME DLG_Frame WITH SIZE 300 BY 15.

FORM
    SpecimenInfo
        FORMAT "X(240)":U
        VIEW-AS EDITOR
        SIZE 300 BY 4
        AT COL 2 ROW 2
        NO-LABEL

        SpecimenInfo2
        FORMAT "X(240)":U
        VIEW-AS EDITOR
        SIZE 300 BY 4
        AT COL 2 ROW 2
        NO-LABEL
    WITH FRAME DLG_Frame.

SpecimenInfo:LARGE = YES.
SpecimenInfo:SENSITIVE = YES.
FRAME DLG_Frame:VISIBLE = YES.

SpecimenInfo:SCREEN-VALUE = "~{\rtf\ansi\deff0~{\fonttbl~{\f0\froman Tms Rmn;}~{\f1\fdecor Symbol;}~{\f2\fswiss Helv;}}~{\colortbl;\red0\green0\blue0;\red0\green0\blue255;\red0\green255\blue255;\red0\green255\blue0;\red255\green0\blue255;\red255\green0\blue0;\red255\green255\blue0;\red255\green255\blue255;} \pard \plain \fs20 \cf2 This is \cf3 plain text.\par}".
SpecimenInfo2:SCREEN-VALUE = "SpecimenInfo 2".
MESSAGE "SpecimenInfo:LARGE" SpecimenInfo:LARGE VIEW-AS ALERT-BOX.

WAIT-FOR WINDOW-CLOSE OF FRAME DLG_Frame.
