
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

 //CONNECT -db glims -H hyperion -S glims96glimssv -U mipsdev -P denmark.

//MESSAGE SUBSTITUTE("zw: &1 connect to database &2":U, PROGRAM-NAME( 1 ), DatabaseName ) VIEW-AS ALERT-BOX.

ASSIGN DatabaseName = 'genro':U.
RUN gp_dbcon(DatabaseName, DatabaseName, 4,
            ApplicationName, ?, OUTPUT ErrorMessage) NO-ERROR.

ASSIGN DatabaseName = 'genrw':U.
RUN gp_dbcon(DatabaseName, DatabaseName, 4,
            ApplicationName, ?, OUTPUT ErrorMessage) NO-ERROR.

ASSIGN DatabaseName = 'glims':U.
RUN gp_dbcon(DatabaseName, DatabaseName, 4,
            ApplicationName, ?, OUTPUT ErrorMessage) NO-ERROR.

//MESSAGE SUBSTITUTE("zw: &1 connected... ":U, PROGRAM-NAME( 1 ) ) VIEW-AS ALERT-BOX.
IF ErrorMessage > ''
THEN MESSAGE ErrorMessage VIEW-AS ALERT-BOX.
ELSE IF CONNECTED(DatabaseName)
THEN MESSAGE "Connection ok" VIEW-AS ALERT-BOX.
ELSE MESSAGE "Db not connected" VIEW-AS ALERT-BOX.

//MESSAGE SUBSTITUTE("zw: &1 start run infrastructure testests ":U, PROGRAM-NAME( 1 ) ) VIEW-AS ALERT-BOX.
RUN RunInfrastructureTest(SESSION:PARAM).
//MESSAGE SUBSTITUTE("zw: &1 end run infrastructure testests ":U, PROGRAM-NAME( 1 ) ) VIEW-AS ALERT-BOX.

DISCONNECT VALUE(DatabaseName).

MESSAGE "Done" VIEW-AS ALERT-BOX.

QUIT.
