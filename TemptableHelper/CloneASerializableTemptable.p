
    /*
        Crate a new temp-table based on an input temp-table.
        Because progress.lang.object cann't be serialized, change field with datatype of "progress.lang.object" into two fields.
        if the datatype of field in the input temp-table is "progress.lang.object"
        then add two fields to the new temp-table
        field1: name = <field name of input temp-table> + "_Id"
        field2: name = <field name of input temp-table> + "_Type"
    */  
    DEFINE INPUT PARAMETER SourceTemptableHandle AS HANDLE NO-UNDO.      
    DEFINE OUTPUT PARAMETER NewTemptableHandle AS HANDLE NO-UNDO.   

    DEFINE VARIABLE SourceTemptableBufferHandle AS HANDLE NO-UNDO.   
    DEFINE VARIABLE NewTableBufferHandle AS HANDLE NO-UNDO.   
    DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.        
    
    DEFINE VARIABLE Counter AS INTEGER NO-UNDO.    
    DEFINE VARIABLE ObjectHandle AS HANDLE NO-UNDO.    
    DEFINE VARIABLE ObjectType AS CHARACTER NO-UNDO.   
    
    DEFINE VARIABLE OriginalRowId AS ROWID NO-UNDO.
    
    /* --------------------------------------------------------------------- */
    
    /*important don't change default buffer, otherwise caller maybe also use the default buffer*/
    CREATE BUFFER SourceTemptableBufferHandle FOR TABLE SourceTemptableHandle.     
    //do don't use default buffer ASSIGN SourceTemptableBufferHandle = SourceTemptableHandle:DEFAULT-BUFFER-HANDLE.
    
    ASSIGN OriginalRowId = SourceTemptableBufferHandle:ROWID.
    
    CREATE TEMP-TABLE NewTemptableHandle.
    
    /*create temp-table structure*/
    DO Counter = 1 TO SourceTemptableBufferHandle:NUM-FIELDS:
        IF SourceTemptableBufferHandle:BUFFER-FIELD(Counter):DATA-TYPE = "progress.lang.object":U
        THEN DO:
            NewTemptableHandle:ADD-NEW-FIELD(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):NAME + "_Id":U, "integer":U). 
            NewTemptableHandle:ADD-NEW-FIELD(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):NAME + "_Type":U, "character":U).            
        END.
        ELSE DO:           
            NewTemptableHandle:ADD-LIKE-FIELD(
                SourceTemptableBufferHandle:BUFFER-FIELD(Counter):Name, 
                SourceTemptableBufferHandle:BUFFER-FIELD(Counter)).        
        END.
    END.   
    
    NewTemptableHandle:TEMP-TABLE-PREPARE(SourceTemptableBufferHandle:TABLE).    
    
    ASSIGN NewTableBufferHandle = NewTemptableHandle:DEFAULT-BUFFER-HANDLE.
    
    CREATE QUERY QueryHandle.
    QueryHandle:ADD-BUFFER(SourceTemptableBufferHandle).
    QueryHandle:QUERY-PREPARE("FOR EACH ":U + SourceTemptableBufferHandle:TABLE).
    QueryHandle:QUERY-OPEN().
    QueryHandle:GET-FIRST().
    
    /*copy data*/
    DO WHILE QueryHandle:QUERY-OFF-END = NO:
        
        NewTableBufferHandle:BUFFER-CREATE().
        DO Counter = 1 TO SourceTemptableBufferHandle:NUM-FIELDS:
            IF SourceTemptableBufferHandle:BUFFER-FIELD(Counter):DATA-TYPE = "progress.lang.object":U
            THEN DO:
                ASSIGN ObjectHandle = SourceTemptableBufferHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(). 
                IF CAST(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(), Progress.Lang.Object) <> ?
                THEN DO:
                    ASSIGN ObjectType = CAST(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(), Progress.Lang.Object)
                        :GetClass():TypeName.
                END.
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):NAME + "_Id":U):BUFFER-VALUE
                    = ObjectHandle.
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):NAME + "_Type":U):BUFFER-VALUE
                    = ObjectType.                              
            END.
            ELSE DO:
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableBufferHandle:BUFFER-FIELD(Counter):NAME):BUFFER-VALUE
                    = SourceTemptableBufferHandle:BUFFER-FIELD(Counter):BUFFER-VALUE.
            END.
        END.    
        NewTableBufferHandle:BUFFER-VALIDATE().    
        QueryHandle:GET-NEXT().
    END.
    
    DELETE OBJECT SourceTemptableBufferHandle.
    DELETE OBJECT QueryHandle.
