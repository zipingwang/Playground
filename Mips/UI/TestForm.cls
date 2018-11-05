
 /*------------------------------------------------------------------------
    File        : TestForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Wed Oct 24 16:13:29 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Infragistics.Win.UltraWinToolbars.PopupMenuTool FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.StateButtonTool FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ButtonTool FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.TestForm INHERITS Form:

    DEFINE PRIVATE VARIABLE m_TestForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_TestForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE TestForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.


    CONSTRUCTOR PUBLIC TestForm (  ):


        SUPER().
        InitializeComponent().
        InitializeExpertSettings().
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
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE popupMenuTool1 AS Infragistics.Win.UltraWinToolbars.PopupMenuTool NO-UNDO.
        popupMenuTool1 = NEW Infragistics.Win.UltraWinToolbars.PopupMenuTool("PopupMenuTool1":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool3 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool3 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool2":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE popupMenuTool2 AS Infragistics.Win.UltraWinToolbars.PopupMenuTool NO-UNDO.
        popupMenuTool2 = NEW Infragistics.Win.UltraWinToolbars.PopupMenuTool("PopupMenuTool1":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE popupMenuTool3 AS Infragistics.Win.UltraWinToolbars.PopupMenuTool NO-UNDO.
        popupMenuTool3 = NEW Infragistics.Win.UltraWinToolbars.PopupMenuTool("PopupMenuTool2":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool1":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE popupMenuTool4 AS Infragistics.Win.UltraWinToolbars.PopupMenuTool NO-UNDO.
        popupMenuTool4 = NEW Infragistics.Win.UltraWinToolbars.PopupMenuTool("PopupMenuTool2":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool1":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool2":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool3":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool4":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool11 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool11 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool5":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE buttonTool12 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool12 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool6":U).
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:TestForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:TestForm_Fill_Panel:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Progress.Windows.Form":U).
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar0 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 2 NO-UNDO.
        arrayvar0[1] = popupMenuTool1.
        arrayvar0[2] = buttonTool3.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:ApplicationMenu:ToolAreaLeft:NonInheritedTools:AddRange(arrayvar0).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        THIS-OBJECT:ultraToolbarsManager1:Style = Infragistics.Win.UltraWinToolbars.ToolbarStyle:Office2010.
        popupMenuTool2:SharedPropsInternal:Caption = "PopupMenuTool1":U.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar1 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 2 NO-UNDO.
        arrayvar1[1] = popupMenuTool3.
        arrayvar1[2] = buttonTool1.
        popupMenuTool2:Tools:AddRange(arrayvar1).
        popupMenuTool4:SharedPropsInternal:Caption = "PopupMenuTool2":U.
        buttonTool2:SharedPropsInternal:Caption = "ButtonTool1":U.
        buttonTool8:SharedPropsInternal:Caption = "ButtonTool2":U.
        buttonTool9:SharedPropsInternal:Caption = "ButtonTool3":U.
        buttonTool10:SharedPropsInternal:Caption = "ButtonTool4":U.
        buttonTool11:SharedPropsInternal:Caption = "ButtonTool5":U.
        buttonTool12:SharedPropsInternal:Caption = "ButtonTool6":U.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar2 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 8 NO-UNDO.
        arrayvar2[1] = popupMenuTool2.
        arrayvar2[2] = popupMenuTool4.
        arrayvar2[3] = buttonTool2.
        arrayvar2[4] = buttonTool8.
        arrayvar2[5] = buttonTool9.
        arrayvar2[6] = buttonTool10.
        arrayvar2[7] = buttonTool11.
        arrayvar2[8] = buttonTool12.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar2).
        /*  */
        /* TestForm_Fill_Panel */
        /*  */
        THIS-OBJECT:TestForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:TestForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:TestForm_Fill_Panel:Location = NEW System.Drawing.Point(8, 54).
        THIS-OBJECT:TestForm_Fill_Panel:Name = "TestForm_Fill_Panel":U.
        THIS-OBJECT:TestForm_Fill_Panel:Size = NEW System.Drawing.Size(624, 348).
        THIS-OBJECT:TestForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* m_TestForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 54).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:Name = "m_TestForm_Toolbars_Dock_Area_Left":U.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 348).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_TestForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(632, 54).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:Name = "m_TestForm_Toolbars_Dock_Area_Right":U.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 348).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_TestForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:Name = "m_TestForm_Toolbars_Dock_Area_Top":U.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(640, 54).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_TestForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 402).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:Name = "m_TestForm_Toolbars_Dock_Area_Bottom":U.
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(640, 8).
        THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* TestForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(640, 410).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:TestForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_TestForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "TestForm":U.
        THIS-OBJECT:Text = "TestForm":U.
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:TestForm_Fill_Panel:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

 METHOD PRIVATE VOID InitializeExpertSettings():

        DEFINE VARIABLE ExpertSettingsPopupMenuTool AS PopupMenuTool NO-UNDO.
        DEFINE VARIABLE ErrorStackButtonTool AS ButtonTool NO-UNDO.
        DEFINE VARIABLE LocalExecutionStateButtonTool AS StateButtonTool NO-UNDO.
        DEFINE VARIABLE DebugAlertStateButtonTool AS StateButtonTool NO-UNDO.
        DEFINE VARIABLE MonitorDbAccessStateButtonTool AS StateButtonTool NO-UNDO.
        DEFINE VARIABLE ExecutionLogStateButtonTool AS StateButtonTool NO-UNDO.
        DEFINE VARIABLE OracleTraceStateButtonTool AS StateButtonTool NO-UNDO.

        /* ------------------------------------------------------------------------------ */

        ASSIGN
            ExpertSettingsPopupMenuTool = NEW PopupMenuTool("ExpertSettingsPopupMenuTool":U)
