/* Copyright ©1995 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

/*+
.TH $RCSfile$ 3 MIPS
.SH Name
$RCSfile$ - Debug Set break point
.SH Syntax
RUN $RCSfile$(CallerHandle).
.SH Parameters
.SH Assumptions
.SH Description
.SH Examples
.SH Databases referenced

.SH Author
Carl Verbiest
.SH Creation date
23-Nov-96 18:30
.SH Version
$Revision$ $Date$
-*/

DEFINE INPUT PARAMETER Parent AS HANDLE.
{ gp_dlg.i
    &ViewAsDialogBox=FALSE
}

DEFINE VARIABLE SccsId AS CHARACTER NO-UNDO INITIAL "$Id$":U.

DEFINE VARIABLE ProcedureName AS CHARACTER NO-UNDO.

//DEFINE VARIABLE GenericDialog AS HANDLE NO-UNDO.

DEFINE VARIABLE LineNumber AS INTEGER NO-UNDO INITIAL 0.

DEFINE NEW SHARED VARIABLE s_Character AS CHARACTER NO-UNDO.
DEFINE NEW SHARED VARIABLE s_Integer AS INTEGER NO-UNDO.

FORM
    ProcedureName
        FORMAT "X(12)":U
        LABEL "Break in":R20
    LineNumber
        FORMAT ">>>>>9":U
        LABEL "at line":R20
        SKIP(1)
    WITH FRAME DLG_Frame.

/* ------------------------------------------------------------------------- */

RUN GetPreferences.

RUN gp_dlg PERSISTENT SET GenericDialog(THIS-PROCEDURE, THIS-PROCEDURE,
    Parent, FRAME DLG_Frame:HANDLE, "Set break point":T75, ?, "OK":U, ?,
    ?, NO, "Initialize":U, "Externalize":U, ?, ?, "OnGo":U, ?).

/*****************************************************************************/

PROCEDURE Initialize:

    DEFINE OUTPUT PARAMETER Proceed AS LOGICAL INITIAL YES.

    /* --------------------------------------------------------------------- */

    DO WITH FRAME DLG_Frame:
        RUN DeclareWidget IN GenericDialog(ProcedureName:HANDLE, 0, TRUE).
        RUN DeclareWidget IN GenericDialog(LineNumber:HANDLE, 0, TRUE).
    END.

END PROCEDURE. /* Initialize */

/****************************************************************************/

PROCEDURE Externalize:

    /* ---------------------------------------------------------------------- */

    DISPLAY
        ProcedureName
        LineNumber
    WITH FRAME DLG_Frame.

END PROCEDURE. /* Externalize */

/****************************************************************************/

PROCEDURE GetPreferences:

    DEFINE VARIABLE ValueTagList AS CHARACTER NO-UNDO.

    /* ---------------------------------------------------------------------- */

    RUN gp_gpref("dg_sdeb":U, "Values":U, OUTPUT ValueTagList).

    IF ValueTagList = ? THEN RETURN.

    CALL gp_ExtractTagCharacter ValueTagList "ProcedureName":U "s_Character":U.
    ASSIGN ProcedureName = s_Character.
    CALL gp_ExtractTagInteger ValueTagList "LineNumber":U "s_Integer":U.
    ASSIGN LineNumber = IF s_Integer <> ? THEN s_Integer ELSE 1.

END PROCEDURE. /* GetPreferences */

/*****************************************************************************/

PROCEDURE OnGo:

    DEFINE OUTPUT PARAMETER CloseFrame AS LOGICAL INITIAL FALSE.

    DEFINE VARIABLE Success AS LOGICAL NO-UNDO.
    DEFINE VARIABLE ValueTagList AS CHARACTER NO-UNDO.

    /* --------------------------------------------------------------------- */

    DO WITH FRAME DLG_Frame:
        ASSIGN
            ProcedureName
            LineNumber.
    END.

    IF LineNumber < 0
    THEN DO:
        RUN DLG_SetFocusByHandle(LineNumber:HANDLE IN FRAME DLG_Frame).
        MESSAGE "Line number should be >= 0":T75 VIEW-AS ALERT-BOX ERROR.
        RETURN.
    END.
    ASSIGN Success = DEBUGGER:INITIATE().
    IF NOT Success 
    THEN DO:
        MESSAGE "Debugger initiate failed":T75 SKIP ERROR-STATUS:GET-MESSAGE(1)
            VIEW-AS ALERT-BOX ERROR.
        RETURN.
    END.
ASSIGN ProcedureName = 'bbag_DiscontinuationDialog'.
    ASSIGN Success = DEBUGGER:SET-BREAK(ProcedureName, LineNumber).
    IF NOT Success 
    THEN DO:
        RUN DLG_SetFocusByHandle(ProcedureName:HANDLE IN FRAME DLG_Frame).
        MESSAGE "Set breakpoint failed":T75 SKIP ERROR-STATUS:GET-MESSAGE(1)
            VIEW-AS ALERT-BOX ERROR.
        ASSIGN CloseFrame = FALSE.
        RETURN.
    END.

    ASSIGN
        CloseFrame = TRUE
        DEBUGGER:VISIBLE = TRUE
        ValueTagList = SUBSTITUTE("ProcedureName=&1\\LineNumber=&2\\":U,
            ProcedureName, LineNumber).
    RUN gp_spref("dg_sdeb":U, "Values":U, ValueTagList).

    MESSAGE SUBSTITUTE("Break point set in &1 at line &2":T75, ProcedureName, 
        LineNumber) VIEW-AS ALERT-BOX INFORMATION.

END PROCEDURE. /* OnGo */
