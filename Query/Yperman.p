 DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.

 DEFINE BUFFER b_Order FOR glims.Order.

 CREATE QUERY QueryHandle.
 QueryHandle:SET-BUFFERS(BUFFER b_Order:HANDLE).
 QueryHandle:QUERY-PREPARE("FOR EACH b_Order FIELDS( ord_Id ord_InternalId ord_Status ord_Agent ord_Department ord_Encounter ord_LowestObjectTime ord_ExternalPlacerAppl ord_ExternalPlacerCode ord_FseRejectionType ord_Issuer ord_ExternalId ord_ReceiptTime ord_Object ord_OrderSet ord_PhoneStatus ord_Recurrence ord_Referral ord_ReportCopyReceiver ord_ReportLanguage ord_Sampler ord_SamplingAddress ord_ShortId ord_CreationTime ord_Study ord_StudyEpisode ord_TariffingStatus ) WHERE b_Order.ord_Status <> 1 AND b_Order.ord_InternalId BEGINS ~"1~"
 AND b_Order.ord_InternalId BEGINS ~"180680~" NO-LOCK    BY b_Order.ord_InternalId DESCENDING  INDEXED-REPOSITION":U).

 QueryHandle:QUERY-OPEN().
 QueryHandle:GET-FIRST(NO-LOCK).
 MESSAGE "done" VIEW-AS ALERT-BOX.
