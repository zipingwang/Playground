
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
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING be.mips.ablframework.gui.WindowManager FROM PROPATH.
USING be.mips.ablframework.Framework FROM PROPATH.
USING Playground.MemoryLeak.Telerik.RadRichTextEditorWindowManagerClient FROM PROPATH.
USING Playground.MemoryLeak.MipsRichTextWithRibbonWindowMangagerClient FROM PROPATH.
USING Playground.MemoryLeak.FormWithResize FROM PROPATH.
USING be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithRibbon FROM PROPATH.
USING Mips.TelerikControls.RichText.RichTextBoxWithRibbon FROM ASSEMBLY.
USING Playground.MemoryLeak.RadRichTextEditorUserControl FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.StartForm INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE btnStartTest AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonMipsRichText_NotWindowsClient_SimpleForm AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE groupBox2 AS System.Windows.Forms.GroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE groupBox3 AS System.Windows.Forms.GroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE label1 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonNotUseWindowManagerClient AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonRadRichTextWithRibbon AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonMipsRichTextWithRibbon AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE groupBox1 AS System.Windows.Forms.GroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonSimpleFormWithResize AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonUseWindowManagerClient AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonWorkflowForm AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radioButtonSimpleForm AS System.Windows.Forms.RadioButton NO-UNDO.
    DEFINE VARIABLE Timer AS System.Windows.Forms.Timer NO-UNDO.
    DEFINE VARIABLE Counter AS INTEGER NO-UNDO INITIAL 0.
    DEFINE VARIABLE DummyWindowManagerClient AS AbstractWindowManagerClient NO-UNDO.
    DEFINE VARIABLE TestTelerikOrMips AS LOGICAL INITIAL YES NO-UNDO.
    DEFINE VARIABLE TestSimpleFormOrWorkflowForm AS LOGICAL INITIAL YES NO-UNDO.
    DEFINE VARIABLE TestFormWithResize AS LOGICAL INITIAL NO NO-UNDO.
    DEFINE VARIABLE TestUseWindowManagerClient AS LOGICAL INITIAL YES NO-UNDO.
    DEFINE PRIVATE VARIABLE txtCount AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE VARIABLE Frm AS PROGRESS.Windows.Form NO-UNDO.

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

        ASSIGN Counter = 0.

        IF(NOT VALID-OBJECT(timer))
        THEN DO:
            timer = NEW System.Windows.Forms.Timer().

            timer:INTERVAL = 1200.
            timer:Tick:Subscribe(TimerTick).
        END.

        timer:Start().

    END METHOD.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID buttonMipsRichText_NotWindowsClient_SimpleForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN Counter = 0.

        IF VALID-OBJECT(timer)
        THEN DELETE OBJECT timer.

        IF(NOT VALID-OBJECT(timer))
        THEN DO:
            timer = NEW System.Windows.Forms.Timer().

            timer:INTERVAL = 1200.
            timer:Tick:Subscribe(TimerTick_MipsRichText_NotWindowsClient_SimpleForm).
        END.

        timer:Start().

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

         ASSIGN Counter = 0.

        IF VALID-OBJECT(timer)
        THEN DELETE OBJECT timer.

        IF(NOT VALID-OBJECT(timer))
        THEN DO:
            timer = NEW System.Windows.Forms.Timer().

            timer:INTERVAL = 1200.
            timer:Tick:Subscribe(TimerTick_MipsRichText_NotWindowsClient_SimpleForm_With_Resize).
        END.

        timer:Start().


    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonMipsRichTextWithRibbon_Click_1( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN TestTelerikOrMips = NO.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonNotUseWindowManagerClient_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN TestUseWindowManagerClient = NO.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonRadRichTextWithRibbon_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN TestTelerikOrMips = YES.

    END METHOD.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonSimpleForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN
            TestSimpleFormOrWorkflowForm = YES
            TestFormWithResize = NO.


    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonSimpleFormWithResize_CheckedChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN
          TestSimpleFormOrWorkflowForm = YES
          TestFormWithResize = YES.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonUseWindowManagerClient_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN TestUseWindowManagerClient = YES.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radioButtonWorkflowForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        ASSIGN TestSimpleFormOrWorkflowForm = NO.

    END METHOD.

    /*****************************************************************************/
    DEFINE VARIABLE RichTextBoxWithRibbon AS RichTextBoxWithRibbon NO-UNDO.
    DEFINE VARIABLE RadRichTextEditorUserControl AS RadRichTextEditorUserControl NO-UNDO.

    METHOD PRIVATE VOID TimerTick(Sender AS System.Object, EventArgs AS System.EventArgs):

        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE NumberOfTest AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN NumberOfTest = INTEGER(txtCount:TEXT).

        IF Counter < NumberOfTest
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(DummyWindowManagerClient) AND TYPE-OF(DummyWindowManagerClient, AbstractWindowManagerClient)
            THEN DO:
                ASSIGN Frm = CAST(DummyWindowManagerClient:FindForm(), PROGRESS.Windows.Form).
                //MESSAGE VALID-OBJECT(Frm) VIEW-AS ALERT-BOX.
                IF VALID-OBJECT(Frm)
                THEN DO:
                    //DummyWindowManagerClient:CloseClient().
                    Frm:Close().
                END.
                ELSE DummyWindowManagerClient:CloseClient().
            END.

            IF VALID-OBJECT(RichTextBoxWithRibbon)
            THEN DO:
                ASSIGN Frm = CAST(RichTextBoxWithRibbon:FindForm(), PROGRESS.Windows.Form).
                Frm:Close().
                RichTextBoxWithRibbon:FreeMemory().
                DELETE OBJECT RichTextBoxWithRibbon.
                RichTextBoxWithRibbon = ?.
            END.

            IF VALID-OBJECT(RadRichTextEditorUserControl)
            THEN DO:
                ASSIGN Frm = CAST(RadRichTextEditorUserControl:FindForm(), PROGRESS.Windows.Form).
                Frm:Close().
                DELETE OBJECT RadRichTextEditorUserControl.
                RadRichTextEditorUserControl = ?.
            END.

            IF TestTelerikOrMips
            THEN DO:
                IF TestUseWindowManagerClient
                THEN ASSIGN DummyWindowManagerClient = NEW RadRichTextEditorWindowManagerClient().
                ELSE ASSIGN RadRichTextEditorUserControl = NEW RadRichTextEditorUserControl().
            END.
            ELSE DO:
                IF TestUseWindowManagerClient
                THEN ASSIGN DummyWindowManagerClient = NEW MipsRichTextWithRibbonWindowMangagerClient().
                ELSE ASSIGN RichTextBoxWithRibbon = NEW RichTextBoxWithRibbon().
            END.

            IF Counter < NumberOfTest AND TestSimpleFormOrWorkflowForm = YES
            THEN DO:
                IF TestFormWithResize = YES
                THEN Frm = NEW FormWithResize().
                ELSE Frm = NEW PROGRESS.Windows.Form().

                ASSIGN
                    Frm:WIDTH = 500
                    Frm:HEIGHT = 500
                    Frm:TEXT = IF TestFormWithResize THEN SUBSTITUTE("Simple form with resizing &1":U, Counter)
                        ELSE SUBSTITUTE("Simple form &1":U, Counter).
                IF TestUseWindowManagerClient
                THEN DO:
                    DummyWindowManagerClient:Dock = DockStyle:FILL.
                    Frm:Controls:Add(DummyWindowManagerClient).
                END.
                ELSE DO:
                    IF VALID-OBJECT(RichTextBoxWithRibbon)
                    THEN DO:
                        RichTextBoxWithRibbon:Dock = DockStyle:FILL.
                        Frm:Controls:Add(RichTextBoxWithRibbon).
                    END.
                    ELSE IF VALID-OBJECT(RadRichTextEditorUserControl)
                    THEN DO:
                        RadRichTextEditorUserControl:Dock = DockStyle:FILL.
                        Frm:Controls:Add(RadRichTextEditorUserControl).
                    END.
                END.
                Frm:Show().
            END.
            ELSE IF Counter < NumberOfTest AND TestSimpleFormOrWorkflowForm = NO
            THEN DO:
                DummyWindowManagerClient:TITLE = SUBSTITUTE("Launched by dispatcher form &1":U, Counter).
                DummyWindowManagerClient:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
                be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyWindowManagerClient, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).
            END.

            timer:Start().
            Counter = Counter + 1.
        END.

    END.

    METHOD PRIVATE VOID TimerTick_MipsRichText_NotWindowsClient_SimpleForm(Sender AS System.Object, EventArgs AS System.EventArgs):

        //DEFINE VARIABLE Frm AS PROGRESS.Windows.Form NO-UNDO.
        DEFINE VARIABLE NumberOfTest AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN NumberOfTest = INTEGER(txtCount:TEXT).

        IF Counter < NumberOfTest
        THEN DO:
            timer:Stop().

            IF VALID-OBJECT(RichTextBoxWithRibbon)
            THEN DO:
                ASSIGN Frm = CAST(RichTextBoxWithRibbon:FindForm(), PROGRESS.Windows.Form).
                Frm:Close().
                RichTextBoxWithRibbon:FreeMemory().
                DELETE OBJECT RichTextBoxWithRibbon.
                RichTextBoxWithRibbon = ?.
            END.

            ASSIGN RichTextBoxWithRibbon = NEW RichTextBoxWithRibbon().
            ASSIGN Frm = NEW PROGRESS.Windows.Form().

            ASSIGN
                Frm:WIDTH = 500
                Frm:HEIGHT = 500
                Frm:TEXT = SUBSTITUTE("Simple form &1":U, Counter)
                RichTextBoxWithRibbon:Dock = DockStyle:FILL.

            Frm:Controls:Add(RichTextBoxWithRibbon).
            Frm:Show().

            timer:Start().
            Counter = Counter + 1.
        END.
    END.


    METHOD PRIVATE VOID TimerTick_MipsRichText_NotWindowsClient_SimpleForm_With_Resize(Sender AS System.Object, EventArgs AS System.EventArgs):

        //
        DEFINE VARIABLE NumberOfTest AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN NumberOfTest = INTEGER(txtCount:TEXT).

        IF Counter < NumberOfTest
        THEN DO:
            timer:Stop().

            IF VALID-OBJECT(RichTextBoxWithRibbon)
            THEN DO:
                ASSIGN Frm = CAST(RichTextBoxWithRibbon:FindForm(), PROGRESS.Windows.Form).
                Frm:Close().
                RichTextBoxWithRibbon:FreeMemory().
                DELETE OBJECT RichTextBoxWithRibbon.
                RichTextBoxWithRibbon = ?.
            END.

            ASSIGN RichTextBoxWithRibbon = NEW RichTextBoxWithRibbon().
            ASSIGN Frm = NEW FormWithResize().

            ASSIGN
                Frm:WIDTH = 500
                Frm:HEIGHT = 500
                Frm:TEXT = SUBSTITUTE("Simple form &1":U, Counter)
                RichTextBoxWithRibbon:Dock = DockStyle:FILL.

            Frm:Controls:Add(RichTextBoxWithRibbon).
            Frm:Show().

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
        THIS-OBJECT:radioButtonRadRichTextWithRibbon = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:groupBox1 = NEW System.Windows.Forms.GroupBox().
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:label1 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txtCount = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:groupBox2 = NEW System.Windows.Forms.GroupBox().
        THIS-OBJECT:radioButtonSimpleFormWithResize = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:radioButtonSimpleForm = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:radioButtonWorkflowForm = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:groupBox3 = NEW System.Windows.Forms.GroupBox().
        THIS-OBJECT:radioButtonNotUseWindowManagerClient = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:radioButtonUseWindowManagerClient = NEW System.Windows.Forms.RadioButton().
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize = NEW System.Windows.Forms.Button().
        THIS-OBJECT:groupBox1:SuspendLayout().
        THIS-OBJECT:groupBox2:SuspendLayout().
        THIS-OBJECT:groupBox3:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* btnStartTest */
        /*  */
        THIS-OBJECT:btnStartTest:Location = NEW System.Drawing.Point(42, 248).
        THIS-OBJECT:btnStartTest:Name = "btnStartTest":U.
        THIS-OBJECT:btnStartTest:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnStartTest:TabIndex = 0.
        THIS-OBJECT:btnStartTest:Text = "Start test":U.
        THIS-OBJECT:btnStartTest:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnStartTest:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnStartTest:Click:Subscribe(THIS-OBJECT:btnStartTest_Click).
        /*  */
        /* radioButtonRadRichTextWithRibbon */
        /*  */
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:Location = NEW System.Drawing.Point(6, 19).
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:Name = "radioButtonRadRichTextWithRibbon":U.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:Size = NEW System.Drawing.Size(291, 24).
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:TabIndex = 1.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:TabStop = TRUE.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:Text = "RadRichTextEditorWithRibbon":U.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonRadRichTextWithRibbon:Click:Subscribe(THIS-OBJECT:radioButtonRadRichTextWithRibbon_Click).
        /*  */
        /* groupBox1 */
        /*  */
        THIS-OBJECT:groupBox1:Controls:Add(THIS-OBJECT:radioButtonMipsRichTextWithRibbon).
        THIS-OBJECT:groupBox1:Controls:Add(THIS-OBJECT:radioButtonRadRichTextWithRibbon).
        THIS-OBJECT:groupBox1:Location = NEW System.Drawing.Point(42, 45).
        THIS-OBJECT:groupBox1:Name = "groupBox1":U.
        THIS-OBJECT:groupBox1:Size = NEW System.Drawing.Size(334, 87).
        THIS-OBJECT:groupBox1:TabIndex = 3.
        THIS-OBJECT:groupBox1:TabStop = FALSE.
        THIS-OBJECT:groupBox1:Text = "WindowManagerClient":U.
        THIS-OBJECT:groupBox1:UseCompatibleTextRendering = TRUE.
        /*  */
        /* radioButtonMipsRichTextWithRibbon */
        /*  */
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:Location = NEW System.Drawing.Point(6, 49).
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:Name = "radioButtonMipsRichTextWithRibbon":U.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:Size = NEW System.Drawing.Size(309, 24).
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:TabIndex = 4.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:TabStop = TRUE.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:Text = "MipsRichTextBoxWithRibbon":U.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonMipsRichTextWithRibbon:Click:Subscribe(THIS-OBJECT:radioButtonMipsRichTextWithRibbon_Click_1).
        /*  */
        /* label1 */
        /*  */
        THIS-OBJECT:label1:Location = NEW System.Drawing.Point(48, 19).
        THIS-OBJECT:label1:Name = "label1":U.
        THIS-OBJECT:label1:Size = NEW System.Drawing.Size(46, 17).
        THIS-OBJECT:label1:TabIndex = 4.
        THIS-OBJECT:label1:Text = "Count:":U.
        THIS-OBJECT:label1:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txtCount */
        /*  */
        THIS-OBJECT:txtCount:Location = NEW System.Drawing.Point(89, 16).
        THIS-OBJECT:txtCount:Name = "txtCount":U.
        THIS-OBJECT:txtCount:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:txtCount:TabIndex = 5.
        THIS-OBJECT:txtCount:Text = "100":U.
        /*  */
        /* groupBox2 */
        /*  */
        THIS-OBJECT:groupBox2:Controls:Add(THIS-OBJECT:radioButtonSimpleFormWithResize).
        THIS-OBJECT:groupBox2:Controls:Add(THIS-OBJECT:radioButtonSimpleForm).
        THIS-OBJECT:groupBox2:Controls:Add(THIS-OBJECT:radioButtonWorkflowForm).
        THIS-OBJECT:groupBox2:Location = NEW System.Drawing.Point(382, 45).
        THIS-OBJECT:groupBox2:Name = "groupBox2":U.
        THIS-OBJECT:groupBox2:Size = NEW System.Drawing.Size(334, 127).
        THIS-OBJECT:groupBox2:TabIndex = 6.
        THIS-OBJECT:groupBox2:TabStop = FALSE.
        THIS-OBJECT:groupBox2:UseCompatibleTextRendering = TRUE.
        /*  */
        /* radioButtonSimpleFormWithResize */
        /*  */
        THIS-OBJECT:radioButtonSimpleFormWithResize:Location = NEW System.Drawing.Point(6, 49).
        THIS-OBJECT:radioButtonSimpleFormWithResize:Name = "radioButtonSimpleFormWithResize":U.
        THIS-OBJECT:radioButtonSimpleFormWithResize:Size = NEW System.Drawing.Size(291, 24).
        THIS-OBJECT:radioButtonSimpleFormWithResize:TabIndex = 3.
        THIS-OBJECT:radioButtonSimpleFormWithResize:TabStop = TRUE.
        THIS-OBJECT:radioButtonSimpleFormWithResize:Text = "Simple Form with resize":U.
        THIS-OBJECT:radioButtonSimpleFormWithResize:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonSimpleFormWithResize:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonSimpleFormWithResize:CheckedChanged:Subscribe(THIS-OBJECT:radioButtonSimpleFormWithResize_CheckedChanged).
        /*  */
        /* radioButtonSimpleForm */
        /*  */
        THIS-OBJECT:radioButtonSimpleForm:Location = NEW System.Drawing.Point(6, 19).
        THIS-OBJECT:radioButtonSimpleForm:Name = "radioButtonSimpleForm":U.
        THIS-OBJECT:radioButtonSimpleForm:Size = NEW System.Drawing.Size(291, 24).
        THIS-OBJECT:radioButtonSimpleForm:TabIndex = 1.
        THIS-OBJECT:radioButtonSimpleForm:TabStop = TRUE.
        THIS-OBJECT:radioButtonSimpleForm:Text = "Simple Form":U.
        THIS-OBJECT:radioButtonSimpleForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonSimpleForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonSimpleForm:Click:Subscribe(THIS-OBJECT:radioButtonSimpleForm_Click).
        /*  */
        /* radioButtonWorkflowForm */
        /*  */
        THIS-OBJECT:radioButtonWorkflowForm:Location = NEW System.Drawing.Point(6, 79).
        THIS-OBJECT:radioButtonWorkflowForm:Name = "radioButtonWorkflowForm":U.
        THIS-OBJECT:radioButtonWorkflowForm:Size = NEW System.Drawing.Size(297, 24).
        THIS-OBJECT:radioButtonWorkflowForm:TabIndex = 2.
        THIS-OBJECT:radioButtonWorkflowForm:TabStop = TRUE.
        THIS-OBJECT:radioButtonWorkflowForm:Text = "Workflow Form":U.
        THIS-OBJECT:radioButtonWorkflowForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonWorkflowForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonWorkflowForm:Click:Subscribe(THIS-OBJECT:radioButtonWorkflowForm_Click).
        /*  */
        /* groupBox3 */
        /*  */
        THIS-OBJECT:groupBox3:Controls:Add(THIS-OBJECT:radioButtonNotUseWindowManagerClient).
        THIS-OBJECT:groupBox3:Controls:Add(THIS-OBJECT:radioButtonUseWindowManagerClient).
        THIS-OBJECT:groupBox3:Location = NEW System.Drawing.Point(42, 138).
        THIS-OBJECT:groupBox3:Name = "groupBox3":U.
        THIS-OBJECT:groupBox3:Size = NEW System.Drawing.Size(334, 84).
        THIS-OBJECT:groupBox3:TabIndex = 7.
        THIS-OBJECT:groupBox3:TabStop = FALSE.
        THIS-OBJECT:groupBox3:UseCompatibleTextRendering = TRUE.
        /*  */
        /* radioButtonNotUseWindowManagerClient */
        /*  */
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:Location = NEW System.Drawing.Point(6, 49).
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:Name = "radioButtonNotUseWindowManagerClient":U.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:Size = NEW System.Drawing.Size(291, 24).
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:TabIndex = 3.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:TabStop = TRUE.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:Text = "Not UseWindowManagerClient":U.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonNotUseWindowManagerClient:Click:Subscribe(THIS-OBJECT:radioButtonNotUseWindowManagerClient_Click).
        /*  */
        /* radioButtonUseWindowManagerClient */
        /*  */
        THIS-OBJECT:radioButtonUseWindowManagerClient:Location = NEW System.Drawing.Point(6, 19).
        THIS-OBJECT:radioButtonUseWindowManagerClient:Name = "radioButtonUseWindowManagerClient":U.
        THIS-OBJECT:radioButtonUseWindowManagerClient:Size = NEW System.Drawing.Size(291, 24).
        THIS-OBJECT:radioButtonUseWindowManagerClient:TabIndex = 1.
        THIS-OBJECT:radioButtonUseWindowManagerClient:TabStop = TRUE.
        THIS-OBJECT:radioButtonUseWindowManagerClient:Text = "UseWindowManagerClient":U.
        THIS-OBJECT:radioButtonUseWindowManagerClient:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:radioButtonUseWindowManagerClient:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:radioButtonUseWindowManagerClient:Click:Subscribe(THIS-OBJECT:radioButtonUseWindowManagerClient_Click).
        /*  */
        /* buttonMipsRichText_NotWindowsClient_SimpleForm */
        /*  */
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:Location = NEW System.Drawing.Point(42, 288).
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:Name = "buttonMipsRichText_NotWindowsClient_SimpleForm":U.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:Size = NEW System.Drawing.Size(403, 23).
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:TabIndex = 8.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:Text = "Start test: MipsRichText_NotWindowsClient_SimpleForm":U.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm:Click:Subscribe(THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_Click).
        /*  */
        /* buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize */
        /*  */
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:Location = NEW System.Drawing.Point(42, 334).
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:Name = "buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize":U.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:Size = NEW System.Drawing.Size(403, 23).
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:TabIndex = 9.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:Text = "Start test: MipsRichText_NotWindowsClient_SimpleForm_With_Resize":U.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize:Click:Subscribe(THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize_Click).
        /*  */
        /* StartForm */
        /*  */
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm_With_Resize).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonMipsRichText_NotWindowsClient_SimpleForm).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:groupBox3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:groupBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtCount).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:groupBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnStartTest).
        THIS-OBJECT:Name = "StartForm":U.
        THIS-OBJECT:Size = NEW System.Drawing.Size(731, 492).
        THIS-OBJECT:groupBox1:ResumeLayout(FALSE).
        THIS-OBJECT:groupBox2:ResumeLayout(FALSE).
        THIS-OBJECT:groupBox3:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC StartForm ( ):

    END DESTRUCTOR.

END CLASS.
