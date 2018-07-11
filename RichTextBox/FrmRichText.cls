
 /*------------------------------------------------------------------------
    File        : FrmRichText
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Jun 26 14:28:13 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.EventArgs FROM ASSEMBLY.
USING Telerik.WinForms.Documents.FormatProviders.Html.HtmlFormatProvider FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.FrmRichText INHERITS Form:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE richTextEditorRibbonBar1 AS Telerik.WinControls.UI.RichTextEditorRibbonBar NO-UNDO.
    DEFINE PRIVATE VARIABLE radRichTextEditor1 AS Telerik.WinControls.UI.RadRichTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE HtmlFormatProvider AS HtmlFormatProvider NO-UNDO.

    CONSTRUCTOR PUBLIC FrmRichText (  ):


        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        THIS-OBJECT:LOAD:Subscribe(Form1_Load).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID Form1_Load(sender AS System.Object,  e AS EventArgs):
        THIS-OBJECT:richTextEditorRibbonBar1:AssociatedRichTextEditor = THIS-OBJECT:radRichTextEditor1.
        ASSIGN HtmlFormatProvider = NEW HtmlFormatProvider().

        radRichTextEditor1:Document = HtmlFormatProvider:Import("hello").
    END.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:richTextEditorRibbonBar1 = NEW Telerik.WinControls.UI.RichTextEditorRibbonBar().
        THIS-OBJECT:radRichTextEditor1 = NEW Telerik.WinControls.UI.RadRichTextEditor().
        CAST(THIS-OBJECT:richTextEditorRibbonBar1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:radRichTextEditor1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* richTextEditorRibbonBar1 */
        /*  */
        THIS-OBJECT:richTextEditorRibbonBar1:ApplicationMenuStyle = Telerik.WinControls.UI.ApplicationMenuStyle:BackstageView.
        THIS-OBJECT:richTextEditorRibbonBar1:AssociatedRichTextEditor = ?.
        THIS-OBJECT:richTextEditorRibbonBar1:BuiltInStylesVersion = Telerik.WinForms.Documents.Model.Styles.BuiltInStylesVersion:Office2013.
        THIS-OBJECT:richTextEditorRibbonBar1:EnableKeyMap = FALSE.
        /*  */
        /*  */
        /*  */
        THIS-OBJECT:richTextEditorRibbonBar1:ExitButton:Text = "Exit":U.
        THIS-OBJECT:richTextEditorRibbonBar1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:richTextEditorRibbonBar1:Name = "richTextEditorRibbonBar1":U.
        /*  */
        /*  */
        /*  */
        THIS-OBJECT:richTextEditorRibbonBar1:OptionsButton:Text = "Options":U.
        THIS-OBJECT:richTextEditorRibbonBar1:Size = NEW System.Drawing.Size(929, 171).
        THIS-OBJECT:richTextEditorRibbonBar1:TabIndex = 0.
        THIS-OBJECT:richTextEditorRibbonBar1:TabStop = FALSE.
        THIS-OBJECT:richTextEditorRibbonBar1:Text = "richTextEditorRibbonBar1":U.
        /*  */
        /* radRichTextEditor1 */
        /*  */
        THIS-OBJECT:radRichTextEditor1:BorderColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(156)), System.Convert:ToInt32(System.Convert:ToByte(189)), System.Convert:ToInt32(System.Convert:ToByte(232))).
        THIS-OBJECT:radRichTextEditor1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:radRichTextEditor1:Location = NEW System.Drawing.Point(0, 171).
        THIS-OBJECT:radRichTextEditor1:Name = "radRichTextEditor1":U.
        THIS-OBJECT:radRichTextEditor1:SelectionFill = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(128)), System.Convert:ToInt32(System.Convert:ToByte(78)), System.Convert:ToInt32(System.Convert:ToByte(158)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:radRichTextEditor1:Size = NEW System.Drawing.Size(929, 320).
        THIS-OBJECT:radRichTextEditor1:TabIndex = 1.
        /*  */
        /* FrmRichText */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(929, 491).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radRichTextEditor1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextEditorRibbonBar1).
        THIS-OBJECT:Name = "FrmRichText":U.
        THIS-OBJECT:Text = "FrmRichText":U.
        CAST(THIS-OBJECT:richTextEditorRibbonBar1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:radRichTextEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC FrmRichText ( ):

    END DESTRUCTOR.

END CLASS.
