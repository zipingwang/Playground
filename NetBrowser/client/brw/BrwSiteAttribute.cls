
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

CLASS Playground.NetBrowser.client.brw.BrwSiteAttribute INHERITS GenericBrowser:
     
    DEFINE PUBLIC OVERRIDE PROPERTY BrowserSortColumName_ AS CHARACTER NO-UNDO
    GET():
       RETURN "satt_Name".
    END.    

    METHOD PUBLIC OVERRIDE BrowserDefinition GetBrowserDefinition():

        DEFINE VARIABLE BrowserDefinition AS BrowserDefinition NO-UNDO.
        DEFINE VARIABLE BrowserColumnDefinition AS BrowserColumnDefinition NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN BrowserDefinition = NEW BrowserDefinition().
        BrowserDefinition:BrowserName = "gp_SiteAttribute":U.

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "satt_Name":U.
        BrowserColumnDefinition:Caption = "name":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "satt_Category":U.
        BrowserColumnDefinition:Caption = "Category":U.
        BrowserDefinition:Add(BrowserColumnDefinition).

        BrowserColumnDefinition = NEW BrowserColumnDefinition().
        BrowserColumnDefinition:DataSourceName = "satt_DataType":U.
        BrowserColumnDefinition:Caption = "DataType":U.
        BrowserDefinition:Add(BrowserColumnDefinition).
    
        RETURN BrowserDefinition.

    END METHOD.

    METHOD PUBLIC OVERRIDE DataRetrievalRequest CreateDataRetrievalRequest():

        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE QueryBlocks AS QueryBlock EXTENT 1 NO-UNDO.
        DEFINE VARIABLE QueryBlcok AS QueryBlock NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FOR EACH":U
            QueryBlcok:TableName = "gp_SiteAttribute":U
            QueryBlcok:FieldList = "satt_DataType satt_Id satt_Label satt_Name satt_Order satt_Table satt_Widget satt_Category satt_TargetTable":U
            QueryBlcok:WherePhrase = "gp_SiteAttribute.satt_Table = 744":U
            QueryBlcok:Hints = "NO-LOCK  ":U
            .

        QueryBlocks[1] = QueryBlcok.
       

        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = BatchSize_
            DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
            DataRetrievalRequest:QueryBlocks = QueryBlocks
            DataRetrievalRequest:SortingPhrase = "BY gp_SiteAttribute.satt_Table BY gp_SiteAttribute.satt_Name "
            .

        RETURN DataRetrievalRequest.

    END METHOD.

END CLASS.
