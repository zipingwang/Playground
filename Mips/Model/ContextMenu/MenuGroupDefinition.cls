
 /*------------------------------------------------------------------------
    File        : MenuGroupDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Oct 19 16:33:52 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemType FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.ContextMenu.MenuGroupDefinition INHERITS MenuItemDefinition:

    DEFINE VARIABLE NumberOfChildAdded AS INTEGER NO-UNDO INITIAL 0.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC MenuGroupDefinition(GroupText AS CHARACTER, GroupKey AS CHARACTER, NumberOfChild AS INTEGER):

        ASSIGN
            THIS-OBJECT:ItemType =  MenuItemType:MenuItemGroup
            THIS-OBJECT:ItemKey = GroupKey
            THIS-OBJECT:ItemText = groupText.

        IF EXTENT(ChildMenuItems) = ?
        THEN EXTENT(ChildMenuItems) = NumberOfChild.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC VOID AddMenuItem(MenuItemDefinition AS MenuItemDefinition):

        IF THIS-OBJECT:ItemType = MenuItemType:MenuItemGroup
        THEN DO:
            NumberOfChildAdded = NumberOfChildAdded + 1.
            ChildMenuItems[NumberOfChildAdded] = MenuItemDefinition.
        END.

    END METHOD.

END CLASS.
