 
 /*------------------------------------------------------------------------
    File        : TestForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Wed Jul 12 16:09:46 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MipsInfraControl.TestForm INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE decimalBox1 AS Mips.InfraControls.DecimalBox NO-UNDO.
    DEFINE PRIVATE VARIABLE relativeDateBox1 AS Mips.InfraControls.RelativeDateBox NO-UNDO.
    DEFINE PRIVATE VARIABLE relativeDateWithTimeBox1 AS Mips.InfraControls.RelativeDateWithTimeBox NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS Mips.InfraControls.TextBox NO-UNDO.

        
    CONSTRUCTOR PUBLIC TestForm (  ):		
        
        SUPER().
        be.mips.ablframework.gui.i18n.MipsInfraContrlResourceCustomizer:InitializeTranslations().
        
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
        THIS-OBJECT:relativeDateBox1 = NEW Mips.InfraControls.RelativeDateBox().
        THIS-OBJECT:textBox1 = NEW Mips.InfraControls.TextBox().
        THIS-OBJECT:decimalBox1 = NEW Mips.InfraControls.DecimalBox().
        THIS-OBJECT:relativeDateWithTimeBox1 = NEW Mips.InfraControls.RelativeDateWithTimeBox().
        CAST(THIS-OBJECT:textBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:decimalBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* relativeDateBox1 */
        /*  */
        THIS-OBJECT:relativeDateBox1:FormatProvider = ?.
        THIS-OBJECT:relativeDateBox1:Location = NEW System.Drawing.Point(28, 83).
        THIS-OBJECT:relativeDateBox1:Name = "relativeDateBox1":U.
        THIS-OBJECT:relativeDateBox1:Size = NEW System.Drawing.Size(146, 21).
        THIS-OBJECT:relativeDateBox1:TabIndex = 0.
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:AblValue = "":U.
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(28, 39).
        THIS-OBJECT:textBox1:Name = "textBox1":U.
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:textBox1:TabIndex = 2.
        /*  */
        /* decimalBox1 */
        /*  */
        THIS-OBJECT:decimalBox1:AblValue = ?.
        THIS-OBJECT:decimalBox1:DecimalSeparator = ".":U.
        THIS-OBJECT:decimalBox1:GroupSeparator = ",":U.
        THIS-OBJECT:decimalBox1:Location = NEW System.Drawing.Point(28, 150).
        THIS-OBJECT:decimalBox1:Name = "decimalBox1":U.
        THIS-OBJECT:decimalBox1:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:decimalBox1:TabIndex = 3.
        THIS-OBJECT:decimalBox1:Text = "?":U.
        /*  */
        /* relativeDateWithTimeBox1 */
        /*  */
        THIS-OBJECT:relativeDateWithTimeBox1:AblValue = "?,?":U.
        THIS-OBJECT:relativeDateWithTimeBox1:Location = NEW System.Drawing.Point(28, 202).
        THIS-OBJECT:relativeDateWithTimeBox1:MinimumSize = NEW System.Drawing.Size(100, 0).
        THIS-OBJECT:relativeDateWithTimeBox1:Name = "relativeDateWithTimeBox1":U.
        THIS-OBJECT:relativeDateWithTimeBox1:Size = NEW System.Drawing.Size(200, 21).
        THIS-OBJECT:relativeDateWithTimeBox1:TabIndex = 4.
        /*  */
        /* TestForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:relativeDateWithTimeBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:decimalBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:relativeDateBox1).
        THIS-OBJECT:Name = "TestForm":U.
        THIS-OBJECT:Text = "TestForm":U.
        CAST(THIS-OBJECT:textBox1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:decimalBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestForm ( ):

    END DESTRUCTOR.

END CLASS.
