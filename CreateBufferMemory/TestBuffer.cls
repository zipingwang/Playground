 
 /*------------------------------------------------------------------------
    File        : TestBuffer
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Mon Jan 22 12:19:53 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS CreateBufferMemory.TestBuffer: 


    METHOD PUBLIC VOID RunTestBufferRun():
        DEFINE VARIABLE xx AS HANDLE NO-UNDO.
        
        xx = TestBufferRun().
        
        
        FINALLY:
/*                ASSIGN xx = ?.	*/

                DELETE OBJECT xx.
        END FINALLY.
    END METHOD.
    
    
    METHOD private HANDLE  TestBufferRun():
        
        DEFINE VARIABLE UserHandle AS HANDLE NO-UNDO.
     
        CREATE BUFFER UserHandle FOR TABLE "sc_user" BUFFER-NAME "b_user".
    
        UserHandle:FIND-FIRST("where usr_LoginName = 'bart'", no-lock).
        RETURN userHandle.
        
    END.



END CLASS.
