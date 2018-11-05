
 /*------------------------------------------------------------------------
    File        : RibbonItemDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:17:39 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Ribbon.RibbonItemType FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Ribbon.RibbonItemDefinition:

    DEFINE PUBLIC PROPERTY ItemKey AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ItemText AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ItemType AS RibbonItemType NO-UNDO
    GET.
    SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC RibbonItemDefinition():
        SUPER ().

    END CONSTRUCTOR.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC RibbonItemDefinition(itemText AS CHARACTER,  itemKey AS CHARACTER, itemType AS RibbonItemType):
        SUPER ().

        ASSIGN
            THIS-OBJECT:ItemKey = itemKey
            THIS-OBJECT:ItemText = itemText
            THIS-OBJECT:ItemType = itemType
            .
    END CONSTRUCTOR.

END CLASS.
