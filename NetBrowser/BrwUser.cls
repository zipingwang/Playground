 
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
USING be.mips.ablframework.smartcomponents.implementation.MipsDataBrowser FROM PROPATH.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.
USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

//CLASS Playground.NetBrowser.BrwUser INHERITS FORM:
CLASS Playground.NetBrowser.BrwUser INHERITS AbstractWindowManagerClient:  
   // { be/mips/glims/generated/BusinessEntities/sc_User/bet_sc_UserFlat.i }
    
    DEFINE PRIVATE VARIABLE bindingSource2 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    //DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS MipsDataBrowser NO-UNDO.
    DEFINE PRIVATE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        
    CONSTRUCTOR PUBLIC BrwUser (  ):
        
        
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
        THIS-OBJECT:ultraGrid1 = NEW MipsDataBrowser().
        //THIS-OBJECT:ultraGrid1 = NEW UltraGrid().
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
        
        //DEFINE BUFFER b_User FOR sc_User.    /*show only one record*/    
        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        
        ASSIGN QueryString = "FOR EACH sc_User FIELDS( usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id usr_Initials usr_Language usr_LastName usr_LoginName ) WHERE sc_User.usr_Enabled = yes  NO-LOCK  , FIRST gp_Language FIELDS( lng_Id lng_Name ) NO-LOCK  OUTER-JOIN WHERE gp_Language.lng_Id = sc_User.usr_Language  BY sc_User.usr_LoginName".
        CREATE QUERY QueryHandle.
        QueryHandle:ADD-BUFFER(BUFFER sc_User:HANDLE).
        QueryHandle:ADD-BUFFER(BUFFER gp_Language:HANDLE).
        QueryHandle:QUERY-PREPARE(QueryString).
        QueryHandle:QUERY-OPEN().      
        
        BindingSource = NEW Progress.Data.BindingSource(QueryHandle, "usr_LoginName, usr_Initials, usr_LastName, usr_FirstName, lng_Name":U, ?).       
        BindingSource:AllowEdit = FALSE.
        BindingSource:AllowRemove = FALSE.
        BindingSource:AllowNew = FALSE.
        BindingSource:AutoSort = TRUE.
        UltraGrid1:SetDataBinding(BindingSource, ?, YES).  
       
    END.
   
   /*
    METHOD PRIVATE VOID LoadData():
        
        //DEFINE BUFFER b_User FOR sc_User.    /*show only one record*/    
        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE DataSourceHandle AS HANDLE NO-UNDO.
        
        CREATE DATA-SOURCE DataSourceHandle.
        
        ASSIGN QueryString = "FOR EACH sc_User FIELDS( usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id usr_Initials usr_Language usr_LastName usr_LoginName ) WHERE sc_User.usr_Enabled = yes  NO-LOCK  , FIRST gp_Language FIELDS( lng_Id lng_Name ) NO-LOCK  OUTER-JOIN WHERE gp_Language.lng_Id = sc_User.usr_Language  BY sc_User.usr_LoginName".
        CREATE QUERY QueryHandle.
        QueryHandle:ADD-BUFFER(BUFFER sc_User:HANDLE).
        QueryHandle:ADD-BUFFER(BUFFER gp_Language:HANDLE).
        QueryHandle:QUERY-PREPARE(QueryString).
        
        DataSourceHandle:QUERY = QueryHandle.
        
        BUFFER esc_UserFlat:ATTACH-DATA-SOURCE (DataSourceHandle, "lng_Id,LanguageId  lng_Name,LanguageName").
        
        TEMP-TABLE esc_UserFlat:FILL().
        //QueryHandle:QUERY-OPEN().      
        
        //BindingSource = NEW Progress.Data.BindingSource(QueryHandle, "usr_LoginName, usr_Initials, usr_LastName, usr_FirstName, lng_Name":U, ?).
        BindingSource = NEW Progress.Data.BindingSource(TEMP-TABLE esc_UserFlat:HANDLE, "usr_LoginName, usr_Initials, usr_LastName, usr_FirstName, lng_Name":U, ?).              
        BindingSource:AllowEdit = FALSE.
        BindingSource:AllowRemove = FALSE.
        BindingSource:AllowNew = FALSE.
        BindingSource:AutoSort = TRUE.
        UltraGrid1:SetDataBinding(BindingSource, ?, YES).  
       
    END.
    */
    
    /*****************************************************************************/
    
    DESTRUCTOR PUBLIC BrwUser ( ):
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.
    END DESTRUCTOR.

END CLASS.
