 /* Copyright ©2017 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

 /*------------------------------------------------------------------------
    File        : BrowserFastPositionHelper
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Mar 07 09:34:04 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.
USING Progress.Lang.Object FROM PROPATH.
USING System.EventArgs FROM ASSEMBLY.
USING System.Windows.Forms.Control FROM ASSEMBLY.
USING System.Windows.Forms.KeyEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.KeyPressEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.Keys FROM ASSEMBLY.
USING System.Windows.Forms.Timer FROM ASSEMBLY.
USING be.mips.ablframework.gui.FastPositionTextEditor FROM PROPATH.
USING be.mips.ablframework.gui.components.widget.FastPositionTextWidget FROM PROPATH.
USING Playground.BrowserExtension.SimpleStringEventArgs FROM PROPATH.
USING Playground.BrowserExtension.SearchDataSourceOrigin FROM PROPATH.

CLASS Playground.BrowserExtension.BrowserFastPositionHelper:

    DEFINE PRIVATE VARIABLE FastPositionTimer AS Timer NO-UNDO.
    DEFINE PRIVATE VARIABLE FastPositionTextField AS FastPositionTextEditor NO-UNDO.
    DEFINE VARIABLE FastPositionCharDownAction AS CHARACTER NO-UNDO.
    DEFINE VARIABLE UltraGrid AS UltraGrid NO-UNDO.
    DEFINE VARIABLE UseDefaultSearchMethod AS SearchDataSourceOrigin NO-UNDO.
    DEFINE VARIABLE WaitingTimeForTriggerSearch AS INTEGER NO-UNDO INITIAL 750.
    DEFINE VARIABLE IsBusyWithSearching AS LOGICAL NO-UNDO.

    DEFINE PUBLIC EVENT RequestSerch SIGNATURE VOID (sender AS Object, e AS SimpleStringEventArgs).

    /*****************************************************************************/

    DEFINE PUBLIC PROPERTY FastPositionTextWidget AS FastPositionTextWidget NO-UNDO
    GET.
    SET.

    DEFINE PRIVATE PROPERTY HasSortedColumn AS LOGICAL NO-UNDO
    GET:
        RETURN UltraGrid:DisplayLayout:Bands[0]:SortedColumns:Count > 0.
    END GET.
    SET.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddFastPostionAbilityToBrowser(UltraGrid AS UltraGrid, UseDefaultSearchMethod AS SearchDataSourceOrigin):

        AddFastPostionAbilityToBrowser(UltraGrid, UseDefaultSearchMethod, THIS-OBJECT:WaitingTimeForTriggerSearch).

    END METHOD.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddFastPostionAbilityToBrowser(UltraGrid_ AS UltraGrid, UseDefaultSearchMethod AS SearchDataSourceOrigin, WaitingTimeForTriggerSearch AS INTEGER):

        THIS-OBJECT:UltraGrid = UltraGrid_.
        UltraGrid:KeyDown:SubScribe(THIS-OBJECT:Browser_KeyDown).
        UltraGrid:KeyPress:Subscribe(THIS-OBJECT:Browser_KeyPressed).
        UltraGrid:AfterRowActivate:Subscribe(Browser_AfterRowActivate).
        FastPositionTextWidget = NEW FastPositionTextWidget().
        FastPositionTextWidget:VISIBLE = NO.

        THIS-OBJECT:UseDefaultSearchMethod = UseDefaultSearchMethod.
        THIS-OBJECT:WaitingTimeForTriggerSearch = WaitingTimeForTriggerSearch.

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID Browser_AfterRowActivate(sender AS System.Object, e AS System.EventArgs):

        IF VALID-OBJECT(FastPositionTextField) AND IsBusyWithSearching = NO
        THEN FastPositionTextField:ResetText().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID Browser_KeyPressed(sender AS System.Object, e AS KeyPressEventArgs):

         IF NOT HasSortedColumn
         THEN RETURN.

         IF FastPositionCharDownAction = ?
         THEN FastPositionTextField:AddCharAction(e:KeyChar).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID Browser_KeyDown(sender AS System.Object, e AS KeyEventArgs):

        IF NOT HasSortedColumn
        THEN RETURN.

        IF NOT VALID-OBJECT(THIS-OBJECT:FastPositionTextField)
            AND NOT e:Modifiers:Equals(Keys:Control) AND NOT e:KEYCODE = KeyS:Up
            AND NOT e:KEYCODE = KeyS:Down
        THEN InitializeFastPositioningControls(CAST(sender, Control)).

        ASSIGN FastPositionCharDownAction = ?.
        IF VALID-OBJECT(FastPositionTextField)
        THEN DO:
            CASE TRUE:
                WHEN e:KeyCode:Equals(Keys:Back)
                THEN ASSIGN FastPositionCharDownAction = "BACK":U.
                WHEN e:KeyCode:Equals(Keys:Enter) OR e:KeyCode:Equals(Keys:Return)
                THEN DO:
                    DoFastPosition().
                    RETURN.
                END.
                WHEN e:KeyCode:Equals(Keys:Space) OR WHEN e:KeyCode:Equals(Keys:Tab)
                    OR WHEN e:Modifiers:Equals(Keys:Control) OR WHEN e:Modifiers:Equals(KEYS:Up)
                    OR WHEN e:Modifiers:Equals(KEYS:Down)
                    OR WHEN e:KEYCODE = KEYS:Down
                    OR WHEN e:KEYCODE = KEYS:UP
                THEN ASSIGN FastPositionCharDownAction = "IGNORE":U.
                /* Use forward slash as space, as in Glims 8 (since spacebar selects row) */
                WHEN e:KeyCode:Equals(Keys:Divide)
                THEN ASSIGN FastPositionCharDownAction = " ":U.
            END CASE.
        END.

        IF FastPositionCharDownAction <> ? AND FastPositionCharDownAction <> "IGNORE"
        THEN FastPositionTextField:AddCharAction(FastPositionCharDownAction).

        IF VALID-OBJECT(FastPositionTextField) AND FastPositionCharDownAction <> "IGNORE"
        THEN FastPositionTextField:VISIBLE = YES.

        IF VALID-OBJECT(FastPositionTimer)
        THEN DO:
            FastPositionTimer:Stop().
            FastPositionTimer:Start().
        END.

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID FastPositionTimer_Tick(sender AS System.Object, e AS System.EventArgs):

        DoFastPosition().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID DoFastPosition():

        FastPositionTimer:Stop().
        FastPositionTextField:VISIBLE = NO.

        IF UltraGrid:DisplayLayout:Bands[0]:SortedColumns:Count > 0
        THEN DO:
            UltraGrid:DisplayLayout:Bands[0]:SortedColumns[0]:Header:Appearance:BackColor =
                UltraGrid:DisplayLayout:Override:HeaderAppearance:BackColor.
        END.

        LocateSearchRow().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID LocateSearchRow():

        DEFINE VARIABLE ColumnName AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIndex AS INTEGER NO-UNDO.
        DEFINE VARIABLE ColumnIndex AS INTEGER NO-UNDO.
        DEFINE VARIABLE Found AS LOGICAL NO-UNDO INITIAL NO.

        IF Trim(FastPositionTextField:TEXT) = ""
        THEN RETURN.

        ASSIGN IsBusyWithSearching = YES.

        IF UseDefaultSearchMethod = SearchDataSourceOrigin:Database
        THEN
             RequestSerch:Publish(THIS-OBJECT, NEW SimpleStringEventArgs(FastPositionTextField:Text)).
        ELSE DO:
            ASSIGN ColumnName = UltraGrid:DisplayLayout:Bands[0]:SortedColumns[0]:Key.

            /*deselect all*/
            DO RowIndex = 0 TO UltraGrid:Rows:Count - 1 :
                UltraGrid:Rows[RowIndex]:Selected = FALSE.
            END.

            DO RowIndex = 0 TO UltraGrid:Rows:Count - 1 :

                IF UltraGrid:Rows[RowIndex]:Cells[ColumnName]:Text BEGINS FastPositionTextField:TEXT
                THEN DO:
                    UltraGrid:Rows[RowIndex]:Selected = TRUE.
                    UltraGrid:Rows[RowIndex]:Activate().
                    Found = YES.
                    LEAVE.
                END.
            END.

            IF Found = NO
            THEN FastPositionTextWidget:TheSearchText = SUBSTITUTE("&1 &2":U, FastPositionTextWidget:TheSearchText, "not found":U).
        END.

        FINALLY:
            ASSIGN IsBusyWithSearching = NO.
        END.
    END METHOD.

    /*****************************************************************************/

    METHOD PROTECTED VOID InitializeFastPositioningControls(ParentControl AS Control):

        IF NOT VALID-OBJECT(THIS-OBJECT:FastPositionTextField)
        THEN DO:

            FastPositionTimer = NEW Timer().
            FastPositionTimer:Interval = THIS-OBJECT:WaitingTimeForTriggerSearch.
            FastPositionTimer:Enabled = TRUE.
            FastPositionTimer:Tick:Subscribe(THIS-OBJECT:FastPositionTimer_Tick).

            ParentControl:SuspendLayout().

            THIS-OBJECT:FastPositionTextField = NEW be.mips.ablframework.gui.FastPositionTextEditor().
            THIS-OBJECT:FastPositionTextField:Dock = System.Windows.Forms.DockStyle:None.
            THIS-OBJECT:FastPositionTextField:VisibleChanged:Subscribe(FastPositionTextField_VisibleChanged).
            THIS-OBJECT:FastPositionTextField:TextChanged:Subscribe(FastPositionTextField_TextChanged).

            ParentControl:Controls:Add(FastPositionTextField).

            ASSIGN
                THIS-OBJECT:FastPositionTextField:Width = ParentControl:Size:Width * 0.62 /* Golden mean. :) */
                THIS-OBJECT:FastPositionTextField:Location = NEW System.Drawing.Point(
                    INTEGER((ParentControl:Size:Width - THIS-OBJECT:FastPositionTextField:Width) / 2),
                    INTEGER((ParentControl:Size:Height - THIS-OBJECT:FastPositionTextField:Height) / 2)).

            THIS-OBJECT:FastPositionTextField:Visible = NO.

            ParentControl:ResumeLayout().

        END.

    END METHOD.

    /*****************************************************************************/

    METHOD VOID FastPositionTextField_VisibleChanged(sender AS Object, e AS EventArgs):

        IF FastPositionTextField:Visible
        THEN FastPositionTextField:ResetText().

    END METHOD.

    /*****************************************************************************/

    METHOD VOID FastPositionTextField_TextChanged(sender AS Object, e AS EventArgs):

        IF UltraGrid:DisplayLayout:Bands[0]:SortedColumns:Count > 0
        THEN DO:
            UltraGrid:DisplayLayout:Bands[0]:SortedColumns[0]:Header:Appearance:BackColor =
                FastPositionTextField:Appearance:BorderColor.
        END.

        IF FastPositionTextField:Visible
        THEN FastPositionTextWidget:TheSearchText = SUBSTITUTE("Search text '&1'":U, FastPositionTextField:TEXT).

        FastPositionTextWidget:VISIBLE = FastPositionTextField:TEXT <> "":U.

        IF FastPositionTextField:VISIBLE
        THEN FastPositionTextWidget:BringToFront().

    END METHOD.

    /*****************************************************************************/

END CLASS.
