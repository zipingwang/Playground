
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

INTERFACE Playground.Mips.Model.Interface.IContextObject:

    DEFINE PUBLIC PROPERTY ContextName AS CHARACTER NO-UNDO
    GET.

    METHOD PUBLIC VOID HandleToolCommand(ToolCommandParameter AS ToolCommandParameter).


END INTERFACE.
