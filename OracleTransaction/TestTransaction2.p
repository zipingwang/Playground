
DEFINE BUFFER b_gp_SpeedTestHistory FOR genrw.gp_SpeedTestHistory.

DEFINE VARIABLE FirstId AS INTEGER NO-UNDO.

FOR FIRST b_gp_SpeedTestHistory NO-LOCK BY b_gp_SpeedTestHistory.sth_Id:
    ASSIGN FirstId = b_gp_SpeedTestHistory.sth_Id.
END.

//MESSAGE "FirstID:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX. 

FOR EACH b_gp_SpeedTestHistory NO-LOCK WHERE b_gp_SpeedTestHistory.sth_Id = FirstId:
    MESSAGE "Session B(SessionID:" SESSION ") Reord Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX. 
END.

/*
//In Oracle SHARE-LOCK is same as NO-LOCK. NO-LOCK not means dirty read, it means no wait, it read only committed data and no wait. But in Progress SHARE-LOCK will wait until the update is done by other session, then continue
FOR EACH b_gp_SpeedTestHistory SHARE-LOCK WHERE b_gp_SpeedTestHistory.sth_Id = FirstId:
    MESSAGE "Found Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX. 
END.
*/

FOR LAST b_gp_SpeedTestHistory NO-LOCK BY b_gp_SpeedTestHistory.sth_Id:
    ASSIGN FirstId = b_gp_SpeedTestHistory.sth_Id.
END.

FOR EACH b_gp_SpeedTestHistory NO-LOCK WHERE b_gp_SpeedTestHistory.sth_Id = FirstId:
    MESSAGE "Session B(SessionID:" SESSION ") Reord Id:" b_gp_SpeedTestHistory.sth_Id "Population:" b_gp_SpeedTestHistory.sth_Population VIEW-AS ALERT-BOX. 
END.
