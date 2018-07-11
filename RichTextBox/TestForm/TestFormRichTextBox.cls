
 /*------------------------------------------------------------------------
    File        : TestFormRichTextBox
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue May 22 14:15:18 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

USING System.EventArgs FROM ASSEMBLY.
USING Mips.TelerikControls.RichText.RichTextBoxTextFormatOptions FROM ASSEMBLY.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraPanel FROM ASSEMBLY.
USING System.GC FROM ASSEMBLY.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.
USING be.mips.ablframework.gui.richtextbox.RequestBufferHandleEventArgs FROM PROPATH.
USING Mips.TelerikControls.RichText.RichTextBoxLayoutMode FROM ASSEMBLY.
USING Playground.RichTextBox.TestForm.Class2 FROM PROPATH.


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TestForm.TestFormRichTextBox INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE btnDummyForm AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btnOpenLargeForm AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btnSave AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btnLoad AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE mipsRichTextBoxWithIndicator1 AS be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator NO-UNDO.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC TestFormRichTextBox():

        SUPER().
        InitializeComponent().
        mipsRichTextBoxWithIndicator1:RequestBuffer:Subscribe(THIS-OBJECT:mipsRichTextBoxWithIndicator1_RequestBuffer).
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        //mipsRichTextBoxWithIndicator1:RichTextBox:LayoutModeOfLargeEditor = RichTextBoxLayoutMode:Flow.
        SetContent().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*****************************************************************************/

    DEFINE BUFFER b_gp_site FOR gp_site.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID SetContent(  ):

        DEFINE VARIABLE Content AS CHARACTER NO-UNDO.
        ASSIGN content =   "asdfsaf
asdfsadfsadf
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
asdfasdfsadfdsa
<br/>
<br/>
<br/>
<br/>
<br/>
asdfasdfsadfdsa
asdfasdfsadfdsa
 sadfs
