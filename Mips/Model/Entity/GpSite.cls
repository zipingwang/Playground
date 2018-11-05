
 /*------------------------------------------------------------------------
    File        : GpSite
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 13:32:08 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.Model.Interface.IContextObject FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.Model.Entity.GpSite IMPLEMENTS IContextObject:

    DEFINE PUBLIC PROPERTY ContextName AS CHARACTER NO-UNDO
    GET:
        RETURN "GpSite".
    END.

END CLASS.
