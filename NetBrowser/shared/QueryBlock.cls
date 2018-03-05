
 /*------------------------------------------------------------------------
    File        : QueryBlock
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Mon Mar 05 09:06:10 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.QueryBlock SERIALIZABLE:


    DEFINE PUBLIC PROPERTY ForPhrase AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY TableName AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY FieldList AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY FieldMapList AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY WherePhrase AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Hints AS CHARACTER NO-UNDO
    GET.
    SET.

    /*****************************************************************************/

    METHOD PUBLIC OVERRIDE CHARACTER ToString():
        DEFINE VARIABLE WherePhraseString AS CHARACTER NO-UNDO INITIAL "":U.

        /* --------------------------------------------------------------------- */

        IF TRIM(WherePhrase) > "":U
        THEN DO:
            WherePhraseString = SUBSTITUTE("WHERE ( &1 )":U, WherePhrase).
        END.

        RETURN SUBSTITUTE("&1 &2 FIELDS( &3 ) &4 &5 ":U, ForPhrase, TableName, FieldList, Hints, WherePhraseString).
    END.

    /*****************************************************************************/

    METHOD PUBLIC CHARACTER GetStringForFastPosition(FastPositionQueryString AS CHARACTER):
        DEFINE VARIABLE WherePhraseString AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF TRIM(WherePhrase) > "":U
        THEN DO:
            WherePhraseString = SUBSTITUTE("WHERE ( &1 ) AND &2 ":U, WherePhrase, FastPositionQueryString).
        END.
        ELSE
            WherePhraseString = SUBSTITUTE("WHERE ( &1 )":U, FastPositionQueryString).

        RETURN SUBSTITUTE("&1 &2 FIELDS( &3 ) &4 &5 ":U, ForPhrase, TableName, FieldList, Hints, WherePhraseString).
    END.
END CLASS.