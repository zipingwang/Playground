 DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO. 
 DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
 DEFINE VARIABLE NumberOfAvailableFields AS INTEGER NO-UNDO.
 DEFINE VARIABLE NumberOfRecords AS INTEGER NO-UNDO.
   
 DEFINE BUFFER b_User FOR sc_User.
 DEFINE BUFFER b_Language FOR gp_Language.
 
 CREATE QUERY QueryHandle.
 QueryHandle:SET-BUFFERS(BUFFER b_User:HANDLE, BUFFER b_Language:HANDLE).        
 QueryHandle:QUERY-PREPARE("FOR EACH b_User  FIELDS(b_User.usr_LoginName b_User.usr_Enabled) NO-LOCk, 
    FIRST b_Language  FIELDS(b_Language.lng_Id b_Language.lng_Name) NO-LOCk where b_Language.lng_Id = b_User.usr_Language":U). 

 QueryHandle:QUERY-OPEN().
 QueryHandle:GET-FIRST(NO-LOCK).
 
 DO WHILE QueryHandle:QUERY-OFF-END = NO AND NumberOfRecords < 5:
     
     ASSIGN NumberOfAvailableFields = 0.
     
     DO Counter = 1 TO QueryHandle:GET-BUFFER-HANDLE(1):NUM-FIELDS:
        IF QueryHandle:GET-BUFFER-HANDLE(1):BUFFER-FIELD(Counter):AVAILABLE               
        THEN ASSIGN NumberOfAvailableFields = NumberOfAvailableFields + 1.
     END.
     
     MESSAGE "NumberOfAvailableFields in buffer 1":U NumberOfAvailableFields VIEW-AS ALERT-BOX.
     
     ASSIGN NumberOfAvailableFields = 0.
     MESSAGE  "buffer 2 number fields:" QueryHandle:GET-BUFFER-HANDLE(2):NUM-FIELDS VIEW-AS ALERT-BOX.
      
     DO Counter = 1 TO QueryHandle:GET-BUFFER-HANDLE(2):NUM-FIELDS:
        IF QueryHandle:GET-BUFFER-HANDLE(2):BUFFER-FIELD(Counter):AVAILABLE               
        THEN ASSIGN NumberOfAvailableFields = NumberOfAvailableFields + 1.
     END.
     
     MESSAGE "NumberOfAvailableFields in buffer 2":U NumberOfAvailableFields VIEW-AS ALERT-BOX.
     
     
     ASSIGN NumberOfRecords = NumberOfRecords + 1.
     
     QueryHandle:GET-NEXT(NO-LOCK).
 END.
 
 QueryHandle:QUERY-CLOSE().
 DELETE OBJECT QueryHandle.
 