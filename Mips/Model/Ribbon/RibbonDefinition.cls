
 /*------------------------------------------------------------------------
    File        : RibbonDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:16:41 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonTabDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Ribbon.RibbonDefinition:


    DEFINE PUBLIC PROPERTY RibbonTabItems AS RibbonTabDefinition EXTENT NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Text AS CHARACTER NO-UNDO
    GET.
    SET.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddRibbonTab(ribbonTabDefinition AS RibbonTabDefinition):

        IF EXTENT(RibbonTabItems) = ?
        THEN EXTENT(RibbonTabItems) = 1.
        ELSE EXTENT(RibbonTabItems) = EXTENT(RibbonTabItems) + 1.

        RibbonTabItems[EXTENT(RibbonTabItems)] = ribbonTabDefinition.

    END METHOD.

END CLASS.
