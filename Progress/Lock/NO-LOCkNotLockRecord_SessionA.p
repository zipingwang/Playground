/*first time set SetUpdate = YES, save and compile it ,run it, then SetUpdate = NO, save and compile it ,run it */
/*NO-LOCk in FOR statement, read committed result, not wait for other process which lock the record*/
/*NO-WAIT is only available for FIND statement.*/

DEFINE BUFFER b_User FOR sc_User. /*use b_Customer or Customer has same result. */
/*
FOR FIRST sc_User WHERE sc_User.usr_LoginName = 'ZipingWA' EXCLUSIVE-LOCK:
    sc_User.usr_LastUpdateTime = sc_User.usr_LastUpdateTime + 1.
    MESSAGE "Session A EXCLUSIVE-LOCK" sc_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
    RELEASE sc_User.
    //FIND CURRENT b_Customer NO-LOCK.
END.
*/
/*
FOR FIRST sc_User WHERE sc_User.usr_LoginName = 'ZipingWA' SHARE-LOCK:
    sc_User.usr_LastUpdateTime = sc_User.usr_LastUpdateTime + 1.
    MESSAGE "Session A SHARE-LOCK" sc_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
    RELEASE sc_User.
    //FIND CURRENT b_Customer NO-LOCK.
END.
*/
FOR FIRST sc_User WHERE sc_User.usr_LoginName = 'ZipingWA' NO-LOCK:
    //sc_User.usr_LastUpdateTime = sc_User.usr_LastUpdateTime + 1.
    MESSAGE "Session A NO-LOCK" sc_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
    RELEASE sc_User.
    //FIND CURRENT b_Customer NO-LOCK.
END.
MESSAGE "SessinA end" VIEW-AS ALERT-BOX.
