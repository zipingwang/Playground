USING OEUnit.Assertion.Assert FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.QueryBlock FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING Playground.NetBrowser.shared.QueryHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.unittest.server.TestDataRetrieval2:
    

    @BeforeClass.
    METHOD PUBLIC VOID SetUp():
        
        CONNECT VALUE("-db sports2000 -S 20000").
      
    END METHOD.

    /*****************************************************************************/
    
    @AfterClass.
    METHOD PUBLIC VOID AfterAllTests():
         
        DISCONNECT sports2000.
        
    END METHOD.
    
    /*****************************************************************************/

    @Test.
    METHOD PUBLIC VOID RetrievalFirst50RecordsFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO. 
        DEFINE VARIABLE QueryHandleTemptable AS HANDLE NO-UNDO.      
        
        DEFINE VARIABLE NumberOfFields AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandleTemptable AS HANDLE NO-UNDO.
        DEFINE VARIABLE RowIdCustomer AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdSalesrep AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdInTempTable AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE NumberOfAvailableFields AS INTEGER NO-UNDO.
            
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().
        
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
                
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).

    END METHOD.
    
    /*****************************************************************************/

    @Test.
    METHOD PUBLIC VOID RetrievalNext50RecordsFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer1Handle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer2Handle AS HANDLE NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().
        
        CREATE BUFFER Buffer1Handle FOR TABLE "Customer".
        CREATE BUFFER Buffer2Handle FOR TABLE "Salesrep".
        CREATE QUERY QueryHandle.
        
        QueryHandle:SET-BUFFERS(Buffer1Handle, Buffer2Handle).
        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
        QueryHandle:QUERY-OPEN().
        DO WHILE QueryHandle:QUERY-OFF-END = NO AND Counter < 100:
            ASSIGN Counter = Counter + 1.        
            QueryHandle:GET-NEXT (NO-LOCK).
        END.
             
        
        DataRetrievalRequest:ToBeRepositionedRecord = STRING(Buffer1Handle:ROWID) + CHR(5) + STRING(Buffer2Handle:ROWID).
      
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
//RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\RetrievalNext50RecordsFromCustomerTable.xml").                            
        DataRetrievalRequest:QueryBlocks[1]:WherePhrase = SUBSTITUTE("CustNum > &1", Buffer1Handle::CustNum).   
        
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).
        
        IF VALID-HANDLE(LastTempTableHandle)
        THEN DELETE OBJECT LastTempTableHandle.
        IF VALID-HANDLE(Buffer1Handle)
        THEN DELETE OBJECT Buffer1Handle.
        IF VALID-HANDLE(Buffer2Handle)
        THEN DELETE OBJECT Buffer2Handle.
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

    END METHOD.
        
    /*****************************************************************************/
     @Test.
    METHOD PUBLIC VOID RetrievalPrevious50RecordsFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
            
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer1Handle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer2Handle AS HANDLE NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().
        
        CREATE BUFFER Buffer1Handle FOR TABLE "Customer".
        CREATE BUFFER Buffer2Handle FOR TABLE "Salesrep".
        CREATE QUERY QueryHandle.
        
        QueryHandle:SET-BUFFERS(Buffer1Handle, Buffer2Handle).
        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
        QueryHandle:QUERY-OPEN().
        DO WHILE QueryHandle:QUERY-OFF-END = NO AND Counter <= 100:
            ASSIGN Counter = Counter + 1.        
            QueryHandle:GET-NEXT (NO-LOCK).
        END.              
      
        DataRetrievalRequest:ToBeRepositionedRecord = STRING(Buffer1Handle:ROWID) + CHR(5) + STRING(Buffer2Handle:ROWID).
        
        DataRetrievalRequest:Direction = DataRetrievalConstant:BACKWARDS.
        
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
 //RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\RetrievalPrevious50RecordsFromCustomerTable.xml").                
        DataRetrievalRequest:QueryBlocks[1]:WherePhrase = SUBSTITUTE("CustNum < &1", Buffer1Handle::CustNum).  
        
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).
        
        IF VALID-HANDLE(LastTempTableHandle)
        THEN DELETE OBJECT LastTempTableHandle.
        IF VALID-HANDLE(Buffer1Handle)
        THEN DELETE OBJECT Buffer1Handle.
        IF VALID-HANDLE(Buffer2Handle)
        THEN DELETE OBJECT Buffer2Handle.
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

    END METHOD.
    
    
    /*****************************************************************************/
    
     @Test.
    METHOD PUBLIC VOID FastPositionFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalRequestTemp AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
            
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer1Handle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer2Handle AS HANDLE NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().        
        DataRetrievalRequest:FastPositionQueryString = " Name BEGINS 'T'".
        DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition.
        DataRetrievalRequest:SortingPhrase = "BY Customer.Name".        
        
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
 RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\FastPositionFromCustomerTable.xml").  
     
        CREATE BUFFER Buffer1Handle FOR TABLE "Customer".
        CREATE BUFFER Buffer2Handle FOR TABLE "Salesrep".
        CREATE QUERY QueryHandle.
        
        ASSIGN DataRetrievalRequest:SortingPhrase = "by Customer.Name DESCENDING".
        DataRetrievalRequest:QueryBlocks[1]:WherePhrase = "Customer.Name < 'T'".
        QueryHandle:SET-BUFFERS(Buffer1Handle, Buffer2Handle).
        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
        QueryHandle:QUERY-OPEN().
        QueryHandle:GET-FIRST().
        DO WHILE QueryHandle:QUERY-OFF-END = NO:
            
            IF Counter > DataRetrievalConstant:StepsOfRepositionBackwards - 3
            THEN LEAVE.
            
            ASSIGN Counter = Counter + 1.    
            QueryHandle:GET-NEXT (NO-LOCK).   
        END.        
       
        DataRetrievalRequest:QueryBlocks[1]:WherePhrase = SUBSTITUTE("Name >= '&1'", Buffer1Handle::Name). 
        DataRetrievalRequest:SortingPhrase = "by Customer.Name".
        
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).
        
        IF VALID-HANDLE(LastTempTableHandle)
        THEN DELETE OBJECT LastTempTableHandle.
        IF VALID-HANDLE(Buffer1Handle)
        THEN DELETE OBJECT Buffer1Handle.
        IF VALID-HANDLE(Buffer2Handle)
        THEN DELETE OBJECT Buffer2Handle.
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

    END METHOD.
    
    /*****************************************************************************/
    
     @Test.
    METHOD PUBLIC VOID RetrievalHome50RecordsFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.           
       
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().
        DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:HomeKey.
        
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
 RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\RetrievalHome50RecordsFromCustomerTable.xml").                
          
        
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).
        
        IF VALID-HANDLE(LastTempTableHandle)
        THEN DELETE OBJECT LastTempTableHandle.
        

    END METHOD.
    
    /*****************************************************************************/
    
    @Test.
    METHOD PUBLIC VOID RetrievalEnd50RecordsFromCustomerTable():
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
            
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer1Handle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer2Handle AS HANDLE NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        DataRetrievalRequest = CreateDataRetrievalRequest().
        DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:EndKey.
        
        RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).
 RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\RetrievalHome50RecordsFromCustomerTable.xml").                
        
        CREATE BUFFER Buffer1Handle FOR TABLE "Customer".
        CREATE BUFFER Buffer2Handle FOR TABLE "Salesrep".
        CREATE QUERY QueryHandle.       
        
        
        QueryHandle:SET-BUFFERS(Buffer1Handle, Buffer2Handle).
        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
        QueryHandle:QUERY-OPEN().
        QueryHandle:GET-LAST(NO-LOCK).           
        
        
        DataRetrievalRequest:Direction = DataRetrievalConstant:BACKWARDS.
        CompareRetrievedData(LastTempTableHandle, DataRetrievalRequest, DataRetrievalResponse, DataRetrievalRequest:GetQueryString()).
        
        IF VALID-HANDLE(LastTempTableHandle)
        THEN DELETE OBJECT LastTempTableHandle.
        IF VALID-HANDLE(Buffer1Handle)
        THEN DELETE OBJECT Buffer1Handle.
        IF VALID-HANDLE(Buffer2Handle)
        THEN DELETE OBJECT Buffer2Handle.
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

    END METHOD.
    
    /*****************************************************************************/
    
    METHOD VOID CompareRetrievedData(LastTempTableHandle AS HANDLE, DataRetrievalRequest AS DataRetrievalRequest,
        DataRetrievalResponse AS DataRetrievalResponse, NewQueryString AS CHARACTER):
       
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.     

        DEFINE VARIABLE QueryHandleTemptable AS HANDLE NO-UNDO.      
        
        DEFINE VARIABLE NumberOfFields AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandleTemptable AS HANDLE NO-UNDO.
        DEFINE VARIABLE RowIdCustomer AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdSalesrep AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdInTempTable AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE NumberOfAvailableFields AS INTEGER NO-UNDO.
        
        DEFINE VARIABLE Buffer1Handle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Buffer2Handle AS HANDLE NO-UNDO.
       
            
        
        /* --------------------------------------------------------------------- */
  
        ASSIGN NumberOfRecords = QueryHelper:GetNumberOfRecordsInTemptable(LastTempTableHandle).  
     
        Assert:AreEqual(NumberOfRecords, 50, "number of records in temptable not equals 50").
        
        CREATE QUERY QueryHandle.
        
        CREATE BUFFER Buffer1Handle FOR TABLE "Customer".
        CREATE BUFFER Buffer2Handle FOR TABLE "Salesrep".
        
        QueryHandle:SET-BUFFERS(Buffer1Handle, Buffer2Handle).  
  
        QueryHandle:QUERY-PREPARE(NewQueryString).
        
        QueryHandle:QUERY-OPEN().
        QueryHandle:GET-FIRST(NO-LOCK).
        
        IF DataRetrievalRequest:Direction = DataRetrievalConstant:Backwards
        THEN DO:
            QueryHandle:GET-LAST(NO-LOCK).
            ASSIGN Counter = 1.
            DO WHILE QueryHandle:QUERY-OFF-END = NO AND Counter < DataRetrievalResponse:NumberOfRecordsRetrieved:
                QueryHandle:GET-PREV().
                ASSIGN Counter = Counter + 1.
            END.
        END.
  
        CREATE QUERY QueryHandleTemptable.
        ASSIGN BufferHandleTemptable = LastTempTableHandle:DEFAULT-BUFFER-HANDLE.
        QueryHandleTemptable:ADD-BUFFER(BufferHandleTemptable).
  
        QueryHandleTemptable:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1", BufferHandleTemptable:TABLE)).
        QueryHandleTemptable:QUERY-OPEN().
        QueryHandleTemptable:GET-FIRST(). 
        
        DO WHILE QueryHandleTemptable:QUERY-OFF-END = NO:   
            
            DO Counter = 1 TO QueryHandle:GET-BUFFER-HANDLE(1):NUM-FIELDS:
                
                IF QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):AVAILABLE               
                THEN DO:   
                    Assert:AreEqual(QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):BUFFER-VALUE(),
                        BufferHandleTemptable:BUFFER-FIELD(QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):NAME):BUFFER-VALUE()).                         
                END.                
            END.    
            
            DO Counter = 1 TO QueryHandle:GET-BUFFER-HANDLE(2):NUM-FIELDS:
                IF LOOKUP(QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):NAME, DataRetrievalRequest:QueryBlocks[2]:FieldList) > 0
                THEN DO:                  
                    Assert:AreEqual(QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):BUFFER-VALUE(),
                        BufferHandleTemptable:BUFFER-FIELD(QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):NAME):BUFFER-VALUE()).                         
                    
                END.                
            END.
            
            ASSIGN RowIdCustomer = STRING(QueryHandle:GET-BUFFER-HANDLE(1):ROWID).
            ASSIGN RowIdSalesrep = STRING(QueryHandle:GET-BUFFER-HANDLE(2):ROWID).
            ASSIGN RowIdInTempTable = STRING(BufferHandleTemptable:BUFFER-FIELD["f_rowid_"]:BUFFER-VALUE()).
            ASSIGN RowIdCustomer = SUBSTITUTE("&1&2&3", RowIdCustomer, CHR(5), RowIdSalesrep).
          
            Assert:IsTrue(RowIdCustomer = RowIdInTempTable).
            
            QueryHandleTemptable:GET-NEXT(NO-LOCK).
            QueryHandle:GET-NEXT(NO-LOCK).
   
            IF NumberOfRecords >= DataRetrievalResponse:NumberOfRecordsRetrieved
            THEN LEAVE.
            NumberOfRecords = NumberOfRecords + 1.
        END.
        
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.
        
        IF VALID-HANDLE(QueryHandleTemptable)
        THEN DELETE OBJECT QueryHandleTemptable.
        
        IF VALID-HANDLE(Buffer1Handle)
        THEN DELETE OBJECT Buffer1Handle.
        
        IF VALID-HANDLE(Buffer2Handle)
        THEN DELETE OBJECT Buffer2Handle.
    END.

    /*****************************************************************************/
    
    METHOD PRIVATE DataRetrievalRequest CreateDataRetrievalRequest():

        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE QueryBlocks AS QueryBlock EXTENT 2 NO-UNDO.
        DEFINE VARIABLE QueryBlcok AS QueryBlock NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FOR EACH":U
            QueryBlcok:TableName = "Customer":U
            QueryBlcok:FieldList = "CustNum Name Address Address2 Balance City Comments Contact Country CreditLimit Discount EmailAddress Fax Phone PostalCode SalesRep State Terms":U
            QueryBlcok:WherePhrase = "":U
            QueryBlcok:Hints = "NO-LOCK":U
            .

        QueryBlocks[1] = QueryBlcok.

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FIRST":U
            QueryBlcok:TableName = "Salesrep":U
            QueryBlcok:FieldList = " RepName SalesRep":U
            QueryBlcok:WherePhrase = "Salesrep.SalesRep  = Customer.SalesRep":U
            QueryBlcok:Hints = "NO-LOCK OUTER-JOIN":U
            .

        QueryBlocks[2] = QueryBlcok.

        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = 50
            DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
            DataRetrievalRequest:QueryBlocks = QueryBlocks
            DataRetrievalRequest:SortingPhrase = "BY Customer.CustNum"
            .

        RETURN DataRetrievalRequest.

    END.

END CLASS.
