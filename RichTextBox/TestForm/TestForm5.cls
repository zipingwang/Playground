 
 /*------------------------------------------------------------------------
    File        : TestForm5
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Oct 01 11:29:48 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.TestForm5 INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.

        
    CONSTRUCTOR PUBLIC TestForm5 (  ):
        
        
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
        THIS-OBJECT:mipsRichTextBoxWithIndicator1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:IndicatorVisible = TRUE.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Paged.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(22, 22).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1":U.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(365, 262).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 0.
        /*  */
        /* TestForm5 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(683, 434).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Name = "TestForm5":U.
        THIS-OBJECT:Text = "TestForm5":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestForm5 ( ):

    END DESTRUCTOR.

END CLASS.