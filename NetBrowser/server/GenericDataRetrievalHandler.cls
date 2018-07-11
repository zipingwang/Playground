
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
USING be.mips.ablframework.shared.database.TableInfo FROM PROPATH.
USING Playground.NetBrowser.shared.RowIdHelper FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalException FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.server.GenericDataRetrievalHandler:
    DEFINE VARIABLE DataRetrievalResponse_ AS DataRetrievalResponse NO-UNDO.
    DEFINE VARIABLE Found AS LOGICAL NO-UNDO INITIAL NO.

    METHOD PUBLIC HANDLE RetrievalData(DataRetrievalRequest AS DataRetrievalRequest, OUTPUT DataRetrievalResponse AS DataRetrievalResponse):
        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE DataSourceHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE TempTableBufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE DataSetHandle AS HANDLE NO-UNDO.
        DEFINE BUFFER b_User FOR sc_User.
        DEFINE BUFFER b_Language FOR gp_Language.
        DEFINE VARIABLE TempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandles AS HANDLE EXTENT NO-UNDO.
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE QueryHandleFastPosition AS HANDLE NO-UNDO.
        DEFINE VARIABLE FieldsInOneBuffer AS CHARACTER NO-UNDO.
        DEFINE VARIABLE FieldCounter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfFields AS INTEGER NO-UNDO.
        DEFINE VARIABLE FieldName AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfBuffers AS INTEGER NO-UNDO.
        DEFINE VARIABLE ReturnValue AS LOGICAL NO-UNDO.

        ASSIGN
            DataRetrievalResponse = NEW DataRetrievalResponse()
            DataRetrievalResponse:DataRetrievalRequest = DataRetrievalRequest
            DataRetrievalResponse:ProcessStartTime = NOW
            DataRetrievalResponse_ = DataRetrievalResponse
            .

        //ASSIGN BufferHandle = TEMP-TABLE VALUE(ClientToServerContext:TempTableName):DEFAULT-BUFFER-HANDLE.
        CREATE TEMP-TABLE TempTableHandle.

        CREATE DATA-SOURCE DataSourceHandle.

/*--CREATE QUERY*/
        CREATE QUERY QueryHandle.
        ASSIGN NumberOfBuffers = NUM-ENTRIES (DataRetrievalRequest:BufferNames).
        EXTENT (BufferHandles) = ? .
        EXTENT (BufferHandles) = NumberOfBuffers.
        DO Counter = 1 TO NumberOfBuffers:
            CREATE BUFFER BufferHandles[Counter] FOR TABLE ENTRY(Counter, DataRetrievalRequest:BufferNames).
            QueryHandle:ADD-BUFFER(BufferHandles[Counter]).
        END.

        QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
        QueryHandle:QUERY-OPEN().

/*END CREATE QUERY*/

/*CREATE TEMP TABLE*/
        QueryHandle:GET-FIRST().

        CREATE TEMP-TABLE TempTableHandle.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.

        DO Counter = 1 TO NumberOfBuffers:
            ASSIGN BufferHandle = BufferHandles[Counter].
            FieldsInOneBuffer = DataRetrievalRequest:QueryBlocks[Counter]:FieldList.
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

        /*add rowid field*/
        TempTableHandle:ADD-NEW-FIELD("f_rowid_", "CHARACTER").

        TempTableHandle:TEMP-TABLE-PREPARE("temptable").

        ASSIGN TempTableBufferHandle = TempTableHandle:DEFAULT-BUFFER-HANDLE.

        //RUN playground/temptablehelper/dumptemptable (TempTableHandle, "d:\temp\temptablebeforefill.xml").


/*END CREATE TEMP TABLE*/

/*-- GET FirstRowIdsInWholeDB*/
        QueryHandle:GET-FIRST(NO-LOCK).
        DataRetrievalResponse:FirstRowIdsInWholeDB = RowIdHelper:GetRowIdsFromQueryHandle(QueryHandle).
        QueryHandle:GET-LAST(NO-LOCK).
        DataRetrievalResponse:LastRowIdsInWholeDB = RowIdHelper:GetRowIdsFromQueryHandle(QueryHandle).
        QueryHandle:GET-FIRST(NO-LOCK).
/*END GET FirstRowIdsInWholeDB*/

