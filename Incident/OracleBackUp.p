    DEFINE VARIABLE BackupTimeString AS CHARACTER NO-UNDO.
    DEFINE VARIABLE FullBackupDate AS DATE NO-UNDO.
    DEFINE VARIABLE FullBackupTime AS INTEGER NO-UNDO.

    DEFINE VARIABLE IsInvalidBackupDate AS LOGICAL NO-UNDO.

    ASSIGN BackupTimeString = "20180703".

    RUN gp_tstdt(BackupTimeString, OUTPUT FullBackupDate,
        OUTPUT FullBackupTime, OUTPUT IsInvalidBackupDate).

    MESSAGE IsInvalidBackupDate VIEW-AS ALERT-BOX.
