 
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalRequest SERIALIZABLE: 
    
    /*starting point to retrieve record. it is comma separated rowids.*/
    DEFINE PUBLIC PROPERTY ToBeRepositionedRecord AS CHARACTER NO-UNDO 
    GET.
    SET.

    /*native 4gl query. e.g for each sc_User*/
    DEFINE PUBLIC PROPERTY QueryString AS CHARACTER NO-UNDO
    GET.
    SET.
    
    /*how many records will be retrieved. -1 means all records*/
    DEFINE PUBLIC PROPERTY BatchSize AS INTEGER NO-UNDO
    GET.
    SET.
    
    /*comma separated table names. e.g. sc_User,gp_language*/
    DEFINE PUBLIC PROPERTY BufferNames AS CHARACTER NO-UNDO
    GET.
    SET.
    
    /*comma separated fields list. e.g. sc_User,gp_language*/
    DEFINE PUBLIC PROPERTY FieldList AS CHARACTER NO-UNDO
    GET.
    SET.
    
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
