
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
USING be.mips.util.GenericGlobals FROM PROPATH.
USING be.mips.ablframework.gui.WindowManager FROM PROPATH.
USING be.mips.ablframework.Framework FROM PROPATH.
USING be.mips.ablframework.gui.bwc.MipsWindowContainer FROM PROPATH.

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

/*add this method in WindowManager.cls*/
/*
METHOD PUBLIC HANDLE GetWindowObjectTempTableHandle():
    RETURN TEMP-TABLE w_WindowObject:HANDLE.
END.
*/
    METHOD STATIC PUBLIC VOID DumpWindowObjectTempTable():
        DEFINE VARIABLE WindowObjectTempTableHandle AS HANDLE NO-UNDO.
        ASSIGN WindowObjectTempTableHandle = CAST(Framework:WindowManager, Windowmanager):GetWindowObjectTempTableHandle().
        RUN playground/temptablehelper/dumptemptable (WindowObjectTempTableHandle, SESSION:TEMP-DIRECTORY + "\\" + "WindowObjectTempTableHandle.xml").
    END.

    METHOD STATIC PUBLIC VOID CheckTitle():
        DEFINE VARIABLE WindowObjectTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE ReturnResult AS LOGICAL NO-UNDO.
        DEFINE VARIABLE Frm AS System.Windows.Forms.Form NO-UNDO.
        DEFINE VARIABLE MipsWindowcontainer AS MipsWindowContainer NO-UNDO.


        /* --------------------------------------------------------------------- */

        ASSIGN WindowObjectTempTableHandle = CAST(Framework:WindowManager, windowmanager):GetWindowObjectTempTableHandle().

        CREATE BUFFER BufferHandle FOR TABLE WindowObjectTempTableHandle BUFFER-NAME "wb_WindowObject".
        CREATE QUERY QueryHandle.

        QueryHandle:ADD-BUFFER(BufferHandle).
        QueryHandle:QUERY-PREPARE("FOR EACH wb_WindowObject where wob_ProcedureName = 'br_rslt7'").
        QueryHandle:QUERY-OPEN().
        ASSIGN ReturnResult = QueryHandle:GET-FIRST().

        IF ReturnResult = YES
        THEN DO:
            ASSIGN MipsWindowcontainer = CAST(BufferHandle::wob_NETWMClient, MipsWindowContainer).
            IF VALID-OBJECT(MipsWindowcontainer) THEN
            DO:
                ASSIGN frm= MipsWindowcontainer:FindForm().
                IF valid-object(frm)
                THEN DO:
                    MESSAGE frm:TEXT VIEW-AS ALERT-BOX.
                END.
            END.
        END.

        DELETE OBJECT BufferHandle.
        DELETE OBJECT QueryHandle.
    END.

END CLASS.
