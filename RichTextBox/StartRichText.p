
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
DEFINE VARIABLE TestFormRichTextBox AS Playground.RichTextBox.TestForm.TestFormRichTextBox2.

ASSIGN TestFormRichTextBox = NEW Playground.RichTextBox.TestForm.TestFormRichTextBox2().


/*TestFormRichTextBox:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.*/
be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(TestFormRichTextBox, PARENT /* Framework:ApplicationForm*/, be.mips.ablframework.gui.ModalityMode:None).
