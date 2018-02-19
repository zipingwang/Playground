DEFINE VARIABLE cSourceType             AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTargetType             AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFile                   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cReadMode               AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSchemaLocation         AS CHARACTER NO-UNDO.
DEFINE VARIABLE lOverrideDefaultMapping AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cFieldTypeMapping       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cVerifySchemaMode       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cEncoding               AS CHARACTER NO-UNDO.
DEFINE VARIABLE lFormatted              AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lWriteSchema            AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lMinSchema              AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lWriteBeforeImage       AS LOGICAL   NO-UNDO.


DEFINE VARIABLE httCust AS HANDLE  NO-UNDO.
DEFINE VARIABLE lReturn AS LOGICAL NO-UNDO.

CREATE TEMP-TABLE httCust.

ASSIGN
  cSourceType             = "FILE"
  cFile                   = "d:\temp\sample.xsd"
  lOverrideDefaultMapping = ?
  cFieldTypeMapping       = ?
  cVerifySchemaMode       = ?.  
 
DISPLAY "Is dynamic temp-table PREPARED? " httCust:PREPARED SKIP.
DISPLAY "Reading XML Schema..." SKIP.
    
lReturn = httCust:READ-XMLSCHEMA(
                                    "FILE",                 /*cSourceType*/
                                    "d:\temp\sample.xsd",   /*cFile*/    
                                    ?,                      /*lOverrideDefaultMapping*/
                                    ?,                      /*cFieldTypeMapping*/
                                    ?                       /*cVerifySchemaMode*/
                                ).
IF lReturn THEN DO:
  DISPLAY "Is dynamic temp-table now PREPARED? " httCust:PREPARED SKIP.
  DISPLAY "How many columns in dynamic temp-table? "
    httCust:DEFAULT-BUFFER-HANDLE:NUM-FIELDS SKIP.
END.


/*read xml to temp-table*/

ASSIGN
  cSourceType             = "FILE"
  cFile                   = "d:\temp\sample.xml" 
  cReadMode               = "EMPTY"
  cSchemaLocation         = ?
  lOverrideDefaultMapping = ?
  cFieldTypeMapping       = ?
  cVerifySchemaMode       = ?. 

lReturn = httCust:READ-XML(
        "FILE",                 /*cSourceType,*/
        "d:\temp\sample.xml",   /*cFile,*/ 
        "EMPTY",                /*cReadMode,*/ 
        ?,                      /*cSchemaLocation,*/ 
        ?,                      /*lOverrideDefaultMapping,*/ 
        ?,                      /*cFieldTypeMapping,*/  
        ?                       /*cVerifySchemaMode*/
        ).

MESSAGE "done" VIEW-AS ALERT-BOX.

/*write again*/
httCust:WRITE-XML("FILE",
                  "d:\temp\sample_2.xml",
                  YES,      /*formatted */
                  ?,        /*encoding */
                  ?,        /*cSchemaLocation*/
                  NO,      /*lWriteSchema*/
                  NO,       /*lMinSchema*/
                  ?,        /*write-before-image */
                  YES     /*omit-initial-values */
                  ).
