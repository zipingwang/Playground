 
 /*------------------------------------------------------------------------
    File        : ErrorHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Thu Feb 15 16:01:36 CET 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.ErrorHelper: 
    
    METHOD PUBLIC STATIC CHARACTER GetErrorMessage(Err AS  Progress.Lang.Error):
        
        DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE AppError AS Progress.Lang.AppError NO-UNDO.
        
        /* --------------------------------------------------------------------- */
        
        DO Counter = 1 TO Err:NumMessages: 
            ErrorMessage = ErrorMessage + "~n" + Err:GetMessage(Counter). 
        END. 
         
        IF TYPE-OF(Err, Progress.Lang.AppError)
        THEN DO:  
            ASSIGN AppError =  CAST(Err, Progress.Lang.AppError).                     
            IF AppError:ReturnValue > "" THEN   
            ErrorMessage = ErrorMessage +  "~n" + AppError:ReturnValue. 
        END.
        
       RETURN ErrorMessage.
       
    END.
END CLASS.
