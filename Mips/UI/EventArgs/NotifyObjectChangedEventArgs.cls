
 /*------------------------------------------------------------------------
    File        : NotifyObjectChangedEventArgs
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 14:42:16 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.EventArgs FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.EventArgs.NotifyObjectChangedEventArgs INHERITS EventArgs:

    DEFINE PUBLIC PROPERTY ContextName AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Id AS INTEGER NO-UNDO
    GET.
    SET.

END CLASS.
