
/*------------------------------------------------------------------------
    File        : 4GLEventBroker.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : ZipingWa
    Created     : Thu Mar 29 14:04:06 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE w_Event
FIELD ProcedureHandle AS HANDLE
FIELD ProcedureName AS CHARACTER
FIELD EventName AS CHARACTER
INDEX idx_EventName EventName
.

PROCEDURE InvokeChangeData:
    DEFINE INPUT PARAMETER Data AS CHARACTER.
    
    DEFINE BUFFER wb_Event FOR w_Event.
    
    /* --------------------------------------------------------------------- */
    
    FOR EACH wb_Event WHERE wb_Event.EventName = 'ChangeData':
        IF ProcedureName > ""
        THEN DO: 
            RUN VALUE(wb_Event.ProcedureName) IN wb_Event.ProcedureHandle(Data).
        END.
    END.
END.

/*****************************************************************************/

PROCEDURE SubScribeChangeData:
    DEFINE INPUT PARAMETER ProcedureHandle AS HANDLE NO-UNDO.
    DEFINE INPUT PARAMETER ProcedureName AS CHARACTER NO-UNDO.
    
    DEFINE BUFFER wb_Event FOR w_Event.
    
    /* --------------------------------------------------------------------- */
    
    FOR EACH wb_Event WHERE wb_Event.EventName = 'ChangeData' AND wb_Event.ProcedureHandle = ProcedureHandle
        AND wb_Event.ProcedureName = ProcedureName:       
    END.
    
    IF NOT AVAILABLE(wb_Event)
    THEN DO:
        CREATE wb_Event.
        ASSIGN 
            wb_Event.EventName = 'ChangeData'
            wb_Event.ProcedureHandle = ProcedureHandle
            wb_Event.ProcedureName = ProcedureName.            
    END.
END.

