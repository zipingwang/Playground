
DEFINE TEMP-TABLE ttSample NO-UNDO /*SERIALIZE-NAME "XMLSample"*/
   FIELD samplenum AS INT64 XML-NODE-TYPE "ATTRIBUTE"
   FIELD data AS CHARACTER INITIAL "This is record number 1"
   INDEX samplenum IS PRIMARY UNIQUE samplenum.
   
DEFINE VARIABLE iCount AS INT64 NO-UNDO.

DO iCount = 1 TO 3:
   CREATE ttSample.
   ASSIGN ttSample.samplenum = icount
          ttSample.data      = "This is record number " + STRING(iCount).
END.

TEMP-TABLE ttSample:WRITE-XML("FILE",
                              "d:\temp\sample.xml",
                              YES,      /*formatted */
                              ?,        /*encoding */
                              ?,        /*cSchemaLocation*/
                              NO,      /*lWriteSchema*/
                              NO,       /*lMinSchema*/
                              ?,        /*write-before-image */
                              YES).     /*omit-initial-values */
                              
TEMP-TABLE ttSample:WRITE-XMLSCHEMA("FILE",
                              "d:\temp\sample.xsd",
                              YES,      /*formatted */
                              ?,        /*encoding */                           
                              NO).      /*lMinSchema*/
                              
/*
TEMP-TABLE ttSample:WRITE-XML("FILE",
                              "d:\temp\sample.xml",
                              YES,
                              ?,
                              ?,
                              YES,
                              NO,
                              ?,
                              YES).       */       

/*TEMP-TABLE ttSample:WRITE-XML("FILE",
                              "d:\temp\sample.xml").  */        