/*            ExpertSettingsPopupMenuTool:SharedProps:AppearancesSmall:Appearance =*/
/*                ImageCache:Instance:ImagePathToAppearance("img/IconsGenericFunctions/16x16/Miscellaneous.png":U)*/
            ExpertSettingsPopupMenuTool:SharedProps:Caption = "Expert settings":T50.
        ultraToolbarsManager1:Tools:Add(ExpertSettingsPopupMenuTool).
        ultraToolbarsManager1:Ribbon:TabItemToolbar:Tools:InsertTool(0, "ExpertSettingsPopupMenuTool":U).

        ASSIGN
            ErrorStackButtonTool = NEW ButtonTool("ErrorStackButtonTool":U)
            ErrorStackButtonTool:SharedProps:Caption = "Error stack":T50.
        ultraToolbarsManager1:Tools:Add(ErrorStackButtonTool).
        ExpertSettingsPopupMenuTool:Tools:Add(ErrorStackButtonTool).

       ASSIGN
                DebugAlertStateButtonTool = NEW StateButtonTool("DebugAlertStateButtonTool":U)
                DebugAlertStateButtonTool:SharedProps:Caption = "Debug alert":T50
                DebugAlertStateButtonTool:Checked = SESSION:DEBUG-ALERT.
            UltraToolbarsManager1:Tools:Add(DebugAlertStateButtonTool).
            ExpertSettingsPopupMenuTool:Tools:Add(DebugAlertStateButtonTool).


        ASSIGN
            LocalExecutionStateButtonTool = NEW StateButtonTool("LocalExecutionStateButtonTool":U)
            LocalExecutionStateButtonTool:SharedProps:Caption = "Local execution":T50
            LocalExecutionStateButtonTool:Checked = YES.
        UltraToolbarsManager1:Tools:Add(LocalExecutionStateButtonTool).
        ExpertSettingsPopupMenuTool:Tools:Add(LocalExecutionStateButtonTool).

        ASSIGN
                MonitorDbAccessStateButtonTool = NEW StateButtonTool("MonitorDbAccessStateButtonTool":U)
                MonitorDbAccessStateButtonTool:SharedProps:Caption = "Monitor db access":T50.
            UltraToolbarsManager1:Tools:Add(MonitorDbAccessStateButtonTool).
            ExpertSettingsPopupMenuTool:Tools:Add(MonitorDbAccessStateButtonTool).



    END METHOD.
    DESTRUCTOR PUBLIC TestForm ( ):

    END DESTRUCTOR.

END CLASS.
