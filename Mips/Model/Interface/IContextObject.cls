
/*------------------------------------------------------------------------
    File        : IContextObject
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 13:29:50 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Other.ToolCommandParameter FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.

INTERFACE Playground.Mips.Model.Interface.IContextObject:

    DEFINE PUBLIC PROPERTY ContextName AS CHARACTER NO-UNDO
    GET.

    METHOD PUBLIC VOID HandleToolCommand(ToolCommandParameter AS ToolCommandParameter).


    METHOD PUBLIC RibbonDefinition GetRibbonDefinition().


    METHOD PUBLIC MenuItemDefinition GetMenuItemDefinition().

END INTERFACE.
