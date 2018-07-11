
 /*------------------------------------------------------------------------
    File        : DummyRichTextForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon May 28 14:52:35 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.RichTextBox.MyWorkflowForm FROM PROPATH.
USING Playground.RichTextBox.WorkflowFormWithoutRibbon FROM PROPATH.
USING be.mips.ablframework.gui.richtextbox.WorkflowFormForTelerikRichTextBox FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

//CLASS Playground.RichTextBox.TestForm.DummyRichTextForm INHERITS Form:
//CLASS Playground.RichTextBox.TestForm.DummyRichTextForm INHERITS WorkflowFormWithoutRibbon:
CLASS Playground.RichTextBox.TestForm.DummyRichTextForm INHERITS WorkflowFormForTelerikRichTextBox:


    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE richTextBoxWithRibbon1 AS Mips.TeleControls.RichTextBoxWithRibbon NO-UNDO.


    CONSTRUCTOR PUBLIC DummyRichTextForm (  ):
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
      //  MESSAGE "ok" view-as ALERT-BOX.
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:richTextBoxWithRibbon1 = NEW Mips.TeleControls.RichTextBoxWithRibbon().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* richTextBoxWithRibbon1 */
        /*  */
        THIS-OBJECT:richTextBoxWithRibbon1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:richTextBoxWithRibbon1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:richTextBoxWithRibbon1:Name = "richTextBoxWithRibbon1".
        THIS-OBJECT:richTextBoxWithRibbon1:Size = NEW System.Drawing.Size(996, 665).
        THIS-OBJECT:richTextBoxWithRibbon1:TabIndex = 0.
        THIS-OBJECT:richTextBoxWithRibbon1:TextFormatOption = Mips.TeleControls.RichTextBoxTextFormatOptions:Html.
        /*  */
        /* DummyRichTextForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(996, 665).
        //THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextBoxWithRibbon1).

        //THIS-OBJECT:Controls:Clear().
        //THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextBoxWithRibbon1).
        THIS-OBJECT:GetContentPanel():ClientArea:Controls:Add(THIS-OBJECT:richTextBoxWithRibbon1).
        //THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextBoxWithRibbon1).
        THIS-OBJECT:Name = "DummyRichTextForm".
        THIS-OBJECT:Text = "DummyRichTextForm".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC DummyRichTextForm ( ):

    END DESTRUCTOR.

END CLASS.
