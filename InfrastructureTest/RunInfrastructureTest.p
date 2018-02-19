
/*------------------------------------------------------------------------
    File        : SpeedTest.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Fri Apr 28 13:13:56 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING InfrastructureTest.InputParameter FROM PROPATH.
USING InfrastructureTest.InfrastructureTestCase FROM PROPATH.
USING InfrastructureTest.Logger FROM PROPATH.
USING InfrastructureTest.TestCase.* FROM PROPATH.

/*---------------------------------------------------------------------*/

DEFINE INPUT PARAMETER InputParameterString AS CHARACTER NO-UNDO.

DEFINE VARIABLE InputParameter AS InputParameter NO-UNDO.
DEFINE VARIABLE InfrastructureTestCases AS InfrastructureTestCase NO-UNDO EXTENT.
DEFINE TEMP-TABLE w_InfrastructureTestCases
    FIELD InfrastructureTestCase AS CLASS PROGRESS.Lang.OBJECT.

/*---------------------------------------------------------------------*/

RUN Main.

/*---------------------------------------------------------------------*/

PROCEDURE Main:

    RUN LogHeader.

    InputParameter = NEW InputParameter(InputParameterString).

    RUN PrepareTestCases.

    RUN RunTestCases.

    CATCH  Err AS Progress.Lang.Error:
        MESSAGE Err:GetMessage(1) VIEW-AS ALERT-BOX BUTTONS OK.
    END.
END. /* Main */


PROCEDURE LogHeader:

    Logger:WriteLine("Application name: Glims").
    Logger:WriteLine("************************").
    Logger:WriteLine("*   GLIMS SPEED TEST   *").
    Logger:WriteLine("************************").

END. /* LogHeader */


PROCEDURE PrepareTestCases:

    RUN AddTestCase(
        NEW SimpleTimeCalls(InputParameter, "Simple time calls test...")
    ).

    RUN AddTestCase(
        NEW SimpleTimeCalls(InputParameter, "Simple time calls test 2...")
    ).

     RUN AddTestCase(
        NEW SimpleTimeCalls(InputParameter, "Simple time calls test 3...")
    ).

END. /* PrepareTestCases */


PROCEDURE AddTestCase:

    DEFINE INPUT PARAMETER InfrastructureTestCase AS InfrastructureTestCase NO-UNDO.

    CREATE w_InfrastructureTestCases.
    ASSIGN w_InfrastructureTestCases.InfrastructureTestCase = InfrastructureTestCase.
/*    IF EXTENT(InfrastructureTestCases) = ?                                            */
/*    THEN EXTENT(InfrastructureTestCases) = 1.                                         */
/*    ELSE DO:                                                                          */
/*        EXTENT(InfrastructureTestCases) = ?.                                          */
/*        EXTENT(InfrastructureTestCases) = arraySize + 1.                              */
/*    END.                                                                              */
/*                                                                                      */
/*    InfrastructureTestCases[EXTENT(InfrastructureTestCases)] = InfrastructureTestCase.*/

END. /* PrepareTestCases */


PROCEDURE RunTestCases:

    DEFINE VARIABLE COUNT AS INTEGER NO-UNDO.

/*    DO COUNT =1 TO EXTENT(InfrastructureTestCases):*/
/*        InfrastructureTestCases[COUNT]:RunTest().  */
/*    END.                                           */
    FOR EACH w_InfrastructureTestCases:
        CAST(w_InfrastructureTestCases.InfrastructureTestCase, InfrastructureTestCase):RunTest().
    END.

END. /* RunTestCases */