/*---CHANGE FASTPOSITION QUERY*/
        IF DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
        THEN DO:
           // MESSAGE DataRetrievalRequest:GetQueryStringForFastPosition() VIEW-AS ALERT-BOX.
            QueryHandle:QUERY-CLOSE().
            QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryStringForFastPosition()).
            QueryHandle:QUERY-OPEN().
            ReturnValue = QueryHandle:GET-FIRST(NO-LOCK).
            IF ReturnValue = NO
            THEN DO:
                UNDO, THROW NEW DataRetrievalException
                    (SUBSTITUTE("Cannot do fast position. query: &1", DataRetrievalRequest:GetQueryStringForFastPosition())).
            END.
            DEFINE VARIABLE QueryRowIdentifier AS QueryRowIdentifier NO-UNDO.
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            QueryHandle:QUERY-CLOSE().
            DataRetrievalResponse:ActiveRowId = QueryRowIdentifier:ToString().


            QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
            QueryHandle:QUERY-OPEN().
            QueryHandle:GET-FIRST(NO-LOCK).
            ReturnValue = QueryRowIdentifier:RepositionQuery(QueryHandle).
            IF ReturnValue = NO
            THEN DO:
                UNDO, THROW NEW DataRetrievalException
                    (SUBSTITUTE("Cannot RepositionQuery. rowids: &1", QueryRowIdentifier:ToString())).
            END.

            QueryHandle:REPOSITION-BACKWARD(DataRetrievalConstant:StepsOfRepositionBackwards).
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            DataRetrievalRequest:ToBeRepositionedRecord = QueryRowIdentifier:ToString().

        END.
/*END CHANGE FASTPOSITION QUERY*/

/*---CHANGE Sorting RepositionId*/
        IF DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting
        THEN DO:

            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
            QueryRowIdentifier:RepositionQuery(QueryHandle).
            DataRetrievalResponse:ActiveRowId = DataRetrievalRequest:ToBeRepositionedRecord.
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryHandle:REPOSITION-BACKWARD(DataRetrievalConstant:StepsOfRepositionBackwards).
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            DataRetrievalRequest:ToBeRepositionedRecord = QueryRowIdentifier:ToString().
        END.
/*END CHANGE Sorting RepositionId*/

/*---CHANGE HOME RepositionId*/
        IF DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:HomeKey
        THEN DO:      
            DataRetrievalRequest:Direction = DataRetrievalConstant:FORWARDS.
            DataRetrievalRequest:ToBeRepositionedRecord = DataRetrievalResponse:FirstRowIdsInWholeDB.
        END.
/*END CHANGE HOME RepositionId*/

/*---CHANGE END RepositionId*/
        IF DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:EndKey
        THEN DO:      
            DataRetrievalRequest:ToBeRepositionedRecord = DataRetrievalResponse:LastRowIdsInWholeDB.
            DataRetrievalRequest:Direction = DataRetrievalConstant:BACKWARDS.
        END.
/*END CHANGE END RepositionId*/


        FillTempTable(QueryHandle, TempTableHandle, TempTableBufferHandle,
            BufferHandles, NumberOfBuffers,  DataRetrievalRequest, DataRetrievalResponse).

        //RUN playground/temptablehelper/dumptemptable (TempTableHandle, "d:\temp\temptableafterfill.xml").

        DataRetrievalResponse:ProcessEndTime = NOW.

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
    METHOD PUBLIC HANDLE RetrievalDataWithoutBatch(DataRetrievalRequest AS DataRetrievalRequest, OUTPUT DataRetrievalResponse AS DataRetrievalResponse):
        IF DataRetrievalRequest:BatchSize <=0 THEN
        DO:

        END.
    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID FillTempTable(QueryHandle AS HANDLE, TempTableHandle AS HANDLE, TempTableBufferHandle AS HANDLE
        , BufferHandles AS HANDLE EXTENT, NumberOfBuffers AS INTEGER,
        DataRetrievalRequest AS  DataRetrievalRequest, DataRetrievalResponse AS DataRetrievalResponse ):

        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
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

