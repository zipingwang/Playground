
 /*------------------------------------------------------------------------
    File        : UserRibbon
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:15:39 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonGroupDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonTabDefinition FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonItemType FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Ribbon.UserRibbon:

    METHOD STATIC PUBLIC RibbonDefinition GetRibbonDefinition():

        DEFINE VARIABLE ribbonDefinition AS RibbonDefinition NO-UNDO.
        DEFINE VARIABLE ribbonItemDefinition AS RibbonItemDefinition NO-UNDO.
        DEFINE VARIABLE ribbonGroupDefinition AS RibbonGroupDefinition NO-UNDO.
        DEFINE VARIABLE ribbonTabDefinition AS RibbonTabDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN ribbonGroupDefinition = NEW RibbonGroupDefinition("User", 2).
        ASSIGN ribbonItemDefinition = NEW RibbonItemDefinition("Open", "Open", RibbonItemType:Button).
        ribbonGroupDefinition:AddRibbonItem(ribbonItemDefinition).
        ASSIGN ribbonItemDefinition = NEW RibbonItemDefinition("Open2", "Open2", RibbonItemType:Button).
        ribbonGroupDefinition:AddRibbonItem(ribbonItemDefinition).

        ASSIGN ribbonTabDefinition = NEW RibbonTabDefinition("User", 1).
        ribbonTabDefinition:AddRibbonGroup(ribbonGroupDefinition).

        ASSIGN ribbonDefinition = NEW RibbonDefinition().
        ribbonDefinition:AddRibbonTab(ribbonTabDefinition).

        RETURN ribbonDefinition.

    END METHOD.

END CLASS.
