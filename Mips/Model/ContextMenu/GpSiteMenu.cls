
 /*------------------------------------------------------------------------
    File        : GpSiteMenu
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Oct 19 16:20:48 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuGroupDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.ContextMenu.GpSiteMenu:

     METHOD STATIC PUBLIC MenuItemDefinition GetMenuItemDefinition():

        DEFINE VARIABLE RootMenuItemDefinition AS MenuGroupDefinition NO-UNDO.
        DEFINE VARIABLE MenuItemDefinition AS MenuItemDefinition NO-UNDO.
        DEFINE VARIABLE MenuGroupDefinition AS MenuGroupDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN RootMenuItemDefinition = NEW MenuGroupDefinition("Root", "Root", 2).

        /* begin security */
        ASSIGN MenuGroupDefinition = NEW MenuGroupDefinition("Security", "Security", 2).
        ASSIGN MenuItemDefinition = NEW MenuItemDefinition("User", "User").
        MenuGroupDefinition:AddMenuItem(MenuItemDefinition).
        ASSIGN MenuItemDefinition = NEW MenuItemDefinition("Role", "Role").
        MenuGroupDefinition:AddMenuItem(MenuItemDefinition).
        /* end security */
        RootMenuItemDefinition:AddMenuItem(MenuGroupDefinition).

        ASSIGN MenuItemDefinition = NEW MenuItemDefinition("Help", "Help").
        RootMenuItemDefinition:AddMenuItem(MenuItemDefinition).

        RETURN RootMenuItemDefinition.

    END METHOD.

END CLASS.
