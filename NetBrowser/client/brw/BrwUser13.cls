
 /*------------------------------------------------------------------------
    File        : BrwUser13
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 11:33:29 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.client.brw.GenericBrowser FROM PROPATH.
USING Playground.NetBrowser.client.brw.BrowserDefinition.BrowserDefinition FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.client.brw.BrowserDefinition.BrowserColumnDefinition FROM PROPATH.
USING Playground.NetBrowser.shared.QueryBlock FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.client.brw.BrwUser13 INHERITS GenericBrowser:

    DEFINE PUBLIC OVERRIDE PROPERTY BrowserSortColumName_ AS CHARACTER NO-UNDO
    GET():
       RETURN "usr_LoginName".
    END.   
    
    METHOD PUBLIC OVERRIDE BrowserDefinition GetBrowserDefinition():

        DEFINE VARIABLE BrowserDefinition AS BrowserDefinition NO-UNDO.
        DEFINE VARIABLE BrowserColumnDefinition AS BrowserColumnDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN BrowserDefinition = NEW BrowserDefinition().
        BrowserDefinition:BrowserName = "sc_User":U.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_LoginName":U.
        BrowserColumnDefinition:Caption = "Login name":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_Initials":U.
        BrowserColumnDefinition:Caption = "Initials":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_FirstName":U.
        BrowserColumnDefinition:Caption = "First name":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_LastName":U.
        BrowserColumnDefinition:Caption = "Last name":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "lng_Name":U.
        BrowserColumnDefinition:Caption = "Language":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

       /*
        {Consultingwerk/foreachABL.i BrowserColumnDefinition BrowserColumnDefinition in BrowserDefinition}

            BrowserColumnDefinition = NEW BrowserColumnDefinition().
            BrowserColumnDefinition:DataSourceName = "usr_LoginName":U.
            BrowserColumnDefinition:Caption = "Login name":U.
            BrowserDefinition:BrowserColumns[1] = BrowserColumnDefinition.
        END.
*/
        /*EXTENT(BrowserDefinition:BrowserColumns) = 5.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_LoginName":U.
        BrowserColumnDefinition:Caption = "Login name":U.
        BrowserDefinition:BrowserColumns[1] = BrowserColumnDefinition.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_Initials":U.
        BrowserColumnDefinition:Caption = "Initials":U.
        BrowserDefinition:BrowserColumns[2] = BrowserColumnDefinition.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_FirstName":U.
        BrowserColumnDefinition:Caption = "First name":U.
        BrowserDefinition:BrowserColumns[3] = BrowserColumnDefinition.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "usr_LastName":U.
        BrowserColumnDefinition:Caption = "Last name":U.
        BrowserDefinition:BrowserColumns[4] = BrowserColumnDefinition.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "lng_Name":U.
        BrowserColumnDefinition:Caption = "Language":U.
        BrowserDefinition:BrowserColumns[5] = BrowserColumnDefinition.
*/
        RETURN BrowserDefinition.

    END METHOD.

    METHOD PUBLIC OVERRIDE DataRetrievalRequest CreateDataRetrievalRequest():

        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE QueryBlocks AS QueryBlock EXTENT 2 NO-UNDO.
        DEFINE VARIABLE QueryBlcok AS QueryBlock NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FOR EACH":U
            QueryBlcok:TableName = "sc_User":U
            QueryBlcok:FieldList = "usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id usr_Initials usr_Language usr_LastName usr_LoginName":U
            QueryBlcok:WherePhrase = "sc_User.usr_Enabled = yes":U
            QueryBlcok:Hints = "NO-LOCK":U
            .

        QueryBlocks[1] = QueryBlcok.

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FIRST":U
            QueryBlcok:TableName = "gp_Language":U
            QueryBlcok:FieldList = "lng_Id lng_Name":U
            QueryBlcok:WherePhrase = "gp_Language.lng_Id = sc_User.usr_Language":U
            QueryBlcok:Hints = "NO-LOCK OUTER-JOIN":U
            .

        QueryBlocks[2] = QueryBlcok.

        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = BatchSize_
            DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
            DataRetrievalRequest:QueryBlocks = QueryBlocks
            DataRetrievalRequest:SortingPhrase = "BY sc_User.usr_LoginName"
            .

        RETURN DataRetrievalRequest.

    END METHOD.

END CLASS.
