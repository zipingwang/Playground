
 /*------------------------------------------------------------------------
    File        : DummyForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Wed May 23 11:08:12 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.DummyForm INHERITS Form:
//CLASS Playground.RichTextBox.TestForm.DummyForm INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE comboBox1 AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE checkBox1 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBox1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithRibbon1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithRibbon NO-UNDO.
    DEFINE PRIVATE VARIABLE pictureBox1 AS System.Windows.Forms.PictureBox NO-UNDO.


    CONSTRUCTOR PUBLIC DummyForm (  ):


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
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("Playground.RichTextBox.TestForm.DummyForm").
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:checkBox1 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:comboBox1 = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:mipsRichTextBoxWithRibbon1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithRibbon().
        THIS-OBJECT:mipsRichTextBox1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBox().
        THIS-OBJECT:mipsRichTextBoxWithIndicator1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator().
        THIS-OBJECT:pictureBox1 = NEW System.Windows.Forms.PictureBox().
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:pictureBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(145, 111).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:button1:TabIndex = 0.
        THIS-OBJECT:button1:Text = "button1".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* checkBox1 */
        /*  */
        THIS-OBJECT:checkBox1:Location = NEW System.Drawing.Point(291, 109).
        THIS-OBJECT:checkBox1:Name = "checkBox1".
        THIS-OBJECT:checkBox1:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox1:TabIndex = 1.
        THIS-OBJECT:checkBox1:Text = "checkBox1".
        THIS-OBJECT:checkBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* comboBox1 */
        /*  */
        THIS-OBJECT:comboBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:comboBox1:Location = NEW System.Drawing.Point(145, 186).
        THIS-OBJECT:comboBox1:Name = "comboBox1".
        THIS-OBJECT:comboBox1:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:comboBox1:TabIndex = 2.
        /*  */
        /* mipsRichTextBoxWithRibbon1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithRibbon1:Location = NEW System.Drawing.Point(493, 160).
        THIS-OBJECT:mipsRichTextBoxWithRibbon1:Name = "mipsRichTextBoxWithRibbon1".
        THIS-OBJECT:mipsRichTextBoxWithRibbon1:Size = NEW System.Drawing.Size(1200, 800).
        THIS-OBJECT:mipsRichTextBoxWithRibbon1:TabIndex = 3.
        THIS-OBJECT:mipsRichTextBoxWithRibbon1:Title = "Editor".
        /*  */
        /* mipsRichTextBox1 */
        /*  */
        THIS-OBJECT:mipsRichTextBox1:AllowDrop = TRUE.
        THIS-OBJECT:mipsRichTextBox1:FontName = "Verdana".
        THIS-OBJECT:mipsRichTextBox1:FontSize = Progress.Util.CastUtil:ToDouble("16").
        THIS-OBJECT:mipsRichTextBox1:IsChanged = TRUE.
        THIS-OBJECT:mipsRichTextBox1:Language = "en-US".
        THIS-OBJECT:mipsRichTextBox1:Location = NEW System.Drawing.Point(156, 285).
        THIS-OBJECT:mipsRichTextBox1:MaximumLength = 200000000.
        THIS-OBJECT:mipsRichTextBox1:Name = "mipsRichTextBox1".
        THIS-OBJECT:mipsRichTextBox1:Padding = NEW System.Windows.Forms.Padding(2).
        THIS-OBJECT:mipsRichTextBox1:Size = NEW System.Drawing.Size(200, 200).
        THIS-OBJECT:mipsRichTextBox1:TabIndex = 4.
        THIS-OBJECT:mipsRichTextBox1:TableId = -1.
        THIS-OBJECT:mipsRichTextBox1:TextFormatOption = Mips.TelerikControls.RichText.RichTextBoxTextFormatOptions:Html.
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(469, 46).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1".
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(365, 262).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 5.
        /*  */
        /* pictureBox1 */
        /*  */
        THIS-OBJECT:pictureBox1:Image = CAST(resources:GetObject("pictureBox1.Image"), System.Drawing.Image).
        THIS-OBJECT:pictureBox1:Location = NEW System.Drawing.Point(40, 212).
        THIS-OBJECT:pictureBox1:Name = "pictureBox1".
        THIS-OBJECT:pictureBox1:Size = NEW System.Drawing.Size(100, 50).
        THIS-OBJECT:pictureBox1:TabIndex = 6.
        THIS-OBJECT:pictureBox1:TabStop = FALSE.
        /*  */
        /* DummyForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(940, 524).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pictureBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithRibbon1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:comboBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Name = "DummyForm".
        THIS-OBJECT:Text = "DummyForm".
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:pictureBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC DummyForm ( ):

    END DESTRUCTOR.

END CLASS.
