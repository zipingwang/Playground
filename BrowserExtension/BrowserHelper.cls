 /* Copyright ©2017 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

 /*------------------------------------------------------------------------
    File        : BrowserHelper
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon Mar 06 16:54:50 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.UltraWinGrid.ColumnsCollection FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.UltraGridColumn FROM ASSEMBLY.
USING Progress.Lang.Object FROM PROPATH.
USING System.Windows.Forms.DataFormats FROM ASSEMBLY.
USING System.Windows.Forms.DragDropEffects FROM ASSEMBLY.
USING System.Windows.Forms.DragEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.FormClosingEventArgs FROM ASSEMBLY.
USING Playground.BrowserExtension.SimpleStringEventArgs FROM PROPATH.
USING Playground.BrowserExtension.BrowserHelper FROM PROPATH.

CLASS Playground.BrowserExtension.BrowserHelper FINAL:

    {tt_GridLayout.i}

    DEFINE PUBLIC EVENT FileDropped SIGNATURE VOID (sender AS Object, e AS SimpleStringEventArgs).

    /*****************************************************************************/

    METHOD PUBLIC VOID  SaveGridLayout(UltraGrid AS UltraGrid):

        SaveGridLayout(UltraGrid, UltraGrid:FindForm():Name, UltraGrid:Name).

    END METHOD.

    /*****************************************************************************/

     METHOD PUBLIC VOID  SaveGridLayout(UltraGrid AS UltraGrid, Context_ AS CHARACTER, Name_ AS CHARACTER):

        DEFINE VARIABLE JSONString AS LONGCHAR NO-UNDO.

        DEFINE BUFFER wb_GridLayout FOR w_GridLayout.

        /* --------------------------------------------------------------------- */

        EMPTY TEMP-TABLE w_GridLayout.

        {Consultingwerk/foreach.i UltraGridColumn TheUltraGridColumn in UltraGrid:DisplayLayout:Bands[0]:Columns}
            CREATE wb_GridLayout.
            ASSIGN
                wb_GridLayout.gl_Key = TheUltraGridColumn:Key
                wb_GridLayout.gl_VisiblePosition = TheUltraGridColumn:Header:VisiblePosition
                wb_GridLayout.gl_Hidden = TheUltraGridColumn:Hidden
                wb_GridLayout.gl_Width = TheUltraGridColumn:Width.
        END.

        TEMP-TABLE w_GridLayout:WRITE-JSON("LONGCHAR":U, JSONString).

        RUN gp_slprf(Context_ /* Context */, Name_ /* PreferenceName */, JSONString).

    END METHOD.

    /*****************************************************************************/

     METHOD PUBLIC VOID ApplySavedGridLayout(TheColumnsCollection AS ColumnsCollection, Context AS CHARACTER):

       ApplySavedGridLayout(TheColumnsCollection, Context, "GridLayout":U).

    END METHOD.

    /*****************************************************************************/

    METHOD PUBLIC VOID ApplySavedGridLayout(TheColumnsCollection AS ColumnsCollection, Context AS CHARACTER, Name_ AS CHARACTER):

        DEFINE VARIABLE JSONString AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE TheUltraGridColumn AS UltraGridColumn NO-UNDO.

        DEFINE BUFFER wb_GridLayout FOR w_GridLayout.

        /* -------------------------------------------------------------------- */

        RUN gp_glprf(Context /* Context */, Name_ /* PreferenceName */, OUTPUT JSONString).

        TEMP-TABLE w_GridLayout:READ-JSON("LONGCHAR":U, JSONString, "EMPTY":U).

        FOR EACH wb_GridLayout:
            IF TheColumnsCollection:Exists(wb_GridLayout.gl_Key)
            THEN ASSIGN
                    TheUltraGridColumn = TheColumnsCollection[wb_GridLayout.gl_Key]
                    TheUltraGridColumn:Header:VisiblePosition = wb_GridLayout.gl_VisiblePosition
                    TheUltraGridColumn:Hidden = wb_GridLayout.gl_Hidden
                    TheUltraGridColumn:Width = wb_GridLayout.gl_Width.
        END.

        CATCH err AS Progress.Lang.Error:
            IF err:GetMessageNum(1) = 15360 /* Error parsing JSON: unexpected token: <token>. (15360) */
            THEN MESSAGE err:GetMessage(1) VIEW-AS ALERT-BOX ERROR. /* Show error message and use the default layout */
            ELSE UNDO, THROW err.
        END CATCH.

    END METHOD.

    /*****************************************************************************/

     METHOD PUBLIC VOID ApplySavedGridLayout(UltraGrid AS UltraGrid):

        UltraGrid:SuspendLayout().
        ApplySavedGridLayout(UltraGrid:DisplayLayout:Bands[0]:Columns, UltraGrid:FindForm():Name, UltraGrid:Name).
        UltraGrid:ResumeLayout().

    END METHOD.

    /*****************************************************************************/
/*
    METHOD PUBLIC VOID InitializeLogicalColumns(UltraGrid AS UltraGrid):

        DEFINE VARIABLE TheUltraGridColumn AS UltraGridColumn NO-UNDO.

        UltraGrid:SuspendLayout().

        DEFINE VARIABLE ColumnIndex AS INTEGER.
        DO ColumnIndex = 0 TO UltraGrid:DisplayLayout:Bands[0]:Columns:Count - 1:

            TheUltraGridColumn = UltraGrid:DisplayLayout:Bands[0]:Columns[ColumnIndex].

            IF TheUltraGridColumn:DataType = Progress.Util.TypeHelper:GetType("System.Boolean":U)
            THEN DO:
                TheUltraGridColumn:EditorComponent = be.mips.ablframework.gui.CheckBoxFactory:PositiveCheckBox.
                TheUltraGridColumn:SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator:Disabled.
           END.
       END.

       UltraGrid:ResumeLayout(FALSE).

    END METHOD.
*/
    /*****************************************************************************/

    METHOD PUBLIC VOID AddDropFileFeature(UltraGrid AS UltraGrid):

        UltraGrid:AllowDrop = YES.
        UltraGrid:DragEnter:SUBSCRIBE(THIS-OBJECT:UltraGrid_DragEnter).
        UltraGrid:DragDrop:SUBSCRIBE(THIS-OBJECT:UltraGrid_DragDrop).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID UltraGrid_DragEnter(sender AS Object, e AS DragEventArgs):

        If e:Data:GetDataPresent(DataFormats:FileDrop)
        Then e:Effect = DragDropEffects:Copy.

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID UltraGrid_DragDrop(sender AS Object, e AS DragEventArgs):

        DEFINE VARIABLE Files AS "System.String[]":U NO-UNDO.
        DEFINE VARIABLE Count AS INTEGER NO-UNDO.
        DEFINE VARIABLE FilesAsString AS CHARACTER NO-UNDO INITIAL "":U.

        Files = CAST(e:Data:GetData(DataFormats:FileDrop), "System.String[]":U).

        DO COUNT = 0 TO Files:LENGTH - 1:

            IF FilesAsString <> "":U
            THEN FilesAsString = FilesAsString + ",":U.

            FilesAsString = FilesAsString + Files:GetValue(COUNT):ToString().

        END.

        if(FilesAsString <> ?)
        THEN FileDropped:Publish(THIS-OBJECT, NEW SimpleStringEventArgs(FilesAsString)).

    END METHOD.

END CLASS.
