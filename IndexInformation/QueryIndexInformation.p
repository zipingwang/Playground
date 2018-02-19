DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
DEFINE BUFFER b_User FOR sc_User.
DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

CREATE QUERY QueryHandle.

QueryHandle:ADD-BUFFER(BUFFER b_User:Handle).
//QueryHandle:QUERY-PREPARE("FOR EACH b_User NO-LOCK WHERE b_User.usr_LoginName BEGINS 'W':U BY b_User.usr_FirstName").
QueryHandle:QUERY-PREPARE("FOR EACH b_User NO-LOCK BY b_User.usr_Initials").
QueryHandle:QUERY-OPEN.

MESSAGE QueryHandle:INDEX-INFORMATION(1) VIEW-AS ALERT-BOX.


DELETE OBJECT QueryHandle.
