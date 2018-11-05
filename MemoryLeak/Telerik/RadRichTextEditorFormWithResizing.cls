
 /*------------------------------------------------------------------------
    File        : RadRichTextEditorForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Sep 27 09:20:07 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.IDisposable FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.Telerik.RadRichTextEditorFormWithResizing INHERITS Form:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE richTextEditorRibbonBar1 AS Telerik.WinControls.UI.RichTextEditorRibbonBar NO-UNDO.
    DEFINE PRIVATE VARIABLE radRichTextEditor1 AS Telerik.WinControls.UI.RadRichTextEditor NO-UNDO.


    CONSTRUCTOR PUBLIC RadRichTextEditorFormWithResizing (  ):


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
        THIS-OBJECT:radRichTextEditor1 = NEW Telerik.WinControls.UI.RadRichTextEditor().
        THIS-OBJECT:richTextEditorRibbonBar1 = NEW Telerik.WinControls.UI.RichTextEditorRibbonBar().
        CAST(THIS-OBJECT:radRichTextEditor1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:richTextEditorRibbonBar1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* radRichTextEditor1 */
        /*  */
        THIS-OBJECT:radRichTextEditor1:BorderColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(156)), System.Convert:ToInt32(System.Convert:ToByte(189)), System.Convert:ToInt32(System.Convert:ToByte(232))).
        THIS-OBJECT:radRichTextEditor1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:radRichTextEditor1:Location = NEW System.Drawing.Point(0, 174).
        THIS-OBJECT:radRichTextEditor1:Name = "radRichTextEditor1":U.
        THIS-OBJECT:radRichTextEditor1:SelectionFill = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(128)), System.Convert:ToInt32(System.Convert:ToByte(78)), System.Convert:ToInt32(System.Convert:ToByte(158)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:radRichTextEditor1:Size = NEW System.Drawing.Size(789, 312).
        THIS-OBJECT:radRichTextEditor1:TabIndex = 0.
        /*  */
        /* richTextEditorRibbonBar1 */
        /*  */
        THIS-OBJECT:richTextEditorRibbonBar1:ApplicationMenuStyle = Telerik.WinControls.UI.ApplicationMenuStyle:BackstageView.
        THIS-OBJECT:richTextEditorRibbonBar1:AssociatedRichTextEditor = THIS-OBJECT:radRichTextEditor1.
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
        THIS-OBJECT:richTextEditorRibbonBar1:Size = NEW System.Drawing.Size(789, 174).
        THIS-OBJECT:richTextEditorRibbonBar1:TabIndex = 1.
        THIS-OBJECT:richTextEditorRibbonBar1:TabStop = FALSE.
        THIS-OBJECT:richTextEditorRibbonBar1:Text = "RadRichTextEditorForm":U.
        /*  */
        /* RadRichTextEditorFormWithResizing */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(789, 486).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radRichTextEditor1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextEditorRibbonBar1).
        THIS-OBJECT:Name = "RadRichTextEditorFormWithResizing":U.
        THIS-OBJECT:Text = "RadRichTextEditorForm":U.
        THIS-OBJECT:FormClosing:Subscribe(THIS-OBJECT:RadRichTextEditorFormWithResizing_FormClosing).
        THIS-OBJECT:Resize:Subscribe(THIS-OBJECT:RadRichTextEditorFormWithResizing_Resize).
        CAST(THIS-OBJECT:radRichTextEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:richTextEditorRibbonBar1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID RadRichTextEditorFormWithResizing_FormClosing( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.FormClosingEventArgs ):

        richTextEditorRibbonBar1:AssociatedRichTextEditor = ?.
        CAST(richTextEditorRibbonBar1, IDisposable):Dispose().
        CAST(radRichTextEditor1, IDisposable):Dispose().

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID RadRichTextEditorFormWithResizing_Resize( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        RETURN.

    END METHOD.

    DESTRUCTOR PUBLIC RadRichTextEditorFormWithResizing ( ):

    END DESTRUCTOR.

END CLASS.
