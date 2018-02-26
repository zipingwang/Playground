/*------------------------------------------------------------------------
  File        : event_alert.p
  Purpose     : Display alerts for Progress Developer Studio for
                OpenEdge events
  ----------------------------------------------------------------------*/
PROCEDURE oeide_event.
DEFINE INPUT PARAMETER eventName AS CHARACTER.
DEFINE INPUT PARAMETER projectName AS CHARACTER.
DEFINE INPUT PARAMETER programName AS CHARACTER.
DEFINE INPUT PARAMETER eventData AS CHARACTER.

IF eventName = "Get-focus" /*Skip Get-focus event*/
THEN RETURN.

MESSAGE "Event name: "     eventName SKIP
   "Project name: "  projectName SKIP
   "Program name: "  programName SKIP
VIEW-AS ALERT-BOX.
END PROCEDURE.
