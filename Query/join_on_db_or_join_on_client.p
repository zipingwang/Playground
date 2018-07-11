/*Hieronder een heel klein voorbeeldje waar join on client (96 ms) echt stukken sneller is dan join on db (4 seconden) probeeer zelf maar eens ;-)
Query komt uit onze productie code en ziet er verdomd onschuldig uit… is query die het meest gebruikt wordt door onze klanten (orders by interna lid) verander variable JoinOnServer naar YES om te testen met join on server…
*/

DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.

DEFINE VARIABLE JoinOnServer AS LOGICAL INITIAL YES.
DEFINE VARIABLE joinOnSqlDb AS CHARACTER NO-UNDO INITIAL "QUERY-TUNING(JOIN-BY-SQLDB)".
DEFINE VARIABLE NoJoinOnSqlDb AS CHARACTER NO-UNDO INITIAL "QUERY-TUNING(NO-JOIN-BY-SQLDB)".
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
DEFINE VARIABLE QueryToExecute AS CHARACTER NO-UNDO.
DEFINE VARIABLE ICount AS INTEGER NO-UNDO INITIAL 0.

DEFINE BUFFER b_order FOR glims.Order.
DEFINE BUFFER b_Issuer FOR Correspondent.
DEFINE BUFFER b_object FOR glims.Object.
DEFINE BUFFER b_StudyEpisode FOR StudyEpisode.

ASSIGN QueryString = "FOR EACH b_Order FIELDS( ord_Id ord_InternalId ord_Issuer " +
     " ord_LowestObjectTime ord_Object ord_ReceiptTime ord_Status ord_StudyEpisode ord_Urgency ) " +
     " WHERE b_Order.ord_Status <> 1  NO-LOCK  , EACH b_Issuer FIELDS( crsp_Id crsp_Name ) NO-LOCK " +
     " OUTER-JOIN WHERE b_Issuer.crsp_Id = b_Order.ord_Issuer, EACH b_Object FIELDS( obj_Externalization obj_Id ) " +
     " NO-LOCK  WHERE b_Object.obj_Id = b_Order.ord_Object, EACH b_StudyEpisode FIELDS( stde_Id stde_Mnemonic ) NO-LOCK  " +
     " OUTER-JOIN WHERE b_StudyEpisode.stde_Id = b_Order.ord_StudyEpisode  BY b_Order.ord_InternalId  " +
     " INDEXED-REPOSITION &1".
     
CREATE QUERY hQuery.
hQuery:ADD-BUFFER (BUFFER b_order:HANDLE).     
hQuery:ADD-BUFFER (BUFFER b_Issuer:HANDLE).     
hQuery:ADD-BUFFER (BUFFER b_object:HANDLE).     
hQuery:ADD-BUFFER (BUFFER b_StudyEpisode:HANDLE).     

IF JoinOnServer
THEN ASSIGN QueryToExecute = SUBSTITUTE(QueryString, joinOnSqlDb).
ELSE ASSIGN QueryToExecute = SUBSTITUTE(QueryString, NoJoinOnSqlDb).

hQuery:QUERY-PREPARE (QueryToExecute).


MESSAGE SUBSTITUTE("START  ~n&1", QueryToExecute) VIEW-AS ALERT-BOX.
ETIME(YES).   
hQuery:QUERY-OPEN.
hQuery:GET-FIRST().
DO WHILE NOT hQuery:QUERY-OFF-END AND ICOUNT < 50:
    hQuery:Get-Next().
    ASSIGN ICOUNT = ICOUNT + 1.
END.
DELETE OBJECT hQuery.
MESSAGE SUBSTITUTE(" END - etime = &1":U,ETIME(NO) ) VIEW-AS ALERT-BOX.

//if get only 50 records, NO-JOIN-BY-SQLDB is much faster 
//Join on server:YES, 50, 9742
//Join on server:NO, 50, 896

//Join on server:YES, 5000, 24263
//Join on server:NO, 5000, 33533
