DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
DEFINE VARIABLE Station AS CHARACTER NO-UNDO.

DEFINE BUFFER b_station FOR glims.station.
DEFINE BUFFER b_assessmentMethod FOR glims.AssessmentMethod.

ASSIGN
    Counter = 0
    Station = "Not found".

FOR FIRST b_station NO-LOCK WHERE b_station.stn_mnemonic BEGINS 's':

    ASSIGN Station = b_station.stn_mnemonic.

    FOR EACH b_assessmentMethod NO-LOCK WHERE b_assessmentMethod.amtd_Station = b_station.stn_Id:
        ASSIGN Counter = Counter + 1.
    END.
END.

MESSAGE "Station" Station "AssessmentMethod Counter" Counter VIEW-AS ALERT-BOX.
