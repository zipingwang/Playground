
 /*------------------------------------------------------------------------
    File        : TestFormRichTextBox2
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Jun 28 15:23:52 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.TestFormRichTextBox2 INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBox1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.


    CONSTRUCTOR PUBLIC TestFormRichTextBox2 (  ):


        SUPER().
        InitializeComponent().
        mipsRichTextBox1:ApplyMipsSetting().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        SetContent().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

 METHOD PUBLIC VOID SetContent(  ):

        DEFINE VARIABLE Content AS CHARACTER NO-UNDO.
        ASSIGN content =   "asdfsaf
asdfsadfsadf
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
<br/>
<br/>
<br/>
<br/>
asdfasdfsadfdsa
asdfasdfsadfdsa
 sadfs
sdfsdfs
asdfsadf
asdfsaf
asdfsadfsa".
        mipsRichTextBoxWithIndicator1:RichTextBox:SetContent(content).
        mipsRichTextBox1:SetContent(content).

    END METHOD.
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
        THIS-OBJECT:mipsRichTextBox1:Location = NEW System.Drawing.Point(673, 138).
        THIS-OBJECT:mipsRichTextBox1:MaximumLength = 0.
        THIS-OBJECT:mipsRichTextBox1:Name = "mipsRichTextBox1":U.
        THIS-OBJECT:mipsRichTextBox1:Padding = NEW System.Windows.Forms.Padding(2).
        THIS-OBJECT:mipsRichTextBox1:RichTextBoxThemeOption = Mips.TelerikControls.RichText.RichTextBoxThemeOptions:Office2010Dark.
        THIS-OBJECT:mipsRichTextBox1:Size = NEW System.Drawing.Size(200, 200).
        THIS-OBJECT:mipsRichTextBox1:TabIndex = 1.
        THIS-OBJECT:mipsRichTextBox1:TableId = -1.
        THIS-OBJECT:mipsRichTextBox1:TextFormatOption = Mips.TelerikControls.RichText.RichTextBoxTextFormatOptions:Html.
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:IndicatorVisible = FALSE.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Flow.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(107, 108).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1":U.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(365, 262).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 2.
        /*  */
        /* TestFormRichTextBox2 */
        /*  */
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBox1).
        THIS-OBJECT:Name = "TestFormRichTextBox2":U.
        THIS-OBJECT:Size = NEW System.Drawing.Size(946, 575).
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestFormRichTextBox2 ( ):

    END DESTRUCTOR.

END CLASS.
