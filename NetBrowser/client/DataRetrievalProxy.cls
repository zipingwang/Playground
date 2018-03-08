
 /*------------------------------------------------------------------------
    File        : DataRetrievalProxy
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Wed Feb 28 08:58:34 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.client.DataRetrievalProxy:

    DEFINE PUBLIC PROPERTY AllowNewRequest AS LOGICAL NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY AppServerHandle AS HANDLE NO-UNDO
    GET():
        IF NOT VALID-HANDLE(AppServerHandle)
        THEN AppServerHandle = SESSION:HANDLE.
        RETURN AppServerHandle.
    END.
    SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC DataRetrievalProxy():
        SUPER ().

        ASSIGN AllowNewRequest = YES.

    END CONSTRUCTOR.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC DataRetrievalProxy(TheAppServerHandle AS HANDLE):
        SUPER ().

        //THIS-OBJECT:DataRetrievalProxy().
        ASSIGN AllowNewRequest = YES.
        ASSIGN AppServerHandle = TheAppServerHandle.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC VOID RetrievalData(INPUT-OUTPUT CurrentTempTableHandle AS HANDLE, DataRetrievalRequest AS DataRetrievalRequest,
        OUTPUT DataRetrievalResponse AS DataRetrievalResponse, TempTableQueryHandle AS HANDLE):

        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE NumberOfRecordsAfterRetrieverData AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfRecordsBeforeRetrieverData AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF AllowNewRequest = NO
        THEN DO:
            ASSIGN DataRetrievalResponse = NEW DataRetrievalResponse().
            DataRetrievalResponse:HasError = YES.
            DataRetrievalResponse:ErrorMessage = DataRetrievalConstant:PreviousRequestIsStillBusy.
        END.

        IF AllowNewRequest = YES
        THEN DO:

            ASSIGN AllowNewRequest = NO.

            ASSIGN NumberOfRecordsBeforeRetrieverData =  GetNumberOfRecordsInTemptable(CurrentTempTableHandle).
            RUN Playground/NetBrowser/server/GenericDataRetrievalHandlerInterface
                ON AppServerHandle (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).

            IF DataRetrievalResponse:HasError = YES
            THEN DO:
                MESSAGE DataRetrievalResponse:ErrorMessage VIEW-AS ALERT-BOX.
                RETURN.
            END.

            IF DataRetrievalResponse:HasError = NO
            THEN DO:
                //merge to data to current temp table
                IF NOT VALID-HANDLE(CurrentTempTableHandle)
                THEN DO:
                    CREATE TEMP-TABLE CurrentTempTableHandle.
                    CurrentTempTableHandle:CREATE-LIKE(LastTempTableHandle:DEFAULT-BUFFER-HANDLE).
                    /*CurrentTempTableHandle:ADD-NEW-INDEX('Id',YES).
                    CurrentTempTableHandle:ADD-INDEX-FIELD( 'Id','usr_Id').*/
                    CurrentTempTableHandle:TEMP-TABLE-PREPARE("temptable").
                END.

                /*clear old data before merge if it is fastposition*/
                IF (DataRetrievalResponse:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition)
                    OR (DataRetrievalResponse:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting)
                THEN DO:
                    CurrentTempTableHandle:EMPTY-TEMP-TABLE().
                    NumberOfRecordsBeforeRetrieverData = 0.
                    IF VALID-HANDLE(TempTableQueryHandle)
                    THEN TempTableQueryHandle:QUERY-OPEN().
                END.

RUN playground/temptablehelper/dumptemptable(CurrentTempTableHandle, "d:\temp\temptablebeforemerge.xml").
RUN playground/temptablehelper/dumptemptable(LastTempTableHandle, "d:\temp\LastTempTableHandle.xml").
                IF DataRetrievalResponse:DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
                THEN DO:
                    DataRetrievalResponse:ActiveRowPosition = DataRetrievalResponse:DataRetrievalRequest:ActiveRowPosition.
                    CurrentTempTableHandle:COPY-TEMP-TABLE(LastTempTableHandle, YES).
                END.
                ELSE DO:
                    LastTempTableHandle:COPY-TEMP-TABLE(CurrentTempTableHandle, YES).
                    CurrentTempTableHandle:EMPTY-TEMP-TABLE().
                    CurrentTempTableHandle:COPY-TEMP-TABLE(LastTempTableHandle, YES).
                    DataRetrievalResponse:ActiveRowPosition=
                        DataRetrievalResponse:NumberOfRecordsRetrieved + DataRetrievalResponse:DataRetrievalRequest:ActiveRowPosition.
                END.

                ASSIGN NumberOfRecordsAfterRetrieverData = GetNumberOfRecordsInTemptable(CurrentTempTableHandle).

                DataRetrievalResponse:NumberOfRecordsRetrieved = NumberOfRecordsAfterRetrieverData - NumberOfRecordsBeforeRetrieverData.

                RUN playground/temptablehelper/dumptemptable(CurrentTempTableHandle, "d:\temp\temptableaftermerge.xml").
            END.
        END.
        FINALLY:
            AllowNewRequest = YES.
        END FINALLY.

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE INTEGER GetNumberOfRecordsInTemptable(TempTableHandle AS HANDLE):
        DEFINE VARIABLE CountQueryHandle AS HANDLE NO-UNDO.

        IF NOT VALID-HANDLE(TempTableHandle)
        THEN RETURN 0.

        CREATE QUERY CountQueryHandle .
        CountQueryHandle:SET-BUFFERS (TempTableHandle:DEFAULT-BUFFER-HANDLE) .
        CountQueryHandle:QUERY-PREPARE ("PRESELECT EACH temptable") .
        CountQueryHandle:QUERY-OPEN ().

        RETURN CountQueryHandle:NUM-RESULTS.

        FINALLY:
            IF VALID-HANDLE (CountQueryHandle)
            THEN DELETE OBJECT CountQueryHandle.
        END FINALLY.

    END.

END CLASS.