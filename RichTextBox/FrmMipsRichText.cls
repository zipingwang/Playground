
 /*------------------------------------------------------------------------
    File        : FrmMipsRichText
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Jun 26 15:11:50 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Mips.TelerikControls.RichText.RichTextBoxWithRibbon FROM ASSEMBLY.
USING Mips.TelerikControls.RichText.RichTextBoxLayoutMode FROM ASSEMBLY.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.FrmMipsRichText INHERITS Form:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE RichTextBoxWithRibbon1 AS RichTextBoxWithRibbon NO-UNDO.

    CONSTRUCTOR PUBLIC FrmMipsRichText (  ):


        SUPER().
        InitializeComponent().
        ASSIGN RichTextBoxWithRibbon1 = NEW RichTextBoxWithRibbon().
        RichTextBoxWithRibbon1:LayoutMode = RichTextBoxLayoutMode:Flow.
        RichTextBoxWithRibbon1:Dock = DockStyle:FILL.

        RichTextBoxWithRibbon1:SetContent("hello").

        THIS-OBJECT:Controls:Add(RichTextBoxWithRibbon1).

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
        /*  */
        /* FrmMipsRichText */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(708, 397).
        THIS-OBJECT:Name = "FrmMipsRichText":U.
        THIS-OBJECT:Text = "FrmMipsRichText":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC FrmMipsRichText ( ):

    END DESTRUCTOR.

END CLASS.
