
 /*------------------------------------------------------------------------
    File        : ServerToClientContext
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Tue Feb 13 11:41:16 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalResponse SERIALIZABLE:

    /*comma separated rowid of buffers in the record.
    e.g. for each sc_User, first gp_Language.., it has two buffers, the LastRecordInTheBatch will be something like this:
        0x0000dc4,0x253654.
    */
  /*  DEFINE PUBLIC PROPERTY LastRecordInTheBatch AS CHARACTER NO-UNDO
    GET.
    SET.*/

    /*e.g fasposition, or from client request. DataRetrievalRequest.ToBeRepositionedRecord*/
    DEFINE PUBLIC PROPERTY ActiveRowId AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY FirstRowIdUsedInFill AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY PositionOfRepositionedRowIdInCurrentBatch AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY NumberOfRecordsRetrieved AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY HasError AS LOGICAL NO-UNDO INITIAL NO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ErrorMessage AS CHARACTER NO-UNDO INITIAL ?
    GET.
    SET.

    DEFINE PUBLIC PROPERTY IsLastBatch AS LOGICAL NO-UNDO INITIAL NO
    GET():
        RETURN THIS-OBJECT:LastRowIdsInThisBatch = THIS-OBJECT:LastRowIdsInWholeDB.
    END.

    DEFINE PUBLIC PROPERTY IsFirstBatch AS LOGICAL NO-UNDO INITIAL NO
    GET():
        RETURN THIS-OBJECT:FirstRowIdsInThisBatch = THIS-OBJECT:FirstRowIdsInWholeDB.
    END.

    DEFINE PUBLIC PROPERTY FirstRowIdsInWholeDB AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY LastRowIdsInWholeDB AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY FirstRowIdsInThisBatch AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY LastRowIdsInThisBatch AS CHARACTER NO-UNDO
    GET.
    SET.

    //in grid, the row has blue background
    DEFINE PUBLIC PROPERTY ActiveRowPosition AS INTEGER NO-UNDO
    GET.
    SET.

    /*Time duration of the process time*/
    DEFINE PUBLIC PROPERTY ProcessDuration AS INTEGER NO-UNDO
    GET():
        DEFINE VARIABLE Duration AS INTEGER NO-UNDO.

        ASSIGN Duration = INTERVAL(THIS-OBJECT:ProcessEndTime, THIS-OBJECT:ProcessStartTime, "milliseconds").
        RETURN Duration.
    END.


    DEFINE PUBLIC PROPERTY ProcessStartTime AS DATETIME NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ProcessEndTime AS DATETIME NO-UNDO
    GET.
    SET.

    /*Data retieval request associated with this response*/
    DEFINE PUBLIC PROPERTY DataRetrievalRequest AS DataRetrievalRequest NO-UNDO
    GET.
    SET.

END CLASS.
