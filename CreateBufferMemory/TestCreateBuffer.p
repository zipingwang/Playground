USING CreateBufferMemory.TestBuffer FROM PROPATH.

DEFINE VARIABLE Counter AS INTEGER NO-UNDO INITIAL 1.

MESSAGE "start" VIEW-AS ALERT-BOX.

DEFINE VARIABLE tt AS TestBuffer NO-UNDO.

ASSIGN tt = NEW TestBuffer().

DO WHILE Counter < 5000:
    
    //RUN CreateBufferMemory/CreateBuffer.
/*    RUN CreateBufferMemory/DefineBuffer.*/
    tt:RunTestBufferRun().
    
    ASSIGN Counter = Counter + 1.
    IF  Counter MODULO 1000 = 0 
    THEN MESSAGE Counter / 10000 VIEW-AS ALERT-BOX.
END.

ASSIGN tt = ?.



MESSAGE "end" VIEW-AS ALERT-BOX.
