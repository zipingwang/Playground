DEFINE INPUT PARAMETER DataSetHandle AS HANDLE NO-UNDO.
DEFINE INPUT PARAMETER XmlFileName AS CHARACTER NO-UNDO. 

DEFINE VARIABLE NumberBuffers AS INTEGER NO-UNDO.
DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

DEFINE VARIABLE DirName AS CHARACTER NO-UNDO.
DEFINE VARIABLE ShortFileName AS CHARACTER NO-UNDO.
DEFINE VARIABLE iIndex AS INTEGER NO-UNDO.

/* --------------------------------------------------------------------- */

ASSIGN NumberBuffers = DataSetHandle:NUM-BUFFERS.

IF XmlFileName = ?
THEN XmlFileName = SESSION:TEMP-DIRECTORY + "/":U + "dataset.xml":U.
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

DO Counter = 1 TO NumberBuffers:
    ASSIGN BufferHandle = DataSetHandle:GET-BUFFER-HANDLE(Counter).
    RUN playground/temptablehelper/dumptemptable (BufferHandle:TABLE-HANDLE, DirName + "/":U + ShortFileName + "_" + BufferHandle:NAME + STRING(Counter) + ".xml":U).
END. 
