
 /*------------------------------------------------------------------------
    File        : FrmLogin
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 11:34:01 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.FrmLogin INHERITS Progress.Windows.Form:

    DEFINE PRIVATE VARIABLE btnOk AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnCancel AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel2 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE txtPassword AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE txtName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.


    CONSTRUCTOR PUBLIC FrmLogin():
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnOk_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:OK.

    END METHOD.


    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel2 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:btnOk = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:txtName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:txtPassword = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:btnCancel = NEW Infragistics.Win.Misc.UltraButton().
        CAST(THIS-OBJECT:txtName, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtPassword, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraLabel1 */
        /*  */
        appearance1:TextHAlignAsString = "Right":U.
        THIS-OBJECT:ultraLabel1:Appearance = appearance1.
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(8, 29).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1":U.
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 0.
        THIS-OBJECT:ultraLabel1:Text = "Name":U.
        /*  */
        /* ultraLabel2 */
        /*  */
        appearance2:TextHAlignAsString = "Right":U.
        THIS-OBJECT:ultraLabel2:Appearance = appearance2.
        THIS-OBJECT:ultraLabel2:Location = NEW System.Drawing.Point(8, 75).
        THIS-OBJECT:ultraLabel2:Name = "ultraLabel2":U.
        THIS-OBJECT:ultraLabel2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel2:TabIndex = 1.
        THIS-OBJECT:ultraLabel2:Text = "Password":U.
        /*  */
        /* btnOk */
        /*  */
        THIS-OBJECT:btnOk:Location = NEW System.Drawing.Point(114, 119).
        THIS-OBJECT:btnOk:Name = "btnOk":U.
        THIS-OBJECT:btnOk:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnOk:TabIndex = 2.
        THIS-OBJECT:btnOk:Text = "Ok":U.
        THIS-OBJECT:btnOk:Click:Subscribe(THIS-OBJECT:btnOk_Click).
        /*  */
        /* txtName */
        /*  */
        THIS-OBJECT:txtName:Location = NEW System.Drawing.Point(114, 25).
        THIS-OBJECT:txtName:Name = "txtName":U.
        THIS-OBJECT:txtName:Size = NEW System.Drawing.Size(174, 21).
        THIS-OBJECT:txtName:TabIndex = 3.
        /*  */
        /* txtPassword */
        /*  */
        THIS-OBJECT:txtPassword:Location = NEW System.Drawing.Point(114, 71).
        THIS-OBJECT:txtPassword:Name = "txtPassword":U.
        THIS-OBJECT:txtPassword:PasswordChar = '*':U.
        THIS-OBJECT:txtPassword:Size = NEW System.Drawing.Size(174, 21).
        THIS-OBJECT:txtPassword:TabIndex = 4.
        /*  */
        /* btnCancel */
        /*  */
        THIS-OBJECT:btnCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        THIS-OBJECT:btnCancel:Location = NEW System.Drawing.Point(213, 119).
        THIS-OBJECT:btnCancel:Name = "btnCancel":U.
        THIS-OBJECT:btnCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnCancel:TabIndex = 5.
        THIS-OBJECT:btnCancel:Text = "Cancel":U.
        /*  */
        /* FrmLogin */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:btnOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:btnCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(342, 170).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnCancel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtPassword).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtName).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnOk).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraLabel2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:None.
        THIS-OBJECT:Name = "FrmLogin":U.
        THIS-OBJECT:Text = "FrmLogin":U.
        CAST(THIS-OBJECT:txtName, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtPassword, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC FrmLogin ( ):

    END DESTRUCTOR.

END CLASS.
