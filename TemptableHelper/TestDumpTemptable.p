DEFINE VARIABLE DataTableHandle AS HANDLE.

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


RUN playground/temptablehelper/dumptemptable (DataTableHandle, ?).