sdfsdfs
asdfsadf
asdfsaf
asdfsadfsa".
        mipsRichTextBoxWithIndicator1:RichTextBox:SetContent(content).

    END METHOD.

    METHOD PRIVATE VOID mipsRichTextBoxWithIndicator1_RequestBuffer(Sender AS PROGRESS.lang.object, EventArgs AS RequestBufferHandleEventArgs):

        /* --------------------------------------------------------------------- */

        FOR FIRST b_gp_site NO-LOCK:
            ASSIGN EventArgs:BufferHandle = BUFFER b_gp_site:HANDLE.
        END.

    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnDummyForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        DEFINE VARIABLE MyClass AS Class2 NO-UNDO.
        ASSIGN MyClass = NEW Class2().
        MESSAGE MyClass:FirstName MyClass:Language VIEW-AS ALERT-BOX.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnLoad_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE BUFFER b_family FOR glims.Family.
        DEFINE VARIABLE content AS LONGCHAR NO-UNDO.

        FIX-CODEPAGE(content) = 'utf-8':U.

        FOR FIRST b_family WHERE fml_id = 117:
            ASSIGN content = b_family.fml_HistoryClob.

            THIS-OBJECT:mipsRichTextBoxWithIndicator1:RichTextBox:SetContent(content).
        END.


    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnOpenLargeForm_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        DEFINE VARIABLE TheContect AS CHARACTER NO-UNDO.

        DEFINE VARIABLE btn AS System.Windows.Forms.Button NO-UNDO.
        btn:Name ="".
        //EvaluateDt().
        //EvaluateDtLongChar().

        //MESSAGE "1" THIS-OBJECT:LANGUAGE VIEW-AS ALERT-BOX.

    END METHOD.

    METHOD VOID EvaluateDt():
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE ExpandedText AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.
        DEFINE BUFFER b_ds_table FOR genro.ds_Table.
        DEFINE VARIABLE TableName AS CHARACTER NO-UNDO.
        DEFINE BUFFER b_Correspodent FOR Correspondent.
        DEFINE VARIABLE TheText AS CHARACTER NO-UNDO.


        /* --------------------------------------------------------------------- */

        //THIS-OBJECT:SmallMipsRichTextBox:NeedBufferForMispl(OUTPUT BufferHandle).

        //IF VALID-HANDLE(BufferHandle)
        //THEN DO:
        ASSIGN TheText = "Correspondent: <style type=text/css> </style> from ~{ sfsfFromSeqNo2~ } ".
        //ASSIGN TheText = "Correspondent: ~{=.Name~} from ~{ sfsfFromSeqNo2~ } to ~{ToSeqNo~}".

            FOR FIRST b_Correspodent NO-LOCK:

            END.

            ASSIGN BufferHandle = BUFFER b_Correspodent:HANDLE.
            RUN gp_dtevl(TheText, ?, ?, ?, 1, "Correspondent", BufferHandle, NO, OUTPUT ExpandedText, OUTPUT ErrorMessage).

            IF ErrorMessage = ?
            THEN MESSAGE ExpandedText VIEW-AS ALERT-BOX.
            ELSE RUN gp_sherr("DynamicTextError":U, ErrorMessage).
        //END.

    END.

    METHOD VOID EvaluateDtLongChar():
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE ExpandedText AS LONGCHAR  NO-UNDO.
        DEFINE VARIABLE ErrorMessage AS LONGCHAR NO-UNDO.
        DEFINE BUFFER b_ds_table FOR genro.ds_Table.
        DEFINE VARIABLE TableName AS CHARACTER NO-UNDO.
        DEFINE BUFFER b_Correspodent FOR Correspondent.
        DEFINE VARIABLE TheText AS LONGCHAR NO-UNDO.

        /* --------------------------------------------------------------------- */

        //THIS-OBJECT:SmallMipsRichTextBox:NeedBufferForMispl(OUTPUT BufferHandle).

        //IF VALID-HANDLE(BufferHandle)
        //THEN DO:
              ASSIGN TheText = "Correspondent:12<style type=text/css> </style>34from ~{ sfsfFromSeqNo2~ } ".
        //ASSIGN TheText = "Correspondent: ~{=.Name~} from ~{ sfsfFromSeqNo2~ } to ~{ToSeqNo~}".

        FOR FIRST b_Correspodent NO-LOCK:

        END.

        ASSIGN BufferHandle = BUFFER b_Correspodent:HANDLE.
        RUN gp_dtevl_longchar_html(TheText, ?, ?, ?, 1, "Correspondent", BufferHandle, NO, OUTPUT ExpandedText, OUTPUT ErrorMessage).

        IF ErrorMessage = ?
        THEN MESSAGE string(ExpandedText) VIEW-AS ALERT-BOX.
        ELSE RUN gp_sherr("DynamicTextError":U, ErrorMessage).
        //END.

    END.

    DEFINE VARIABLE Timer AS System.Windows.Forms.Timer NO-UNDO.
    DEFINE VARIABLE Counter AS INTEGER NO-UNDO INITIAL 0.


    METHOD PRIVATE VOID OpenFormRichTextBoxWithRibbon():

        IF(NOT VALID-OBJECT(timer))
        THEN DO:
            timer = new System.Windows.Forms.Timer().

            timer:INTERVAL = 3000.
            timer:Tick:Subscribe(TimerTick).

        END.
        timer:Start().
    END.

/*no memory leak. put MipsRichTextBox on a form*/
/*    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):

        IF Counter < 30
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
            THEN TestFormRichTextBoxWithRibbon:Close().

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().
            TestFormRichTextBoxWithRibbon:Show().
            timer:Start().
            Counter = Counter + 1.
        END.

    END.
*/
/*
    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 2
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
            THEN DO:
                TestFormRichTextBoxWithRibbon:FindForm():Close().
                //DELETE OBJECT TestFormRichTextBoxWithRibbon.
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            TestFormRichTextBoxWithRibbon:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
            be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(TestFormRichTextBoxWithRibbon, Parent, be.mips.ablframework.gui.ModalityMode:None).

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
*/


    //DEFINE VARIABLE Frm AS System.Windows.Forms.Form NO-UNDO.

    //DEFINE VARIABLE WorkflowFormWithoutRibbon AS WorkflowFormWithoutRibbon NO-UNDO.
