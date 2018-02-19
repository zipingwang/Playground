 /* Copyright ©2017 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

 /*------------------------------------------------------------------------
    File        : AnalyzeTranslatorServerLogFiles
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Mar 03 08:43:37 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.UltraWinGrid.HeaderClickAction FROM ASSEMBLY.
USING System.Windows.Forms.FormStartPosition FROM ASSEMBLY.
USING be.mips.ablframework.events.SimpleStringEventArgs FROM PROPATH.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.
USING be.mips.ablframework.gui.browser.BrowserExtension FROM PROPATH.
USING be.mips.ablframework.gui.browser.BrowserHelper FROM PROPATH.
USING be.mips.base.client.browser.AnalyzeTranslatorServerLogFilesSummary FROM PROPATH.

CLASS be.mips.base.client.browser.AnalyzeTranslatorServerLogFiles INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE UltraButtonAddGroup AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraButtonAdd AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraButtonDump AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraButtonSummary AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraButtonClear AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE SplitContainer1 AS System.Windows.Forms.SplitContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE UltraGridLog AS be.mips.ablframework.smartcomponents.implementation.MipsDataBrowser NO-UNDO.
    DEFINE PRIVATE VARIABLE DataTableHandle AS HANDLE NO-UNDO.
    DEFINE PRIVATE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE QueryHandle AS HANDLE NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraPanelSearchText AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE BrowserHelper AS BrowserHelper NO-UNDO.
    DEFINE PRIVATE VARIABLE BrowserExtension AS BrowserExtension NO-UNDO.

    /****************************************************************************/

    DEFINE PUBLIC PROPERTY ProcedureHandle AS HANDLE NO-UNDO
    GET:
       DEFINE VARIABLE DummyOutput AS CHARACTER NO-UNDO.

       IF NOT VALID-HANDLE (ProcedureHandle)
       THEN RUN gp_atslClassic PERSISTENT SET ProcedureHandle (NO, ?, ?, ?, ?, INPUT-OUTPUT DummyOutput).
       RETURN ProcedureHandle.
    END GET.
    SET.

    /****************************************************************************/

    CONSTRUCTOR PUBLIC AnalyzeTranslatorServerLogFiles():

        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).

        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:AnalyzeTranslatorServerLogFiles_Load).
        THIS-OBJECT:UltraButtonAdd:Click:Subscribe(THIS-OBJECT:UltraButtonAdd_Click).
        THIS-OBJECT:UltraButtonAddGroup:Click:Subscribe(THIS-OBJECT:UltraButtonAddGroup_Click).
        THIS-OBJECT:UltraButtonClear:Click:Subscribe(THIS-OBJECT:UltraButtonClear_Click).
        THIS-OBJECT:UltraButtonSummary:Click:Subscribe(THIS-OBJECT:UltraButtonSummary_Click).
        THIS-OBJECT:UltraGridLog:InitializeLayout:Subscribe(THIS-OBJECT:UltraGridLog_InitializeLayout).

        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /****************************************************************************/

    METHOD PRIVATE VOID AnalyzeTranslatorServerLogFiles_Load(INPUT sender AS System.Object, INPUT e AS System.EventArgs):

        BrowserExtension = NEW BrowserExtension(THIS-OBJECT:UltraGridLog).
        BrowserExtension
            :AddAutoSaveAndLoadLayoutPreferenceFeature()
            :AddFastPositioningFeature(YES)
            :AddDropFileFeature()
            :FileDropped:Subscribe(THIS-OBJECT:FileDropped).

        ultraPanelSearchText:ClientArea:Controls:Add(BrowserExtension:FastPositionTextWidget).

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID UltraButtonAdd_Click(INPUT sender AS System.Object, INPUT e AS System.EventArgs):

        RunClientProcedure("AddFile":U).

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID UltraButtonAddGroup_Click(INPUT sender AS System.Object, INPUT e AS System.EventArgs):

         RunClientProcedure("AddFileGroup":U).

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID UltraButtonClear_Click(INPUT sender AS System.Object, INPUT e AS System.EventArgs):

        IF VALID-HANDLE(DataTableHandle)
        THEN DataTableHandle:DEFAULT-BUFFER-HANDLE:EMPTY-TEMP-TABLE().

        IF VALID-HANDLE(QueryHandle)
        THEN QueryHandle:QUERY-OPEN().

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID UltraButtonDump_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        RUN "Dump" IN ProcedureHandle.

    END METHOD.

   /****************************************************************************/

    METHOD PRIVATE VOID UltraButtonSummary_Click(INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        DEFINE VARIABLE AnalyzeTranslatorServerLogFilesSummary AS AnalyzeTranslatorServerLogFilesSummary.
        DEFINE VARIABLE SummaryTempTableHandle AS HANDLE NO-UNDO.

        RUN "PrepareSummaryTempTable" IN ProcedureHandle.
        RUN "GetSummaryTemptableHandle" IN ProcedureHandle(OUTPUT SummaryTempTableHandle).

        IF VALID-HANDLE(SummaryTempTableHandle) AND SummaryTempTableHandle:HAS-RECORDS
        THEN DO:
            AnalyzeTranslatorServerLogFilesSummary = NEW AnalyzeTranslatorServerLogFilesSummary(THIS-OBJECT:ProcedureHandle).

            AnalyzeTranslatorServerLogFilesSummary:StartPosition = FormStartPosition:CenterParent.
            WAIT-FOR AnalyzeTranslatorServerLogFilesSummary:ShowDialog(THIS-OBJECT).
        END.

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("Band 0":U, -1).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_Identifier":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_StartTime":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_EndTime":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_Duration":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn13 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn13 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_Type":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn14 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn14 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("trns_Info":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance4 AS Infragistics.Win.Appearance NO-UNDO.
        appearance4 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:SplitContainer1 = NEW System.Windows.Forms.SplitContainer().
        THIS-OBJECT:UltraGridLog = NEW be.mips.ablframework.smartcomponents.implementation.MipsDataBrowser().
        THIS-OBJECT:ultraPanelSearchText = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:UltraButtonSummary = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:UltraButtonClear = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:UltraButtonAddGroup = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:UltraButtonAdd = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:UltraButtonDump = NEW Infragistics.Win.Misc.UltraButton().
        CAST(THIS-OBJECT:SplitContainer1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SplitContainer1:Panel1:SuspendLayout().
        THIS-OBJECT:SplitContainer1:Panel2:SuspendLayout().
        THIS-OBJECT:SplitContainer1:SuspendLayout().
        CAST(THIS-OBJECT:UltraGridLog, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraPanelSearchText:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* SplitContainer1 */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:SplitContainer1:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:SplitContainer1:FixedPanel = System.Windows.Forms.FixedPanel:Panel2.
        THIS-OBJECT:SplitContainer1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:SplitContainer1:Name = "SplitContainer1":U.
        THIS-OBJECT:SplitContainer1:Orientation = System.Windows.Forms.Orientation:Horizontal.
        /*  */
        /* SplitContainer1.Panel1 */
        /*  */
        THIS-OBJECT:SplitContainer1:Panel1:Controls:Add(THIS-OBJECT:UltraGridLog).
        /*  */
        /* SplitContainer1.Panel2 */
        /*  */
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:UltraButtonDump).
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:ultraPanelSearchText).
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:UltraButtonSummary).
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:UltraButtonClear).
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:UltraButtonAddGroup).
        THIS-OBJECT:SplitContainer1:Panel2:Controls:Add(THIS-OBJECT:UltraButtonAdd).
        THIS-OBJECT:SplitContainer1:Size = NEW System.Drawing.Size(837, 301).
        THIS-OBJECT:SplitContainer1:SplitterDistance = 275.
        THIS-OBJECT:SplitContainer1:SplitterWidth = 1.
        THIS-OBJECT:SplitContainer1:TabIndex = 0.
        /*  */
        /* UltraGridLog */
        /*  */
        THIS-OBJECT:UltraGridLog:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn1:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn1:ExcludeFromColumnChooser = Infragistics.Win.UltraWinGrid.ExcludeFromColumnChooser:True.
        ultraGridColumn1:Header:Caption = "Id":U.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn1:Width = 240.
        ultraGridColumn2:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn2:Header:Caption = "Start":U.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn2:Width = 120.
        ultraGridColumn12:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn12:Header:Caption = "End":U.
        ultraGridColumn12:Header:VisiblePosition = 2.
        ultraGridColumn12:Width = 120.
        ultraGridColumn3:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn3:Header:Caption = "Duration":U.
        ultraGridColumn3:Header:VisiblePosition = 3.
        ultraGridColumn3:Width = 60.
        ultraGridColumn13:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn13:Header:Caption = "Type":U.
        ultraGridColumn13:Header:VisiblePosition = 4.
        ultraGridColumn13:Width = 60.
        ultraGridColumn14:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn14:Header:Caption = "Info":U.
        ultraGridColumn14:Header:VisiblePosition = 5.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar0 AS System.Object EXTENT 6 NO-UNDO.
        arrayvar0[1] = ultraGridColumn1.
        arrayvar0[2] = ultraGridColumn2.
        arrayvar0[3] = ultraGridColumn12.
        arrayvar0[4] = ultraGridColumn3.
        arrayvar0[5] = ultraGridColumn13.
        arrayvar0[6] = ultraGridColumn14.
        ultraGridBand1:Columns:AddRange(arrayvar0).
        ultraGridBand1:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        ultraGridBand1:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        ultraGridBand1:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        ultraGridBand1:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Extended.
        THIS-OBJECT:UltraGridLog:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:UltraGridLog:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Rounded1.
        THIS-OBJECT:UltraGridLog:DisplayLayout:EmptyRowSettings:ShowEmptyRows = TRUE.
        appearance1:BackColor = System.Drawing.SystemColors:Highlight.
        appearance1:ForeColor = System.Drawing.SystemColors:HighlightText.
        appearance1:ImageBackgroundAlpha = Infragistics.Win.Alpha:Transparent.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:ActiveRowAppearance = appearance1.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance2:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:CellAppearance = appearance2.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        appearance3:TextHAlignAsString = "Left":U.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:HeaderAppearance = appearance3.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:ExternalSortMulti.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance4:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(234)), System.Convert:ToInt32(System.Convert:ToByte(242)), System.Convert:ToInt32(System.Convert:ToByte(251))).
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:RowAlternateAppearance = appearance4.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:RowSizing = Infragistics.Win.UltraWinGrid.RowSizing:Fixed.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:RowSizingAutoMaxLines = 1.
        THIS-OBJECT:UltraGridLog:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Extended.
        THIS-OBJECT:UltraGridLog:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:UltraGridLog:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:UltraGridLog:LinkDataSource = ?.
        THIS-OBJECT:UltraGridLog:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:UltraGridLog:Name = "UltraGridLog":U.
        THIS-OBJECT:UltraGridLog:SettingsKey = "87265828-8dab-9f8b-2114-fc7b309453f4":U.
        THIS-OBJECT:UltraGridLog:Size = NEW System.Drawing.Size(837, 275).
        THIS-OBJECT:UltraGridLog:TabIndex = 0.
        /*  */
        /* ultraPanelSearchText */
        /*  */
        THIS-OBJECT:ultraPanelSearchText:Dock = System.Windows.Forms.DockStyle:Left.
        THIS-OBJECT:ultraPanelSearchText:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraPanelSearchText:Name = "ultraPanelSearchText":U.
        THIS-OBJECT:ultraPanelSearchText:Size = NEW System.Drawing.Size(322, 25).
        THIS-OBJECT:ultraPanelSearchText:TabIndex = 4.
        /*  */
        /* UltraButtonSummary */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:UltraButtonSummary:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraButtonSummary:Location = NEW System.Drawing.Point(705, -1).
        THIS-OBJECT:UltraButtonSummary:Name = "UltraButtonSummary":U.
        THIS-OBJECT:UltraButtonSummary:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:UltraButtonSummary:TabIndex = 3.
        THIS-OBJECT:UltraButtonSummary:Text = "Summary":U.
        /*  */
        /* UltraButtonClear */
        /*  */
        DEFINE VARIABLE nestedvar2 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar2 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:UltraButtonClear:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar2, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraButtonClear:Location = NEW System.Drawing.Point(543, -1).
        THIS-OBJECT:UltraButtonClear:Name = "UltraButtonClear":U.
        THIS-OBJECT:UltraButtonClear:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:UltraButtonClear:TabIndex = 2.
        THIS-OBJECT:UltraButtonClear:Text = "Clear":U.
        /*  */
        /* UltraButtonAddGroup */
        /*  */
        DEFINE VARIABLE nestedvar3 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar3 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:UltraButtonAddGroup:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar3, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraButtonAddGroup:Location = NEW System.Drawing.Point(462, -1).
        THIS-OBJECT:UltraButtonAddGroup:Name = "UltraButtonAddGroup":U.
        THIS-OBJECT:UltraButtonAddGroup:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:UltraButtonAddGroup:TabIndex = 1.
        THIS-OBJECT:UltraButtonAddGroup:Text = "Add Group":U.
        /*  */
        /* UltraButtonAdd */
        /*  */
        DEFINE VARIABLE nestedvar4 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar4 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:UltraButtonAdd:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar4, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraButtonAdd:Location = NEW System.Drawing.Point(381, -1).
        THIS-OBJECT:UltraButtonAdd:Name = "UltraButtonAdd":U.
        THIS-OBJECT:UltraButtonAdd:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:UltraButtonAdd:TabIndex = 0.
        THIS-OBJECT:UltraButtonAdd:Text = "Add":U.
        /*  */
        /* UltraButtonDump */
        /*  */
        DEFINE VARIABLE nestedvar5 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar5 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:UltraButtonDump:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar5, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:UltraButtonDump:Location = NEW System.Drawing.Point(624, -1).
        THIS-OBJECT:UltraButtonDump:Name = "UltraButtonDump":U.
        THIS-OBJECT:UltraButtonDump:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:UltraButtonDump:TabIndex = 5.
        THIS-OBJECT:UltraButtonDump:Text = "Dump":U.
        THIS-OBJECT:UltraButtonDump:Click:Subscribe(THIS-OBJECT:UltraButtonDump_Click).
        /*  */
        /* AnalyzeTranslatorServerLogFiles */
        /*  */
        THIS-OBJECT:AutoScaleDimensions = NEW System.Drawing.SizeF(Progress.Util.CastUtil:ToSingle(6), Progress.Util.CastUtil:ToSingle(13)).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:SplitContainer1).
        THIS-OBJECT:Name = "AnalyzeTranslatorServerLogFiles":U.
        THIS-OBJECT:Size = NEW System.Drawing.Size(837, 301).
        THIS-OBJECT:SplitContainer1:Panel1:ResumeLayout(FALSE).
        THIS-OBJECT:SplitContainer1:Panel2:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:SplitContainer1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:SplitContainer1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:UltraGridLog, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraPanelSearchText:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID UltraGridLog_InitializeLayout(INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs):

        e:Layout:Override:HeaderClickAction = HeaderClickAction:SortSingle.

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID FileDropped(sender AS Progress.Lang.Object, e AS SimpleStringEventArgs):

         RUN "FileDropped":U IN ProcedureHandle (e:StringValue).
         UpdateData().

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID RunClientProcedure(ProcedureName AS CHARACTER):

        DEFINE VARIABLE HasResult AS LOGICAL NO-UNDO.

        RUN VALUE(ProcedureName) IN ProcedureHandle (OUTPUT HasResult).

        IF HasResult
        THEN UpdateData().

    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID UpdateData():

        IF NOT VALID-HANDLE(QueryHandle)
        THEN DO:
            RUN GetTemptableHandle IN ProcedureHandle(OUTPUT DataTableHandle).
            CREATE QUERY QueryHandle.
            QueryHandle:SET-BUFFERS(DataTableHandle:DEFAULT-BUFFER-HANDLE).
            QueryHandle:QUERY-PREPARE("FOR EACH w_Transaction":U).
            QueryHandle:FORWARD-ONLY = FALSE.
            END.
        ELSE DO:
             QueryHandle:QUERY-OPEN().
             END.

        IF NOT VALID-OBJECT(BindingSource)
        THEN DO:
            BindingSource = NEW Progress.Data.BindingSource(QueryHandle, "*":U, "trns_DurationDec, trns_EndTimeDec, trns_StartTimeDec, trns_FileDescriptor":U ).
            BindingSource:AllowEdit = FALSE.
            BindingSource:AllowRemove = FALSE.
            BindingSource:AllowNew = FALSE.
            BindingSource:AutoSort = TRUE.
            UltraGridLog:SetDataBinding(BindingSource, ?, YES).
            BrowserHelper = NEW BrowserHelper().
            BrowserHelper:InitializeLogicalColumns(THIS-OBJECT:UltraGridLog).
        END.

    END METHOD.

    /****************************************************************************/

    DESTRUCTOR PUBLIC AnalyzeTranslatorServerLogFiles ( ):
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

        IF VALID-HANDLE(ProcedureHandle)
        THEN DELETE OBJECT ProcedureHandle.

    END DESTRUCTOR.

END CLASS.
