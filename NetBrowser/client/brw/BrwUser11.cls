
 /*------------------------------------------------------------------------
    File        : BrwUser
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Fri Feb 09 13:33:31 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
//USING be.mips.ablframework.smartcomponents.implementation.MipsDataBrowser FROM PROPATH.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.
USING be.mips.ablframework.smartcomponents.implementation.MipsDataBrowser FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.server.GenericDataRetrievalHandler FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING be.mips.ablframework.client.dialog.MessageBox FROM PROPATH.
USING be.mips.appserver.Connection FROM PROPATH.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.
USING Consultingwerk.Util.LogManager FROM PROPATH.
USING Playground.NetBrowser.client.DataRetrievalProxy FROM PROPATH.
USING Infragistics.Win.UltraWinGrid.RowScrollRegionEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.RowScrollRegion FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.SelectType FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.BeforeRowRegionScrollEventArgs FROM ASSEMBLY.
USING Playground.NetBrowser.shared.DataRetrievalConstant FROM PROPATH.
USING Playground.BrowserExtension.BrowserExtension FROM PROPATH.
USING Playground.BrowserExtension.SimpleStringEventArgs FROM PROPATH.
USING Infragistics.Win.UltraWinGrid.UltraGridRow FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.RefreshRow FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.HeaderClickAction FROM ASSEMBLY.
USING Playground.NetBrowser.shared.QueryBlock FROM PROPATH.
USING Infragistics.Win.UltraWinGrid.SortIndicator FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.CellClickAction FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

//&SCOPED-DEFINE AbstractWindowManagerClient 1

&IF DEFINED(AbstractWindowManagerClient)
&THEN
CLASS Playground.NetBrowser.client.brw.BrwUser11 INHERITS AbstractWindowManagerClient:
&ELSE
CLASS Playground.NetBrowser.client.brw.BrwUser11 INHERITS FORM:
&ENDIF
   {NetBrowser/shared/esc_UserFlat.i}

    DEFINE PRIVATE VARIABLE bindingSource2 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.

    &IF DEFINED(AbstractWindowManagerClient)
    &THEN
    DEFINE PRIVATE VARIABLE ultraGrid1 AS MipsDataBrowser NO-UNDO.
    &ELSE
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    &ENDIF

    DEFINE PRIVATE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE TempTableQueryHandle AS HANDLE NO-UNDO.
    DEFINE PRIVATE VARIABLE TempTableHandle AS HANDLE NO-UNDO.
    DEFINE VARIABLE DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.
    DEFINE VARIABLE DataRetrivalProxy AS DataRetrievalProxy NO-UNDO.

    DEFINE VARIABLE RowScrollRegion AS RowScrollRegion NO-UNDO.
    DEFINE VARIABLE BrowserExtension AS BrowserExtension NO-UNDO.
    DEFINE VARIABLE IsScrollingUp AS LOGICAL NO-UNDO.
    DEFINE VARIABLE BatchSize_ AS INTEGER NO-UNDO INITIAL -1.

    /*****************************************************************************/

    DEFINE PUBLIC PROPERTY AppServerHandle AS HANDLE NO-UNDO
    GET():
        &IF DEFINED(AbstractWindowManagerClient)
        &THEN
        RETURN Connection:Synchronous.
        &ELSE
        RETURN SESSION:HANDLE.
        &ENDIF
    END.
    SET.

    DEFINE PUBLIC PROPERTY SortExpression AS CHARACTER NO-UNDO
    GET():
        RETURN GetSortExpression().
    END.

    DEFINE PUBLIC PROPERTY PossibelSorting AS CHARACTER EXTENT NO-UNDO
    GET.
    SET.
    /*****************************************************************************/

    CONSTRUCTOR PUBLIC BrwUser11 (  ):

        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).

        THIS-OBJECT:ultraGrid1:DisplayLayout:Bands[0]:Override:CellClickAction = CellClickAction:RowSelect.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Bands[0]:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.

        ASSIGN BrowserExtension = NEW BrowserExtension(THIS-OBJECT:ultraGrid1).

        IF BatchSize_ > 0
        THEN DO:
            THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = HeaderClickAction:ExternalSortMulti.
            BrowserExtension:AddFastPositioningFeature(FALSE).
            BrowserExtension:FastPositioningRequestSerch:Subscribe(THIS-OBJECT:BrowserExtension_FastPositioningRequestSerch).
            THIS-OBJECT:ultraGrid1:AfterRowRegionScroll:Subscribe(AfterRowRegionScroll).
            THIS-OBJECT:ultraGrid1:BeforeRowRegionScroll:Subscribe(BeforeRowRegionScroll).
            THIS-OBJECT:ultraGrid1:KeyDown:Subscribe(ultraGrid1_KeyDown).
            THIS-OBJECT:ultraGrid1:AfterSortChange:Subscribe(THIS-OBJECT:ultraGrid1_AfterSortChange).
            THIS-OBJECT:ultraGrid1:BeforeSortChange:Subscribe(THIS-OBJECT:ultraGrid1_BeforeSortChange).
            THIS-OBJECT:ultraGrid1:MouseWheel:Subscribe(THIS-OBJECT:ultraGrid1_MouseWheel).
        END.
        ELSE DO:
            BrowserExtension:AddFastPositioningFeature(YES).
        END.

        ultraGrid1:DisplayLayout:Override:SelectTypeRow = SelectType:SINGLE.

        EXTENT(PossibelSorting) = 1.
        PossibelSorting[1]= "usr_LoginName".

        ASSIGN DataRetrivalProxy = NEW DataRetrievalProxy(AppServerHandle).

        LoadData().

        IF BatchSize_ > 0
        THEN DO:
            THIS-OBJECT:ultraGrid1:AfterSortChange:UNSubscribe(THIS-OBJECT:ultraGrid1_AfterSortChange).
            THIS-OBJECT:ultraGrid1:BeforeSortChange:UNSubscribe(THIS-OBJECT:ultraGrid1_BeforeSortChange).

            THIS-OBJECT:ultraGrid1:DisplayLayout:Bands[0]:SortedColumns:Add("usr_LoginName", false, false). // key, desending, groupby

            THIS-OBJECT:ultraGrid1:AfterSortChange:Subscribe(THIS-OBJECT:ultraGrid1_AfterSortChange).
            THIS-OBJECT:ultraGrid1:BeforeSortChange:Subscribe(THIS-OBJECT:ultraGrid1_BeforeSortChange).
        END.
        ELSE DO:
            THIS-OBJECT:ultraGrid1:DisplayLayout:Bands[0]:SortedColumns:Add("usr_LoginName", false, false). // key, desending, groupby
        END.

        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("sc_User":U, -1).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("usr_LoginName":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("usr_Initials":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("usr_FirstName":U).
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("usr_LastName":U).
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("lng_Name":U).
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("f_rowid_":U).
        ultraGridColumn6:HIDDEN = NO.

        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance4 AS Infragistics.Win.Appearance NO-UNDO.
        appearance4 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance5 AS Infragistics.Win.Appearance NO-UNDO.
        appearance5 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance6 AS Infragistics.Win.Appearance NO-UNDO.
        appearance6 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance7 AS Infragistics.Win.Appearance NO-UNDO.
        appearance7 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance8 AS Infragistics.Win.Appearance NO-UNDO.
        appearance8 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance9 AS Infragistics.Win.Appearance NO-UNDO.
        appearance9 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance10 AS Infragistics.Win.Appearance NO-UNDO.
        appearance10 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance11 AS Infragistics.Win.Appearance NO-UNDO.
        appearance11 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE appearance12 AS Infragistics.Win.Appearance NO-UNDO.
        appearance12 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("sc_User":U).

        &IF DEFINED(AbstractWindowManagerClient)
        &THEN
        THIS-OBJECT:ultraGrid1 = NEW MipsDataBrowser().
        &ELSE
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        &ENDIF

        THIS-OBJECT:bindingSource2 = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bindingSource2, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraGrid1 */
        /*  */
       // THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bindingSource2.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance1.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn4:Header:VisiblePosition = 3.
        ultraGridColumn5:Header:VisiblePosition = 4.
        ultraGridColumn6:Header:VisiblePosition = 5.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar0 AS System.Object EXTENT 6 NO-UNDO.
        arrayvar0[1] = ultraGridColumn1.
        arrayvar0[2] = ultraGridColumn2.
        arrayvar0[3] = ultraGridColumn3.
        arrayvar0[4] = ultraGridColumn4.
        arrayvar0[5] = ultraGridColumn5.
        arrayvar0[6] = ultraGridColumn6.
        ultraGridBand1:Columns:AddRange(arrayvar0).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left":U.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:Vertical.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1":U.
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(837, 386).
        THIS-OBJECT:ultraGrid1:TabIndex = 0.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1":U.
        /*  */
        /* bindingSource2 */
        /*  */
        THIS-OBJECT:bindingSource2:MaxDataGuess = 0.
        THIS-OBJECT:bindingSource2:NoLOBs = FALSE.
        THIS-OBJECT:bindingSource2:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar1 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar1 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar1.
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar2 AS Progress.Data.ColumnPropDesc EXTENT 6 NO-UNDO.
        arrayvar2[1] = NEW Progress.Data.ColumnPropDesc("usr_LoginName":U, "Login name":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[2] = NEW Progress.Data.ColumnPropDesc("usr_Initials":U, "Initials":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[3] = NEW Progress.Data.ColumnPropDesc("usr_FirstName":U, "First name":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[4] = NEW Progress.Data.ColumnPropDesc("usr_LastName":U, "Last name":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[5] = NEW Progress.Data.ColumnPropDesc("lng_Name":U, "Language":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[6] = NEW Progress.Data.ColumnPropDesc("f_rowid_":U, "f_rowid_":U, Progress.Data.DataType:CHARACTER).

        tableDesc1:Columns = arrayvar2.
        THIS-OBJECT:bindingSource2:TableSchema = tableDesc1.
        /*  */
        /* BrwUser */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(837, 386).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:Name = "BrwUser":U.
        THIS-OBJECT:Text = "BrwUser":U.
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bindingSource2, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE INTEGER LoadData():
        DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN  DataRetrievalRequest = CreateDataRetrievalRequest().

        RETURN LoadData(DataRetrievalRequest).

        CATCH Err AS Progress.Lang.Error:
           ASSIGN ErrorMessage = ErrorHelper:FormattedErrorMessages(Err). //ErrorHelper:GetErrorMessage(Err).
           MESSAGE "error load data" ErrorMessage VIEW-AS ALERT-BOX.
        END CATCH.
    END.

       /*****************************************************************************/

    METHOD PROTECTED VOID LoadData(Direction AS CHARACTER):
        DEFINE VARIABLE FirstVisibleRow AS UltraGridRow NO-UNDO.
        DEFINE VARIABLE LastVisibleRow AS UltraGridRow NO-UNDO.
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN RowScrollRegion = ultraGrid1:DisplayLayout:RowScrollRegions[0]. //ultragrid1:ActiveRowScrollRegion.

        ASSIGN FirstVisibleRow = RowScrollRegion:VisibleRows[0]:Row.
        ASSIGN LastVisibleRow = RowScrollRegion:VisibleRows[RowScrollRegion:VisibleRows:Count - 1]:Row.

        IF Direction = DataRetrievalConstant:FORWARDS
        THEN DO:
            IF STRING(LastVisibleRow:Cells["f_rowid_"]:Value)  <> DataRetrievalResponse:LastRowIdsInWholeDB
                AND LastVisibleRow:INDEX = ultraGrid1:Rows:Count - 1
            THEN DO:
                 //get next batch data.
                ASSIGN
                    DataRetrievalRequest = CreateDataRetrievalRequest()
                    DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
                    DataRetrievalRequest:ToBeRepositionedRecord = STRING(LastVisibleRow:Cells["f_rowid_"]:Value)
                    DataRetrievalRequest:SortingPhrase = THIS-OBJECT:SortExpression
                    DataRetrievalRequest:ToBeRepositionedRecord = STRING(LastVisibleRow:Cells["f_rowid_"]:Value)
                    DataRetrievalRequest:ActiveRowPosition = BindingSource:POSITION
                    .
                LoadData(DataRetrievalRequest).
            END.
        END.
        ELSE DO: //backwards
            IF FirstVisibleRow:Index < 2
                AND STRING(FirstVisibleRow:Cells["f_rowid_"]:Value) <> DataRetrievalResponse:FirstRowIdsInWholeDB
            THEN DO:
                //get previous batch data.
                ASSIGN
                    DataRetrievalRequest = CreateDataRetrievalRequest()
                    DataRetrievalRequest:Direction = DataRetrievalConstant:BACKWARDS
                    DataRetrievalRequest:ToBeRepositionedRecord = STRING(FirstVisibleRow:Cells["f_rowid_"]:Value)
                    DataRetrievalRequest:SortingPhrase = THIS-OBJECT:SortExpression
                    DataRetrievalRequest:ActiveRowPosition = BindingSource:POSITION
                    .
                LoadData(DataRetrievalRequest).
            END.
        END.
    END.

    /*****************************************************************************/

    METHOD PRIVATE INTEGER LoadData(DataRetrievalRequest AS DataRetrievalRequest):
        DEFINE VARIABLE ErrorMessage AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF VALID-OBJECT(DataRetrievalResponse) AND DataRetrievalRequest:Direction = DataRetrievalConstant:BACKWARDS
            AND DataRetrievalResponse:FirstRowIdsInWholeDB = STRING(ultraGrid1:Rows[0]:Cells["f_rowid_"]:Value)
            AND DataRetrievalRequest:TriggeredBy <> DataRetrievalConstant:FastPosition
            AND DataRetrievalRequest:TriggeredBy <> DataRetrievalConstant:ChangeSorting
        THEN DO:
            //MESSAGE "first batch " VIEW-AS ALERT-BOX.
            RETURN 0.
        END.
        ELSE IF VALID-OBJECT(DataRetrievalResponse) AND DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
            AND  DataRetrievalResponse:LastRowIdsInWholeDB = STRING(ultraGrid1:Rows[ultraGrid1:Rows:Count - 1]:Cells["f_rowid_"]:Value)
            AND DataRetrievalRequest:TriggeredBy <> DataRetrievalConstant:FastPosition
            AND DataRetrievalRequest:TriggeredBy <> DataRetrievalConstant:ChangeSorting
        THEN DO:
            //MESSAGE "last batch " VIEW-AS ALERT-BOX.
            RETURN 0.
        END.

        DataRetrivalProxy:RetrievalData(INPUT-OUTPUT TempTableHandle, DataRetrievalRequest, OUTPUT DataRetrievalResponse, TempTableQueryHandle).
        DisplayTempTable(TempTableHandle:DEFAULT-BUFFER-HANDLE, DataRetrievalResponse).  /*simulate binding data on client side*/

        RETURN DataRetrievalResponse:NumberOfRecordsRetrieved.

        CATCH Err AS Progress.Lang.Error:
           ASSIGN ErrorMessage = ErrorHelper:FormattedErrorMessages(Err). //ErrorHelper:GetErrorMessage(Err).
           MESSAGE "error load data" ErrorMessage VIEW-AS ALERT-BOX.
        END CATCH.
    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID DisplayTempTable(TempTableBufferHandle AS HANDLE, DataRetrievalResponse AS DataRetrievalResponse):
        DEFINE VARIABLE ScrollPositionOffset AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF DataRetrievalResponse:HasError = YES
        THEN DO:
            MESSAGE DataRetrievalResponse:ErrorMessage VIEW-AS ALERT-BOX.
            RETURN.
        END.

        IF NOT VALID-HANDLE(TempTableQueryHandle)
        THEN DO:
            CREATE QUERY TempTableQueryHandle.

            TempTableQueryHandle:ADD-BUFFER(TempTableBufferHandle).
            TempTableQueryHandle:QUERY-PREPARE("PRESELECT EACH temptable":U).

            BindingSource = NEW Progress.Data.BindingSource(TempTableQueryHandle, "usr_LoginName, usr_Initials, usr_LastName,
                usr_FirstName, lng_Name, f_rowid_":U, ?).
            ASSIGN BindingSource:AllowEdit = FALSE
                BindingSource:AllowRemove = FALSE
                BindingSource:AllowNew = FALSE
                BindingSource:AutoSync = YES
                BindingSource:AutoSort = FALSE //TRUE
                BindingSource:Batching = NO. /*YES important for OffEnd event */

            //BindingSource:OffEnd:Subscribe(OffEndHandler).
            UltraGrid1:SetDataBinding(BindingSource, ?, YES).

        END.

        TempTableQueryHandle:QUERY-OPEN().

        IF DataRetrievalResponse:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
            OR DataRetrievalResponse:DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting
        THEN DO:

                PROCESS EVENTS. /*show message also works*/

            IF DataRetrievalResponse:PositionOfRepositionedRowIdInCurrentBatch > 5
            THEN DO:
                ASSIGN ScrollPositionOffset = DataRetrievalResponse:PositionOfRepositionedRowIdInCurrentBatch - 5.
            END.
            ELSE DO:
                ASSIGN ScrollPositionOffset = DataRetrievalResponse:PositionOfRepositionedRowIdInCurrentBatch - 1.
            END.

            ultraGrid1:DisplayLayout:RowScrollRegions[0]:ScrollPosition = ScrollPositionOffset.
            BindingSource:POSITION = DataRetrievalResponse:PositionOfRepositionedRowIdInCurrentBatch.

        END.
        ELSE DO:
            BindingSource:POSITION = DataRetrievalResponse:ActiveRowPosition.
        END.

        IF DataRetrievalResponse:DataRetrievalRequest:Direction = DataRetrievalConstant:Backwards
        THEN DO:
            RowScrollRegion:ScrollPosition = RowScrollRegion:ScrollPosition + DataRetrievalResponse:NumberOfRecordsRetrieved - 1.
        END.

    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID OffEndHandler (sender AS System.Object,
                                         e AS Progress.Data.OffEndEventArgs):

        DEFINE VARIABLE NumberOfRecordsAdded AS INTEGER NO-UNDO.
        //MessageBox:Show("OffEndHandler").

        ASSIGN NumberOfRecordsAdded = LoadData().
        IF VALID-OBJECT (e) THEN
            e:RowsAdded = NumberOfRecordsAdded. // hCountQuery:NUM-RESULTS - iNumResults .

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE DataRetrievalRequest CreateDataRetrievalRequest():

        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE QueryBlocks AS QueryBlock EXTENT 2 NO-UNDO.
        DEFINE VARIABLE QueryBlcok AS QueryBlock NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FOR EACH":U
            QueryBlcok:TableName = "sc_User":U
            QueryBlcok:FieldList = "usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id usr_Initials usr_Language usr_LastName usr_LoginName":U
            QueryBlcok:WherePhrase = "sc_User.usr_Enabled = yes":U
            QueryBlcok:Hints = "NO-LOCK":U
            .

        QueryBlocks[1] = QueryBlcok.

        ASSIGN
            QueryBlcok = NEW QueryBlock()
            QueryBlcok:ForPhrase = "FIRST":U
            QueryBlcok:TableName = "gp_Language":U
            QueryBlcok:FieldList = "lng_Id lng_Name":U
            QueryBlcok:WherePhrase = "gp_Language.lng_Id = sc_User.usr_Language":U
            QueryBlcok:Hints = "NO-LOCK OUTER-JOIN":U
            .

        QueryBlocks[2] = QueryBlcok.

        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = BatchSize_
            DataRetrievalRequest:Direction = DataRetrievalConstant:Forwards
            DataRetrievalRequest:QueryBlocks = QueryBlocks
            DataRetrievalRequest:SortingPhrase = "BY sc_User.usr_LoginName"
            .

        RETURN DataRetrievalRequest.

    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID AfterRowRegionScroll (Sender AS System.Object, e AS RowScrollRegionEventArgs):

        IF IsScrollingUp
        THEN DO:
            //ultraGrid1:DisplayLayout:RowScrollRegions[0]:FirstRow = ultraGrid1:Rows[DataRetrievalResponse:NumberOfRecordsRetrieved - 1].
            //e:RowScrollRegion:FirstRow = ultraGrid1:Rows[DataRetrievalResponse:NumberOfRecordsRetrieved - 1].
            //e:RowScrollRegion:ScrollPosition = e:RowScrollRegion:ScrollPosition + DataRetrievalResponse:NumberOfRecordsRetrieved - 1.
            //ultraGrid1:Rows:Refresh(RefreshRow:RefreshDisplay, YES).
            //PROCESS EVENTS.
        END.
        LoadData(IF IsScrollingUp THEN DataRetrievalConstant:BACKWARDS ELSE DataRetrievalConstant:Forwards).
    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID BeforeRowRegionScroll (Sender AS Progress.Lang.Object, e AS BeforeRowRegionScrollEventArgs):

        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            RowScrollRegion = e:NewState
            IsScrollingUp = e:OldState:FirstRow:Index > e:NewState:FirstRow:Index.
    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID ultraGrid1_KeyDown(Sender AS System.Object, e AS System.Windows.Forms.KeyEventArgs):

        IF e:KeyCode = System.Windows.Forms.Keys:UP OR e:KEYCODE = System.Windows.Forms.Keys:PageUp
        THEN DO:
            LoadData(DataRetrievalConstant:Backwards).
        END.
        ELSE IF e:KeyCode = System.Windows.Forms.Keys:Down OR e:KEYCODE = System.Windows.Forms.Keys:PageDown
        THEN DO:
            LoadData(DataRetrievalConstant:Forwards).
        END.

    END.

    METHOD PROTECTED VOID ultraGrid1_AfterSortChange(Sender AS System.Object, e AS Infragistics.Win.UltraWinGrid.BandEventArgs):

         DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            DataRetrievalRequest = CreateDataRetrievalRequest()
            DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:ChangeSorting
            DataRetrievalRequest:ToBeRepositionedRecord = STRING(ultraGrid1:ActiveRow:Cells["f_rowid_"]:Value)
            DataRetrievalRequest:SortingPhrase = GetSortExpression()
            DataRetrievalRequest:BatchSize = BatchSize_
            .

        LoadData(DataRetrievalRequest).
    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID ultraGrid1_BeforeSortChange(Sender AS System.Object, e AS Infragistics.Win.UltraWinGrid.BeforeSortChangeEventArgs):

        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        DO Counter = 0 TO e:SortedColumns:Count - 1:
            //SortedColumns[Counter]:Key
        END.
    END.

    /*****************************************************************************/

    METHOD PROTECTED CHARACTER GetSortExpression():
        RETURN GetSortExpression(ultraGrid1:DisplayLayout:Bands[0]).
    END.

    /*****************************************************************************/

    METHOD PROTECTED CHARACTER GetSortExpression(UltraGridBand AS Infragistics.Win.UltraWinGrid.UltraGridBand):

        DEFINE VARIABLE SortColumn AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE SortString AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        /* build a sort string from the band's SortedColumns */
        DO Counter = 0 TO UltraGridBand:SortedColumns:Count - 1:
            SortColumn = CAST(UltraGridBand:SortedColumns[Counter], Infragistics.Win.UltraWinGrid.UltraGridColumn).
            SortString = sortString + " by " + sortColumn:Key.
            IF Progress.Util.EnumHelper:AreEqual(sortColumn:SortIndicator,
                Infragistics.Win.UltraWinGrid.SortIndicator:DESCENDING) THEN
            SortString = SortString + " descending".
        END.
      RETURN LEFT-TRIM(SortString).
    END.

    /*****************************************************************************/

    METHOD PROTECTED CHARACTER GetFastPositionExpression(SearchString AS CHARACTER):
        DEFINE VARIABLE FastPositionExpression AS CHARACTER.

        /* --------------------------------------------------------------------- */

        IF ultraGrid1:DisplayLayout:Bands[0]:SortedColumns:Count < 1
        THEN
            ASSIGN FastPositionExpression = "".
        ELSE
            ASSIGN FastPositionExpression = SUBSTITUTE("&1 BEGINS '&2'",
                CAST(ultraGrid1:DisplayLayout:Bands[0]:SortedColumns[0], Infragistics.Win.UltraWinGrid.UltraGridColumn):KEY
                , SearchString).

        RETURN FastPositionExpression.
    END.

    /*****************************************************************************/

    METHOD PROTECTED VOID BrowserExtension_FastPositioningRequestSerch(Sender AS Progress.Lang.Object, e AS SimpleStringEventArgs):
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN
            DataRetrievalRequest = CreateDataRetrievalRequest()
            DataRetrievalRequest:TriggeredBy = DataRetrievalConstant:FastPosition
            DataRetrievalRequest:ToBeRepositionedRecord = ?
            DataRetrievalRequest:FastPositionQueryString = GetFastPositionExpression(e:StringValue)
            DataRetrievalRequest:SortingPhrase = THIS-OBJECT:SortExpression
            DataRetrievalRequest:BatchSize = BatchSize_
        .

        LoadData(DataRetrievalRequest).

    END.

    /*****************************************************************************/

     METHOD PROTECTED VOID ultraGrid1_MouseWheel (Sender AS System.Object, e AS System.Windows.Forms.MouseEventArgs):

        SUPER:OnMouseWheel(e) .
        //MESSAGE e:Delta VIEW-AS ALERT-BOX.

        CATCH err AS Progress.Lang.Error:
            ErrorHelper:ShowErrorMessage (err) .
        END CATCH.

    END METHOD.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC BrwUser11 ( ):
        IF VALID-HANDLE(TempTableQueryHandle)
        THEN DELETE OBJECT TempTableQueryHandle.

        &IF DEFINED(AbstractWindowManagerClient)
        &THEN
        &ELSE
            IF VALID-HANDLE(AppServerHandle)
            THEN DO:
                IF AppServerHandle <> SESSION:HANDLE AND AppServerHandle:CONNECTED() = YES
                THEN DO:
                    AppServerHandle:DISCONNECT().
                    DELETE OBJECT AppServerHandle.
                END.
            END.
        &ENDIF
    END DESTRUCTOR.

END CLASS.
