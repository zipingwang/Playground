
 /*------------------------------------------------------------------------
    File        : DataRetrievalException
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Tue Mar 06 15:18:08 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalException INHERITS AppError SERIALIZABLE:

    CONSTRUCTOR PUBLIC DataRetrievalException(ErrorMessage AS CHARACTER):
        SUPER (ErrorMessage, 1).

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC CHARACTER GetMessage ():
        RETURN THIS-OBJECT:GetMessage(1).
    END METHOD.

END CLASS.