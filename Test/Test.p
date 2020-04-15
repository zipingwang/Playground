DEFINE VARIABLE MyTestTime AS DECIMAL NO-UNDO.
DEFINE VARIABLE MaxSeconds AS INTEGER INITIAL 86400 NO-UNDO.
DEFINE VARIABLE MaxMiliseconds AS INTEGER INITIAL 86400000 NO-UNDO.
DEFINE VARIABLE ValueInDb AS DECIMAL NO-UNDO.
DEFINE VARIABLE Counter AS DECIMAL NO-UNDO.
DEFINE VARIABLE MisMatchOld AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE MisMatchNew AS INTEGER NO-UNDO INITIAL 0.

ASSIGN Counter = 1.
DO WHILE Counter < 86400:
    ValueInDb = TRUNCATE(Counter / 86400, 6).
    
    IF Counter <> INTEGER(ValueInDb * 86400)
    THEN MisMatchOld = MisMatchOld + 1.
    
    //INTEGER(TRUNCATE( ((DecimalDateTime - INTEGER(DateValue)) * 86400) + 0.00005 , 0)).
    IF Counter <> INTEGER(TRUNCATE(ValueInDb * 86400 + 0.00005 , 0))
    //IF Counter <> INTEGER(TRUNCATE((ValueInDb + 0.00005) * 86400, 0))
    THEN MisMatchNew = MisMatchNew + 1.
    
    Counter = Counter + 1.    
END.

MESSAGE "R4" Counter "Old way:" MisMatchOld "New way:" MisMatchNew VIEW-AS ALERT-BOX.

RETURN.

ASSIGN 
    Counter = 1
    MisMatchNew = 0
    MisMatchOld = 0.
    
/*DO WHILE Counter < 86400:
    ValueInDb = TRUNCATE(Counter * 1000 / 86400000, 9).
    //IF Counter <> INTEGER(ValueInDb * 86400)
    IF Counter <> INTEGER(TRUNCATE((ValueInDb * 86400), 0))
    THEN MisMatchOld = MisMatchOld + 1.
    Counter = Counter + 1.    
END. 
*/
DO WHILE Counter < 86400000:
    ValueInDb = TRUNCATE(Counter / 86400000, 9).
    IF INTEGER(Counter / 1000) <> INTEGER(ValueInDb * 86400)
    THEN MisMatchOld = MisMatchOld + 1.
    IF INTEGER(Counter / 1000) <> INTEGER(TRUNCATE(ValueInDb * 86400 + 0.00005 , 0))
    THEN MisMatchNew = MisMatchNew + 1.
    Counter = Counter + 1.
END.

MESSAGE Counter "Old way:" MisMatchOld "New way:" MisMatchNew VIEW-AS ALERT-BOX.

RETURN.

ASSIGN 
    MyTestTime = 2 // 86399
    ValueInDb = TRUNCATE(MyTestTime / 86400, 6)
    .

MESSAGE
    ValueInDb
    INTEGER(ValueInDb * 86400)
    TRUNCATE(ValueInDb * 86400, 0)
    INTEGER(TRUNCATE(ValueInDb * 86400 + 0.001336, 0))
    //TimeValue = INTEGER(TRUNCATE(((DecimalDateTime - INTEGER(DateValue)) * 86400) + 0.00005, 0)).
VIEW-AS ALERT-BOX.

ASSIGN 
    MyTestTime = 86399999
    ValueInDb = TRUNCATE(MyTestTime / 86400000, 9)
    .
    
MESSAGE
    ValueInDb
    INTEGER(ValueInDb * 86400)
    TRUNCATE(ValueInDb * 86400, 0)
    INTEGER(TRUNCATE(ValueInDb * 86400 + 0.0010367, 0))
VIEW-AS ALERT-BOX.

RETURN.


/*MESSAGE           */
/*    INTEGER(0.4)  */
/*    INTEGER(0.5)  */
/*    INTEGER(0.6)  */
/*    INTEGER(0.7)  */
/*VIEW-AS ALERT-BOX.*/



















DEFINE VARIABLE DecimalDateTime AS DECIMAL NO-UNDO.
        DEFINE VARIABLE DateValue AS DATE NO-UNDO.
        DEFINE VARIABLE TimeValue AS INTEGER NO-UNDO.
        DEFINE VARIABLE MyDate AS DATE NO-UNDO.
        DEFINE VARIABLE MyTime AS INTEGER NO-UNDO.
        DEFINE VARIABLE MyTrancatedTime AS DECIMAL NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        MESSAGE TRUNCATE(86399 / 86400, 6) VIEW-AS ALERT-BOX.
        
        ASSIGN 
            MyDate = TODAY
            MyTime = 24 * 60 * 60 - 1
            MyTrancatedTime = TRUNCATE(MyTime / 86400, 6)
            DecimalDateTime = INTEGER(MyDate) + MyTrancatedTime.
        
        RUN gp_ddt(DecimalDateTime, OUTPUT DateValue, OUTPUT TimeValue).
    
    MESSAGE "MyDate:" INTEGER(MyDate) "MyTrancatedTime:" MyTrancatedTime "Datetime:" DecimalDateTime "TimeValue" TimeValue VIEW-AS ALERT-BOX. 
        
        ASSIGN 
            MyDate = TODAY
            MyTime = 24 * 60 * 60 * 1000 - 1
            DecimalDateTime = INTEGER(MyDate) + TRUNCATE(MyTime / 86400000, 9).
     
        RUN gp_ddt(DecimalDateTime, OUTPUT DateValue, OUTPUT TimeValue).
        
         MESSAGE "MyDate:" INTEGER(MyDate) "Datetime:" DecimalDateTime "TimeValue" TimeValue VIEW-AS ALERT-BOX.
  
