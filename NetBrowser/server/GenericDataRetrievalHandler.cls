 
 /*------------------------------------------------------------------------
    File        : GenericDataRetriver
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Tue Feb 13 11:57:54 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING Consultingwerk.QueryRowIdentifier FROM PROPATH.
USING Consultingwerk.Util.GarbageCollectorHelper FROM PROPATH.
USING Consultingwerk.Util.LogManager FROM PROPATH.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.server.GenericDataRetrievalHandler: 
    
    METHOD PUBLIC HANDLE GetData(DataRetrievalRequest AS DataRetrievalRequest, OUTPUT DataRetrievalResponse AS DataRetrievalResponse):
        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE DataSourceHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE TempTableBufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE DataSetHandle AS HANDLE NO-UNDO.
        DEFINE BUFFER b_User FOR sc_User.  
        DEFINE BUFFER b_Language FOR gp_Language.
        DEFINE VARIABLE TempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandles AS HANDLE EXTENT NO-UNDO.
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE FieldsInOneBuffer AS CHARACTER NO-UNDO.
        DEFINE VARIABLE FieldCounter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfFields AS INTEGER NO-UNDO.
        DEFINE VARIABLE FieldName AS CHARACTER NO-UNDO.
        
        DataRetrievalResponse = NEW DataRetrievalResponse().
        
        //ASSIGN BufferHandle = TEMP-TABLE VALUE(ClientToServerContext:TempTableName):DEFAULT-BUFFER-HANDLE.    
        CREATE TEMP-TABLE TempTableHandle.
               
        CREATE DATA-SOURCE DataSourceHandle.

        CREATE QUERY QueryHandle.
        
        /*add buffer to query*/
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfBuffers AS INTEGER NO-UNDO.
       .
        ASSIGN NumberOfBuffers = NUM-ENTRIES (DataRetrievalRequest:BufferNames).
        EXTENT (BufferHandles) = ? . 
        EXTENT (BufferHandles) = NumberOfBuffers.
        DO Counter = 1 TO NumberOfBuffers:
            CREATE BUFFER BufferHandles[Counter] FOR TABLE ENTRY(Counter, DataRetrievalRequest:BufferNames).  
            QueryHandle:ADD-BUFFER(BufferHandles[Counter]).            
        END.       
       
        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:QueryString).
        QueryHandle:QUERY-OPEN().
        
        
/*create temp-table*/
        QueryHandle:GET-FIRST(). 
        
        CREATE TEMP-TABLE TempTableHandle.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
       
        DO Counter = 1 TO NumberOfBuffers:
            ASSIGN BufferHandle = BufferHandles[Counter]. 
            FieldsInOneBuffer = TRIM(ENTRY(Counter, DataRetrievalRequest:FieldList, ",")).
            NumberOfFields = NUM-ENTRIES (FieldsInOneBuffer, " ").
            
            DO FieldCounter = 1 TO NumberOfFields:                
                ASSIGN FieldName = TRIM(ENTRY(FieldCounter, FieldsInOneBuffer, " ")).
                IF TRIM(FieldName) > ""
                THEN DO:
                    TempTableHandle:ADD-LIKE-FIELD(FieldName, BufferHandle:BUFFER-FIELD(FieldName)).
                END.
            END.
            /*           
            DO FieldCounter = 1 TO BufferHandle:NUM-FIELDS:
                IF BufferHandle:BUFFER-FIELD(FieldCounter):AVAILABLE
                THEN DO:
                    TempTableHandle:ADD-LIKE-FIELD(
                        BufferHandle:BUFFER-FIELD(FieldCounter):Name, BufferHandle:BUFFER-FIELD(FieldCounter)).
                END.
            END.    
            */  
        END.       
        
        TempTableHandle:TEMP-TABLE-PREPARE("temptable").
        
        ASSIGN TempTableBufferHandle = TempTableHandle:DEFAULT-BUFFER-HANDLE.
        
        //RUN playground/temptablehelper/dumptemptable (TempTableHandle, "d:\temp\temptablebeforefill.xml").
          
        //TempTableBufferHandle:EMPTY-TEMP-TABLE().
