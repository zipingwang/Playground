 
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

//&SCOPED-DEFINE AbstractWindowManagerClient 1

&IF DEFINED(AbstractWindowManagerClient)
&THEN
CLASS Playground.NetBrowser.client.BrwUser3 INHERITS AbstractWindowManagerClient:
&ELSE
CLASS Playground.NetBrowser.client.BrwUser3 INHERITS FORM:
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
        
    CONSTRUCTOR PUBLIC BrwUser3 (  ):
        
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).        
        
        LoadData().
        
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
        @VisualDesigner.FormMember (NeedsInitialize="false":U, InitializeArray="true":U).
        DEFINE VARIABLE arrayvar0 AS System.Object EXTENT 5 NO-UNDO.
        arrayvar0[1] = ultraGridColumn1.
        arrayvar0[2] = ultraGridColumn2.
        arrayvar0[3] = ultraGridColumn3.
        arrayvar0[4] = ultraGridColumn4.
        arrayvar0[5] = ultraGridColumn5.
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
        DEFINE VARIABLE arrayvar2 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar2[1] = NEW Progress.Data.ColumnPropDesc("usr_LoginName":U, "Login name":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[2] = NEW Progress.Data.ColumnPropDesc("usr_Initials":U, "Initials":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[3] = NEW Progress.Data.ColumnPropDesc("usr_FirstName":U, "First name":U, Progress.Data.DataType:CHARACTER).
        arrayvar2[4] = NEW Progress.Data.ColumnPropDesc("usr_LastName":U, "Last name":U, Progress.Data.DataType:CHARACTER).
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
   
    METHOD PRIVATE VOID LoadData():                   
        FillTempTable(). /*simulate fill data on server side*/
        DisplayTempTable(TempTableHandle:DEFAULT-BUFFER-HANDLE).  /*simulate binding data on client side*/
    END.
    
    /*****************************************************************************/
    
    /*simulate fill data on server side*/
    METHOD PRIVATE VOID FillTempTable():      
       
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
        DEFINE VARIABLE GenericDataRetriver AS GenericDataRetrievalHandler NO-UNDO.        
        DEFINE VARIABLE LastTempTableHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE NumberOfRecordsBeforeRetrieverData AS INTEGER NO-UNDO.
        DEFINE VARIABLE NumberOfRecordsAfterRetrieverData AS INTEGER NO-UNDO.
        
        /* --------------------------------------------------------------------- */     
          
        ASSIGN NumberOfRecordsBeforeRetrieverData = GetNumberOfRecordsInTemptable(TempTableHandle).
        
        ASSIGN DataRetrievalRequest = CreateDataRetrievalRequest().
        
        ASSIGN GenericDataRetriver = NEW GenericDataRetrievalHandler().
        ASSIGN LastTempTableHandle = GenericDataRetriver:GetData(DataRetrievalRequest, OUTPUT DataRetrievalResponse). 
        
        IF NOT VALID-HANDLE(TempTableHandle)
        THEN ASSIGN TempTableHandle = LastTempTableHandle. 
        ELSE DO:
            TempTableHandle:COPY-TEMP-TABLE(LastTempTableHandle, YES).
            ASSIGN NumberOfRecordsAfterRetrieverData = GetNumberOfRecordsInTemptable(TempTableHandle).
            
            DataRetrievalResponse:NumberOfRecordsRetrieved = NumberOfRecordsAfterRetrieverData - NumberOfRecordsBeforeRetrieverData.
            
            RUN playground/temptablehelper/dumptemptable (TempTableHandle, "d:\temp\temptable.xml2").
        END.        
    END. 
    
    /*****************************************************************************/
    
    /*simulate binding data on client side*/
    METHOD PRIVATE VOID DisplayTempTable(TempTableBufferHandle AS HANDLE):   
        
        
               
        /*
        IF VALID-HANDLE(TempTableQueryHandle)
        THEN DO:
            BindingSource:OffEnd:Unsubscribe(OffEndHandler).
            UltraGrid1:SetDataBinding(?, ?, ?).
            DELETE OBJECT BindingSource.
            DELETE OBJECT TempTableQueryHandle.
            
        END.
        */
        IF NOT VALID-HANDLE(TempTableQueryHandle)
        THEN DO:
            CREATE QUERY TempTableQueryHandle.
        
            TempTableQueryHandle:ADD-BUFFER(TempTableBufferHandle).
            TempTableQueryHandle:QUERY-PREPARE("FOR EACH temptable":U).
            //TempTableQueryHandle:QUERY-OPEN().
            BindingSource = NEW Progress.Data.BindingSource(TempTableQueryHandle, "usr_LoginName, usr_Initials, usr_LastName, 
                usr_FirstName, lng_Name":U, ?).
            ASSIGN BindingSource:AllowEdit = FALSE
                BindingSource:AllowRemove = FALSE
                BindingSource:AllowNew = FALSE
                BindingSource:AutoSync = YES
                BindingSource:AutoSort = FALSE //TRUE
                BindingSource:Batching = YES. /*important for OffEnd event */
                
            BindingSource:OffEnd:Subscribe(OffEndHandler).
            UltraGrid1:SetDataBinding(BindingSource, ?, YES).
        END.
        
        TempTableQueryHandle:QUERY-OPEN().
       

        
       /* IF TempTableQueryHandle:IS-OPEN
        THEN DO:
            TempTableQueryHandle:QUERY-CLOSE().
        END.
        TempTableQueryHandle:QUERY-OPEN().
        BindingSource:Refresh().*/
    END.    
    
    /*****************************************************************************/
    
    METHOD PRIVATE INTEGER GetNumberOfRecordsInTemptable(TempTableHandle AS HANDLE):
        DEFINE VARIABLE CountQueryHandle AS HANDLE NO-UNDO.
        
        IF NOT VALID-HANDLE(TempTableHandle)
        THEN RETURN 0.
         
        CREATE QUERY CountQueryHandle .
        CountQueryHandle:SET-BUFFERS (TempTableHandle:DEFAULT-BUFFER-HANDLE) .
        CountQueryHandle:QUERY-PREPARE ("PRESELECT EACH temptable") .
        CountQueryHandle:QUERY-OPEN ().
        
        RETURN CountQueryHandle:NUM-RESULTS.
        
        FINALLY:
            IF VALID-HANDLE (CountQueryHandle) 
            THEN DELETE OBJECT CountQueryHandle.
        END FINALLY.
        
    END.
    
    /*****************************************************************************/
    
    METHOD PROTECTED VOID OffEndHandler (sender AS System.Object, 
                                         e AS Progress.Data.OffEndEventArgs):
        
        MessageBox:Show("OffEndHandler").
        
        LoadData().
        IF VALID-OBJECT (e) THEN
            e:RowsAdded = DataRetrievalResponse:NumberOfRecordsRetrieved. // hCountQuery:NUM-RESULTS - iNumResults .
        
    END METHOD.
    
    /*****************************************************************************/
    
    METHOD PRIVATE DataRetrievalRequest CreateDataRetrievalRequest():
        
        DEFINE VARIABLE DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.             
        
        /* --------------------------------------------------------------------- */
        
        ASSIGN DataRetrievalRequest = NEW DataRetrievalRequest()
            DataRetrievalRequest:BatchSize = 50
            DataRetrievalRequest:BufferNames = "sc_User,gp_Language"
            DataRetrievalRequest:QueryString = "FOR EACH sc_User FIELDS( usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id 
            usr_Initials usr_Language usr_LastName usr_LoginName ) WHERE sc_User.usr_Enabled = yes  NO-LOCK  , 
            FIRST gp_Language FIELDS( lng_Id lng_Name ) NO-LOCK  OUTER-JOIN WHERE gp_Language.lng_Id = sc_User.usr_Language  
            BY sc_User.usr_LoginName INDEXED-REPOSITION"            
            .
        IF VALID-OBJECT(DataRetrievalResponse)
        THEN DO:
            ASSIGN DataRetrievalRequest:ToBeRepositionedRecord = DataRetrievalResponse:LastRecordInTheBatch.
            MessageBox:Show(DataRetrievalRequest:ToBeRepositionedRecord).
        END.
            
        RETURN DataRetrievalRequest.
        
    END.
    
    /*****************************************************************************/
    
    DESTRUCTOR PUBLIC BrwUser3 ( ):
        IF VALID-HANDLE(TempTableQueryHandle)
        THEN DELETE OBJECT TempTableQueryHandle.
    END DESTRUCTOR.

END CLASS.
