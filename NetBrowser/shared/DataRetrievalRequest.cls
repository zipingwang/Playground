
 /*------------------------------------------------------------------------
    File        : ClientToServerContext
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Tue Feb 13 11:07:41 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.
USING Playground.NetBrowser.shared.QueryBlock FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalRequest SERIALIZABLE:

    /*starting point to retrieve record. it is comma separated rowids.*/
    DEFINE PUBLIC PROPERTY ToBeRepositionedRecord AS CHARACTER NO-UNDO
    GET.
    SET.
/*
    /*native 4gl query. e.g for each sc_User*/
    DEFINE PUBLIC PROPERTY QueryString AS CHARACTER NO-UNDO
    GET.
    SET.
*/

    /*native 4gl query. e.g for each sc_User*/
    DEFINE PUBLIC PROPERTY FastPositionQueryString AS CHARACTER NO-UNDO
    GET.
    SET.

    /*how many records will be retrieved. -1 means all records*/
    DEFINE PUBLIC PROPERTY BatchSize AS INTEGER NO-UNDO
    GET.
    SET.

    /*Forwards, Backwards*/
    DEFINE PUBLIC PROPERTY Direction AS CHARACTER NO-UNDO
    GET.
    SET.
/*
    /*comma separated fields list. e.g. sc_User,gp_language*/
    DEFINE PUBLIC PROPERTY FieldList AS CHARACTER NO-UNDO
    GET.
    SET.
*/
    /*Id of this request*/
    DEFINE PUBLIC PROPERTY RequestId AS CHARACTER NO-UNDO
    GET.
    SET.

    /*timestamp of this request*/
    DEFINE PUBLIC PROPERTY RequestTime AS DATETIME NO-UNDO
    GET.
    SET.

    /**/
    DEFINE PUBLIC PROPERTY IsFastPosition AS LOGICAL NO-UNDO
    GET():
        RETURN THIS-OBJECT:TriggeredBy = DataRetrievalConstant:FastPosition.
    END.


    /*Trigger by. FastPosition, PageUp, PageDown, KeyUp, KeyDown, Home, End, ScrollUp, OffEnd(out of end of binding source)*/
    DEFINE PUBLIC PROPERTY TriggeredBy AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY SortingPhrase AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY QueryBlocks AS QueryBlock EXTENT NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ActiveRowPosition AS INTEGER NO-UNDO
    GET.
    SET.

    /*comma separated table names. e.g. sc_User,gp_language*/
    DEFINE PUBLIC PROPERTY BufferNames AS CHARACTER NO-UNDO
    GET():
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfQueryBlock AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF BufferNames <= ""
        THEN DO:
            ASSIGN NumberOfQueryBlock = EXTENT(QueryBlocks).

            DO Counter = 1 TO NumberOfQueryBlock:
                IF Counter = 1
                THEN BufferNames = QueryBlocks[Counter]:TableName.
                ELSE BufferNames = BufferNames + "," + QueryBlocks[Counter]:TableName.
            END.
        END.

        RETURN BufferNames.
    END.
    PRIVATE SET.

    METHOD PUBLIC CHARACTER GetQueryString(  ):

        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfQueryBlock AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN NumberOfQueryBlock = EXTENT(QueryBlocks).

        DO Counter = 1 TO NumberOfQueryBlock:
            IF Counter = 1
            THEN
                QueryString = QueryBlocks[Counter]:ToString().
            ELSE
                QueryString =  QueryString + ",~n"  + QueryBlocks[Counter]:ToString().
        END.

        IF SortingPhrase > ""
        THEN ASSIGN QueryString = QueryString + " " + SortingPhrase.

        IF THIS-OBJECT:BatchSize > 0
        THEN ASSIGN QueryString = QueryString + " INDEXED-REPOSITION".

        RETURN QueryString.

    END METHOD.

    /*****************************************************************************/

    METHOD PUBLIC CHARACTER GetQueryStringForFastPosition():

        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfQueryBlock AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN NumberOfQueryBlock = EXTENT(QueryBlocks).

        DO Counter = 1 TO NumberOfQueryBlock:
            IF Counter = 1
            THEN
                QueryString = QueryBlocks[Counter]:GetStringForFastPosition(THIS-OBJECT:FastPositionQueryString).
            ELSE
                QueryString = QueryString + ",~n" + QueryBlocks[Counter]:ToString().
        END.

        IF SortingPhrase > ""
        THEN ASSIGN QueryString = QueryString + " " + SortingPhrase.

        IF THIS-OBJECT:BatchSize > 0
        THEN ASSIGN QueryString = QueryString + " INDEXED-REPOSITION".

        RETURN QueryString.

    END METHOD.

    /* TODO LIST
    mipl filter id
    file name of dataaccess delegate
    site attribute list
    */

    /*
    /*Temp-table to store query restults*/
    DEFINE PUBLIC PROPERTY TempTableName AS CHARACTER NO-UNDO
    GET.
    SET.
    */
    /*
    /*"LanguageId,lng_Id,LanguageName,lng_Name"*/
    DEFINE PUBLIC PROPERTY FieldMapping AS CHARACTER NO-UNDO
    GET.
    SET.
    */
END CLASS.
