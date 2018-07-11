 
 /*------------------------------------------------------------------------
    File        : TestShowDarkBackgroundFrom
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Mar 19 12:41:56 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.DarkBackgroundForm.ChildForm FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.DarkBackgroundForm.TestShowDarkBackgroundFrom INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.

        
    CONSTRUCTOR PUBLIC TestShowDarkBackgroundFrom (  ):
        
        
        SUPER().
        InitializeComponent().
        MESSAGE "TestShowDarkBackgroundFrom" VIEW-AS ALERT-BOX.
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
	METHOD PRIVATE VOID button1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		DEFINE VARIABLE Frm AS ChildForm.

        ASSIGN Frm = NEW ChildForm().       
        Frm:ShowWithDarkBackgroundForm().        

	END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(92, 116).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:button1:TabIndex = 0.
        THIS-OBJECT:button1:Text = "button1".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button1:Click:Subscribe(THIS-OBJECT:button1_Click).
        /*  */
        /* TestShowDarkBackgroundFrom */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Name = "TestShowDarkBackgroundFrom".
        THIS-OBJECT:Text = "TestShowDarkBackgroundFrom".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestShowDarkBackgroundFrom ( ):

    END DESTRUCTOR.

END CLASS.