/*REPOSITION*/
        IF DataRetrievalRequest:ToBeRepositionedRecord > ""
        THEN DO:

            QueryRowIdentifier = NEW QueryRowIdentifier().
            IF DataRetrievalRequest:Direction = DataRetrievalConstant:FORWARDS AND DataRetrievalRequest:BatchSize > 0
            THEN DO:
                QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
                QueryRowIdentifier:RepositionQuery(QueryHandle).

                IF DataRetrievalResponse:FirstRowIdsInWholeDB = QueryRowIdentifier:ToString()
                THEN QueryHandle:GET-PREV(NO-LOCK).
                ELSE DO:
                    QueryHandle:GET-NEXT(NO-LOCK).
                    QueryHandle:GET-NEXT(NO-LOCK).
                END.
                QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
                QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            END.
            ELSE IF DataRetrievalRequest:Direction = DataRetrievalConstant:Backwards AND DataRetrievalRequest:BatchSize > 0
            THEN DO:
                QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
                QueryRowIdentifier:RepositionQuery(QueryHandle).
                
                IF DataRetrievalResponse:LastRowIdsInWholeDB = QueryRowIdentifier:ToString()
                THEN DO:
                    QueryHandle:REPOSITION-BACKWARD(DataRetrievalRequest:BatchSize).
                    QueryHandle:GET-NEXT(NO-LOCK).
                    QueryHandle:GET-NEXT(NO-LOCK).
                END.
                ELSE DO:
                    QueryHandle:REPOSITION-BACKWARD(DataRetrievalRequest:BatchSize).
                    //QueryHandle:GET-PREV(NO-LOCK).
                END.   
                
                QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
                QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            END.


        END.
/*END REPOSITION*/

/*--SET CALLBACK AND FILL*/

        DataRetrievalResponse:PositionOfRepositionedRowIdInCurrentBatch = 0.
        ASSIGN Found = NO.
        TempTableBufferHandle:SET-CALLBACK("AFTER-ROW-FILL":U, "AfterRowFillCallback":U, THIS-OBJECT) .
        TempTableBufferHandle:FILL().

        /*e.g. fastpostion to 'z' but it is at 3 before end, it it has maximum 13 rows. we want 50(it is required for ultragrid)*/
        IF DataRetrievalRequest:BatchSize > 0
            AND DataRetrievalResponse:LastRowIdsInThisBatch = DataRetrievalResponse:LastRowIdsInWholeDB
            AND DataRetrievalResponse:NumberOfRecordsRetrieved < DataRetrievalResponse:DataRetrievalRequest:BatchSize
            AND DataRetrievalResponse:FirstRowIdsInThisBatch <> DataRetrievalResponse:FirstRowIdsInWholeDB
            AND (DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
                OR DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting)
        THEN DO:
            TempTableBufferHandle:EMPTY-TEMP-TABLE().

            QueryRowIdentifier = NEW QueryRowIdentifier().
            IF DataRetrievalResponse:ActiveRowId <= ""
            THEN
                MESSAGE DataRetrievalResponse:ActiveRowId VIEW-AS ALERT-BOX.

            QueryRowIdentifier:ParseString(DataRetrievalResponse:ActiveRowId).
            QueryHandle:QUERY-OPEN().
            QueryRowIdentifier:RepositionQuery(QueryHandle).
            //DataRetrievalResponse:RepositionedRowId = DataRetrievalResponse:RepositionedRowId.
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryHandle:REPOSITION-BACKWARD(DataRetrievalResponse:DataRetrievalRequest:BatchSize - DataRetrievalResponse:NumberOfRecordsRetrieved).
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            //DataRetrievalRequest:ToBeRepositionedRecord = QueryRowIdentifier:ToString().

            ASSIGN Found = NO
                DataRetrievalResponse_:FirstRowIdsInThisBatch = ?
                DataRetrievalResponse_:LastRowIdsInThisBatch = ?
                DataRetrievalResponse_:PositionOfRepositionedRowIdInCurrentBatch = 0
                DataRetrievalResponse_:NumberOfRecordsRetrieved = 0.
            QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            TempTableBufferHandle:FILL().
        END.
