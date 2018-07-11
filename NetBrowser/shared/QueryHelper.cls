 
 /*------------------------------------------------------------------------
    File        : QueryHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Wed Mar 14 14:16:42 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.QueryHelper: 
    
     METHOD PUBLIC STATIC INTEGER GetNumberOfRecordsInTemptable(TempTableHandle AS HANDLE):
        DEFINE VARIABLE CountQueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO INITIAL 0.
        
        /* --------------------------------------------------------------------- */
    
        IF NOT VALID-HANDLE(TempTableHandle)
        THEN RETURN 0.
        
        IF TempTableHandle:HAS-RECORDS
        THEN DO:
            CREATE QUERY CountQueryHandle .
            CountQueryHandle:SET-BUFFERS (TempTableHandle:DEFAULT-BUFFER-HANDLE) .
            CountQueryHandle:QUERY-PREPARE(SUBSTITUTE("PRESELECT EACH &1", TempTableHandle:NAME)).
            CountQueryHandle:QUERY-OPEN ().
        
            CountQueryHandle:GET-FIRST(NO-lock).
            
            DO WHILE CountQueryHandle:QUERY-OFF-END = NO:            
                ASSIGN NumberOfRecords = NumberOfRecords + 1.
                CountQueryHandle:GET-NEXT(NO-LOCK).
            END.            
        END.
        ELSE
            ASSIGN NumberOfRecords = 0.
     
        RETURN NumberOfRecords.

        FINALLY:
            IF VALID-HANDLE (CountQueryHandle)
            THEN DELETE OBJECT CountQueryHandle.
        END FINALLY.

    END.

END CLASS.