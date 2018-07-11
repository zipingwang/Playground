 
/*------------------------------------------------------------------------
   File        : DymmyForm2
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : ZipingWa
   Created     : Fri Jun 22 15:37:56 CEST 2018
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Windows.Form FROM ASSEMBLY.

CLASS Playground.RichTextBox.TestForm.DymmyForm2 INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.

        
    CONSTRUCTOR PUBLIC DymmyForm2 (  ):
        DEFINE VARIABLE Counter AS integer init 0.  
        
        IF TRUE 
        THEN 
        DO:
        END.
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
        THIS-OBJECT:SuspendLayout().
        THIS-OBJECT:Name = "DymmyForm2":U.
        THIS-OBJECT:Text = "DymmyForm2":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END METHOD.

    DESTRUCTOR PUBLIC DymmyForm2 ( ):

    END DESTRUCTOR.

END CLASS.