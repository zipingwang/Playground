 
 /*------------------------------------------------------------------------
    File        : TestForm2
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Oct 01 08:48:21 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.TestForm2 INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBox1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBox NO-UNDO.

        
    CONSTRUCTOR PUBLIC TestForm2 (  ):
        
        
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
        THIS-OBJECT:mipsRichTextBox1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBox().
        THIS-OBJECT:mipsRichTextBoxWithIndicator1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator().
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* mipsRichTextBox1 */
        /*  */
        THIS-OBJECT:mipsRichTextBox1:AllowDrop = TRUE.
        THIS-OBJECT:mipsRichTextBox1:FontName = ?.
        THIS-OBJECT:mipsRichTextBox1:FontSize = Progress.Util.CastUtil:ToDouble("0":U).
        THIS-OBJECT:mipsRichTextBox1:IsChanged = FALSE.
        THIS-OBJECT:mipsRichTextBox1:Language = ?.
        THIS-OBJECT:mipsRichTextBox1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Paged.
        THIS-OBJECT:mipsRichTextBox1:Location = NEW System.Drawing.Point(42, 34).
        THIS-OBJECT:mipsRichTextBox1:MaximumLength = 0.
        THIS-OBJECT:mipsRichTextBox1:Name = "mipsRichTextBox1":U.
        THIS-OBJECT:mipsRichTextBox1:Padding = NEW System.Windows.Forms.Padding(2).
        THIS-OBJECT:mipsRichTextBox1:RichTextBoxThemeOption = Mips.TelerikControls.RichText.RichTextBoxThemeOptions:Office2010Dark.
        THIS-OBJECT:mipsRichTextBox1:Size = NEW System.Drawing.Size(200, 200).
        THIS-OBJECT:mipsRichTextBox1:TabIndex = 0.
        THIS-OBJECT:mipsRichTextBox1:TableId = -1.
        THIS-OBJECT:mipsRichTextBox1:TextFormatOption = Mips.TelerikControls.RichText.RichTextBoxTextFormatOptions:Html.
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:IndicatorVisible = TRUE.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Paged.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(277, 34).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1":U.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(365, 262).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 1.
        /*  */
        /* TestForm2 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(654, 436).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBox1).
        THIS-OBJECT:Name = "TestForm2":U.
        THIS-OBJECT:Text = "TestForm2":U.
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestForm2 ( ):

    END DESTRUCTOR.

END CLASS.