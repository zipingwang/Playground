
 /*------------------------------------------------------------------------
    File        : Logger
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Apr 28 13:39:56 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS InfrastructureTest.Logger:

    DEFINE STATIC VARIABLE LogFile AS CHARACTER NO-UNDO.


    CONSTRUCTOR STATIC Logger (  ):

        DEFINE VARIABLE TimeStamp AS CHARACTER NO-UNDO.
        ASSIGN TimeStamp =
            STRING(YEAR(TODAY),"9999":U) +
            STRING(MONTH(TODAY),"99":U) +
            STRING(DAY(TODAY),"99":U) +
            REPLACE(STRING(TIME, "HH:MM:SS":U), ":":U, "":U).

        ASSIGN LogFile = SESSION:TEMP-DIRECTORY + SUBSTITUTE("InfrastructureTest.&1.log":U, TimeStamp).

    END CONSTRUCTOR.

    METHOD PUBLIC STATIC VOID WriteLine(Msg AS Character):

        DEFINE VARIABLE LineHeader AS CHARACTER NO-UNDO.
        ASSIGN LineHeader =
            STRING(YEAR(TODAY),"9999":U) + "-" +
            STRING(MONTH(TODAY),"99":U) + "-" +
            STRING(DAY(TODAY),"99":U) + " " +
            STRING(TIME, "HH:MM:SS":U)
            + " *** "
            .

        OUTPUT TO VALUE(LogFile) APPEND.
        PUT UNFORMATTED LineHeader + Msg + "~n".
        OUTPUT CLOSE.
        //RUN gp_log(Msg).

    END METHOD.

END CLASS.
