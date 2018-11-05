
 /*------------------------------------------------------------------------
    File        : GpSiteRibbon
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:15:54 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonGroupDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonTabDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemType FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Ribbon.GpSiteRibbon:

    METHOD STATIC PUBLIC RibbonDefinition GetRibbonDefinition():

        DEFINE VARIABLE ribbonDefinition AS RibbonDefinition NO-UNDO.
        DEFINE VARIABLE ribbonItemDefinition AS RibbonItemDefinition NO-UNDO.
        DEFINE VARIABLE ribbonGroupDefinition AS RibbonGroupDefinition NO-UNDO.
        DEFINE VARIABLE ribbonTabDefinition AS RibbonTabDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN ribbonGroupDefinition = NEW RibbonGroupDefinition("Security", 2).

        ASSIGN ribbonItemDefinition = NEW RibbonItemDefinition("Users", "Users", RibbonItemType:Button).
        ribbonGroupDefinition:AddRibbonItem(ribbonItemDefinition).

        ASSIGN ribbonItemDefinition = NEW RibbonItemDefinition("Roles", "Roles", RibbonItemType:Button).
        ribbonGroupDefinition:AddRibbonItem(ribbonItemDefinition).

        ASSIGN ribbonTabDefinition = NEW RibbonTabDefinition("Security", 1).
        ribbonTabDefinition:AddRibbonGroup(ribbonGroupDefinition).

        ASSIGN ribbonDefinition = NEW RibbonDefinition().
        ribbonDefinition:AddRibbonTab(ribbonTabDefinition).

        RETURN ribbonDefinition.

    END METHOD.
END CLASS.
