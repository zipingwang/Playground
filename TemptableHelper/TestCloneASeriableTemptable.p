    DEFINE TEMP-TABLE SourceTemptable NO-UNDO
        FIELD wff_WorkflowForm AS Progress.Lang.Object
        FIELD wff_ZOrder AS INTEGER
        FIELD wff_Procedure AS HANDLE
        FIELD wff_Frame AS WIDGET-HANDLE
        FIELD wob_TargetRecord AS RECID
        INDEX wff_WorkflowForm IS PRIMARY UNIQUE wff_WorkflowForm
        INDEX wff_ZOrder wff_ZOrder.     
    
    DEFINE BUFFER b_SourceTemptable FOR SourceTemptable.
    DEFINE VARIABLE NewTemptableHandle AS HANDLE.
    
    /* --------------------------------------------------------------------- */
   
    CREATE b_SourceTemptable.
    ASSIGN 
        b_SourceTemptable.wff_WorkflowForm = NEW Playground.TemptableViewer.TemptableViewer()
        wff_ZOrder =1.   
    VALIDATE b_SourceTemptable.
        
    CREATE b_SourceTemptable.
    ASSIGN 
        //b_SourceTemptable.wff_WorkflowForm = NEW Playground.TemptableViewer.TemptableViewer()
        wff_ZOrder =2.   
    VALIDATE b_SourceTemptable.  
     
    RUN playground/temptablehelper/CloneASerializableTemptable(TEMP-TABLE SourceTemptable:HANDLE, OUTPUT NewTemptableHandle).
    
    RUN playground/temptablehelper/dumptemptable(NewTemptableHandle, ?).
