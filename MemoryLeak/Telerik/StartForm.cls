
 /*------------------------------------------------------------------------
    File        : StartForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Sep 27 09:18:05 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.Telerik.StartForm INHERITS Form:

    DEFINE PRIVATE VARIABLE buttonOpenRichTextForm AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonRadRichextEditorFormWithReizsing AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonStartRadRichTextEditorForm AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.


    CONSTRUCTOR PUBLIC StartForm (  ):


        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID buttonOpenRichTextForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE VARIABLE Frm AS Playground.MemoryLeak.Telerik.MipsRichTextForm NO-UNDO.

        ASSIGN Frm = NEW Playground.MemoryLeak.Telerik.MipsRichTextForm().
        Frm:Show().

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID buttonRadRichextEditorFormWithReizsing_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE VARIABLE Frm AS Playground.MemoryLeak.Telerik.RadRichTextEditorFormWithResizing NO-UNDO.

        ASSIGN Frm = NEW Playground.MemoryLeak.Telerik.RadRichTextEditorFormWithResizing().
        Frm:Show().

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID buttonStartRadRichTextEditorForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE VARIABLE RadRichTextEditorForm AS Playground.MemoryLeak.Telerik.RadRichTextEditorForm NO-UNDO.

        ASSIGN RadRichTextEditorForm = NEW Playground.MemoryLeak.Telerik.RadRichTextEditorForm().
        RadRichTextEditorForm:Show().

    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:buttonStartRadRichTextEditorForm = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonOpenRichTextForm = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonStartRadRichTextEditorForm */
        /*  */
        THIS-OBJECT:buttonStartRadRichTextEditorForm:Location = NEW System.Drawing.Point(38, 166).
        THIS-OBJECT:buttonStartRadRichTextEditorForm:Name = "buttonStartRadRichTextEditorForm":U.
        THIS-OBJECT:buttonStartRadRichTextEditorForm:Size = NEW System.Drawing.Size(246, 23).
        THIS-OBJECT:buttonStartRadRichTextEditorForm:TabIndex = 0.
        THIS-OBJECT:buttonStartRadRichTextEditorForm:Text = "Open RadRichTextEditor Form":U.
        THIS-OBJECT:buttonStartRadRichTextEditorForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonStartRadRichTextEditorForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonStartRadRichTextEditorForm:Click:Subscribe(THIS-OBJECT:buttonStartRadRichTextEditorForm_Click).
        /*  */
        /* buttonRadRichextEditorFormWithReizsing */
        /*  */
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:Location = NEW System.Drawing.Point(38, 195).
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:Name = "buttonRadRichextEditorFormWithReizsing":U.
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:Size = NEW System.Drawing.Size(246, 23).
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:TabIndex = 1.
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:Text = "Open RadRichTextEditor Form with resizing":U.
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonRadRichextEditorFormWithReizsing:Click:Subscribe(THIS-OBJECT:buttonRadRichextEditorFormWithReizsing_Click).
        /*  */
        /* buttonOpenRichTextForm */
        /*  */
        THIS-OBJECT:buttonOpenRichTextForm:Location = NEW System.Drawing.Point(38, 235).
        THIS-OBJECT:buttonOpenRichTextForm:Name = "buttonOpenRichTextForm":U.
        THIS-OBJECT:buttonOpenRichTextForm:Size = NEW System.Drawing.Size(246, 23).
        THIS-OBJECT:buttonOpenRichTextForm:TabIndex = 2.
        THIS-OBJECT:buttonOpenRichTextForm:Text = "Open Mips RichText Form":U.
        THIS-OBJECT:buttonOpenRichTextForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonOpenRichTextForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonOpenRichTextForm:Click:Subscribe(THIS-OBJECT:buttonOpenRichTextForm_Click).
        /*  */
        /* StartForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(471, 410).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonOpenRichTextForm).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonRadRichextEditorFormWithReizsing).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonStartRadRichTextEditorForm).
        THIS-OBJECT:Name = "StartForm":U.
        THIS-OBJECT:Text = "StartForm":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC StartForm ( ):

    END DESTRUCTOR.

END CLASS.
