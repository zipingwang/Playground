 
 /*------------------------------------------------------------------------
    File        : TestGenericDataRetrievalHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Fri Feb 16 10:12:29 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.test.TestGenericDataRetrievalHandler: 
    
    
    METHOD PUBLIC VOID TestGetData():
        
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
        
        ASSIGN DataRetrievalRequest = CreateDataRetrievalRequest().
 
        RUN NetBrowser/server/GenericDataRetrievalHandlerInterface (DataRetrievalRequest, OUTPUT TABLE-HANDLE LastTempTableHandle, OUTPUT DataRetrievalResponse).       
    END.
    
    METHOD PRIVATE DataRetrievalRequest CreateDataRetrievalRequest():
        
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.             
        
        /* --------------------------------------------------------------------- */
        
        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = 50
            DataRetrievalRequest:BufferNames = "sc_User,gp_Language"
            DataRetrievalRequest:FieldList = "usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id usr_Initials usr_Language usr_LastName usr_LoginName,lng_Id lng_Name".
            DataRetrievalRequest:QueryString = "FOR EACH sc_User FIELDS( usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id 
            usr_Initials usr_Language usr_LastName usr_LoginName ) WHERE sc_User.usr_Enabled = yes AND usr_Id = -10  NO-LOCK  , 
            FIRST gp_Language FIELDS( lng_Id lng_Name ) NO-LOCK  OUTER-JOIN WHERE gp_Language.lng_Id = sc_User.usr_Language  
            BY sc_User.usr_LoginName INDEXED-REPOSITION"            
            .
        /*    
        IF VALID-OBJECT(DataRetrievalResponse)
        THEN DO:
            ASSIGN DataRetrievalRequest:ToBeRepositionedRecord = DataRetrievalResponse:LastRecordInTheBatch.
          //  MessageBox:Show(DataRetrievalRequest:ToBeRepositionedRecord).
          LogManager:WriteMessage("zwa recid" +  DataRetrievalRequest:ToBeRepositionedRecord).
        END.
        */    
        RETURN DataRetrievalRequest.
        
    END.
END CLASS.
