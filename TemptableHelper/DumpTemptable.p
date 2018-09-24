//USING System.IO.Path FROM ASSEMBLY.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

DEFINE INPUT PARAMETER TemptableHandle AS HANDLE NO-UNDO.
DEFINE INPUT PARAMETER XmlFileName AS CHARACTER NO-UNDO.    /*If no XmlFileName specified, then the file name will be current
                                                            working folder + temptable.xml*/

DEFINE VARIABLE XsdFileName AS CHARACTER NO-UNDO.
DEFINE VARIABLE NewTemptableHandle AS HANDLE NO-UNDO.
DEFINE VARIABLE DirName AS CHARACTER NO-UNDO.
DEFINE VARIABLE ShortFileName AS CHARACTER NO-UNDO.
DEFINE VARIABLE iIndex AS INTEGER NO-UNDO.

/* --------------------------------------------------------------------- */

IF NOT VALID-HANDLE(TemptableHandle)
THEN DO:
    MESSAGE "Invalid temp-table handle":U VIEW-AS ALERT-BOX.
    RETURN.
END.

/*
IF XmlFileName <> ? AND System.IO.File:Exists(XmlFileName) = NO
THEN DO:
    MESSAGE SUBSTITUTE("File not exists: &1":U, XmlFileName) VIEW-AS ALERT-BOX.
    RETURN.
END.
*/

IF XmlFileName = ?
THEN XmlFileName = SESSION:TEMP-DIRECTORY + "/":U + "temptable.xml":U.
ELSE DO:
    DirName = Consultingwerk.Util.FileHelper:DirectoryName(XmlFileName).

    IF DirName =  XmlFileName /*no directory in the input parameter*/
    THEN DO:
        XmlFileName = SESSION:TEMP-DIRECTORY + "/":U + XmlFileName.
    END.
END.

DirName = Consultingwerk.Util.FileHelper:DirectoryName(XmlFileName).
ShortFileName = Consultingwerk.Util.FileHelper:ShortFileName(XmlFileName).

/*get file without extention. e.g temptable.xml - > temptable*/
iIndex = R-INDEX (ShortFileName, ".":U) .
IF iIndex > 0
THEN ShortFileName = SUBSTRING (ShortFileName, 1, iIndex - 1, "CHARACTER":U) .

ASSIGN XsdFileName = DirName + "/":U + ShortFileName + ".xsd":U.

RUN playground/temptablehelper/CloneASerializableTemptable(TemptableHandle, OUTPUT NewTemptableHandle).

NewTemptableHandle:WRITE-XML(
    "FILE":U,
    XmlFileName,
    YES,      /*formatted */
    ?,        /*encoding */
    ?,        /*cSchemaLocation*/
    NO,      /*lWriteSchema*/
    NO,       /*lMinSchema*/
    ?,        /*write-before-image */
    YES     /*omit-initial-values */
    ).

NewTemptableHandle:WRITE-XMLSCHEMA(
    "FILE":U,
    XsdFileName,
    YES,      /*formatted */
    ?,        /*encoding */
    NO      /*lMinSchema*/
    ).

CATCH err AS Progress.Lang.Error :
    ErrorHelper:ShowErrorMessage(err).
END CATCH.

FINALLY:
    IF VALID-HANDLE(NewTemptableHandle)
    THEN DELETE OBJECT NewTemptableHandle.
END FINALLY.

