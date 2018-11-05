
 /*------------------------------------------------------------------------
    File        : TestForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Sep 27 10:57:59 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Mips.TelerikControls.RichText.RichTextBoxWithRibbon FROM ASSEMBLY.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.
USING System.IDisposable FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.MipsRichTextWithRibbonWindowMangagerClient INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE RichTextBoxWithRibbon AS RichTextBoxWithRibbon NO-UNDO.

    CONSTRUCTOR PUBLIC MipsRichTextWithRibbonWindowMangagerClient (  ):
        SUPER().
        InitializeComponent().
        ASSIGN
            RichTextBoxWithRibbon = NEW RichTextBoxWithRibbon()
            RichTextBoxWithRibbon:Dock = DockStyle:FILL.

        THIS-OBJECT:Controls:Add(RichTextBoxWithRibbon).
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
        /* TestForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(796, 558).
        THIS-OBJECT:Name = "TestForm":U.
        THIS-OBJECT:Text = "TestForm":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    METHOD PUBLIC OVERRIDE VOID CloseClient():
        RichTextBoxWithRibbon:FreeMemory().
        CAST(RichTextBoxWithRibbon, IDisposable):Dispose().
        ASSIGN RichTextBoxWithRibbon = ?.
    END METHOD.

    DESTRUCTOR PUBLIC MipsRichTextWithRibbonWindowMangagerClient ( ):

    END DESTRUCTOR.

END CLASS.