/*end create temp-table*/
        
        /*
        DataSourceHandle:QUERY = QueryHandle.        
       
        TempTableBufferHandle:ATTACH-DATA-SOURCE(DataSourceHandle, ?, ?, ?).
        TempTableBufferHandle:BATCH-SIZE = ClientToServerContext:BatchSize.  /*fill temp-table with 50 records*/
        TempTableBufferHandle:FILL-MODE = "REPLACE":U.
     
        /*reposition*/   
       /* FOR b_User NO-LOCK WHERE b_User.usr_Id = 272, 
            FIRST b_Language NO-LOCK WHERE b_Language.lng_Id = b_User.usr_Language:   
            
            DEFINE VARIABLE RepositionSuccessed AS LOGICAL NO-UNDO.
                      
            RepositionSuccessed = QueryHandle:REPOSITION-TO-ROWID(BUFFER b_User:ROWID, BUFFER b_Language:RowId). /*not working yet*/
            QueryHandle:GET-NEXT().
            TempTableBufferHandle:DATA-SOURCE:RESTART-ROWID(1) = BUFFER b_User:ROWID.
            TempTableBufferHandle:DATA-SOURCE:RESTART-ROWID(2) = BUFFER b_Language:ROWID.
          
        END. 
       */
        TempTableBufferHandle:FILL().
        */
        
        FillTempTable(QueryHandle, TempTableHandle, TempTableBufferHandle,
            BufferHandles, NumberOfBuffers,  DataRetrievalRequest, DataRetrievalResponse).
        
        //RUN playground/temptablehelper/dumptemptable (TempTableHandle, "d:\temp\temptableafterfill.xml").
        
        RETURN TempTableHandle.
                                 
        CATCH Err AS Progress.Lang.Error:                                
           ProcessError(Err, DataRetrievalResponse).                          
        END CATCH. 
        
        FINALLY:
            IF VALID-HANDLE(QueryHandle)
            THEN DO: 
                QueryHandle:QUERY-CLOSE().
                DELETE OBJECT QueryHandle.  
            END.		
        END FINALLY.
        
    END. 
    
    /*****************************************************************************/
    
    METHOD PRIVATE VOID FillTempTable(QueryHandle AS HANDLE, TempTableHandle AS HANDLE, TempTableBufferHandle AS HANDLE
        , BufferHandles AS HANDLE EXTENT, NumberOfBuffers AS INTEGER,  
        DataRetrievalRequest AS  DataRetrievalRequest, DataRetrievalResponse AS DataRetrievalResponse ):           
   
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE FieldCounter AS INTEGER NO-UNDO.
        DEFINE VARIABLE DataSetHandle AS HANDLE NO-UNDO.
         
        DEFINE VARIABLE DataSourceHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE QueryRowIdentifier AS QueryRowIdentifier NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        CREATE DATASET DataSetHandle.
        DataSetHandle:ADD-BUFFER(TempTableBufferHandle).
        
        CREATE DATA-SOURCE DataSourceHandle.
        DataSourceHandle:QUERY = QueryHandle.        
       
        TempTableBufferHandle:ATTACH-DATA-SOURCE(DataSourceHandle, ?, ?, ?).
        IF DataRetrievalRequest:BatchSize > -1 THEN TempTableBufferHandle:BATCH-SIZE = DataRetrievalRequest:BatchSize.  /*fill temp-table with x number of records*/
        //TempTableBufferHandle:FILL-MODE = "REPLACE":U.
        
          /*reposition*/ 
        IF DataRetrievalRequest:ToBeRepositionedRecord > ""
        THEN DO: 
            QueryRowIdentifier = NEW QueryRowIdentifier(). 
            QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
            QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).           
        END.
       
       
        TempTableBufferHandle:FILL().
        
        ASSIGN BufferHandle = BufferHandles[1].
        
        IF VALID-HANDLE (TempTableBufferHandle) AND (NOT TempTableBufferHandle:LAST-BATCH) AND VALID-HANDLE (TempTableBufferHandle:DATA-SOURCE) THEN DO:
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:GetDataSourceNextRowids (DataSourceHandle) .

            DataRetrievalResponse:LastRecordInTheBatch = QueryRowIdentifier:ToString() .
//MESSAGE DataRetrievalResponse:LastRecordInTheBatch VIEW-AS ALERT-BOX.
//            GarbageCollectorHelper:DeleteObject (QueryRowIdentifier) .
        END.
        
        IF VALID-HANDLE (TempTableBufferHandle) AND (TempTableBufferHandle:LAST-BATCH) AND VALID-HANDLE (TempTableBufferHandle:DATA-SOURCE) THEN DO:
            DataRetrievalResponse:IsLastBatch = YES.
            LogManager:WriteMessage("zwa last batch").
        END.
        
    END. 
    
    /*****************************************************************************/
    
    METHOD PRIVATE VOID ProcessError(Err AS  Progress.Lang.Error, DataRetrievalResponse AS DataRetrievalResponse):
        
        DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.        
        
        /* --------------------------------------------------------------------- */
        
        ASSIGN ErrorMessage = ErrorHelper:FormattedErrorMessages(Err).
        
        IF ErrorMessage > ""
        THEN DO:
            ASSIGN DataRetrievalResponse:ErrorMessage = ErrorMessage
                DataRetrievalResponse:HasError = YES.
            MESSAGE ErrorMessage VIEW-AS ALERT-BOX.
        END.
    END.
     
    /*****************************************************************************/
    
    /*this method fill temptable manually*/
    METHOD PRIVATE VOID FillTempTable2(QueryHandle AS HANDLE, TempTableHandle AS HANDLE, TempTableBufferHandle AS HANDLE
        , BatchSize AS INTEGER, BufferHandles AS HANDLE EXTENT,  NumberOfBuffers AS INTEGER ): 
        
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE FieldCounter AS INTEGER NO-UNDO.
        
        QueryHandle:GET-FIRST().  
         
        DO WHILE QueryHandle:QUERY-OFF-END = NO AND NumberOfRecords < BatchSize:
            TempTableBufferHandle:BUFFER-CREATE().
            NumberOfRecords = NumberOfRecords + 1.
            DO Counter = 1 TO NumberOfBuffers:
                ASSIGN BufferHandle = BufferHandles[Counter].                         
                DO FieldCounter = 1 TO BufferHandle:NUM-FIELDS: 
                    IF BufferHandle:BUFFER-FIELD(FieldCounter):AVAILABLE
                    THEN DO:                             
                        ASSIGN TempTableBufferHandle:BUFFER-FIELD(BufferHandle:BUFFER-FIELD(FieldCounter):NAME):BUFFER-VALUE
                            = BufferHandle:BUFFER-FIELD(FieldCounter):BUFFER-VALUE(). 
                    END.
                END.      
            END.  
            QueryHandle:GET-NEXT().  
        END.
    END. 
    
END CLASS.