/*
    /*has memory leak, put WindowmanagerClient to a simple winform's form */

        METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 2
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                CAST(Frm:Controls[0], UltraPanel):ClientArea:Controls:Clear().
                Frm:Controls:Clear().
                Frm:Close().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.
                GC:Collect().
                GC:WaitForPendingFinalizers().
                GC:Collect().
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().
            //Frm = NEW System.Windows.Forms.Form().
            //Frm = NEW Progress.Windows.Form(). /*ok*/
            Frm = NEW WorkflowFormWithoutRibbon(). /*ok*/
            //Cast(Frm, WorkflowFormWithoutRibbon):AfterConstructor().
            CAST(Frm:Controls[0], UltraPanel):ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).

            Frm:Show().

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
    */
    /*
    METHOD PRIVATE VOID TimerTick_ok_only_WorkflowFormWithoutRibbon(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 100
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                Frm:Controls:Clear().
                Frm:Close().
                //DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
            END.

            //ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().
            //Frm = NEW System.Windows.Forms.Form().
            //Frm = NEW Progress.Windows.Form(). /*ok*/
            Frm = NEW WorkflowFormWithoutRibbon(). /*ok*/
            Cast(Frm, WorkflowFormWithoutRibbon):AfterConstructor().
            //CAST(Frm:Controls[0], UltraPanel):ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).
            //Frm:Controls:Add(TestFormRichTextBoxWithRibbon).
            Frm:Show().

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
*/
/*
    METHOD PRIVATE VOID TimerTick_real_ok(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 10
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW Progress.Windows.Form().
            Frm:Controls:Add(TestFormRichTextBoxWithRibbon).
            Frm:TEXT = STRING(Counter).
            Frm:Show().


            timer:Start().

        END.

        Counter = Counter + 1.

        IF Counter = 11 AND VALID-OBJECT(Frm)
        THEN DO:
                timer:Stop().
                MESSAGE "stop" VIEW-AS ALERT-BOX.
                Counter = 0.
                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.

        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.
    END.
    */
/*
    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE ParentForm AS System.Windows.Forms.Form NO-UNDO.

        IF Counter < 5
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
            THEN DO:

                 //MESSAGE "1" VIEW-AS ALERT-BOX.
                ASSIGN ParentForm = TestFormRichTextBoxWithRibbon:FindForm().
                //TestFormRichTextBoxWithRibbon:CloseClient().
                 //MESSAGE "2" VIEW-AS ALERT-BOX.
                IF VALID-OBJECT(ParentForm)
                THEN DO:
                    ParentForm:Controls:Clear().
                    ParentForm:Close().
                END.
 //MESSAGE "3" VIEW-AS ALERT-BOX.
                /*TestFormRichTextBoxWithRibbon:CloseClient().*/
                IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
                THEN DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                ELSE ASSIGN TestFormRichTextBoxWithRibbon = ?.

                /*DELETE OBJECT Frm.*/
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            TestFormRichTextBoxWithRibbon:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
            be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(TestFormRichTextBoxWithRibbon, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).

            /*

            Frm = NEW WorkflowFormWithoutRibbon().
            CAST(Frm, WorkflowFormWithoutRibbon):MyContentPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).
            //Frm:Controls:Add(TestFormRichTextBoxWithRibbon).
            Frm:TEXT = STRING(Counter).
            Frm:Show().*/

            timer:Start().
        END.

        Counter = Counter + 1.

        IF Counter = 6 AND VALID-OBJECT(TestFormRichTextBoxWithRibbon)
        THEN DO:
                timer:Stop().
                MESSAGE "stop" VIEW-AS ALERT-BOX.
                Counter = 0.

                ASSIGN ParentForm = TestFormRichTextBoxWithRibbon:FindForm().
                //TestFormRichTextBoxWithRibbon:CloseClient().

                IF VALID-OBJECT(ParentForm)
                THEN DO:
                    ParentForm:Controls:Clear().
                    ParentForm:Close().
                END.

                /*TestFormRichTextBoxWithRibbon:CloseClient().*/
                IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
                THEN DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                ELSE ASSIGN TestFormRichTextBoxWithRibbon = ?.
        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.
    END.
