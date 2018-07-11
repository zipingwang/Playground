DEFINE VARIABLE WinderHandle AS HANDLE NO-UNDO.

/*RUN Playground\Progress\Window-Frame-Persistent-Non-Persistent\Window.*/

RUN Playground\Progress\Window-Frame-Persistent-Non-Persistent\Window
PERSISTENT SET WinderHandle.

WAIT-FOR 'CLOSE':U OF THIS-PROCEDURE.
        
MESSAGE "end" VIEW-AS ALERT-BOX.