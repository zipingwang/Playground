DEFINE VARIABLE userwin AS HANDLE.

DEFINE QUERY userq FOR sc_user.
DEFINE BROWSE userb QUERY userq
  DISPLAY sc_User.usr_LastName sc_User.usr_FirstName WITH 10 DOWN.

DEFINE BUTTON bName    LABEL "Query on Name".
DEFINE BUTTON bFistName LABEL "Query on FirstName".
DEFINE BUTTON bCancel  LABEL "Cancel".

DEFINE FRAME UserFrame userb SKIP
  bName bFistName bCancel.

ON CHOOSE OF bName IN FRAME UserFrame DO:
  userwin:TITLE = "Customers by Name".
  OPEN QUERY userq FOR EACH sc_user BY sc_user.usr_LastName.
END.

ON CHOOSE OF bFistName IN FRAME UserFrame DO:
  userwin:TITLE = "Customers by Balance".
  OPEN QUERY userq FOR EACH sc_user BY sc_user.usr_FirstName DESCENDING.
END.

IF THIS-PROCEDURE:PERSISTENT THEN DO:
  THIS-PROCEDURE:PRIVATE-DATA = "Customer Browse".
  CREATE WIDGET-POOL.
END.

CREATE WINDOW userwin ASSIGN
  TITLE            = "Customer Browser"
  SCROLL-BARS      = FALSE
  MAX-HEIGHT-CHARS = FRAME UserFrame:HEIGHT-CHARS
  MAX-WIDTH-CHARS  = FRAME UserFrame:WIDTH-CHARS.

THIS-PROCEDURE:CURRENT-WINDOW = userwin.

ENABLE ALL WITH FRAME UserFrame.

IF THIS-PROCEDURE:PERSISTENT THEN
  ON CHOOSE OF bCancel IN FRAME UserFrame DO:
    RUN destroy-query.
  END.
ELSE 
  WAIT-FOR CHOOSE OF bCancel IN FRAME UserFrame.

PROCEDURE destroy-query:
  DELETE PROCEDURE THIS-PROCEDURE.
  DELETE WIDGET-POOL.
END PROCEDURE.