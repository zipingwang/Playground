DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.

DEFINE VARIABLE JoinOnServer AS LOGICAL INITIAL YES.
DEFINE VARIABLE joinOnSqlDb AS CHARACTER NO-UNDO INITIAL "QUERY-TUNING(JOIN-BY-SQLDB)".
DEFINE VARIABLE NoJoinOnSqlDb AS CHARACTER NO-UNDO INITIAL "QUERY-TUNING(NO-JOIN-BY-SQLDB)".
DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
DEFINE VARIABLE QueryToExecute AS CHARACTER NO-UNDO.
DEFINE VARIABLE ICount AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE ReturnValue AS LOGICAL NO-UNDO.

DEFINE VARIABLE RowIdOrder AS ROWID NO-UNDO.
DEFINE VARIABLE RowIdIssuer AS ROWID NO-UNDO.
DEFINE VARIABLE RowIdObject AS ROWID NO-UNDO.

DEFINE VARIABLE OrderId AS INTEGER NO-UNDO.
DEFINE VARIABLE Issuerid AS INTEGER NO-UNDO.
DEFINE VARIABLE ObjectId AS INTEGER NO-UNDO.

DEFINE BUFFER b_order FOR glims.Order.
DEFINE BUFFER b_OrderIssuer FOR Correspondent.
DEFINE BUFFER b_OrderObject FOR glims.Object.

/*
FOR EACH wb_UrgentOrder FIELDS( wurg_Id wurg_InternalId wurg_LowestObjectTime wurg_Order wurg_ResultList wurg_Urgency ) NO-LOCK  ,
EACH b_Order FIELDS( ord_Id ord_InternalId ord_Issuer ord_Object ord_Status ) NO-LOCK  WHERE b_Order.ord_Id = wb_UrgentOrder.wurg_Order,
EACH b_OrderIssuer FIELDS( crsp_Id crsp_Name ) NO-LOCK  OUTER-JOIN WHERE b_OrderIssuer.crsp_Id = b_Order.ord_Issuer,
EACH b_OrderObject FIELDS( obj_Externalization obj_Id ) NO-LOCK  OUTER-JOIN WHERE b_OrderObject.obj_Id = b_Order.ord_Object
BY wb_UrgentOrder.wurg_InternalId DESCENDING  INDEXED-REPOSITION QUERY-TUNING(NO-JOIN-BY-SQLDB HINT 'FIRST_ROWS(100)')
*/
ASSIGN QueryString = "
FOR EACH b_Order FIELDS( ord_Id ord_InternalId ord_Issuer ord_Object ord_Status ) NO-LOCK,
 EACH b_OrderIssuer FIELDS( crsp_Id crsp_Name ) NO-LOCK  OUTER-JOIN WHERE b_OrderIssuer.crsp_Id = b_Order.ord_Issuer,
 EACH b_OrderObject FIELDS( obj_Externalization obj_Id ) NO-LOCK  OUTER-JOIN WHERE b_OrderObject.obj_Id = b_Order.ord_Object
 BY b_Order.ord_InternalId DESCENDING  INDEXED-REPOSITION QUERY-TUNING(NO-JOIN-BY-SQLDB HINT 'FIRST_ROWS(100)')
    ".

FOR FIRST b_Order:
    MESSAGE b_order.ord_id    ROWID(b_Order) VIEW-AS ALERT-BOX.
END.

CREATE QUERY hQuery.
hQuery:ADD-BUFFER (BUFFER b_order:HANDLE).
hQuery:ADD-BUFFER (BUFFER b_OrderIssuer:HANDLE).
hQuery:ADD-BUFFER (BUFFER b_OrderObject:HANDLE).

hQuery:QUERY-PREPARE (QueryString).

hQuery:QUERY-OPEN.

ASSIGN
    OrderId = 106451
    Issuerid = ?
    ObjectId = 77199.

FOR FIRST b_Order WHERE b_order.ord_Id = OrderId:
    ASSIGN RowIdOrder = ROWID(b_order).
END.

FOR FIRST b_OrderIssuer WHERE b_OrderIssuer.crsp_Id = Issuerid:
    ASSIGN RowIdIssuer = ROWID(b_OrderIssuer).
END.

FOR FIRST b_OrderObject WHERE b_OrderObject.obj_Id = ObjectId:
    ASSIGN RowIdObject = ROWID(b_OrderObject).
END.


ReturnValue = hQuery:REPOSITION-TO-ROWID(RowIdOrder,RowIdIssuer, RowIdObject).

MESSAGE "ReturnValue " ReturnValue VIEW-AS ALERT-BOX.

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
