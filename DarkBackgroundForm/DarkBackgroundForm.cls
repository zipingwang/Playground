 
 /*------------------------------------------------------------------------
    File        : BarkBackgroundForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Mar 19 12:15:55 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.Drawing.Color FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.DarkBackgroundForm.DarkBackgroundForm INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.

        
    CONSTRUCTOR PUBLIC DarkBackgroundForm (  ):
        
        
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        
        THIS-OBJECT:BackColor = Color:Black.
        //THIS-OBJECT:TransparencyKey = THIS-OBJECT:BackColor.
        THIS-OBJECT:Opacity = 0.5.
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* BarkBackgroundForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(503, 266).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:None.
        THIS-OBJECT:Name = "BarkBackgroundForm".
        THIS-OBJECT:Text = "BarkBackgroundForm".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC DarkBackgroundForm ( ):

    END DESTRUCTOR.

END CLASS.