
 /*------------------------------------------------------------------------
    File        : MenuItemType
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Oct 19 16:08:36 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

ENUM Playground.Mips.Model.ContextMenu.MenuItemType:

    DEFINE ENUM
        MenuItemGroup
        MenuItem
        .

END ENUM.
