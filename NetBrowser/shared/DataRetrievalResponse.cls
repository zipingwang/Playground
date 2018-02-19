 
 /*------------------------------------------------------------------------
    File        : ServerToClientContext
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Tue Feb 13 11:41:16 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalResponse SERIALIZABLE: 
    
    /*comma separated rowid of buffers in the record.
    e.g. for each sc_User, first gp_Language.., it has two buffers, the LastRecordInTheBatch will be something like this: 
        0x0000dc4,0x253654.
    */
    DEFINE PUBLIC PROPERTY LastRecordInTheBatch AS CHARACTER NO-UNDO
    GET.
    SET.
    
    DEFINE PUBLIC PROPERTY NumberOfRecordsRetrieved AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY HasError AS LOGICAL NO-UNDO INITIAL NO
    GET.
    SET.
    
    DEFINE PUBLIC PROPERTY ErrorMessage AS CHARACTER NO-UNDO INITIAL ?
    GET.
    SET.   

    DEFINE PUBLIC PROPERTY IsLastBatch AS LOGICAL NO-UNDO INITIAL NO
    GET.
    SET.   
    
END CLASS.
