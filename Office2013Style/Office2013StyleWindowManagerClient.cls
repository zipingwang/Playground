
 /*------------------------------------------------------------------------
    File        : Office2013StyleWindowManagerClient
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Oct 05 09:00:57 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.Windows.Forms.OpenFileDialog FROM ASSEMBLY.
USING System.Windows.Forms.DialogResult FROM ASSEMBLY.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Office2013Style.Office2013StyleWindowManagerClient INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditorStyleFile AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraButtonOpenFile AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraButtonLoad AS Infragistics.Win.Misc.UltraButton NO-UNDO.


    CONSTRUCTOR PUBLIC Office2013StyleWindowManagerClient (  ):


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
        THIS-OBJECT:ultraTextEditorStyleFile = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraButtonOpenFile = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraButtonLoad = NEW Infragistics.Win.Misc.UltraButton().
        CAST(THIS-OBJECT:ultraTextEditorStyleFile, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTextEditorStyleFile */
        /*  */
        THIS-OBJECT:ultraTextEditorStyleFile:Location = NEW System.Drawing.Point(28, 29).
        THIS-OBJECT:ultraTextEditorStyleFile:Name = "ultraTextEditorStyleFile":U.
        THIS-OBJECT:ultraTextEditorStyleFile:Size = NEW System.Drawing.Size(606, 21).
        THIS-OBJECT:ultraTextEditorStyleFile:TabIndex = 0.
        /*  */
        /* ultraButtonOpenFile */
        /*  */
        THIS-OBJECT:ultraButtonOpenFile:Location = NEW System.Drawing.Point(640, 29).
        THIS-OBJECT:ultraButtonOpenFile:Name = "ultraButtonOpenFile":U.
        THIS-OBJECT:ultraButtonOpenFile:Size = NEW System.Drawing.Size(31, 23).
        THIS-OBJECT:ultraButtonOpenFile:TabIndex = 1.
        THIS-OBJECT:ultraButtonOpenFile:Text = "...":U.
        THIS-OBJECT:ultraButtonOpenFile:Click:Subscribe(THIS-OBJECT:ultraButtonOpenFile_Click).
        /*  */
        /* ultraButtonLoad */
        /*  */
        THIS-OBJECT:ultraButtonLoad:Location = NEW System.Drawing.Point(28, 79).
        THIS-OBJECT:ultraButtonLoad:Name = "ultraButtonLoad":U.
        THIS-OBJECT:ultraButtonLoad:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:ultraButtonLoad:TabIndex = 2.
        THIS-OBJECT:ultraButtonLoad:Text = "Load":U.
        THIS-OBJECT:ultraButtonLoad:Click:Subscribe(THIS-OBJECT:ultraButtonLoad_Click).
        /*  */
        /* Office2013StyleWindowManagerClient */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(750, 292).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraButtonLoad).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraButtonOpenFile).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraTextEditorStyleFile).
        THIS-OBJECT:Name = "Office2013StyleWindowManagerClient":U.
        THIS-OBJECT:Text = "Office2013StyleWindowManagerClient":U.
        CAST(THIS-OBJECT:ultraTextEditorStyleFile, System.ComponentModel.ISupportInitialize):EndInit().
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
    METHOD PRIVATE VOID ultraButtonLoad_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        IF ultraTextEditorStyleFile:TextLength > 0
        THEN DO:
            be.mips.ablframework.gui.styles.MipsStyleManager:LoadStyle(ultraTextEditorStyleFile:Text).
        END.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID ultraButtonOpenFile_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE VARIABLE OpenFileDialog AS OpenFileDialog NO-UNDO.
        DEFINE VARIABLE DialogResult AS DialogResult NO-UNDO.

        ASSIGN OpenFileDialog = NEW OpenFileDialog().

        WAIT-FOR OpenFileDialog:ShowDialog() SET DialogResult.
        IF DialogResult = System.Windows.Forms.DialogResult:OK
        THEN ultraTextEditorStyleFile:TEXT = OpenFileDialog:FILENAME.

    END METHOD.

    /*****************************************************************************/

    METHOD PROTECTED OVERRIDE CHARACTER GetTitle():

        RETURN "Office 2013 style":T50.

    END METHOD.

    DESTRUCTOR PUBLIC Office2013StyleWindowManagerClient ( ):

    END DESTRUCTOR.

END CLASS.