/*END CALLBACK AND FILL*/

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
    METHOD PRIVATE VOID FillTempTable2(QueryHandle AS HANDLE, TempTableHandle AS HANDLE, TempTableBufferHandle AS HANDLE,
        BatchSize AS INTEGER, BufferHandles AS HANDLE EXTENT,  NumberOfBuffers AS INTEGER ):

        DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE FieldCounter AS INTEGER NO-UNDO.

        QueryHandle:GET-FIRST(NO-LOCK).

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
            QueryHandle:GET-NEXT(NO-LOCK).
        END.
    END.

    /*****************************************************************************/

    METHOD PUBLIC FINAL VOID AfterFillCallback(DATASET-HANDLE TempTableHandle):
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.

        /* --------------------------------------------------------------------- */
        ASSIGN BufferHandle = TempTableHandle:GET-BUFFER-HANDLE("temptable").
        CREATE QUERY QueryHandle.
        QueryHandle:ADD-BUFFER(BufferHandle).
        QueryHandle:QUERY-PREPARE("FOR EACH temptable":U).
        QueryHandle:QUERY-OPEN().

        QueryHandle:GET-FIRST(NO-LOCK).
        DO WHILE NOT QueryHandle:QUERY-OFF-END:
           BufferHandle:BUFFER-FIELD("f_rowid_"):BUFFER-VALUE() = STRING(BufferHandle:ROWID).

           //MESSAGE BufferHandle:BUFFER-FIELD("usr_LoginName"):BUFFER-VALUE() BufferHandle:BUFFER-FIELD("f_rowid_"):BUFFER-VALUE() VIEW-AS ALERT-BOX.
           QueryHandle:GET-NEXT(NO-LOCK).
        END.

        QueryHandle:QUERY-CLOSE().
        DELETE OBJECT QueryHandle.


    END METHOD. /* AfterFillCallback */

    /*****************************************************************************/

    METHOD PUBLIC FINAL VOID AfterRowFillCallback(DATASET-HANDLE DataSetHandle):
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferCounter AS INTEGER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN BufferHandle = DataSetHandle:GET-BUFFER-HANDLE("temptable").
        DO BufferCounter = 1 TO BufferHandle:DATA-SOURCE:NUM-SOURCE-BUFFERS:
            IF BufferCounter = 1 THEN
                BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE =
                    STRING(BufferHandle:DATA-SOURCE:GET-SOURCE-BUFFER(BufferCounter):ROWID).
            ELSE DO:
                BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE =
                    SUBSTITUTE("&1&2&3":U, STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE), CHR(5),
                        STRING(BufferHandle:DATA-SOURCE:GET-SOURCE-BUFFER(BufferCounter):ROWID)).
            END.
        END.

        IF DataRetrievalResponse_:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
            OR DataRetrievalResponse_:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting
            THEN DO:
               /* IF STRING(BufferHandle:BUFFER-FIELD("usr_LoginName":U):BUFFER-VALUE) = "5556_user2"
                THEN DO:
                    MESSAGE STRING(BufferHandle:BUFFER-FIELD("usr_LoginName":U):BUFFER-VALUE) BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE
                      DataRetrievalResponse_:RepositionedRowId  VIEW-AS ALERT-BOX.
                END.*/

                IF STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE) = DataRetrievalResponse_:ActiveRowId
                   // OR STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE) = DataRetrievalResponse_:DataRetrievalRequest:ToBeRepositionedRecord
                THEN ASSIGN Found = YES.

                IF Found = NO
                THEN ASSIGN DataRetrievalResponse_:PositionOfRepositionedRowIdInCurrentBatch = DataRetrievalResponse_:PositionOfRepositionedRowIdInCurrentBatch + 1.
        END.

        IF DataRetrievalResponse_:FirstRowIdsInThisBatch <= ""
        THEN  DataRetrievalResponse_:FirstRowIdsInThisBatch = STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE).

        DataRetrievalResponse_:LastRowIdsInThisBatch = STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE).
        DataRetrievalResponse_:NumberOfRecordsRetrieved = DataRetrievalResponse_:NumberOfRecordsRetrieved + 1.

    END METHOD. /* AfterRowFillCallback */

    /*****************************************************************************/

    METHOD PUBLIC INTEGER GetRepositionBackwardSteps(QueryHandle AS Handle):
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

        DO WHILE QueryHandle:QUERY-OFF-END = NO:
            ASSIGN Counter = Counter + 1.
            QueryHandle:GET-NEXT(NO-LOCk).
        END.

    END.

END CLASS.
