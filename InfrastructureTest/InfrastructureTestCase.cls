
 /*------------------------------------------------------------------------
    File        : InfrastructureTestCase
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue May 02 11:51:52 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING InfrastructureTest.Logger FROM PROPATH.
USING InfrastructureTest.InputParameter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS  InfrastructureTest.InfrastructureTestCase ABSTRACT:

    DEFINE VARIABLE Description_ AS CHARACTER NO-UNDO.
    DEFINE VARIABLE Population_ AS INTEGER NO-UNDO.

    /*-------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC InfrastructureTestCase(Population AS INTEGER, DESCRIPTION AS CHARACTER):
        Super().

        ASSIGN
            Description_ = DESCRIPTION
            Population_ = Population.
    END.

    METHOD PUBLIC FINAL VOID RunTest():
        DEFINE VARIABLE StartTime AS DATETIME NO-UNDO.
        DEFINE VARIABLE TimeInterval AS INT64 NO-UNDO.
        DEFINE VARIABLE RecordsPerSecond AS INTEGER NO-UNDO.
        DEFINE VARIABLE PreTimeSource AS CHARACTER NO-UNDO.

        Logger:WriteLine("").
        Logger:WriteLine(Description_).

        ASSIGN PreTimeSource = SESSION:TIME-SOURCE.
        ASSIGN SESSION:TIME-SOURCE = "local".
        ASSIGN StartTime = NOW.

        DoRunTest().

        TimeInterval = INTERVAL(NOW , StartTime , 'milliseconds' ).
        Logger:WriteLine(SUBSTITUTE("Total time:          &1 milliseconds", TimeInterval)).

        RecordsPerSecond = Population_ * 60000 / TimeInterval.
        Logger:WriteLine(SUBSTITUTE("Records per second:  &1", RecordsPerSecond)).

        FINALLY:
            ASSIGN SESSION:TIME-SOURCE = PreTimeSource.
        END.

    END.

    METHOD PUBLIC ABSTRACT VOID DoRunTest().

END CLASS.
