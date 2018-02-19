USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

DEFINE OUTPUT PARAMETER TestResult AS CHARACTER NO-UNDO INITIAL "".

DEFINE VARIABLE MyQuery AS CHARACTER NO-UNDO.
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
DEFINE VARIABLE DistibutorId AS INTEGER NO-UNDO INITIAL 652440.
DEFINE VARIABLE MyRowId AS ROWID NO-UNDO.

DEFINE BUFFER b_SortingZone FOR SortingZone.

ASSIGN DistibutorId = 442268. /* DEV ORACLE */
ASSIGN DistibutorId = 346440. /* 9.5 ORALCE*/
ASSIGN DistibutorId = 652440. /* DEV Progress*/

//FOR EACH b_SortingZone FIELDS( srtz_Distributor srtz_Id srtz_SeqNo ) USE-INDEX srtz_Distributor_SeqNo_Cod:
//END.

ASSIGN MyQuery = SUBSTITUTE("FOR EACH b_SortingZone FIELDS( srtz_Distributor srtz_Id srtz_SeqNo ) WHERE " +
" b_SortingZone.srtz_Distributor = &1 USE-INDEX srtz_Distributor_Code NO-LOCK BY b_SortingZone.srtz_SeqNo INDEXED-REPOSITION":U, distibutorId).

FOR FIRST b_SortingZone WHERE b_SortingZone.srtz_Distributor = DistibutorId:
    ASSIGN myrowid = ROWID(b_SortingZone).
END.
RELEASE b_SortingZone.

ASSIGN TestResult = TestResult + SUBSTITUTE("DistibutorId &1", DistibutorId).

ASSIGN TestResult = TestResult + MyQuery.

CREATE QUERY hQuery.
hQuery:ADD-BUFFER (BUFFER b_SortingZone:handle).
hQuery:QUERY-PREPARE (MyQuery).

hQuery:QUERY-OPEN().
hQuery:REPOSITION-TO-ROWID (MyRowId).
hQuery:GET-NEXT().

IF AVAILABLE(b_SortingZone)
THEN DO:
    ASSIGN TestResult = TestResult + SUBSTITUTE(" Fist record available." ).
END.

hQuery:REPOSITION-BACKWARD (10).
ASSIGN TestResult = TestResult + SUBSTITUTE(" After REPOSITION-BACKWARD." ).
//hQuery:GET-NEXT ().

//IF AVAILABLE(b_SortingZone)THEN MESSAGE SUBSTITUTE("FOUND SORTINGZONRE &1":U,b_SortingZone.srtz_Id ) VIEW-AS ALERT-BOX.
//ELSE MESSAGE SUBSTITUTE("NO SORTINGZONRE ":U ) VIEW-AS ALERT-BOX.

TestResult = "OK. " + TestResult.
hQuery:QUERY-CLOSE ().

CATCH err AS Progress.Lang.Error:
    ASSIGN TestResult= "Error" + ErrorHelper:FormattedErrorMessages(err) + err:ToString() +  "~n" + err:GetMessage(1) + "~n" + TestResult.   
END CATCH.

