/*first time set SetUpdate = YES, save and compile it ,run it, then SetUpdate = NO, save and compile it ,run it */
/*NO-LOCk in FOR statement, read committed result, not wait for other process which lock the record*/
/*NO-WAIT is only available for FIND statement.*/

DEFINE BUFFER b_User FOR sc_User. /*use b_Customer or Customer has same result. */
DEFINE VARIABLE TheRecId AS RECID NO-UNDO.

FOR FIRST b_User WHERE b_User.usr_LoginName = 'ZipingWA' NO-LOCK:
    MESSAGE  "Sessin B NO-LOCK" b_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
END.

FIND CURRENT b_User EXCLUSIVE-LOCK NO-WAIT NO-ERROR.
IF LOCKED b_User
THEN MESSAGE  "SessionB: recorder locked by other session" VIEW-AS ALERT-BOX.
ELSE DO:
    IF NOT AVAILABLE b_User
    THEN MESSAGE "SessionB: recorder no more exists" VIEW-AS ALERT-BOX.
END.

FOR FIRST b_User WHERE b_User.usr_LoginName = 'ZipingWA' SHARE-LOCK:
    MESSAGE  "Sessin B read SHARE-LOCK" b_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
END.

FOR FIRST b_User WHERE b_User.usr_LoginName = 'ZipingWA' EXCLUSIVE-LOCK:
    MESSAGE  "Sessin B read EXCLUSIVE-LOCK" b_User.usr_LastUpdateTime VIEW-AS ALERT-BOX.
END.

MESSAGE "SessinB end" VIEW-AS ALERT-BOX.
