
 /*------------------------------------------------------------------------
    File        : FormWithResize
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Sep 27 15:41:55 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING System.EventArgs FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.FormWithResize INHERITS PROGRESS.Windows.Form:

    METHOD OVERRIDE PROTECTED VOID OnResize(e AS EventArgs):
        SUPER:OnResize(e).
    END METHOD.

END CLASS.
