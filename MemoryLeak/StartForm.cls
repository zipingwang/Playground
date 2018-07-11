
 /*------------------------------------------------------------------------
    File        : StartForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Wed May 23 13:45:09 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.
USING Playground.MemoryLeak.DummyWindowManagerClient FROM PROPATH.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING be.mips.ablframework.gui.WindowManager FROM PROPATH.
USING be.mips.ablframework.Framework FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.StartForm INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE btnStartTest AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE VARIABLE Timer AS System.Windows.Forms.Timer NO-UNDO.
    DEFINE VARIABLE Counter AS INTEGER NO-UNDO INITIAL 0.
    DEFINE VARIABLE DummyWindowManagerClient AS DummyWindowManagerClient NO-UNDO.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC StartForm():

        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PRIVATE VOID btnStartTest_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        IF(NOT VALID-OBJECT(timer))
        THEN DO:
            timer = NEW System.Windows.Forms.Timer().

            timer:INTERVAL = 1200.
            timer:Tick:Subscribe(TimerTick).
        END.

        timer:Start().

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):

        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE Frm AS PROGRESS.Windows.Form NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF Counter < 200
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(DummyWindowManagerClient) AND TYPE-OF(DummyWindowManagerClient, AbstractWindowManagerClient)
            THEN DO:

                CAST(DummyWindowManagerClient, AbstractWindowManagerClient):FindForm():Close().
            END.

            ASSIGN DummyWindowManagerClient = NEW DummyWindowManagerClient().

            IF Counter < 100
            THEN DO:
                ASSIGN
                    Frm = NEW PROGRESS.Windows.Form()
                    Frm:WIDTH = 500
                    Frm:HEIGHT = 500
                    Frm:TEXT = SUBSTITUTE("Normal form &1":U, Counter)
                    DummyWindowManagerClient:Dock = DockStyle:FILL.
                Frm:Controls:Add(DummyWindowManagerClient).
                Frm:Show().
            END.
            ELSe
            DO:
                DummyWindowManagerClient:TITLE = SUBSTITUTE("Launched by dispatcher form &1":U, Counter).
                DummyWindowManagerClient:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
                be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyWindowManagerClient, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).
            END.

            timer:Start().
            Counter = Counter + 1.
        END.

    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:btnStartTest = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* btnStartTest */
        /*  */
        THIS-OBJECT:btnStartTest:Location = NEW System.Drawing.Point(77, 135).
        THIS-OBJECT:btnStartTest:Name = "btnStartTest".
        THIS-OBJECT:btnStartTest:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnStartTest:TabIndex = 0.
        THIS-OBJECT:btnStartTest:Text = "Start test".
        THIS-OBJECT:btnStartTest:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnStartTest:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnStartTest:Click:Subscribe(THIS-OBJECT:btnStartTest_Click).
        /*  */
        /* StartForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnStartTest).
        THIS-OBJECT:Name = "StartForm".
        THIS-OBJECT:Text = "StartForm".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC StartForm ( ):

    END DESTRUCTOR.

END CLASS.
