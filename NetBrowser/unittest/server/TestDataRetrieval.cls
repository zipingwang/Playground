USING OEUnit.Assertion.Assert FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.QueryBlock FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING Playground.NetBrowser.shared.QueryHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.unittest.server.TestDataRetrieval:
    

    @BeforeClass.
    METHOD PUBLIC VOID SetUp():
        
      
    END METHOD.

    /*****************************************************************************/
    
    @AfterClass.
    METHOD PUBLIC VOID AfterAllTests():
         

    END METHOD.
    
    /*****************************************************************************/


    
    /*****************************************************************************/

   /*****************************************************************************/

   
    
    /*****************************************************************************/

   
    /*****************************************************************************/

   
    
    /*****************************************************************************/
    
    METHOD VOID CompareRetrievedData(LastTempTableHandle AS HANDLE, DataRetrievalRequest AS DataRetrievalRequest,
        DataRetrievalResponse AS DataRetrievalResponse, NewQueryString AS CHARACTER):
       
        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.     
        //DEFINE BUFFER b_Customer FOR Customer.
        //DEFINE BUFFER b_Salesrep FOR Salesrep.
        DEFINE VARIABLE QueryHandleTemptable AS HANDLE NO-UNDO.      
        
        DEFINE VARIABLE NumberOfFields AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandleTemptable AS HANDLE NO-UNDO.
        DEFINE VARIABLE RowIdCustomer AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdSalesrep AS CHARACTER NO-UNDO.
        DEFINE VARIABLE RowIdInTempTable AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE NumberOfAvailableFields AS INTEGER NO-UNDO.
       
            
        
        /* --------------------------------------------------------------------- */
  
        ASSIGN NumberOfRecords = QueryHelper:GetNumberOfRecordsInTemptable(LastTempTableHandle).  
        
        Assert:AreEqual(NumberOfRecords, 50, "number of records in temptable not equals 50").
        
        CREATE QUERY QueryHandle.
        QueryHandle:SET-BUFFERS(BUFFER Customer:HANDLE, BUFFER Salesrep:HANDLE).  
        //MESSAGE NewQueryString VIEW-AS ALERT-BOX.
        QueryHandle:QUERY-PREPARE(NewQueryString).
        
        QueryHandle:QUERY-OPEN().
        QueryHandle:GET-FIRST(NO-LOCK).
        //QueryHandle:REPOSITION-FORWARD(QueryHandle:NUM-RESULTS -  DataRetrievalResponse:NumberOfRecordsRetrieved).
        //QueryHandle:GET-NEXT(NO-LOCK).
        
        IF DataRetrievalRequest:Direction = DataRetrievalConstant:Backwards
        THEN DO:
            QueryHandle:GET-LAST(NO-LOCK).
            ASSIGN Counter = 1.
            DO WHILE QueryHandle:QUERY-OFF-END = NO AND Counter < DataRetrievalResponse:NumberOfRecordsRetrieved:
                QueryHandle:GET-PREV().
                ASSIGN Counter = Counter + 1.
            END.
        END.

        //MESSAGE "backwards" QueryHandle:NUM-RESULTS -  DataRetrievalResponse:NumberOfRecordsRetrieved VIEW-AS ALERT-BOX.
        
        //Assert:IsTrue(QueryHandle:NUM-RESULTS < 50, "number of records in customer is less than 50").
    
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
/*                    MESSAGE QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):BUFFER-VALUE()                                 */
/*                    BufferHandleTemptable:BUFFER-FIELD(QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):NAME):BUFFER-VALUE()*/
/*                    VIEW-AS                                                                                                       */
/*                    ALERT-BOX.                                                                                                    */
                    
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
                    
      /* MESSAGE  "buffer 2 number fields:" QueryHandle:GET-BUFFER-HANDLE(2):NUM-FIELDS VIEW-AS ALERT-BOX.
       MESSAGE QueryHandle:PREPARE-STRING VIEW-AS ALERT-BOX.
            ASSIGN NumberOfAvailableFields = 0.  
            DO Counter = 1 TO QueryHandle:GET-BUFFER-HANDLE(2):NUM-FIELDS:
                IF QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):AVAILABLE
                THEN DO:
                    ASSIGN NumberOfAvailableFields = NumberOfAvailableFields + 1.
                    MESSAGE
                    Counter
                    QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):NAME
                    QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):BUFFER-VALUE()
                 
                    VIEW-AS ALERT-BOX.
                    //Assert:AreEqual(QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):BUFFER-VALUE(),
                    //    BufferHandleTemptable:BUFFER-FIELD(QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):NAME):BUFFER-VALUE()).                         
                    
                END.                
            END.
            MESSAGE "NumberOfAvailableFields" NumberOfAvailableFields VIEW-AS ALERT-BOX.
       */     
            
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
