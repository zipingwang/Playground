
 /*------------------------------------------------------------------------
    File        : RibbonGroupDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:17:23 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonItemDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.
USING Playground.Mips.Model.Ribbon.RibbonItemDefinition.

CLASS Playground.Mips.Model.Ribbon.RibbonGroupDefinition:

    DEFINE VARIABLE NumberOfChildAdded AS INTEGER NO-UNDO INITIAL 0.

    DEFINE PUBLIC PROPERTY RibbonItems AS RibbonItemDefinition EXTENT NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY GroupText AS CHARACTER NO-UNDO
    GET.
    SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC RibbonGroupDefinition(groupText AS CHARACTER, NumberOfChild AS INTEGER):
        SUPER ().

        ASSIGN THIS-OBJECT:GroupText = groupText.

        IF EXTENT(RibbonItems) = ?
        THEN EXTENT(RibbonItems) = NumberOfChild.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddRibbonItem(ribbonItemDefinition AS RibbonItemDefinition):

        NumberOfChildAdded = NumberOfChildAdded + 1.
        RibbonItems[NumberOfChildAdded] = ribbonItemDefinition.

    END METHOD.

END CLASS.
