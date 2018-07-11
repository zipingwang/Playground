
/*------------------------------------------------------------------------
    File        : StartRichText.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : ZipingWa
    Created     : Tue May 15 08:53:55 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING be.mips.ablframework.Framework FROM PROPATH.

DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
DEFINE VARIABLE StartForm AS Playground.MemoryLeak.StartForm.

ASSIGN StartForm = NEW Playground.MemoryLeak.StartForm().

be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient
    (StartForm, PARENT, be.mips.ablframework.gui.ModalityMode:None).
