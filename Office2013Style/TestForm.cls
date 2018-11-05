
 /*------------------------------------------------------------------------
    File        : TestForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Jul 19 11:49:15 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.Drawing.Color FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Office2013Style.TestForm INHERITS FORM: //INHERITS be.mips.ablframework.gui.FormWithAppStyle:

    /*DEFINE PRIVATE VARIABLE m_TestForm_UltraFormManager_Dock_Area_Top AS Infragistics.Win.UltraWinForm.UltraFormDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_UltraFormManager_Dock_Area_Right AS Infragistics.Win.UltraWinForm.UltraFormDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_UltraFormManager_Dock_Area_Left AS Infragistics.Win.UltraWinForm.UltraFormDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_UltraFormManager_Dock_Area_Bottom AS Infragistics.Win.UltraWinForm.UltraFormDockArea NO-UNDO.
    */
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE pictureBox1 AS System.Windows.Forms.PictureBox NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraFormManager1 AS Infragistics.Win.UltraWinForm.UltraFormManager NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel2 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel3 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditor1 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraPanel1 AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.

    DEFINE PRIVATE VARIABLE LoginPluggableControl AS be.mips.ablframework.startup.gui.StartupPluggableControl.
    DEFINE PRIVATE VARIABLE ultraTextEditor2 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.

    CONSTRUCTOR PUBLIC TestForm (  ):


        SUPER().
        InitializeComponent().

        LoginPluggableControl= NEW be.mips.ablframework.startup.gui.StartupPluggableControl().
        pictureBox1:BackColor = Color:TRANSPARENT.
        //THIS-OBJECT:Controls:Add(LoginPluggableControl).

        //THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("Playground.Office2013Style.TestForm":U).
        THIS-OBJECT:ultraPanel1 = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraLabel3 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraTextEditor2 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:pictureBox1 = NEW System.Windows.Forms.PictureBox().
        THIS-OBJECT:ultraTextEditor1 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel2 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraFormManager1 = NEW Infragistics.Win.UltraWinForm.UltraFormManager(THIS-OBJECT:components).
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left = NEW Infragistics.Win.UltraWinForm.UltraFormDockArea().  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right = NEW Infragistics.Win.UltraWinForm.UltraFormDockArea(). */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top = NEW Infragistics.Win.UltraWinForm.UltraFormDockArea().   */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinForm.UltraFormDockArea().*/
        THIS-OBJECT:ultraPanel1:ClientArea:SuspendLayout().
        THIS-OBJECT:ultraPanel1:SuspendLayout().
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:pictureBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTextEditor1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraFormManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraPanel1 */
        /*  */
        /*  */
        /* ultraPanel1.ClientArea */
        /*  */
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel3).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraTextEditor2).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:pictureBox1).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraTextEditor1).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraPanel1:Location = NEW System.Drawing.Point(24, 50).
        THIS-OBJECT:ultraPanel1:Name = "ultraPanel1":U.
        THIS-OBJECT:ultraPanel1:Size = NEW System.Drawing.Size(579, 145).
        THIS-OBJECT:ultraPanel1:TabIndex = 4.
        /*  */
        /* ultraLabel3 */
        /*  */
        THIS-OBJECT:ultraLabel3:Location = NEW System.Drawing.Point(431, 65).
        THIS-OBJECT:ultraLabel3:Name = "ultraLabel3":U.
        THIS-OBJECT:ultraLabel3:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel3:TabIndex = 4.
        THIS-OBJECT:ultraLabel3:Text = "ultraLabel3":U.
        /*  */
        /* ultraTextEditor2 */
        /*  */
        THIS-OBJECT:ultraTextEditor2:Location = NEW System.Drawing.Point(431, 38).
        THIS-OBJECT:ultraTextEditor2:Name = "ultraTextEditor2":U.
        THIS-OBJECT:ultraTextEditor2:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor2:TabIndex = 3.
        /*  */
        /* pictureBox1 */
        /*  */
        THIS-OBJECT:pictureBox1:BackgroundImage = CAST(resources:GetObject("pictureBox1.BackgroundImage":U), System.Drawing.Image).
        THIS-OBJECT:pictureBox1:Location = NEW System.Drawing.Point(389, 13).
        THIS-OBJECT:pictureBox1:Name = "pictureBox1":U.
        THIS-OBJECT:pictureBox1:Size = NEW System.Drawing.Size(175, 116).
        THIS-OBJECT:pictureBox1:TabIndex = 2.
        THIS-OBJECT:pictureBox1:TabStop = FALSE.
        /*  */
        /* ultraTextEditor1 */
        /*  */
        THIS-OBJECT:ultraTextEditor1:Location = NEW System.Drawing.Point(235, 38).
        THIS-OBJECT:ultraTextEditor1:Name = "ultraTextEditor1":U.
        THIS-OBJECT:ultraTextEditor1:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor1:TabIndex = 1.
        /*  */
        /* ultraLabel1 */
        /*  */
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(40, 38).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1":U.
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 0.
        THIS-OBJECT:ultraLabel1:Text = "ultraLabel1":U.
        /*  */
        /* ultraLabel2 */
        /*  */
        THIS-OBJECT:ultraLabel2:Location = NEW System.Drawing.Point(24, 187).
        THIS-OBJECT:ultraLabel2:Name = "ultraLabel2":U.
        THIS-OBJECT:ultraLabel2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel2:TabIndex = 5.
        THIS-OBJECT:ultraLabel2:Text = "ultraLabel2":U.
        /*  */
        /* ultraFormManager1 */
        /*  */
        THIS-OBJECT:ultraFormManager1:Form = THIS-OBJECT.
        /*  */
        /* _TestForm_UltraFormManager_Dock_Area_Left */
        /*  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.                                                                                                                                        */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).*/
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinForm.DockedPosition:Left.                                                                                                                                   */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.                                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:FormManager = THIS-OBJECT:ultraFormManager1.                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:InitialResizeAreaExtent = 8.                                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 31).                                                                                                                                                           */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:Name = "_TestForm_UltraFormManager_Dock_Area_Left":U.                                                                                                                                                 */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 417).                                                                                                                                                               */
/*        /*  */                                                                                                                                                                                                                                                       */
/*        /* _TestForm_UltraFormManager_Dock_Area_Right */                                                                                                                                                                                                             */
/*        /*  */                                                                                                                                                                                                                                                       */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.                                                                                                                                       */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).*/
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinForm.DockedPosition:Right.                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.                                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:FormManager = THIS-OBJECT:ultraFormManager1.                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:InitialResizeAreaExtent = 8.                                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:Location = NEW System.Drawing.Point(672, 31).                                                                                                                                                         */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:Name = "_TestForm_UltraFormManager_Dock_Area_Right":U.                                                                                                                                                */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 417).                                                                                                                                                               */
        /*  */
        /* _TestForm_UltraFormManager_Dock_Area_Top */
        /*  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.                                                                                                                                        */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).*/
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinForm.DockedPosition:Top.                                                                                                                                    */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.                                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:FormManager = THIS-OBJECT:ultraFormManager1.                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).                                                                                                                                                            */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:Name = "_TestForm_UltraFormManager_Dock_Area_Top":U.                                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top:Size = NEW System.Drawing.Size(680, 31).                                                                                                                                                              */
        /*  */
        /* _TestForm_UltraFormManager_Dock_Area_Bottom */
        /*  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.                                                                                                                                        */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).*/
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinForm.DockedPosition:Bottom.                                                                                                                                 */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.                                                                                                                                                  */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:FormManager = THIS-OBJECT:ultraFormManager1.                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:InitialResizeAreaExtent = 8.                                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 448).                                                                                                                                                          */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:Name = "_TestForm_UltraFormManager_Dock_Area_Bottom":U.                                                                                                                                               */
/*        THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom:Size = NEW System.Drawing.Size(680, 8).                                                                                                                                                               */
        /*  */
        /* TestForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(680, 456).
        THIS-OBJECT:ControlBox = FALSE.
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraLabel2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraPanel1).
/*        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Left).  */
/*        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Right). */
/*        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Top).   */
/*        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_UltraFormManager_Dock_Area_Bottom).*/
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:None.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "TestForm":U.
        THIS-OBJECT:Text = "":U.
        THIS-OBJECT:ultraPanel1:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:ultraPanel1:ClientArea:PerformLayout().
        THIS-OBJECT:ultraPanel1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:pictureBox1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTextEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraFormManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestForm ( ):

    END DESTRUCTOR.

END CLASS.
