DEFINE VARIABLE V1 AS CHARACTER NO-UNDO.
DEFINE VARIABLE V2 AS CHARACTER NO-UNDO.
DEFINE VARIABLE Vtemp AS CHARACTER NO-UNDO.

ASSIGN vtemp = System.Environment:GetEnvironmentVariable("path").
ASSIGN V1 = REPLACE(Vtemp, "C:\OpenEdge\11764\bin\graphicsmagick\;", ""). //System.Environment:GetEnvironmentVariable("path") .

V2 = OS-GETENV("PATH").
MESSAGE //V1 = V2 
skip(1)
"net:"    vtemp

skip(2)
"os-getenv:"
    v2
VIEW-AS ALERT-BOX.
