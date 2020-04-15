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

DEFINE BUFFER b_gp_SiteAttribute FOR genrw.gp_SiteAttribute.


/*
FOR EACH wb_UrgentOrder FIELDS( wurg_Id wurg_InternalId wurg_LowestObjectTime wurg_Order wurg_ResultList wurg_Urgency ) NO-LOCK  ,
EACH b_Order FIELDS( ord_Id ord_InternalId ord_Issuer ord_Object ord_Status ) NO-LOCK  WHERE b_Order.ord_Id = wb_UrgentOrder.wurg_Order,
EACH b_OrderIssuer FIELDS( crsp_Id crsp_Name ) NO-LOCK  OUTER-JOIN WHERE b_OrderIssuer.crsp_Id = b_Order.ord_Issuer,
EACH b_OrderObject FIELDS( obj_Externalization obj_Id ) NO-LOCK  OUTER-JOIN WHERE b_OrderObject.obj_Id = b_Order.ord_Object
BY wb_UrgentOrder.wurg_InternalId DESCENDING  INDEXED-REPOSITION QUERY-TUNING(NO-JOIN-BY-SQLDB HINT 'FIRST_ROWS(100)')
*/
ASSIGN QueryString = "
FOR EACH b_gp_SiteAttribute FIELDS( satt_DataType satt_Id satt_Label satt_Name satt_Order satt_Table satt_Widget satt_Category satt_TargetTable ) WHERE b_gp_SiteAttribute.satt_Table = 744  NO-LOCK    BY b_gp_SiteAttribute.satt_Table BY b_gp_SiteAttribute.satt_Name  INDEXED-REPOSITION
    ".


DEFINE VARIABLE Counter AS integer NO-UNDO INITIAL 1.
FOR EACH b_gp_SiteAttribute WHERE b_gp_SiteAttribute.satt_Table = 744  NO-LOCK    BY b_gp_SiteAttribute.satt_Table BY b_gp_SiteAttribute.satt_Name: //  INDEXED-REPOSITION:
    MESSAGE satt_Name VIEW-AS ALERT-BOX.
    ASSIGN Counter= Counter + 1.
    IF Counter > 5
    THEN LEAVE.
END.

MESSAGE "query" VIEW-AS ALERT-BOX.
CREATE QUERY hQuery.
DEFINE VARIABLE bufferHandle AS HANDLE NO-UNDO.
ASSIGN bufferHandle = BUFFER b_gp_SiteAttribute:HANDLE.
hQuery:ADD-BUFFER (bufferHandle).

hQuery:QUERY-PREPARE (QueryString).

hQuery:QUERY-OPEN.

//ReturnValue = hQuery:REPOSITION-TO-ROWID(RowIdOrder,RowIdIssuer, RowIdObject).

hQuery:GET-FIRST().
DO WHILE NOT hQuery:QUERY-OFF-END AND ICOUNT < 10:
    
    MESSAGE bufferHandle:BUFFER-FIELD("satt_Name"):BUFFER-VALUE( ) VIEW-AS ALERT-BOX.
    hQuery:Get-Next().
    ASSIGN ICOUNT = ICOUNT + 1.
END.
DELETE OBJECT hQuery.
MESSAGE SUBSTITUTE(" END - etime = &1":U,ETIME(NO) ) VIEW-AS ALERT-BOX.


