
 /*------------------------------------------------------------------------
    File        : ResultListEntryForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : lievendf
    Created     : Tue Feb 27 15:30:57 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Windows.Form FROM ASSEMBLY.
USING System.EventArgs FROM ASSEMBLY.
USING System.Object FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.test.ResultListEntryForm INHERITS Form:

    DEFINE PRIVATE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE DeleteRecordButton AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE FillTempTableButton AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE InsertRecordButton AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE OpenQueryButton AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraGrid AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE QueryHandle AS HANDLE NO-UNDO.
    DEFINE PRIVATE VARIABLE NextId AS INTEGER NO-UNDO.

    DEFINE PRIVATE TEMP-TABLE w_Order NO-UNDO
        FIELD Id AS INTEGER        
        INDEX Id IS PRIMARY UNIQUE Id.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC ResultListEntryForm():

        InitializeComponent().
        ComponentsCollection:Add(components).

        Initialize().

    END CONSTRUCTOR.

    /*****************************************************************************/

    @VisualDesigner.
    METHOD PRIVATE VOID DeleteRecordButton_Click(sender AS Object, e AS EventArgs):

        DeleteRecord().

    END METHOD.

    /*****************************************************************************/

    @VisualDesigner.
    METHOD PRIVATE VOID FillTempTableButton_Click(sender AS Object, e AS EventArgs):

        FillTempTable().
        OpenQuery().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID Initialize():

        CreateQuery().
        OpenQuery(). /* Needed before linking with BindingSource */
        BindingSource:HANDLE = QueryHandle.

    END METHOD. /* Initialize */

    /*****************************************************************************/

    METHOD PRIVATE VOID CreateQuery():

        CREATE QUERY QueryHandle.
        QueryHandle:SET-BUFFERS(BUFFER w_Order:HANDLE).

    END METHOD. /* CreateQuery */

    /*****************************************************************************/

    METHOD PRIVATE VOID FillTempTable():

        CreateOrder().
        CreateOrder().
        CreateOrder().

    END METHOD. /* FillTempTable */

    /*****************************************************************************/

    METHOD PRIVATE VOID CreateOrder():

        DEFINE BUFFER wb_Order FOR w_Order.

        /* --------------------------------------------------------------------- */

        CREATE wb_Order.
        ASSIGN wb_Order.Id = NextId().

    END METHOD. /* CreateOrder */

    /*****************************************************************************/

    @VisualDesigner.
    METHOD PRIVATE VOID InsertRecordButton_Click(sender AS Object, e AS EventArgs):

        AddRecord().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID OpenQuery():

        QueryHandle:QUERY-PREPARE("PRESELECT EACH w_Order":U).
        QueryHandle:QUERY-OPEN().

    END METHOD. /* OpenQuery */

    /*****************************************************************************/

    METHOD PRIVATE VOID AddRecord():

        CreateOrder().
        FIND LAST w_Order.
        QueryHandle:CREATE-RESULT-LIST-ENTRY().
        BindingSource:RefreshAll().

    END METHOD. /* AddRecord */

    /*****************************************************************************/

    METHOD PRIVATE VOID DeleteRecord():

        IF AVAILABLE w_Order
        THEN DO:
            QueryHandle:DELETE-RESULT-LIST-ENTRY().
            DELETE w_Order.
            BindingSource:RefreshAll().
        END.

    END METHOD. /* DeleteRecord */

    /*****************************************************************************/

    METHOD PRIVATE VOID InitializeComponent():

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        THIS-OBJECT:UltraGrid = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:BindingSource = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:OpenQueryButton = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:InsertRecordButton = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:FillTempTableButton = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:DeleteRecordButton = NEW Infragistics.Win.Misc.UltraButton().
        CAST(THIS-OBJECT:UltraGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:BindingSource, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* UltraGrid */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraGrid:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraGrid:DataSource = THIS-OBJECT:BindingSource.
        THIS-OBJECT:UltraGrid:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:UltraGrid:Name = "UltraGrid":U.
        THIS-OBJECT:UltraGrid:Size = NEW System.Drawing.Size(652, 266).
        THIS-OBJECT:UltraGrid:TabIndex = 0.
        THIS-OBJECT:UltraGrid:Text = "UltraGrid":U.
        /*  */
        /* BindingSource */
        /*  */
        THIS-OBJECT:BindingSource:MaxDataGuess = 0.
        THIS-OBJECT:BindingSource:NoLOBs = FALSE.
        THIS-OBJECT:BindingSource:TableSchema = ?.
        /*  */
        /* OpenQueryButton */
        /*  */
        THIS-OBJECT:OpenQueryButton:Location = NEW System.Drawing.Point(145, 272).
        THIS-OBJECT:OpenQueryButton:Name = "OpenQueryButton":U.
        THIS-OBJECT:OpenQueryButton:Size = NEW System.Drawing.Size(127, 23).
        THIS-OBJECT:OpenQueryButton:TabIndex = 1.
        THIS-OBJECT:OpenQueryButton:Text = "OpenQuery":U.
        THIS-OBJECT:OpenQueryButton:Click:Subscribe(THIS-OBJECT:ultraButton1_Click).
        /*  */
        /* InsertRecordButton */
        /*  */
        THIS-OBJECT:InsertRecordButton:Location = NEW System.Drawing.Point(278, 272).
        THIS-OBJECT:InsertRecordButton:Name = "InsertRecordButton":U.
        THIS-OBJECT:InsertRecordButton:Size = NEW System.Drawing.Size(135, 23).
        THIS-OBJECT:InsertRecordButton:TabIndex = 2.
        THIS-OBJECT:InsertRecordButton:Text = "CreateRecord":U.
        THIS-OBJECT:InsertRecordButton:Click:Subscribe(THIS-OBJECT:InsertRecordButton_Click).
        /*  */
        /* FillTempTableButton */
        /*  */
        THIS-OBJECT:FillTempTableButton:Location = NEW System.Drawing.Point(12, 272).
        THIS-OBJECT:FillTempTableButton:Name = "FillTempTableButton":U.
        THIS-OBJECT:FillTempTableButton:Size = NEW System.Drawing.Size(127, 23).
        THIS-OBJECT:FillTempTableButton:TabIndex = 3.
        THIS-OBJECT:FillTempTableButton:Text = "FillTempTable":U.
        THIS-OBJECT:FillTempTableButton:Click:Subscribe(THIS-OBJECT:FillTempTableButton_Click).
        /*  */
        /* DeleteRecordButton */
        /*  */
        THIS-OBJECT:DeleteRecordButton:Location = NEW System.Drawing.Point(419, 272).
        THIS-OBJECT:DeleteRecordButton:Name = "DeleteRecordButton":U.
        THIS-OBJECT:DeleteRecordButton:Size = NEW System.Drawing.Size(135, 23).
        THIS-OBJECT:DeleteRecordButton:TabIndex = 4.
        THIS-OBJECT:DeleteRecordButton:Text = "DeleteRecord":U.
        THIS-OBJECT:DeleteRecordButton:Click:Subscribe(THIS-OBJECT:DeleteRecordButton_Click).
        /*  */
        /* ResultListEntryForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(652, 333).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:DeleteRecordButton).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:FillTempTableButton).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:InsertRecordButton).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:OpenQueryButton).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:UltraGrid).
        THIS-OBJECT:Name = "ResultListEntryForm":U.
        THIS-OBJECT:Text = "ResultListEntryForm":U.
        CAST(THIS-OBJECT:UltraGrid, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:BindingSource, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*****************************************************************************/

    @VisualDesigner.
    METHOD PRIVATE VOID ultraButton1_Click(sender AS Object, e AS EventArgs):

        OpenQuery().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE INTEGER NextId():

        ASSIGN NextId = NextId + 1.

        RETURN NextId.

    END METHOD. /* NextId */

END CLASS.
