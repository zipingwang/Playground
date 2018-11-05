 
 /*------------------------------------------------------------------------
    File        : RadRichTextEditorUserControl
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Fri Sep 28 08:55:51 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.UserControl.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.RadRichTextEditorUserControl INHERITS UserControl: 
    
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE richTextEditorRibbonBar1 AS Telerik.WinControls.UI.RichTextEditorRibbonBar NO-UNDO.
    DEFINE PRIVATE VARIABLE radRichTextEditor1 AS Telerik.WinControls.UI.RadRichTextEditor NO-UNDO.

        
    CONSTRUCTOR PUBLIC RadRichTextEditorUserControl (  ):
        
        
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
        THIS-OBJECT:radRichTextEditor1:Size = NEW System.Drawing.Size(672, 344).
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
        THIS-OBJECT:richTextEditorRibbonBar1:Size = NEW System.Drawing.Size(672, 174).
        THIS-OBJECT:richTextEditorRibbonBar1:TabIndex = 1.
        THIS-OBJECT:richTextEditorRibbonBar1:TabStop = FALSE.
        /*  */
        /* RadRichTextEditorUserControl */
        /*  */
        THIS-OBJECT:AutoScaleDimensions = NEW System.Drawing.SizeF(Progress.Util.CastUtil:ToSingle(6), Progress.Util.CastUtil:ToSingle(13)).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radRichTextEditor1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:richTextEditorRibbonBar1).
        THIS-OBJECT:Name = "RadRichTextEditorUserControl":U.
        THIS-OBJECT:Size = NEW System.Drawing.Size(672, 518).
        CAST(THIS-OBJECT:radRichTextEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:richTextEditorRibbonBar1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC RadRichTextEditorUserControl ( ):

    END DESTRUCTOR.

END CLASS.