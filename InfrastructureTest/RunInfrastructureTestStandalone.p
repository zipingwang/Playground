
/*------------------------------------------------------------------------
    File        : RunInfrastructureTest.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Tue May 02 11:46:57 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/
BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.
DEFINE VARIABLE DatabaseName AS CHARACTER NO-UNDO.
DEFINE VARIABLE ApplicationName AS CHARACTER NO-UNDO.

ASSIGN DatabaseName = 'glims':U.
ASSIGN ApplicationName = "Glims":U.


IF CONNECTED(DatabaseName)
THEN MESSAGE "Connection ok" VIEW-AS ALERT-BOX.
ELSE MESSAGE "Db not connected" VIEW-AS ALERT-BOX.

RUN ConnectToDb("genro", ApplicationName, OUTPUT ErrorMessage).
RUN ConnectToDb("genrw", ApplicationName, OUTPUT ErrorMessage).
//RUN ConnectToDb("glims_sh", ApplicationName, OUTPUT ErrorMessage).
RUN ConnectToDb("glims", ApplicationName, OUTPUT ErrorMessage).

IF ErrorMessage > ''
THEN MESSAGE ErrorMessage VIEW-AS ALERT-BOX.
ELSE IF CONNECTED(DatabaseName)
THEN MESSAGE "Connection ok" VIEW-AS ALERT-BOX.
ELSE MESSAGE "Db not connected" VIEW-AS ALERT-BOX.

MESSAGE SESSION:PARAMETER VIEW-AS ALERT-BOX.

RUN RunInfrastructureTest(SESSION:PARAMETER).

IF CONNECTED("genro")
THEN DISCONNECT "genro".

IF CONNECTED("genrw")
THEN DISCONNECT "genrw".

IF CONNECTED("glims")
THEN DISCONNECT "glims".

MESSAGE "Done" VIEW-AS ALERT-BOX.

QUIT.


PROCEDURE ConnectToDb:

    DEFINE INPUT PARAMETER DatabaseName AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER ApplicationName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER ErrorMessage AS CHARACTER NO-UNDO.

    RUN gp_dbcon(DatabaseName, DatabaseName, 4,
            ApplicationName, ?, OUTPUT ErrorMessage) NO-ERROR.
END.
