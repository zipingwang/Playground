
 /*------------------------------------------------------------------------
    File        : ToolCommandParameter
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 14:10:21 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.ContextObject.ContextObjectBase FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Other.ToolCommandParameter INHERITS System.Object:

    DEFINE PUBLIC PROPERTY ToolKey AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ContextObject AS ContextObjectBase NO-UNDO
    GET.
    SET.

END CLASS.
