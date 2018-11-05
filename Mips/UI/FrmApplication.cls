
 /*------------------------------------------------------------------------
    File        : FrmApplication
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 11:08:59 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.Mips.App.RibbonAndMenuManager FROM PROPATH.
USING Playground.Mips.Model.Ribbon.UserRibbon FROM PROPATH.
USING Playground.Mips.Model.Ribbon.GpSiteRibbon FROM PROPATH.
USING Infragistics.Win.UltraWinToolbars.ToolClickEventArgs FROM ASSEMBLY.
USING Playground.Mips.Model.ContextMenu.GpSiteMenu FROM PROPATH.
USING Progress.Util.TypeHelper FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.PopupMenuTool FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolBase FROM ASSEMBLY.
USING Playground.Mips.UI.FrmBase FROM PROPATH.
USING Playground.Mips.Model.ContextObject.GpSiteObject FROM PROPATH.
USING Playground.Mips.Model.Other.ToolCommandParameter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.FrmApplication INHERITS FrmBase:


    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmApplication_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmApplication_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmApplication_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_FrmApplication_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE FrmApplication_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    CONSTRUCTOR PUBLIC FrmApplication (  ):


        SUPER().
        InitializeComponent().

        RibbonAndMenuManager:AddRibbonToUltraToolbarsManager(ultraToolbarsManager1, NEW GpSiteObject()).
        RibbonAndMenuManager:AddMenuToUltraToolbarsManager(ultraToolbarsManager1, NEW GpSiteObject()).


        ultraToolbarsManager1:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).

        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):


        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:FrmApplication_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:FrmApplication_Fill_Panel:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Progress.Windows.Form":U).
        THIS-OBJECT:ultraToolbarsManager1:Office2007UICompatibility = FALSE.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        /*  */
        /* FrmApplication_Fill_Panel */
        /*  */
        THIS-OBJECT:FrmApplication_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:FrmApplication_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:FrmApplication_Fill_Panel:Location = NEW System.Drawing.Point(8, 55).
        THIS-OBJECT:FrmApplication_Fill_Panel:Name = "FrmApplication_Fill_Panel":U.
        THIS-OBJECT:FrmApplication_Fill_Panel:Size = NEW System.Drawing.Size(583, 333).
        THIS-OBJECT:FrmApplication_Fill_Panel:TabIndex = 0.
        /*  */
        /* m_FrmApplication_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 55).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:Name = "m_FrmApplication_Toolbars_Dock_Area_Left":U.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 333).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_FrmApplication_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(591, 55).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:Name = "m_FrmApplication_Toolbars_Dock_Area_Right":U.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 333).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_FrmApplication_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:Name = "m_FrmApplication_Toolbars_Dock_Area_Top":U.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(599, 55).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_FrmApplication_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 388).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:Name = "m_FrmApplication_Toolbars_Dock_Area_Bottom":U.
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(599, 8).
        THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* FrmApplication */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(599, 396).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:FrmApplication_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_FrmApplication_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "FrmApplication":U.
        THIS-OBJECT:Text = "FrmApplication":U.
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:FrmApplication_Fill_Panel:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID ultraToolbarsManager1_ToolClick(sender AS System.Object, e AS ToolClickEventArgs):

        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE PopupMenuTool AS PopupMenuTool NO-UNDO.
        DEFINE VARIABLE Tool AS ToolBase NO-UNDO.
        DEFINE VARIABLE ToolCommandParameter AS ToolCommandParameter NO-UNDO.

MESSAGE  "ultraToolbarsManager1_ToolClick" e:Tool:Key e:Tool:SharedPropsInternal:Caption
ultraToolbarsManager1:Tools[e:Tool:Key]:Tag e:Tool:GetType() VIEW-AS ALERT-BOX.
        IF TYPE-OF(ultraToolbarsManager1:Tools[e:Tool:Key]:Tag, ToolCommandParameter)
        THEN DO:
            ASSIGN ToolCommandParameter = CAST(ultraToolbarsManager1:Tools[e:Tool:Key]:Tag, ToolCommandParameter).
            ToolCommandParameter:ContextObject:HandleToolCommand(ToolCommandParameter).
        END.

/*
        MESSAGE  e:Tool:Key e:Tool:SharedPropsInternal:Caption e:Tool:GetType() VIEW-AS ALERT-BOX.

        IF TYPE-OF(e:Tool, PopupMenuTool)
        THEN DO:
            ASSIGN PopupMenuTool = CAST(e:Tool, PopupMenuTool).
            DO Counter = 0 TO PopupMenuTool:Tools:Count:
                ASSIGN Tool = PopupMenuTool:Tools[Counter].
                MESSAGE Tool:Key Tool:SharedPropsInternal:Caption Tool:GetType() VIEW-AS ALERT-BOX.
            END.

        END.
*/

    END METHOD.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC FrmApplication ( ):

    END DESTRUCTOR.

END CLASS.
