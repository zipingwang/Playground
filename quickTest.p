DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
 DEFINE BUFFER b_SpeedTest1 FOR genrw.gp_SpeedTest1.
 DEFINE BUFFER b_SpeedTest2 FOR genrw.gp_SpeedTest2.
 DEFINE VARIABLE Number AS INTEGER NO-UNDO.
 DEFINE VARIABLE currentEtime AS INTEGER NO-UNDO.

 /*-------------------------------------------------------------------*/
 ASSIGN Number = RANDOM(0, 2147483647).

 ASSIGN currentEtime = etime(yes).
 DO TRANSACTION:
 DO Counter = 1 TO 1000:

 CREATE b_SpeedTest1.
 ASSIGN
 b_SpeedTest1.spt1_SeqNo = Counter
 b_SpeedTest1.spt1_Number1 = Number
 b_SpeedTest1.spt1_Number2 = Number
 b_SpeedTest1.spt1_Number3 = Number
 b_SpeedTest1.spt1_Number4 = Number
 b_SpeedTest1.spt1_Number5 = Number
 b_SpeedTest1.spt1_Varchar1 = "testjen"
 b_SpeedTest1.spt1_Varchar2 = "testjen"
 b_SpeedTest1.spt1_Varchar3 = "testjen"
 b_SpeedTest1.spt1_Varchar4 = "testjen"
 b_SpeedTest1.spt1_Varchar5 = "testjen"
 .

 CREATE b_SpeedTest2.
 ASSIGN
 b_SpeedTest2.spt2_SpeedTest1 = b_SpeedTest1.spt1_Id
 b_SpeedTest2.spt2_SeqNo = Counter
 b_SpeedTest2.spt2_Number1 = Number
 b_SpeedTest2.spt2_Number2 = Number
 b_SpeedTest2.spt2_Number3 = Number
 b_SpeedTest2.spt2_Number4 = Number
 b_SpeedTest2.spt2_Number5 = Number
 b_SpeedTest2.spt2_Varchar1 = "testjen"
 b_SpeedTest2.spt2_Varchar2 = "testjen"
 b_SpeedTest2.spt2_Varchar3 = "testjen"
 b_SpeedTest2.spt2_Varchar4 = "testjen"
 b_SpeedTest2.spt2_Varchar5 ="testjen"
 .
 END.
 END.
 MESSAGE SUBSTITUTE("the end, etime = &1":U, ETIME - currentEtime ) VIEW-AS ALERT-BOX.
 ETIME(NO).
