 
 /*------------------------------------------------------------------------
    File        : WindowManagerHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zipingwa
    Created     : Thu Nov 09 15:11:17 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING be.mips.ablframework.gui.IWindowManagerClient FROM PROPATH.
USING be.mips.ablframework.gui.context.IContextualControl FROM PROPATH.
USING Consultingwerk.Framework.LogManagerErrorHandler FROM PROPATH.
USING Consultingwerk.Util.LogManager FROM PROPATH.
USING be.mips.ablframework.gui.context.IContextualToolbarProvider FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS windowmanager.WindowManagerHelper: 
    
    METHOD STATIC PUBLIC VOID Log(MyText AS CHARACTER,  Client AS IWindowManagerClient):
        
        DEFINE VARIABLE ClientAsContextualControl AS IContextualControl NO-UNDO.      
        DEFINE VARIABLE ClientContextTableId AS INTEGER NO-UNDO.
      
        ClientAsContextualControl = CAST(Client, IContextualControl).
        Log(Mytext, ClientAsContextualControl).

    END.    
     
    METHOD STATIC PUBLIC VOID Log(MyText AS CHARACTER,  Client AS IContextualControl):        
        
        DEFINE VARIABLE ClientContextTableId AS INTEGER NO-UNDO.      
      
        IF VALID-OBJECT(Client)
        THEN DO:
            ClientContextTableId = Client:ContextTableId.
            IF /*ClientContextTableId = 762 /*speciment*/ OR*/ ClientContextTableId = 789 /*result*/
            THEN DO:
       //         MESSAGE MyText ClientContextTableId VIEW-AS ALERT-BOX.
                LogManager:WriteFormattedMessage(MyText, ClientContextTableId).
            END.
        END.    

    END.
    
     METHOD STATIC PUBLIC VOID Log(MyText AS CHARACTER,  ContextualToolbarProvider AS IContextualToolbarProvider,
        ContextualControl AS IContextualControl):
        
        DEFINE VARIABLE ClientContextTableId AS INTEGER NO-UNDO.      
      
        IF VALID-OBJECT(ContextualControl)
        THEN DO:
            ClientContextTableId = ContextualControl:ContextTableId.
            IF /*ClientContextTableId = 762 /*speciment*/ OR*/ ClientContextTableId = 789 /*result*/
            THEN DO:
               Log(MyText, ContextualControl).
               Log(MyText, ClientContextTableId, ContextualToolbarProvider).
            END.
        END.    

    END.
    
    
      METHOD STATIC PUBLIC VOID Log(MyText AS CHARACTER, TClientContextTableId AS INTEGER,  ToolbarProvider AS IContextualToolbarProvider):  
      
        IF VALID-OBJECT(ToolbarProvider)
        THEN DO:  
            
            MESSAGE MyText "TableId" TClientContextTableId "ToolbarManager:" ToolbarProvider:ToolbarsManager
                "ActiveMdiChildManager:"  ToolbarProvider:ToolbarsManager:ActiveMdiChildManager VIEW-AS ALERT-BOX.
            LogManager:WriteFormattedMessage(MyText, ToolbarProvider:ToolbarsManager:ToString()).       
                
        END.
    END.    

END CLASS.
