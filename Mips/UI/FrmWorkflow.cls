
 /*------------------------------------------------------------------------
    File        : FrmWorkflow
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 15:06:55 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.Mips.UI.FrmBase FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.FrmWorkflow INHERITS FrmBase:

    DEFINE PRIVATE VARIABLE m_FrmWorkflow_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmWorkflow_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmWorkflow_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmWorkflow_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE FrmWorkflow_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.


    CONSTRUCTOR PUBLIC FrmWorkflow (  ):


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
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:FrmWorkflow_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:FrmWorkflow_Fill_Panel:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Playground.Mips.UI.FrmBase":U).
        /*  */
        /* FrmWorkflow_Fill_Panel */
        /*  */
        THIS-OBJECT:FrmWorkflow_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:FrmWorkflow_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:FrmWorkflow_Fill_Panel:Location = NEW System.Drawing.Point(0, 25).
        THIS-OBJECT:FrmWorkflow_Fill_Panel:Name = "FrmWorkflow_Fill_Panel":U.
        THIS-OBJECT:FrmWorkflow_Fill_Panel:Size = NEW System.Drawing.Size(370, 336).
        THIS-OBJECT:FrmWorkflow_Fill_Panel:TabIndex = 0.
        /*  */
        /* _FrmWorkflow_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:BackColor = System.Drawing.SystemColors:Control.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 25).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:Name = "_FrmWorkflow_Toolbars_Dock_Area_Left":U.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(0, 336).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* _FrmWorkflow_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:BackColor = System.Drawing.SystemColors:Control.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(370, 25).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:Name = "_FrmWorkflow_Toolbars_Dock_Area_Right":U.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(0, 336).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* _FrmWorkflow_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:BackColor = System.Drawing.SystemColors:Control.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:Name = "_FrmWorkflow_Toolbars_Dock_Area_Top":U.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(370, 25).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* _FrmWorkflow_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.SystemColors:Control.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 361).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:Name = "_FrmWorkflow_Toolbars_Dock_Area_Bottom":U.
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(370, 0).
        THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* FrmWorkflow */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(370, 361).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:FrmWorkflow_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmWorkflow_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "FrmWorkflow":U.
        THIS-OBJECT:Text = "FrmWorkflow":U.
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:FrmWorkflow_Fill_Panel:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC FrmWorkflow ( ):

    END DESTRUCTOR.

END CLASS.
