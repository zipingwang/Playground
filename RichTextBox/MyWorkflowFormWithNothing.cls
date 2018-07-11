
 /*------------------------------------------------------------------------
    File        : MyWorkflowFormWithNothing
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon May 28 16:28:49 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.EventArgs FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.MyWorkflowFormWithNothing INHERITS FORM ABSTRACT:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.


    CONSTRUCTOR PUBLIC MyWorkflowFormWithNothing (  ):


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
        THIS-OBJECT:Name = "MyWorkflowFormWithNothing".
        THIS-OBJECT:Text = "MyWorkflowFormWithNothing".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END METHOD.

    DESTRUCTOR PUBLIC MyWorkflowFormWithNothing ( ):

    END DESTRUCTOR.

END CLASS.
