
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.server.GenericDataRetrievalHandler:

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

        ASSIGN
            DataRetrievalResponse = NEW DataRetrievalResponse()
            DataRetrievalResponse:DataRetrievalRequest = DataRetrievalRequest
            DataRetrievalResponse:ProcessStartTime = NOW
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

        //TempTableBufferHandle:EMPTY-TEMP-TABLE().
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
            MESSAGE DataRetrievalRequest:GetQueryStringForFastPosition() VIEW-AS ALERT-BOX.
            QueryHandle:QUERY-CLOSE().
            QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryStringForFastPosition()).
            QueryHandle:QUERY-OPEN().
            QueryHandle:GET-FIRST(NO-LOCK).

            DEFINE VARIABLE QueryRowIdentifier AS QueryRowIdentifier NO-UNDO.
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).

            QueryHandle:QUERY-CLOSE().
            QueryHandle:QUERY-PREPARE(DataRetrievalRequest:GetQueryString()).
            QueryHandle:QUERY-OPEN().
            QueryHandle:GET-FIRST(NO-LOCK).
            QueryRowIdentifier:RepositionQuery(QueryHandle).
            QueryHandle:REPOSITION-BACKWARD(10).
            QueryHandle:GET-NEXT(NO-LOCK).
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            DataRetrievalRequest:ToBeRepositionedRecord = QueryRowIdentifier:ToString().

        END.
/*END CHANGE FASTPOSITION QUERY*/

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
        //TempTableBufferHandle:FILL-MODE = "REPLACE":U.

/*--REPOSITION*/
     /*   IF DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
        THEN DO:
            //QueryHandle:REPOSITION-BACKWARD(10).
            QueryHandle:REPOSITION-FORWARD(10).
            QueryHandle:GET-NEXT().
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            DataRetrievalRequest:ToBeRepositionedRecord = QueryRowIdentifier:ToString().
        END.
     */
        IF DataRetrievalRequest:ToBeRepositionedRecord > ""
        THEN DO:
            /* it works
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
            QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            */

/* it works
            QueryRowIdentifier = NEW QueryRowIdentifier().
            QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
            QueryRowIdentifier:RepositionQuery(QueryHandle).
            QueryHandle:GET-NEXT().
            QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
            QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
*/

            //QueryHandle:REPOSITION-TO-ROWID(TO-ROWID('0x000000000008168e'), TO-ROWID('0x000000000000d102')).
            QueryRowIdentifier = NEW QueryRowIdentifier().
            IF DataRetrievalRequest:Direction = DataRetrievalConstant:FORWARDS AND DataRetrievalRequest:BatchSize > 0
            THEN DO:
                QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
                QueryRowIdentifier:RepositionQuery(QueryHandle).
                QueryHandle:GET-NEXT(NO-LOCK).
                QueryHandle:GET-NEXT(NO-LOCK).
                QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
                QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            END.
            ELSE IF DataRetrievalRequest:Direction = DataRetrievalConstant:Backwards AND DataRetrievalRequest:BatchSize > 0
            THEN DO:
                QueryRowIdentifier:ParseString(DataRetrievalRequest:ToBeRepositionedRecord).
                QueryRowIdentifier:RepositionQuery(QueryHandle).
                QueryHandle:REPOSITION-BACKWARD(DataRetrievalRequest:BatchSize).
                QueryHandle:GET-PREV(NO-LOCK).
                QueryRowIdentifier:GetQueryCurrentRowids(QueryHandle).
                QueryRowIdentifier:SetBufferRestartRowids(TempTableBufferHandle).
            END.


        END.
/*END REPOSITION*/

/*--SET CALLBACK AND FILL*/
        //TempTableBufferHandle:SET-CALLBACK("AFTER-FILL":U, "AfterFillCallback":U, THIS-OBJECT).
        TempTableBufferHandle:SET-CALLBACK("AFTER-ROW-FILL":U, "AfterRowFillCallback":U, THIS-OBJECT) .
        TempTableBufferHandle:FILL().
/*END CALLBACK AND FILL*/

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

    METHOD PUBLIC FINAL VOID AfterRowFillCallback(DATASET-HANDLE DataSetHandle):
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN BufferHandle = DataSetHandle:GET-BUFFER-HANDLE("temptable").
        DO Counter = 1 TO BufferHandle:DATA-SOURCE:NUM-SOURCE-BUFFERS:
            IF Counter = 1 THEN
                BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE =
                    STRING(BufferHandle:DATA-SOURCE:GET-SOURCE-BUFFER(Counter):ROWID).
            ELSE DO:
                BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE =
                    SUBSTITUTE("&1&2&3":U, STRING(BufferHandle:BUFFER-FIELD("f_rowid_":U):BUFFER-VALUE), CHR(5), STRING(BufferHandle:DATA-SOURCE:GET-SOURCE-BUFFER(Counter):ROWID)).
            END.
        END.

    END METHOD. /* AfterRowFillCallback */

END CLASS.
