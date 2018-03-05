
 /*------------------------------------------------------------------------
    File        : RowIdHelper
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Thu Mar 01 13:10:40 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.RowIdHelper:

    METHOD PUBLIC STATIC CHARACTER GetRowIdsFromQueryHandle(QueryHandle AS HANDLE):

        DEFINE VARIABLE RowIds AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        //DEFINE VARIABLE OneRowId AS CHARACTER NO-UNDO.

        IF NOT VALID-HANDLE (QueryHandle) OR QueryHandle:TYPE <> "QUERY":U THEN
            UNDO, THROW NEW AppError ("Invalid Query object."{&TRAN}, 0).

        DO Counter = 1 TO QueryHandle:NUM-BUFFERS:
          /*  IF QueryHandle:GET-BUFFER-HANDLE(Counter):AVAILABLE THEN
                ASSIGN OneRowId = QueryHandle:GET-BUFFER-HANDLE(Counter):ROWID .
            ELSE
                ASSIGN OneRowId = ? .
                */
            IF Counter = 1 THEN
                RowIds =  SUBSTITUTE("&1", QueryHandle:GET-BUFFER-HANDLE(Counter):ROWID).
            ELSE
                RowIds =  SUBSTITUTE("&1&2&3",  RowIds, CHR(5), QueryHandle:GET-BUFFER-HANDLE(Counter):ROWID).
        END.
        RETURN RowIds.

    END METHOD.

END CLASS.