DEFINE INPUT PARAMETER DataSetHandle AS HANDLE NO-UNDO.
DEFINE INPUT PARAMETER XmlFileName AS CHARACTER NO-UNDO. 

DEFINE VARIABLE NumberBuffers AS INTEGER NO-UNDO.
DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

ASSIGN NumberBuffers = DataSetHandle:NUM-BUFFERS.

DO Counter = 1 TO NumberBuffers:
    ASSIGN BufferHandle = DataSetHandle:GET-BUFFER-HANDLE(Counter).
    RUN playground/temptablehelper/dumptemptable (BufferHandle:TABLE-HANDLE, XmlFileName + STRING(Counter)).
END. 
