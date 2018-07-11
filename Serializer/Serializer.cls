
 /*------------------------------------------------------------------------
    File        : Serializer
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Jul 06 08:47:54 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Serializer.Serializer SERIALIZABLE:


    DEFINE PUBLIC PROPERTY TestName AS CHARACTER NO-UNDO INITIAL "Test Name"
    GET.
    SET.

    CONSTRUCTOR PUBLIC Serializer():
        SUPER ().

    END CONSTRUCTOR.

    METHOD PUBLIC STATIC CHARACTER GetString(  ):

        DEFINE VARIABLE result AS CHARACTER NO-UNDO.

        RETURN result.

    END METHOD.

    METHOD PUBLIC STATIC VOID SaveObjectToTempFolder(TheFileName AS CHARACTER, TheObject AS Progress.Lang.Object):

        DEFINE VARIABLE myFileOutStream AS Progress.IO.FileOutputStream.
        DEFINE VARIABLE myFileInStream  AS Progress.IO.FileInputStream.
        DEFINE VARIABLE mySerializer    AS Progress.IO.JsonSerializer.

        mySerializer = NEW Progress.IO.JsonSerializer(FALSE).
        myFileOutStream = NEW Progress.IO.FileOutputStream(SESSION:TEMP-DIRECTORY + "/" + TheFileName).
        mySerializer:Serialize(TheObject, myFileOutStream).
        myFileOutStream:Close().

    END.

END CLASS.
