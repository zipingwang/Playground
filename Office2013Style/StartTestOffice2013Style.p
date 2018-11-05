/*
USING Playground.Office2013Style.Office2013StyleForm FROM PROPATH.
USING System.Windows.Forms.Application FROM ASSEMBLY.

DEFINE VARIABLE TestForm AS Office2013StyleForm.

TestForm = NEW Office2013StyleForm().
WAIT-FOR APPLICATION:Run(TestForm).
QUIT.*/
BLOCK-LEVEL ON ERROR UNDO, THROW.

USING be.mips.ablframework.Framework FROM PROPATH.

DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
DEFINE VARIABLE StartForm AS Playground.Office2013Style.Office2013StyleWindowManagerClient.

ASSIGN StartForm = NEW Playground.Office2013Style.Office2013StyleWindowManagerClient().

be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient
    (StartForm, PARENT, be.mips.ablframework.gui.ModalityMode:None).
