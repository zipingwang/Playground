 
 /*------------------------------------------------------------------------
    File        : TestForm2
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Thu Jan 12 11:48:15 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.TestForm2 INHERITS Form: 
	
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE relativeDateBox1 AS Mips.InfraControls.RelativeDateBox NO-UNDO.

		
	CONSTRUCTOR PUBLIC TestForm2 (  ):
		
		
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
        THIS-OBJECT:relativeDateBox1 = NEW Mips.InfraControls.RelativeDateBox().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* relativeDateBox1 */
        /*  */
        THIS-OBJECT:relativeDateBox1:FormatProvider = ?.
        THIS-OBJECT:relativeDateBox1:Location = NEW System.Drawing.Point(78, 89).
        THIS-OBJECT:relativeDateBox1:Name = "relativeDateBox1":U.
        THIS-OBJECT:relativeDateBox1:Size = NEW System.Drawing.Size(146, 23).
        THIS-OBJECT:relativeDateBox1:TabIndex = 0.
        /*  */
        /* TestForm2 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:relativeDateBox1).
        THIS-OBJECT:Name = "TestForm2":U.
        THIS-OBJECT:Text = "TestForm2":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	DESTRUCTOR PUBLIC TestForm2 ( ):

	END DESTRUCTOR.

END CLASS.