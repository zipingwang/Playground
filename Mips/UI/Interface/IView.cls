
 /*------------------------------------------------------------------------
    File        : IView
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 14:23:20 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.UI.EventArgs.NotifyObjectChangedEventArgs FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

INTERFACE Playground.Mips.UI.Interface.IView:

    DEFINE PUBLIC EVENT NotifyObjectChanged SIGNATURE VOID(
        Sender AS Progress.Lang.Object, NotifyObjectChangedEventArgs AS NotifyObjectChangedEventArgs).

    METHOD PUBLIC VOID ParentChangedHandler(
        Sender AS Progress.Lang.Object, NotifyObjectChangedEventArgs AS NotifyObjectChangedEventArgs).

    METHOD PUBLIC VOID Close().

    METHOD PUBLIC RibbonDefinition GetRibbonDefinition().

    METHOD PUBLIC MenuItemDefinition GetMenuItemDefinition().

END INTERFACE.
