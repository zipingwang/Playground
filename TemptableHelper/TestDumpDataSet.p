DEFINE VARIABLE DataTableHandle AS HANDLE NO-UNDO.
DEFINE VARIABLE DataSetHandle AS HANDLE NO-UNDO.

CREATE TEMP-TABLE DataTableHandle.
            
        DataTableHandle:READ-XMLSCHEMA(
                                "FILE",                 /*cSourceType*/
                                "d:\temp\sample.xsd",            /*cFile*/    
                                ?,                      /*lOverrideDefaultMapping*/
                                ?,                      /*cFieldTypeMapping*/
                                ?                       /*cVerifySchemaMode*/
                            ).
        
        DataTableHandle:READ-XML(
                                "FILE",                 /*cSourceType,*/
                                "d:\temp\sample.xml",                /*cFile,*/ 
                                "EMPTY",                /*cReadMode,*/ 
                                ?,                      /*cSchemaLocation,*/ 
                                ?,                      /*lOverrideDefaultMapping,*/ 
                                ?,                      /*cFieldTypeMapping,*/  
                                ?                       /*cVerifySchemaMode*/
                                ).                     


//RUN playground/temptablehelper/dumptemptable (DataTableHandle, ?).

CREATE DATASET DataSetHandle.
DataSetHandle:ADD-BUFFER(DataTableHandle).
//DataSetHandle:PREFER-DATASET.

RUN playground/temptablehelper/DumpDataSet(DataSetHandle, "d:\temp\dumpdataset.xml").

