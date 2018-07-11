

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

DEFINE BUFFER b_gpText FOR genrw.gp_Text.
DEFINE BUFFER b_gpTextText FOR genrw.gp_TextText.
DEFINE BUFFER b_ds_table FOR genro.ds_Table.
DEFINE BUFFER b_gpSite FOR genrw.gp_Site.

DEFINE VARIABLE ExpandedText AS CHARACTER NO-UNDO.
DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.
DEFINE VARIABLE ExpandedTextNew AS LONGCHAR NO-UNDO.
DEFINE VARIABLE ErrorMessageNew AS LONGCHAR NO-UNDO.
DEFINE VARIABLE LanguageId AS INTEGER NO-UNDO.
DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.

DEFINE TEMP-TABLE w_Result NO-UNDO
FIELD DynamicText AS CHARACTER
FIELD TableName AS CHARACTER
FIELD ExpandedText AS CLOB
FIELD ExpandedTextNew AS CLOB
FIELD ErrorMessage AS CLOB
FIELD ErrorMessageNew AS CLOB
.

DEFINE BUFFER wb_Result FOR w_Result.

FOR FIRST b_gpSite NO-LOCK.
    LanguageId = b_gpSite.gsit_Language.
END.

ASSIGN Counter = 1.

LeaveBlock:
FOR EACH b_ds_table NO-LOCK,
    EACH b_gpText NO-LOCK WHERE b_ds_table.tb_Id = b_gpText.txt_Table,
        FIRST b_gpTextText NO-LOCK WHERE b_gpText.txt_Id = b_gpTextText.ml41_Text AND b_gpTextText.ml41_Language = LanguageId:

    ASSIGN
        ExpandedText = ?
        ErrorMessage = ?
        ExpandedTextNew = ?
        ErrorMessageNew = ?
        .

    IF b_ds_table.tb_Name BEGINS 'w_' /*skip temp-table*/
    THEN NEXT.

    CREATE BUFFER BufferHandle FOR TABLE b_ds_table.tb_Name.

    RUN gp_dtevl_orig(b_gpTextText.ml41_Translation, ?, ?, ?, 1, b_ds_table.tb_Name, BufferHandle, NO,
        OUTPUT ExpandedText, OUTPUT ErrorMessage).

    RUN gp_dtevl_longchar_html(b_gpTextText.ml41_Translation, ?, ?, ?, 1, b_ds_table.tb_Name, BufferHandle, NO, YES,
        OUTPUT ExpandedTextNew, OUTPUT ErrorMessageNew).

    IF ExpandedText <> ExpandedTextNew OR ErrorMessage <> ErrorMessageNew
    THEN DO:
        CREATE wb_Result.

        ASSIGN
            wb_Result.DynamicText = b_gpTextText.ml41_Translation
            wb_Result.ExpandedText = ExpandedText
            wb_Result.ExpandedTextNew = ExpandedTextNew
            wb_Result.ErrorMessage = ErrorMessage
            wb_Result.ErrorMessageNew = ErrorMessageNew
            wb_Result.TableName = b_ds_table.tb_Name
            .

        RELEASE wb_Result.
    END.

    DELETE OBJECT BufferHandle.

    ASSIGN Counter = Counter + 1.

    IF Counter > 10000
    THEN LEAVE LeaveBlock.
END.

RUN playground/temptablehelper/dumptemptable(TEMP-TABLE w_Result:HANDLE, "c:\temp\testnewdtresult.xml").

CATCH ex AS Progress.Lang.Error :
    ErrorHelper:ShowErrorMessage(ex).
END CATCH.
