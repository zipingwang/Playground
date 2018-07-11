
 /*------------------------------------------------------------------------
    File        : Class1
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Jun 28 14:56:34 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.Class1:



    DEFINE PUBLIC PROPERTY FirstName AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Language AS CHARACTER NO-UNDO
    GET.
    SET.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC Class1 (  ):
        SUPER ().
        ASSIGN
            FirstName = "Ziping"
            LANGUAGE = "US".

    END CONSTRUCTOR.


END CLASS.
