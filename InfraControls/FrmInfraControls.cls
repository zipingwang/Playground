 
 /*------------------------------------------------------------------------
    File        : FrmInfraControls
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Wed Aug 29 15:40:50 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.InfraControls.FrmInfraControls INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox3 AS Mips.InfraControls.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox2 AS Mips.InfraControls.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS Mips.InfraControls.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditor3 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditor2 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditor1 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.

        
    CONSTRUCTOR PUBLIC FrmInfraControls (  ):
        
        
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:textBox1 = NEW Mips.InfraControls.TextBox().
        THIS-OBJECT:textBox2 = NEW Mips.InfraControls.TextBox().
        THIS-OBJECT:textBox3 = NEW Mips.InfraControls.TextBox().
        THIS-OBJECT:ultraTextEditor1 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraTextEditor2 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraTextEditor3 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        CAST(THIS-OBJECT:textBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:textBox2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:textBox3, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTextEditor1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTextEditor3, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:AblValue = "":U.
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(23, 12).
        THIS-OBJECT:textBox1:Name = "textBox1":U.
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:textBox1:TabIndex = 0.
        /*  */
        /* textBox2 */
        /*  */
        THIS-OBJECT:textBox2:AblValue = "":U.
        THIS-OBJECT:textBox2:Location = NEW System.Drawing.Point(23, 50).
        THIS-OBJECT:textBox2:Name = "textBox2":U.
        THIS-OBJECT:textBox2:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:textBox2:TabIndex = 1.
        /*  */
        /* textBox3 */
        /*  */
        THIS-OBJECT:textBox3:AblValue = "":U.
        THIS-OBJECT:textBox3:Location = NEW System.Drawing.Point(23, 97).
        THIS-OBJECT:textBox3:Name = "textBox3":U.
        THIS-OBJECT:textBox3:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:textBox3:TabIndex = 2.
        /*  */
        /* ultraTextEditor1 */
        /*  */
        THIS-OBJECT:ultraTextEditor1:Location = NEW System.Drawing.Point(189, 11).
        THIS-OBJECT:ultraTextEditor1:Name = "ultraTextEditor1":U.
        THIS-OBJECT:ultraTextEditor1:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor1:TabIndex = 3.
        /*  */
        /* ultraTextEditor2 */
        /*  */
        THIS-OBJECT:ultraTextEditor2:Location = NEW System.Drawing.Point(189, 50).
        THIS-OBJECT:ultraTextEditor2:Name = "ultraTextEditor2":U.
        THIS-OBJECT:ultraTextEditor2:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor2:TabIndex = 4.
        /*  */
        /* ultraTextEditor3 */
        /*  */
        THIS-OBJECT:ultraTextEditor3:Location = NEW System.Drawing.Point(189, 97).
        THIS-OBJECT:ultraTextEditor3:Name = "ultraTextEditor3":U.
        THIS-OBJECT:ultraTextEditor3:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor3:TabIndex = 5.
        /*  */
        /* FrmInfraControls */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(341, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraTextEditor3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraTextEditor2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraTextEditor1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Name = "FrmInfraControls":U.
        THIS-OBJECT:Text = "FrmInfraControls":U.
        CAST(THIS-OBJECT:textBox1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:textBox2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:textBox3, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTextEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTextEditor3, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC FrmInfraControls ( ):

    END DESTRUCTOR.

END CLASS.