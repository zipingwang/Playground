
 /*------------------------------------------------------------------------
    File        : GpSiteObject
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 13:35:10 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Interface.IContextObject FROM PROPATH.
USING Playground.Mips.Model.ContextObject.ContextObjectBase FROM PROPATH.
USING Playground.Mips.Model.Ribbon.GpSiteRibbon FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.GpSiteMenu FROM PROPATH.
USING Playground.Mips.Model.Other.ToolCommandParameter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.ContextObject.GpSiteObject INHERITS ContextObjectBase:

    DEFINE PUBLIC OVERRIDE PROPERTY ContextName AS CHARACTER NO-UNDO
    GET:
        RETURN "GpSite".
    END.

    METHOD PUBLIC OVERRIDE RibbonDefinition GetRibbonDefinition():
        RETURN GpSiteRibbon:GetRibbonDefinition().
    END METHOD.

    METHOD PUBLIC OVERRIDE MenuItemDefinition GetMenuItemDefinition():
        RETURN GpSiteMenu:GetMenuItemDefinition().
    END METHOD.

    METHOD PUBLIC OVERRIDE VOID HandleToolCommand(ToolCommandParameter AS ToolCommandParameter):

        CASE ToolCommandParameter:ToolKey:
            WHEN "Users" THEN MESSAGE  ToolCommandParameter:ToolKey VIEW-AS ALERT-BOX.
        END CASE.

    END METHOD.

END CLASS.