*/
/*
    //DEFINE VARIABLE TestFormRichTextBoxWithRibbon AS TestFormRichTextBoxWithRibbon NO-UNDO.

    //DEFINE VARIABLE DummyForm AS DummyForm NO-UNDO.
    METHOD PRIVATE VOID TimerTick_real_ok(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 5
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW WorkflowFormWithoutRibbon().
            CAST(Frm, WorkflowFormWithoutRibbon):MyContentPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).
            //Frm:Controls:Add(TestFormRichTextBoxWithRibbon).
            Frm:TEXT = STRING(Counter).
            Frm:Show().

            timer:Start().
        END.

        Counter = Counter + 1.

        IF Counter = 6 AND VALID-OBJECT(Frm)
        THEN DO:
                timer:Stop().
                MESSAGE "stop" VIEW-AS ALERT-BOX.
                Counter = 0.
                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.
        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.
    END.
    */



    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
   /*     DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE TestFormRichTextBoxWithRibbon AS TestFormRichTextBoxWithRibbon NO-UNDO.
        DEFINE VARIABLE Frm AS Progress.Windows.Form NO-UNDO.

        IF Counter < 5
        THEN DO:
            timer:Stop().

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW WorkflowFormWithoutRibbon().
            //CAST(Frm, WorkflowFormWithoutRibbon):AfterConstructor().

            //CAST(Frm, WorkflowFormWithoutRibbon):MyContentPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).
            Frm:Controls:Clear().
            Frm:Controls:Add(TestFormRichTextBoxWithRibbon).

            /*Frm = NEW Progress.Windows.Form().
            Frm:Controls:Add(TestFormRichTextBoxWithRibbon).*/

            Frm:TEXT = STRING(Counter).
            Frm:Show().
        END.

        Counter = Counter + 1.
        RUN gp_Wait(2000).
        PROCESS EVENTs.
        RUN gp_Wait(2000).
        IF VALID-OBJECT(Frm)
        THEN DO:
                timer:Stop().
                //MESSAGE "stop" VIEW-AS ALERT-BOX.

                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.

                IF Counter = 5
                THEN DO:
                    Counter = 0.
                    timer:Stop().
                END.
                Else timer:Start().
        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.*/
    END.
/*
    METHOD PRIVATE VOID TimerTick_nok_20180528_1252(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE TestFormRichTextBoxWithRibbon AS TestFormRichTextBoxWithRibbon NO-UNDO.
        //DEFINE VARIABLE DummyForm AS DummyForm NO-UNDO.
        DEFINE VARIABLE Frm AS Progress.Windows.Form NO-UNDO.

        //DEFINE VARIABLE Parent AS HANDLE NO-UNDO.

        /* --------------------------------------------------------------------- */
//MESSAGE "start" VIEW-AS ALERT-BOX.
        IF Counter < 3
        THEN DO:
            timer:Stop().
            /*IF VALID-OBJECT(Frm)
            THEN DO:
                Frm:Controls:Clear().
                Frm:Close().
                TestFormRichTextBoxWithRibbon:CloseClient().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
                DELETE OBJECT Frm.
            END.*/

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW WorkflowFormWithoutRibbon().

            //CAST(Frm, WorkflowFormWithoutRibbon):Place(TestFormRichTextBoxWithRibbon).

           // CAST(Frm, WorkflowFormWithoutRibbon):MainWMChild = TestFormRichTextBoxWithRibbon.
            CAST(Frm, WorkflowFormWithoutRibbon):MyContentPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).
            //Frm:Controls:Add(TestFormRichTextBoxWithRibbon).

            Frm:TEXT = STRING(Counter).
            Frm:Show().

            //timer:Start().
        END.

        Counter = Counter + 1.
        timer:Stop().

        RUN gp_Wait(3000).

