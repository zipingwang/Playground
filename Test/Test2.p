DEFINE VARIABLE ValueInDb AS DECIMAL NO-UNDO.
DEFINE VARIABLE Counter AS DECIMAL NO-UNDO.
DEFINE VARIABLE MisMatch AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE DecimalDateTime AS DECIMAL NO-UNDO.
DEFINE VARIABLE DateValue AS DATE NO-UNDO.
DEFINE VARIABLE TimeValue AS INTEGER NO-UNDO.


ASSIGN Counter = 1.
DO WHILE Counter < 1000:
    ValueInDb = TRUNCATE(Counter / 86400, 6).
    DecimalDateTime = INTEGER(TODAY) + ValueInDb.
    
    RUN gp_ddt(DecimalDateTime, OUTPUT DateValue, OUTPUT TimeValue).
    
    IF Counter <> TimeValue
    THEN MisMatch = MisMatch + 1.
        
    Counter = Counter + 1.    
END.

MESSAGE "R6" Counter "Mismatch:" MisMatch VIEW-AS ALERT-BOX.


