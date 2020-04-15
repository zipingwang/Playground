
 /*------------------------------------------------------------------------
    File        : ContextObjectBase
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 13:36:03 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Interface.IContextObject FROM PROPATH.
USING Playground.Mips.Model.Ribbon.RibbonDefinition FROM PROPATH.
USING Playground.Mips.Model.ContextMenu.MenuItemDefinition FROM PROPATH.
USING Playground.Mips.Model.Other.ToolCommandParameter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.ContextObject.ContextObjectBase ABSTRACT IMPLEMENTS IContextObject:

    DEFINE PUBLIC ABSTRACT PROPERTY ContextName AS CHARACTER NO-UNDO
    GET.

    METHOD PUBLIC ABSTRACT RibbonDefinition GetRibbonDefinition():

    METHOD PUBLIC ABSTRACT MenuItemDefinition GetMenuItemDefinition():

    METHOD PUBLIC ABSTRACT VOID HandleToolCommand(ToolCommandParameter AS ToolCommandParameter):

END CLASS.
