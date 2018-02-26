
/*------------------------------------------------------------------------
    File        : RunInfrastructureTestStandaloneWithDbConnectionInProject.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Mon May 08 10:38:48 CEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

USING be.mips.system.tools.infrastructuretest.InputParameter FROM PROPATH.
USING be.mips.system.tools.infrastructuretest.Helper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


DEFINE VARIABLE TheInputParameter AS InputParameter NO-UNDO.
ASSIGN TheInputParameter = NEW InputParameter(SESSION:PARAMETER).
/*
DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
DEFINE VARIABLE Population AS INTEGER NO-UNDO.
DEFINE VARIABLE StartTime AS DATETIME NO-UNDO.
DEFINE VARIABLE TimeInterval AS INTEGER NO-UNDO.
DEFINE VARIABLE DummyValue AS INTEGER NO-UNDO.
DEFINE VARIABLE Ids AS INTEGER EXTENT NO-UNDO.
DEFINE VARIABLE DummyText AS CHARACTER NO-UNDO.

ASSIGN EXTENT(Ids) = 28000. //TheInputParameter:Population.

ASSIGN population = TheInputParameter:Population.
MESSAGE "start" VIEW-AS ALERT-BOX.
ASSIGN StartTime = NOW.

DO counter = 1 TO 10000:
    DummyText = Helper:GenerateRandomText().
    //DummyValue= population. //TheInputParameter:Population.
END.

TimeInterval = INTERVAL(NOW , StartTime , 'milliseconds':U ).

MESSAGE TimeInterval VIEW-AS ALERT-BOX.
*/
TheInputParameter:Interactive = FALSE.
TheInputParameter:Population = 10.
TheInputParameter:DatabaseType = "Oracle":U.
TheInputParameter:OnServer = NO.
TheInputParameter:SharedMemory = NO.
RUN be/mips/system/tools/infrastructuretest/RunInfrastructureTest(TheInputParameter).
