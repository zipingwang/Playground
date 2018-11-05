
 /*------------------------------------------------------------------------
    File        : RibbonManager
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 15:00:49 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Infragistics.Win.UltraWinToolbars.UltraToolbarsManager FROM ASSEMBLY.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonTabDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonGroupDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemType FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuGroupDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemType FROM PROPATH.
USING Infragistics.Win.UltraWinToolbars.PopupMenuTool FROM ASSEMBLY.
USING Progress.Util.TypeHelper FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.FileMenuStyle FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolbarStyle FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolBase FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ButtonTool FROM ASSEMBLY.
USING Playground.Mips.Model.ContextObject.ContextObjectBase FROM PROPATH.
USING Playground.Mips.Model.Other.ToolCommandParameter FROM PROPATH.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.App.RibbonAndMenuManager:

    METHOD PUBLIC STATIC VOID AddRibbonToUltraToolbarsManager
        (ultraToolbarsManager AS UltraToolbarsManager, ContextObjectBase AS ContextObjectBase):

        DEFINE VARIABLE counterTab AS INTEGER NO-UNDO.
        DEFINE VARIABLE counterRibbonGroup AS INTEGER NO-UNDO.
        DEFINE VARIABLE counterRibbonItem AS INTEGER NO-UNDO.
        DEFINE VARIABLE ribbonTab AS RibbonTabDefinition NO-UNDO.
        DEFINE VARIABLE ribbonTabGroup AS RibbonGroupDefinition NO-UNDO.
        DEFINE VARIABLE ribbonItem AS RibbonItemDefinition NO-UNDO.
        DEFINE VARIABLE ribbonDefinition AS RibbonDefinition NO-UNDO.

        DEFINE VARIABLE Level1 AS INTEGER NO-UNDO.
        DEFINE VARIABLE Level2 AS INTEGER NO-UNDO.
        DEFINE VARIABLE Level3 AS INTEGER NO-UNDO.

        DEFINE VARIABLE arrayRibbonTab AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN ribbonDefinition = ContextObjectBase:RibbonDefinition.

        EXTENT(arrayRibbonTab) = EXTENT(ribbonDefinition:RibbonTabItems).

        DO counterTab = 1 TO EXTENT(ribbonDefinition:RibbonTabItems):
            ASSIGN
                ribbonTab = ribbonDefinition:RibbonTabItems[counterTab]
                Level1 = Level1 + 1.

            DEFINE VARIABLE ribbonTab1 AS Infragistics.Win.UltraWinToolbars.RibbonTab NO-UNDO.
            ribbonTab1 = NEW Infragistics.Win.UltraWinToolbars.RibbonTab(ribbonTab:TabText).
            ribbonTab1:Caption = ribbonTab:TabText.

            arrayRibbonTab[counterTab] = ribbonTab1.

            DO counterRibbonGroup = 1 TO EXTENT(ribbonTab:RibbonGroupItems):
                ASSIGN
                    ribbonTabGroup = ribbonTab:RibbonGroupItems[counterRibbonGroup]
                    Level2 = Level2 + 1.

                DEFINE VARIABLE ribbonGroup1 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
                ribbonGroup1 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup(ribbonTabGroup:GroupText).
                ribbonGroup1:Caption = ribbonTabGroup:GroupText.

                ribbonTab1:Groups:Add(ribbonGroup1).

                DO counterRibbonItem = 1 TO EXTENT(ribbonTabGroup:RibbonItems):
                    ASSIGN
                        ribbonItem = ribbonTabGroup:RibbonItems[counterRibbonItem]
                        Level3 = Level3 + 1.

                    IF ribbonItem:ItemType = RibbonItemType:Button
                    THEN DO:
                        DEFINE VARIABLE buttonTool AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
                        DEFINE VARIABLE ToolCommandParameter AS ToolCommandParameter NO-UNDO.
                        buttonTool = NEW Infragistics.Win.UltraWinToolbars.ButtonTool(
                            SUBSTITUTE("&1.&2.&3_&4", Level1, Level2, Level3, ribbonItem:ItemText)).

                        buttonTool:SharedPropsInternal:Caption = ribbonItem:ItemText.

                        ToolCommandParameter = NEW ToolCommandParameter().
                        ASSIGN
                            ToolCommandParameter:ToolKey = ribbonItem:ItemKey
                            ToolCommandParameter:ContextObject = ContextObjectBase
                            .

                        buttonTool:Tag = ToolCommandParameter.

                        ribbonGroup1:Tools:Add(CloneTool(buttonTool)).
                        ultraToolbarsManager:Tools:Add(buttonTool).
                    END.
                END.
            END.
        END.

        ultraToolbarsManager:Ribbon:NonInheritedRibbonTabs:AddRange(arrayRibbonTab).

    END METHOD. /*AddRibbonToUltraToolbarsManager*/

    /*****************************************************************************/

    METHOD PUBLIC STATIC VOID AddMenuToUltraToolbarsManager
        (UltraToolbarsManager AS UltraToolbarsManager, ContextObjectBase AS ContextObjectBase):

        DEFINE VARIABLE RootMenuTool AS PopupMenuTool NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE arrayMenuItem AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT NO-UNDO.
        DEFINE VARIABLE CounterTools AS INTEGER NO-UNDO.
        DEFINE VARIABLE Tool AS ToolBase NO-UNDO.
        DEFINE VARIABLE NewTool AS ToolBase NO-UNDO.
        DEFINE VARIABLE MenuItemDefinition AS MenuItemDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN MenuItemDefinition = ContextObjectBase:MenuItemDefinition.

        ASSIGN RootMenuTool = GenerateUltraPopupMenuTool(MenuItemDefinition, ultraToolbarsManager, ContextObjectBase).

        ultraToolbarsManager:Tools:Add(CloneTool(RootMenuTool)).

        EXTENT(arrayMenuItem) = RootMenuTool:Tools:Count.
        DO Counter = 1 TO RootMenuTool:Tools:Count:
            ASSIGN Tool = RootMenuTool:Tools[Counter - 1].

            arrayMenuItem[Counter] = CloneTool(Tool).
        END.

        ultraToolbarsManager:Style = ToolbarStyle:Office2010.
        ultraToolbarsManager:Ribbon:FileMenuStyle = FileMenuStyle:ApplicationMenu.
        ultraToolbarsManager:Office2007UICompatibility = NO.

        ultraToolbarsManager:Ribbon:ApplicationMenu:ToolAreaLeft:NonInheritedTools:AddRange(arrayMenuItem).

    END METHOD.

    /*****************************************************************************/

    METHOD STATIC PopupMenuTool GenerateUltraPopupMenuTool(MenuItemDefinition AS MenuItemDefinition,
        UltraToolbarsManager AS UltraToolbarsManager,
        ContextObjectBase AS ContextObjectBase):

        DEFINE VARIABLE ChildMenuItemDefinition AS MenuItemDefinition NO-UNDO.
        DEFINE VARIABLE Level1 AS INTEGER NO-UNDO.
        DEFINE VARIABLE counterMenuItem AS INTEGER NO-UNDO.
        DEFINE VARIABLE arrayMenuItem AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT NO-UNDO.
        DEFINE VARIABLE RootMenuTool AS PopupMenuTool NO-UNDO.

        /* --------------------------------------------------------------------- */

        RootMenuTool = NEW PopupMenuTool("Root").

        DoAddUltraPopupMenuToolForChildMenuItem(MenuItemDefinition, RootMenuTool, "0", UltraToolbarsManager, ContextObjectBase).

        RETURN RootMenuTool.

    END METHOD.

    /*****************************************************************************/

    METHOD STATIC PRIVATE VOID DoAddUltraPopupMenuToolForChildMenuItem(
        ParentMenuItemDefinition AS MenuItemDefinition,
        ParentPopupMenuTool AS PopupMenuTool,
        ParentLevel AS CHARACTER,
        UltraToolbarsManager AS UltraToolbarsManager,
        ContextObjectBase AS ContextObjectBase
        ):

        DEFINE VARIABLE Level1 AS INTEGER NO-UNDO.
        DEFINE VARIABLE counterMenuItem AS INTEGER NO-UNDO.
        DEFINE VARIABLE arrayMenuItem AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        EXTENT(arrayMenuItem) = EXTENT(ParentMenuItemDefinition:ChildMenuItems).

        DO counterMenuItem = 1 TO EXTENT(ParentMenuItemDefinition:ChildMenuItems):
            DEFINE VARIABLE ChildMenuItemDefinition AS MenuItemDefinition NO-UNDO.
            ASSIGN
                ChildMenuItemDefinition = ParentMenuItemDefinition:ChildMenuItems[counterMenuItem]
                Level1 = Level1 + 1
                .

            DEFINE VARIABLE Tool AS ToolBase NO-UNDO.
            Tool = CreateTool(ChildMenuItemDefinition, Level1, ContextObjectBase).

            ASSIGN
                Tool:SharedPropsInternal:Caption = ChildMenuItemDefinition:ItemText
                arrayMenuItem[counterMenuItem] = CloneTool(Tool)
                .

            Counter = UltraToolbarsManager:Tools:Add(Tool).
            UltraToolbarsManager:Tools[Counter]:Tag = Tool:Tag.

            IF ChildMenuItemDefinition:ItemType = MenuItemType:MenuItemGroup
            THEN DO:
                DoAddUltraPopupMenuToolForChildMenuItem(
                    ChildMenuItemDefinition,
                    CAST(Tool, PopupMenuTool), SUBSTITUTE("&1.&2", ParentLevel, Level1),
                    UltraToolbarsManager,
                    ContextObjectBase
                    ).
            END.
        END.
        ParentPopupMenuTool:Tools:AddRange(arrayMenuItem).

    END METHOD.

    /*****************************************************************************/

    METHOD STATIC PRIVATE ToolBase CreateTool(
        MenuItemDefinition AS MenuItemDefinition,
        Level AS INTEGER,
        ContextObjectBase AS ContextObjectBase):

        DEFINE VARIABLE Tool AS ToolBase NO-UNDO.
        DEFINE VARIABLE ItemKey AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ToolCommandParameter AS ToolCommandParameter NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN ItemKey = MenuItemDefinition:ItemKey + "_" + STRING(Level).

        IF MenuItemDefinition:ItemType = MenuItemType:MenuItemGroup
        THEN Tool = NEW PopupMenuTool(ItemKey).
        ELSE Tool = NEW ButtonTool(ItemKey).

        ToolCommandParameter = NEW ToolCommandParameter().
        ASSIGN
            ToolCommandParameter:ToolKey = MenuItemDefinition:ItemKey
            ToolCommandParameter:ContextObject = ContextObjectBase
            .
        Tool:Tag = ToolCommandParameter.

        RETURN Tool.

    END METHOD.


    /*****************************************************************************/

    METHOD STATIC PRIVATE ToolBase CloneTool(ToolBaseToClone AS ToolBase):

        DEFINE VARIABLE Tool AS ToolBase NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF TYPE-OF(ToolBaseToClone, PopupMenuTool)
        THEN Tool = NEW PopupMenuTool(ToolBaseToClone:Key).
        ELSE Tool = NEW ButtonTool(ToolBaseToClone:Key).

        Tool:SharedPropsInternal:Caption = ToolBaseToClone:SharedPropsInternal:Caption.
        Tool:Tag = ToolBaseToClone:Tag.

        RETURN Tool.

    END METHOD.

END CLASS.
