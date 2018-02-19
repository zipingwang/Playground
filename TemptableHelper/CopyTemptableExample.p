    /*
        Crate a new temp-table based on an input temp-table.
        Because progress.lang.object cann't be serialized, change field with datatype of "progress.lang.object" into two fields.
        if the datatype of field in the input temp-table is "progress.lang.object"
        then add two fields to the new temp-table
        field1: name = <field name of input temp-table> + "_Id"
        field2: name = <field name of input temp-table> + "_Type"
    */  
    DEFINE TEMP-TABLE SourceTemptable NO-UNDO
        FIELD wff_WorkflowForm AS Progress.Lang.Object
        FIELD wff_ZOrder AS INTEGER
        INDEX wff_WorkflowForm IS PRIMARY UNIQUE wff_WorkflowForm
        INDEX wff_ZOrder wff_ZOrder.     
    
    DEFINE BUFFER b_SourceTemptable FOR SourceTemptable.
    
    DEFINE VARIABLE NewTemptableHandle AS HANDLE.
    CREATE TEMP-TABLE NewTemptableHandle.
    
    DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
    DEFINE VARIABLE SourceTemptableHandle AS HANDLE.
    DEFINE VARIABLE ObjectHandle AS HANDLE.
    DEFINE VARIABLE NewTableBufferHandle AS HANDLE.
    
    CREATE b_SourceTemptable.
    ASSIGN 
        b_SourceTemptable.wff_WorkflowForm = NEW Playground.TemptableViewer.TemptableViewer()
        wff_ZOrder =1.
        
    CREATE b_SourceTemptable.
    ASSIGN 
        b_SourceTemptable.wff_WorkflowForm = NEW Playground.TemptableViewer.TemptableViewer()
        wff_ZOrder =2.
     
   
    
    ASSIGN SourceTemptableHandle = BUFFER b_SourceTemptable:HANDLE.
    
    /*create temp-table structure*/
    DO Counter = 1 TO SourceTemptableHandle:NUM-FIELDS:
        IF SourceTemptableHandle:BUFFER-FIELD(Counter):DATA-TYPE = "progress.lang.object"
        THEN DO:
            NewTemptableHandle:ADD-NEW-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):NAME + "_Id", "integer"). 
            NewTemptableHandle:ADD-NEW-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):NAME + "_Type", "character").            
        END.
        ELSE DO:
            NewTemptableHandle:ADD-LIKE-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):Name, SourceTemptableHandle:TABLE + "." + SourceTemptableHandle:BUFFER-FIELD(Counter):Name).        
        END.
        
        ASSIGN ObjectHandle = SourceTemptableHandle:BUFFER-FIELD(Counter):Buffer-value(). 
        MESSAGE ObjectHandle VIEW-AS ALERT-BOX.
        MESSAGE SourceTemptableHandle:BUFFER-FIELD(Counter):Name  
           /* CAST(SourceTemptableHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(), Progress.Lang.Object ):ToString()   */             
            SourceTemptableHandle:BUFFER-FIELD(Counter):DATA-TYPE VIEW-AS ALERT-BOX.           
        
    END.   
    
    NewTemptableHandle:TEMP-TABLE-PREPARE(SourceTemptableHandle:TABLE).
    
    
    ASSIGN NewTableBufferHandle = NewTemptableHandle:DEFAULT-BUFFER-HANDLE.
    
    /*copy data*/
    FOR EACH b_SourceTemptable:
        NewTableBufferHandle:BUFFER-CREATE().
        DO Counter = 1 TO SourceTemptableHandle:NUM-FIELDS:
            IF SourceTemptableHandle:BUFFER-FIELD(Counter):DATA-TYPE = "progress.lang.object"
            THEN DO:
                ASSIGN ObjectHandle = SourceTemptableHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(). 
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):NAME + "_Id"):BUFFER-VALUE
                    = ObjectHandle.
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):NAME + "_Type"):BUFFER-VALUE
                    = CAST(SourceTemptableHandle:BUFFER-FIELD(Counter):BUFFER-VALUE(), Progress.Lang.Object):GetClass():TypeName.          
            END.
            ELSE DO:
                NewTableBufferHandle:BUFFER-FIELD(SourceTemptableHandle:BUFFER-FIELD(Counter):NAME):BUFFER-VALUE
                    = SourceTemptableHandle:BUFFER-FIELD(Counter):BUFFER-VALUE.
            END.
        END.    
        NewTableBufferHandle:BUFFER-VALIDATE().    
    END.
   
   RUN playground/temptablehelper/dumptemptable (NewTemptableHandle, ?).

