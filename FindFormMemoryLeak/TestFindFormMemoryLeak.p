
/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

MESSAGE "start" VIEW-AS ALERT-BOX. 

DO counter = 1 TO 3000:    
    RUN ShowForm.    
END.

MESSAGE "done" VIEW-AS ALERT-BOX. 

//with ASSIGN MyParentForm = ultraGrid1:FindForm(). in FindFormMemoryLeak.cls. Memory usuage: 57MB
//without ASSIGN MyParentForm = ultraGrid1:FindForm(). in FindFormMemoryLeak.cls. Memory usuage: 43MB
//same case in .net 12MB. with FindForm is same as without FindForm.
PROCEDURE ShowForm:
    DEFINE VARIABLE Wnd AS FindFormMemoryLeak.FindFormMemoryLeak NO-UNDO.
    Wnd = NEW FindFormMemoryLeak.FindFormMemoryLeak().
    Wnd:Show().
    PROCESS EVENTS.
    Wnd:Close().
END.