MESSAGE "show" VIEW-AS ALERT-BOX.

        IF VALID-OBJECT(Frm)
        THEN DO:

           // CAST(Frm, WorkflowFormWithoutRibbon):MainWMChild = ?.

            CAST(Frm, WorkflowFormWithoutRibbon):MyContentPanel:ClientArea:Controls:Clear().
            Frm:Controls:Clear().
            Frm:Close().

            TestFormRichTextBoxWithRibbon:CloseClient().
            DELETE OBJECT TestFormRichTextBoxWithRibbon.

            MESSAGE "close2" VIEW-AS ALERT-BOX.


            IF VALID-OBJECT(TestFormRichTextBoxWithRibbon)
            THEN DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
            IF VALID-OBJECT(Frm)
            THEN DELETE OBJECT Frm.

            IF Counter = 3
            THEN DO:
                Counter = 0.
                timer:Stop().
            END.
            Else timer:Start().
        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.
    END.
    */
/*
    METHOD PRIVATE VOID TimerTick_ok2(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE UltraPanel AS UltraPanel NO-UNDO.

        IF Counter < 2
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                //Frm:Controls:Clear().
                Frm:Close().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW Progress.Windows.Form().
            UltraPanel = NEW UltraPanel().
            UltraPanel:Dock = DockStyle:FILL.

            Frm:Controls:Add(UltraPanel).

            UltraPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).

            Frm:Show().

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
    */
/*
    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE UltraPanel AS UltraPanel NO-UNDO.

        IF Counter < 2
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(Frm)
            THEN DO:
                //Frm:Controls:Clear().
                Frm:Close().
                DELETE OBJECT TestFormRichTextBoxWithRibbon. /*important*/
            END.

            ASSIGN TestFormRichTextBoxWithRibbon = NEW TestFormRichTextBoxWithRibbon().

            Frm = NEW Progress.Windows.Form(). //WorkflowFormWithoutRibbon().
            UltraPanel = NEW UltraPanel().
            UltraPanel:Dock = DockStyle:FILL.

            Frm:Controls:Add(UltraPanel).

            UltraPanel:ClientArea:Controls:Add(TestFormRichTextBoxWithRibbon).

            Frm:Show().

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
*/

    /*
    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):
        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        IF Counter < 300
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(DummyForm)
            THEN DO:
                DummyForm:FindForm():Close().
            END.

            ASSIGN DummyForm = NEW DummyForm().

            DummyForm:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
            be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyForm, Parent, be.mips.ablframework.gui.ModalityMode:None).

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
    */
