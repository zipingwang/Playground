
 /*------------------------------------------------------------------------
    File        : DummyForm2
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon Jun 18 14:22:55 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.DummyForm2 INHERITS Form:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraButton1 AS Infragistics.Win.Misc.UltraButton NO-UNDO.


    CONSTRUCTOR PUBLIC DummyForm2 (  ):


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
        THIS-OBJECT:ultraButton1 = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraButton1 */
        /*  */
        THIS-OBJECT:ultraButton1:Location = NEW System.Drawing.Point(148, 139).
        THIS-OBJECT:ultraButton1:Name = "ultraButton1":U.
        THIS-OBJECT:ultraButton1:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:ultraButton1:TabIndex = 0.
        THIS-OBJECT:ultraButton1:Text = "ultraButton1":U.
        /*  */
        /* DummyForm2 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraButton1).
        THIS-OBJECT:Name = "DummyForm2":U.
        THIS-OBJECT:Text = "DummyForm2":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC DummyForm2 ( ):

    END DESTRUCTOR.

END CLASS.
