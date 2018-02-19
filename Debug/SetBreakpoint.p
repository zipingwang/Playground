DEFINE VARIABLE ProcedureName AS CHARACTER NO-UNDO.
DEFINE VARIABLE LineNumber AS INTEGER NO-UNDO.

ASSIGN 
    ProcedureName = "DataAccess"
    LineNumber = 1280.
    
DEFINE VARIABLE Success AS LOGICAL NO-UNDO.

ASSIGN Success = DEBUGGER:INITIATE().
IF NOT Success 
THEN DO:
    MESSAGE "Debugger initiate failed":T75 SKIP ERROR-STATUS:GET-MESSAGE(1)
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

ASSIGN Success = DEBUGGER:SET-BREAK(ProcedureName, LineNumber).
IF NOT Success 
THEN DO:      
    MESSAGE "Set breakpoint failed":T75 SKIP ERROR-STATUS:GET-MESSAGE(1)
        VIEW-AS ALERT-BOX ERROR.     
    RETURN.
END.
ELSE DO:
    ASSIGN DEBUGGER:VISIBLE = TRUE.  

    MESSAGE SUBSTITUTE("Break point set in &1 at line &2":T75, ProcedureName, 
        LineNumber) VIEW-AS ALERT-BOX INFORMATION.
END.

