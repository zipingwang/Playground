DEFINE BUFFER b_gp_SpeedTestHistory FOR genrw.gp_SpeedTestHistory.

DEFINE NEW GLOBAL SHARED VARIABLE g_UserId AS INTEGER INITIAL 1.
DEFINE VARIABLE FirstId AS INTEGER NO-UNDO.

FOR FIRST b_gp_SpeedTestHistory NO-LOCK BY b_gp_SpeedTestHistory.sth_Id:
    ASSIGN FirstId = b_gp_SpeedTestHistory.sth_Id.
END.

DO TRANSACTION:
    FOR FIRST b_gp_SpeedTestHistory WHERE b_gp_SpeedTestHistory.sth_Id = FirstId:
        ASSIGN b_gp_SpeedTestHistory.sth_Population = b_gp_SpeedTestHistory.sth_Population + 1.
        VALIDATE b_gp_SpeedTestHistory.  //other session don't know the status of this record. same for progress db and for oracle db.   
        MESSAGE "Session A SessionID:" SESSION DBTYPE("genrw") "in transaction" TRANSACTION  ". Record Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX. 
    END.
END.

DO TRANSACTION:
    CREATE b_gp_SpeedTestHistory. //after create this. other session can query status of this record if it is progress db. oracle not.  
    MESSAGE "Session A SessionID:" SESSION DBTYPE("genrw") "in transaction" TRANSACTION  ". Record Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX.
    ASSIGN 
        b_gp_SpeedTestHistory.sth_Population = 9999
        b_gp_SpeedTestHistory.sth_TotalDuration = 0
        .
    VALIDATE b_gp_SpeedTestHistory. //other session don't know the status of this record. same for progress db and for oracle db.          
    MESSAGE "Session A SessionID:" SESSION DBTYPE("genrw") "in transaction" TRANSACTION  ". Record Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX.
     
END.
