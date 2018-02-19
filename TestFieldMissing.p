DEFINE VARIABLE TestResult AS CHARACTER NO-UNDO INITIAL "".
DEFINE VARIABLE MyQuery AS CHARACTER NO-UNDO.
DEFINE VARIABLE MyQueryOK AS CHARACTER NO-UNDO.
DEFINE VARIABLE MyQueryError AS CHARACTER NO-UNDO.
DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
DEFINE VARIABLE DistibutorId AS INTEGER NO-UNDO INITIAL 652440.
DEFINE VARIABLE MyRowId AS ROWID NO-UNDO.

DEFINE BUFFER b_SortingZone FOR SortingZone.

ASSIGN DistibutorId = 442268. /* DEV ORACLE */
ASSIGN DistibutorId = 346440. /* 9.5 ORALCE*/
ASSIGN DistibutorId = 652440. /* DEV Progress*/

ASSIGN MyQueryOK = SUBSTITUTE("FOR EACH b_SortingZone FIELDS( srtz_Distributor srtz_Id srtz_SeqNo ) WHERE " +
" b_SortingZone.srtz_Distributor = &1 USE-INDEX srtz_Distributor_Code NO-LOCK BY b_SortingZone.srtz_SeqNo INDEXED-REPOSITION":U, DistibutorId).

ASSIGN MyQueryError = SUBSTITUTE("FOR EACH b_SortingZone FIELDS( srtz_Distributor srtz_Id srtz_SeqNo ) WHERE " +
" b_SortingZone.srtz_Distributor = &1 NO-LOCK BY b_SortingZone.srtz_SeqNo INDEXED-REPOSITION":U, DistibutorId).

ASSIGN MyQuery = MyQueryError.

FOR FIRST b_SortingZone WHERE b_SortingZone.srtz_Distributor = DistibutorId:
    ASSIGN MyRowId = ROWID(b_SortingZone).
END.
RELEASE b_SortingZone.

ASSIGN TestResult = TestResult + SUBSTITUTE("DistibutorId &1", DistibutorId).

ASSIGN TestResult = TestResult + "~n" + "QueryString:" + MyQuery.

CREATE QUERY QueryHandle.
QueryHandle:ADD-BUFFER (BUFFER b_SortingZone:handle).
QueryHandle:QUERY-PREPARE (MyQuery).

QueryHandle:QUERY-OPEN().
QueryHandle:REPOSITION-TO-ROWID (MyRowId).
QueryHandle:GET-NEXT().

IF AVAILABLE(b_SortingZone)
THEN DO:
    ASSIGN TestResult = TestResult + "~n" +  SUBSTITUTE("Fist record available." ).
END.

QueryHandle:REPOSITION-BACKWARD (10).
ASSIGN TestResult = TestResult + "~n" + SUBSTITUTE("After REPOSITION-BACKWARD." ).

TestResult = "Result OK." + "~n" + TestResult.
QueryHandle:QUERY-CLOSE ().

MESSAGE TestResult VIEW-AS ALERT-BOX.
 
CATCH err AS Progress.Lang.Error:
    ASSIGN TestResult= "Error message:" + "~n" + err:GetMessage(1) + "~n" + TestResult.
    MESSAGE TestResult VIEW-AS ALERT-BOX.   
END CATCH.


