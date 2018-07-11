
 /*------------------------------------------------------------------------
    File        : Class2
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Jun 28 14:57:54 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.RichTextBox.TestForm.Class1 FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.Class2 INHERITS Class1:


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC Class2 (  ):
        SUPER ().

        ASSIGN THIS-OBJECT:FirstName = "Ziping2".
        THIS-OBJECT:LANGUAGE = "NL".
    END CONSTRUCTOR.


END CLASS.
