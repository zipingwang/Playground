
 /*------------------------------------------------------------------------
    File        : SimpleTimeCalls
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue May 02 13:30:18 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING InfrastructureTest.InfrastructureTestCase FROM PROPATH.
USING InfrastructureTest.InputParameter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS InfrastructureTest.TestCase.SimpleTimeCalls INHERITS InfrastructureTestCase:

    DEFINE VARIABLE InputParameter_ AS Inputparameter NO-UNDO.

    /*-------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC SimpleTimeCalls(TheInputParameter AS InputParameter, DESCRIPTION AS CHARACTER):
        super(TheInputParameter:Population, DESCRIPTION).

        InputParameter_ = TheInputParameter.
    END.

    METHOD PUBLIC OVERRIDE VOID DoRunTest():

        DEFINE VARIABLE COUNT AS INTEGER NO-UNDO.
        DEFINE VARIABLE PreTimeSource AS CHARACTER NO-UNDO.

        ASSIGN PreTimeSource = SESSION:TIME-SOURCE.

        ASSIGN SESSION:TIME-SOURCE = InputParameter_:Db.

        DO COUNT = 1 TO InputParameter_:Population:
            NOW. //The NOW function returns the system date and time of server machine
        END.

        FINALLY:
            ASSIGN SESSION:TIME-SOURCE = PreTimeSource.
        END.

    END.

END CLASS.
