 
 /*------------------------------------------------------------------------
    File        : TestForm3
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Thu Jan 12 12:31:32 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.TestForm3 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE checkBox1 AS System.Windows.Forms.CheckBox NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE relativeDateBox1 AS Mips.InfraControls.RelativeDateBox NO-UNDO.

		
	CONSTRUCTOR PUBLIC TestForm3 (  ):
		
		
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
        THIS-OBJECT:checkBox1 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:relativeDateBox1 = NEW Mips.InfraControls.RelativeDateBox().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* checkBox1 */
        /*  */
        THIS-OBJECT:checkBox1:Location = NEW System.Drawing.Point(34, 13).
        THIS-OBJECT:checkBox1:Name = "checkBox1":U.
        THIS-OBJECT:checkBox1:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox1:TabIndex = 0.
        THIS-OBJECT:checkBox1:Text = "checkBox1":U.
        THIS-OBJECT:checkBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* relativeDateBox1 */
        /*  */
        THIS-OBJECT:relativeDateBox1:FormatProvider = ?.
        THIS-OBJECT:relativeDateBox1:Location = NEW System.Drawing.Point(34, 104).
        THIS-OBJECT:relativeDateBox1:Name = "relativeDateBox1":U.
        THIS-OBJECT:relativeDateBox1:Size = NEW System.Drawing.Size(146, 23).
        THIS-OBJECT:relativeDateBox1:TabIndex = 1.
        /*  */
        /* TestForm3 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:relativeDateBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox1).
        THIS-OBJECT:Name = "TestForm3":U.
        THIS-OBJECT:Text = "TestForm3":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	DESTRUCTOR PUBLIC TestForm3 ( ):

	END DESTRUCTOR.

END CLASS.