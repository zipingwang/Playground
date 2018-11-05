
 /*------------------------------------------------------------------------
    File        : RibbonTabDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:29:16 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonGroupDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Ribbon.RibbonTabDefinition:

    DEFINE PUBLIC PROPERTY RibbonGroupItems AS RibbonGroupDefinition EXTENT NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY TabText AS CHARACTER NO-UNDO
    GET.
    SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC RibbonTabDefinition(tabText AS CHARACTER, NumberOfChild AS INTEGER):
        SUPER ().

        ASSIGN THIS-OBJECT:TabText = tabText.

        IF EXTENT(RibbonGroupItems) = ?
        THEN EXTENT(RibbonGroupItems) = NumberOfChild.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddRibbonGroup(ribbonGroupDefinition AS RibbonGroupDefinition):


        RibbonGroupItems[EXTENT(RibbonGroupItems)] = ribbonGroupDefinition.

    END METHOD.

END CLASS.
