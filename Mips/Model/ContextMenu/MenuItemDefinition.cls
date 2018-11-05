
 /*------------------------------------------------------------------------
    File        : MenuItem
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Oct 19 16:08:13 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.ContextMenu.MenuItemType FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.ContextMenu.MenuItemDefinition:

    DEFINE PUBLIC PROPERTY ItemKey AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ItemText AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ItemType AS MenuItemType NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ChildMenuItems AS MenuItemDefinition EXTENT NO-UNDO
    GET.
    SET.

    CONSTRUCTOR PUBLIC MenuItemDefinition():
    END CONSTRUCTOR.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC MenuItemDefinition(ItemText AS CHARACTER,  ItemKey AS CHARACTER):
        SUPER ().

        ASSIGN
            THIS-OBJECT:ItemKey = ItemKey
            THIS-OBJECT:ItemText = ItemText
            THIS-OBJECT:ItemType = MenuItemType:MenuItem
            .
    END CONSTRUCTOR.

END CLASS.
