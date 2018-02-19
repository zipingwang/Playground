
 /*------------------------------------------------------------------------
    File        : Parameter
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Apr 28 13:20:32 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING InfrastructureTest.Logger FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS InfrastructureTest.InputParameter:

    /*----------begin property-------------*/

    DEFINE PUBLIC PROPERTY Upload AS LOGICAL NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY Batch AS LOGICAL NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY Population AS INTEGER NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY UploadUrl AS CHARACTER NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY DisplayUrl AS CHARACTER NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY Db AS CHARACTER NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PUBLIC PROPERTY StandAlone AS Logical NO-UNDO
    GET.
    PRIVATE SET.

    /*----------end property-------------*/

    /************************************************************************************************/

    CONSTRUCTOR PUBLIC InputParameter (ParameterString AS CHARACTER):
        SUPER ().

/*        DEFINE VARIABLE i AS INTEGER.                            */
/*                                                                 */
/*        REPEAT i = 1 TO NUM-ENTRIES(ParameterString):            */
/*            DISPLAY "Entry: " I " is " ENTRY(I, ParameterString).*/
/*        END.                                                     */

        ASSIGN
            Upload = NO
            Batch = NO
            Population = 2000
            UploadUrl = ''
            DisplayUrl = ''
            Db = 'glims'
            StandAlone = NO
            .

        //TODO: Parse ParameterString

        Logger:WriteLine(SUBSTITUTE("The population is &1 records", Population)).

        //check input parameter
        IF HasEnoughPopulation() = NO
        THEN DO:
            Logger:WriteLine("ERROR: The population is too small.  Allowed values: 1000 or more.").
            UNDO, THROW NEW Progress.Lang.AppError('The population is too small.  Allowed values: 1000 or more.').
        END.

    END CONSTRUCTOR.

    /************************************************************************************************/

    METHOD PUBLIC LOGICAL HasEnoughPopulation():

        RETURN Population > 1000.

    END.

END CLASS.
