
/*------------------------------------------------------------------------
    File        : CompileProgressFile.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Mon Mar 13 16:49:26 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdgeProjectHelper.CompileFilesEventArgs FROM ASSEMBLY.
USING OpenEdgeProjectHelper.ProgressCompilerView FROM ASSEMBLY.
USING System.Object FROM ASSEMBLY.

/******************************************************************************/

RUN Main.

/******************************************************************************/

PROCEDURE MainTest:

    DEFINE VARIABLE Errors AS LOGICAL NO-UNDO.
    DEFINE VARIABLE Warnings AS LOGICAL NO-UNDO.
    DEFINE VARIABLE MessageCounter AS INTEGER NO-UNDO.
    DEFINE VARIABLE Messages AS CHARACTER NO-UNDO.
    DEFINE VARIABLE ProgressCompilerView AS ProgressCompilerView NO-UNDO.
    DEFINE VARIABLE ToBeCompiledFiles AS CLASS "System.Collections.Generic.List<CHARACTER>" NO-UNDO.
    DEFINE VARIABLE FileCount AS INTEGER NO-UNDO.

    RUN CreateAlias.

    CONNECT -db cpage_sh -H hyperion -S dvglimscpagesv -ld cpage_sh.

        COMPILE "C:\workspace\EclipseOE116Workspace\glims_dev_pro\glims-abl-sources\gen\dsp\cm_gsit.p" SAVE NO-ERROR.
        ASSIGN
            Errors = COMPILER:ERROR
            Warnings = COMPILER:WARNING.

        ASSIGN Messages="".

        DO MessageCounter = 1 TO ERROR-STATUS:NUM-MESSAGES:
            ASSIGN Messages = Messages + ERROR-STATUS:GET-MESSAGE(MessageCounter) + "~n":U.
        END.

        MESSAGE Messages VIEW-AS ALERT-BOX.
END.

/******************************************************************************/

PROCEDURE Main:

    DEFINE VARIABLE DirectoryList AS CLASS "System.Collections.Generic.List<CHARACTER>" NO-UNDO.
    DEFINE VARIABLE ProgressCompilerView AS ProgressCompilerView NO-UNDO.

    RUN CreateAlias.

    DirectoryList = NEW "System.Collections.Generic.List<CHARACTER>"().

    DirectoryList:Add("C:\workspace\EclipseOE116Workspace\glims_dev_pro\smartcomponents").
    DirectoryList:Add("C:\workspace\EclipseOE116Workspace\glims_dev_pro\mate-abl-sources").
    DirectoryList:Add("C:\workspace\EclipseOE116Workspace\glims_dev_pro\glims-abl-sources").

    ProgressCompilerView = NEW ProgressCompilerView(DirectoryList).
    ProgressCompilerView:CompileFilesRequested:Subscribe("ProgressCompilerView_CompileFilesRequested").

    WAIT-FOR ProgressCompilerView:ShowDialog().

END.

/******************************************************************************/

PROCEDURE CreateAlias:

    CREATE ALIAS glimssha FOR DATABASE glims.
    CREATE ALIAS rtgenro FOR DATABASE genro.
    CREATE ALIAS qrlibgenro FOR DATABASE genro.
    CREATE ALIAS genrosha FOR DATABASE genro.
    CREATE ALIAS source FOR DATABASE genro.
    CREATE ALIAS target FOR DATABASE genro.
    CREATE ALIAS vstdb FOR DATABASE genro.
    CREATE ALIAS dictdb1 FOR DATABASE genro.
    CREATE ALIAS dictdb2 FOR DATABASE genro.
    CREATE ALIAS SourceGenro FOR DATABASE genro.
    CREATE ALIAS TargetGenro FOR DATABASE genro.
    CREATE ALIAS DB1 FOR DATABASE genro.
    CREATE ALIAS DB2 FOR DATABASE genro.
    CREATE ALIAS basic FOR DATABASE genro.
    CREATE ALIAS defdb FOR DATABASE genro.
    CREATE ALIAS rtgenrw FOR DATABASE genrw.
    CREATE ALIAS qrlibgenrw FOR DATABASE genrw.
    CREATE ALIAS genrwsha FOR DATABASE genrw.

END.

/******************************************************************************/

PROCEDURE ProgressCompilerView_CompileFilesRequested:

    DEFINE INPUT PARAMETER Sender AS Object NO-UNDO.
    DEFINE INPUT PARAMETER Args AS CompileFilesEventArgs NO-UNDO.

    DEFINE VARIABLE Errors AS LOGICAL NO-UNDO.
    DEFINE VARIABLE Warnings AS LOGICAL NO-UNDO.
    DEFINE VARIABLE MessageCounter AS INTEGER NO-UNDO.
    DEFINE VARIABLE Messages AS CHARACTER NO-UNDO.
    DEFINE VARIABLE ProgressCompilerView AS ProgressCompilerView NO-UNDO.
    DEFINE VARIABLE ToBeCompiledFiles AS CLASS "System.Collections.Generic.List<CHARACTER>" NO-UNDO.
    DEFINE VARIABLE FileCount AS INTEGER NO-UNDO.

    ToBeCompiledFiles = Args:Files.
    ProgressCompilerView = CAST(Sender, ProgressCompilerView).

    DO FileCount = 0 TO ToBeCompiledFiles:COUNT - 1:

        ASSIGN Messages = "".

        COMPILE VALUE(ToBeCompiledFiles[FileCount]) SAVE NO-ERROR.
        IF COMPILER:ERROR
            THEN DO:
                DO MessageCounter = 1 TO COMPILER:NUM-MESSAGES:
                    ASSIGN Messages = Messages + COMPILER:GET-MESSAGE(MessageCounter) + "~n":U.
                END.
            END.
        ELSE
            ASSIGN Messages = "Ok".

        ProgressCompilerView:AddCompileResult(ToBeCompiledFiles[FileCount], Messages).
    END.
END.

