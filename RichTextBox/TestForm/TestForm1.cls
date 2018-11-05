 
 /*------------------------------------------------------------------------
    File        : TestForm1
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Oct 01 09:52:40 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.TestForm1 INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBox1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBox NO-UNDO.

        
    CONSTRUCTOR PUBLIC TestForm1 (  ):
        
        
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
        THIS-OBJECT:mipsRichTextBox1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBox().
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:IndicatorVisible = TRUE.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Paged.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(73, 63).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1":U.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(365, 262).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 0.
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Load:Subscribe(THIS-OBJECT:mipsRichTextBoxWithIndicator1_Load).
        /*  */
        /* mipsRichTextBox1 */
        /*  */
        THIS-OBJECT:mipsRichTextBox1:AllowDrop = TRUE.
        THIS-OBJECT:mipsRichTextBox1:BorderColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(156)), System.Convert:ToInt32(System.Convert:ToByte(189)), System.Convert:ToInt32(System.Convert:ToByte(232))).
        THIS-OBJECT:mipsRichTextBox1:FontName = ?.
        THIS-OBJECT:mipsRichTextBox1:FontSize = Progress.Util.CastUtil:ToDouble("0":U).
        THIS-OBJECT:mipsRichTextBox1:IsChanged = FALSE.
        THIS-OBJECT:mipsRichTextBox1:Language = ?.
        THIS-OBJECT:mipsRichTextBox1:LayoutModeOfLargeEditor = Mips.TelerikControls.RichText.RichTextBoxLayoutMode:Paged.
        THIS-OBJECT:mipsRichTextBox1:Location = NEW System.Drawing.Point(502, 121).
        THIS-OBJECT:mipsRichTextBox1:MaximumLength = 0.
        THIS-OBJECT:mipsRichTextBox1:Name = "mipsRichTextBox1":U.
        THIS-OBJECT:mipsRichTextBox1:Padding = NEW System.Windows.Forms.Padding(2).
        THIS-OBJECT:mipsRichTextBox1:RichTextBoxThemeOption = Mips.TelerikControls.RichText.RichTextBoxThemeOptions:Office2010Dark.
        THIS-OBJECT:mipsRichTextBox1:SelectionFill = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(128)), System.Convert:ToInt32(System.Convert:ToByte(78)), System.Convert:ToInt32(System.Convert:ToByte(158)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:mipsRichTextBox1:Size = NEW System.Drawing.Size(200, 200).
        THIS-OBJECT:mipsRichTextBox1:TabIndex = 1.
        THIS-OBJECT:mipsRichTextBox1:TableId = -1.
        THIS-OBJECT:mipsRichTextBox1:TextFormatOption = Mips.TelerikControls.RichText.RichTextBoxTextFormatOptions:Html.
        /*  */
        /* TestForm1 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(823, 449).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Name = "TestForm1":U.
        THIS-OBJECT:Text = "TestForm1":U.
        CAST(THIS-OBJECT:mipsRichTextBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID mipsRichTextBoxWithIndicator1_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

    DESTRUCTOR PUBLIC TestForm1 ( ):

    END DESTRUCTOR.

END CLASS.