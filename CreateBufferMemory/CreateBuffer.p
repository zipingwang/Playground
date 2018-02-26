DEFINE VARIABLE UserHandle AS HANDLE NO-UNDO.
 
CREATE BUFFER UserHandle FOR TABLE "sc_user" BUFFER-NAME "b_user".

UserHandle:FIND-FIRST("where usr_LoginName = 'bart'", no-lock).