/*

    METHOD PRIVATE VOID TimerTick(O AS System.Object, EventArgs AS System.EventArgs):

        DEFINE VARIABLE Parent AS HANDLE NO-UNDO.
        DEFINE VARIABLE Frm AS PROGRESS.Windows.Form NO-UNDO.

        IF Counter < 200
        THEN DO:
            timer:Stop().
            IF VALID-OBJECT(DummyForm) AND TYPE-OF(DummyForm, AbstractWindowManagerClient)
            THEN DO:
                CAST(DummyForm, AbstractWindowManagerClient):FindForm():Close().
            END.

            ASSIGN DummyForm = NEW DummyForm().

            IF Counter < 100
            THEN DO:
                ASSIGN
                    Frm = NEW PROGRESS.Windows.Form()
                    Frm:WIDTH = 500
                    Frm:HEIGHT = 500
                    Frm:TEXT = "Normal form":U
                    DummyForm:Dock = DockStyle:FILL.
                Frm:Controls:Add(DummyForm).
                Frm:Show().
            END.
            ELSe
            DO:
                DummyForm:PreferredWindowManagerPlaceMode = be.mips.ablframework.gui.WindowManagerPlaceMode:Floating.
                be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyForm, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).
            END.

            timer:Start().
            Counter = Counter + 1.
        END.

    END.
*/

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnSave_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):


        DEFINE BUFFER b_family FOR glims.Family.
        DEFINE VARIABLE content AS LONGCHAR NO-UNDO.

        FIX-CODEPAGE(content) = 'utf-8':U.

        FOR FIRST b_family WHERE fml_id = 117:
            ASSIGN content = THIS-OBJECT:mipsRichTextBoxWithIndicator1:RichTextBox:GetContent().
            ASSIGN b_family.fml_HistoryClob = content.

            RELEASE b_family.
        END.

        RETURN.

    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1 = NEW be.mips.ablframework.gui.richtextbox.MipsRichTextBoxWithIndicator(RichTextBoxTextFormatOptions:Html, 743).
        THIS-OBJECT:btnLoad = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btnSave = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btnOpenLargeForm = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btnDummyForm = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* mipsRichTextBoxWithIndicator1 */
        /*  */
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Location = NEW System.Drawing.Point(12, 23).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Name = "mipsRichTextBoxWithIndicator1".
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:Size = NEW System.Drawing.Size(294, 226).
        THIS-OBJECT:mipsRichTextBoxWithIndicator1:TabIndex = 0.
        /*  */
        /* btnLoad */
        /*  */
        THIS-OBJECT:btnLoad:Location = NEW System.Drawing.Point(12, 315).
        THIS-OBJECT:btnLoad:Name = "btnLoad".
        THIS-OBJECT:btnLoad:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnLoad:TabIndex = 1.
        THIS-OBJECT:btnLoad:Text = "Load".
        THIS-OBJECT:btnLoad:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnLoad:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnLoad:Click:Subscribe(THIS-OBJECT:btnLoad_Click).
        /*  */
        /* btnSave */
        /*  */
        THIS-OBJECT:btnSave:Location = NEW System.Drawing.Point(155, 315).
        THIS-OBJECT:btnSave:Name = "btnSave".
        THIS-OBJECT:btnSave:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnSave:TabIndex = 2.
        THIS-OBJECT:btnSave:Text = "Save".
        THIS-OBJECT:btnSave:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnSave:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnSave:Click:Subscribe(THIS-OBJECT:btnSave_Click).
        /*  */
        /* btnOpenLargeForm */
        /*  */
        THIS-OBJECT:btnOpenLargeForm:Location = NEW System.Drawing.Point(279, 315).
        THIS-OBJECT:btnOpenLargeForm:Name = "btnOpenLargeForm".
        THIS-OBJECT:btnOpenLargeForm:Size = NEW System.Drawing.Size(131, 23).
        THIS-OBJECT:btnOpenLargeForm:TabIndex = 3.
        THIS-OBJECT:btnOpenLargeForm:Text = "Open large form".
        THIS-OBJECT:btnOpenLargeForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnOpenLargeForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnOpenLargeForm:Click:Subscribe(THIS-OBJECT:btnOpenLargeForm_Click).
        /*  */
        /* btnDummyForm */
        /*  */
        THIS-OBJECT:btnDummyForm:Location = NEW System.Drawing.Point(466, 314).
        THIS-OBJECT:btnDummyForm:Name = "btnDummyForm".
        THIS-OBJECT:btnDummyForm:Size = NEW System.Drawing.Size(103, 23).
        THIS-OBJECT:btnDummyForm:TabIndex = 4.
        THIS-OBJECT:btnDummyForm:Text = "Dummy Form".
        THIS-OBJECT:btnDummyForm:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnDummyForm:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnDummyForm:Click:Subscribe(THIS-OBJECT:btnDummyForm_Click).
        /*  */
        /* TestFormRichTextBox */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(625, 376).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnDummyForm).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnOpenLargeForm).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnSave).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnLoad).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:mipsRichTextBoxWithIndicator1).
        THIS-OBJECT:Name = "TestFormRichTextBox".
        THIS-OBJECT:Text = "TestFormRichTextBox".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:TestFormRichTextBox_Load).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID TestFormRichTextBox_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        RETURN.

    END METHOD.

    DESTRUCTOR PUBLIC TestFormRichTextBox ( ):

    END DESTRUCTOR.

END CLASS.
