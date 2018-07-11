 
 /*------------------------------------------------------------------------
    File        : ChildForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Mar 19 12:23:13 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.DarkBackgroundForm.DarkBackgroundForm FROM PROPATH.
USING System.Windows.Forms.FormWindowState FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.DarkBackgroundForm.ChildForm INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE VARIABLE DarkBackgroundForm AS DarkBackgroundForm NO-UNDO.
        
    CONSTRUCTOR PUBLIC ChildForm (  ):
        
        
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
	METHOD PRIVATE VOID ChildForm_FormClosed( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.FormClosedEventArgs ):
		
		IF VALID-OBJECT(DarkBackgroundForm)
		THEN DO:
		    DarkBackgroundForm:Close().
		    DarkBackgroundForm:Dispose().
		    ASSIGN DarkBackgroundForm = ?.       
	    END.

	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID ShowWithDarkBackgroundForm(  ):
        
        ASSIGN DarkBackgroundForm = NEW DarkBackgroundForm().
        //System.Windows.Forms.Screen:PrimaryScreen:WorkingArea
        DarkBackgroundForm:LEFT = System.Windows.Forms.Screen:PrimaryScreen:WorkingArea:Left.
        DarkBackgroundForm:Top = System.Windows.Forms.Screen:PrimaryScreen:WorkingArea:Top.
        DarkBackgroundForm:Width = System.Windows.Forms.Screen:PrimaryScreen:WorkingArea:Width.
        DarkBackgroundForm:Height = System.Windows.Forms.Screen:PrimaryScreen:WorkingArea:Height.
        //DarkBackgroundForm:WindowState = FormWindowState:Maximized.
        DarkBackgroundForm:Show().
        WAIT-FOR THIS-OBJECT:ShowDialog().

    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ChildForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Name = "ChildForm".
        THIS-OBJECT:Text = "ChildForm".
        THIS-OBJECT:FormClosed:Subscribe(THIS-OBJECT:ChildForm_FormClosed).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.


    DESTRUCTOR PUBLIC ChildForm ( ):

    END DESTRUCTOR.

END CLASS.