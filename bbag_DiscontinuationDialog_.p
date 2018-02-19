/* Copyright ©2011 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

/*+
.TH $RCSfile$ 3 MIPS
.SH Name
$RCSfile$ - Bloodbag discontinuation dialog screen
.SH Databases referenced
glims
.SH Author
Olivier Rombauts
.SH Creation date
15-Nov-11 17:00
.SH Version
$Revision$ $Date$
-*/

{ ui_bbag.i }
{ en_bbag.i }

DEFINE INPUT PARAMETER ParentHandle AS HANDLE NO-UNDO.
DEFINE OUTPUT PARAMETER DiscontinuationType AS INTEGER NO-UNDO INITIAL {&BloodbagDiscontinuationTypeOther}.
DEFINE OUTPUT PARAMETER DiscontinuationReason AS CHARACTER NO-UNDO INITIAL ?.

&IF "{&WINDOW-SYSTEM}" <> "TTY"
&THEN

DEFINE VARIABLE GenericDialog AS HANDLE NO-UNDO.

DEFINE VARIABLE SccsId AS CHARACTER NO-UNDO INITIAL "$Id$":U.
DEFINE VARIABLE DialogTitle AS CHARACTER NO-UNDO INITIAL "Confirm discontinuation":L40.

{ gp_dlg.i &ViewAsDialogBox=NO }

DEFINE RECTANGLE CommentBox
    SIZE-CHARS { gp_wsys.i "78 BY 10" "112 BY 12.5" }
    GRAPHIC-EDGE NO-FILL EDGE-PIXELS 2.

FORM
    DiscontinuationType
        COLON 35
        LABEL {&bbag_DiscontinuationTypeSideLabel}
        VIEW-AS RADIO-SET SIZE 40 BY {&BloodbagDiscontinuationTypeNumEntries}
            RADIO-BUTTONS
            "":U, 1
    SKIP(0.1)
    DiscontinuationReason
        COLON 35
        {&bbag_DiscontinuationReasonDefaults}
    SKIP ({&FrameBottomSpacing})
    WITH FRAME DLG_Frame
        CENTERED OVERLAY.

MESSAGE DialogTitle VIEW-AS ALERT-BOX.
RUN gp_dlg PERSISTENT SET GenericDialog(THIS-PROCEDURE, THIS-PROCEDURE, ParentHandle, FRAME DLG_Frame:HANDLE,
    DialogTitle, ? /* FirstBottomButton */, "OK":T12, ?, ?, YES /* Modal */, "Initialize":U, "Externalize":U,
    ? /* DispatchProcedure */, ? /* StartMode */, "OnGo":U, ?).

/*****************************************************************************/

PROCEDURE Initialize:

    DEFINE OUTPUT PARAMETER Proceed AS LOGICAL NO-UNDO INITIAL YES.

    DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.

    /* --------------------------------------------------------------------- */

    DO WITH FRAME DLG_Frame:
        RUN DeclareEditor IN GenericDialog(DiscontinuationReason:HANDLE, 0, YES, NO).
        RUN DeclareWidget IN GenericDialog(DiscontinuationType:HANDLE, 0, YES).
        RUN gp_setrb(DiscontinuationType:HANDLE, {&BloodbagDiscontinuationTypeValueList}, ?).
    END.

END PROCEDURE. /* Initialize */

/*****************************************************************************/

PROCEDURE Externalize:

    DEFINE BUFFER b_QCPopulation FOR QCPopulation.

    /* --------------------------------------------------------------------- */

    DO WITH FRAME DLG_Frame:
        DISPLAY
            DiscontinuationReason
            DiscontinuationType.
    END.

END PROCEDURE. /* Externalize */

/*****************************************************************************/

PROCEDURE OnGo:

    DEFINE OUTPUT PARAMETER CloseFrame AS LOGICAL INITIAL YES.

    /* --------------------------------------------------------------------- */

    DO WITH FRAME DLG_Frame:
        ASSIGN
            DiscontinuationReason
            DiscontinuationType.
        IF DiscontinuationType = {&BloodbagDiscontinuationTypeOther}
        THEN DO:
            IF DiscontinuationReason = "":U OR DiscontinuationReason = ?
            THEN DO:
                RUN gp_sherr("GP$ValueRequired":U, SUBSTITUTE("&1 (&2=&3)":U,
                    {&bbag_DiscontinuationReasonColumnLabel}, {&bbag_DiscontinuationTypeColumnLabel},
                    ENTRY({&BloodbagDiscontinuationTypeOther}, {&BloodbagDiscontinuationTypeValueList}))).
                ASSIGN CloseFrame = NO.
            END.
        END.
        ELSE ASSIGN DiscontinuationReason = ENTRY(DiscontinuationType, {&BloodBagDiscontinuationTypeValueList})
                WHEN DiscontinuationReason = "" OR DiscontinuationReason = ?.
    END.

END PROCEDURE. /* OnGo */

&ENDIF
