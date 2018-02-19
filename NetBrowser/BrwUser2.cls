 
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

&SCOPED-DEFINE AbstractWindowManagerClient 1

&IF DEFINED(AbstractWindowManagerClient)
&THEN
CLASS Playground.NetBrowser.BrwUser2 INHERITS AbstractWindowManagerClient:
&ELSE
CLASS Playground.NetBrowser.BrwUser2 INHERITS FORM:
&ENDIF    
    DEFINE TEMP-TABLE esc_UserFlat NO-UNDO
    FIELD Selection_ AS LOGICAL  LABEL 'Selection_':U  /* SERIALIZE-NAME 'Selection_':U */
    FIELD RecId_ AS RECID LABEL 'RecId_':U /* SERIALIZE-NAME 'RecId_':U */
    FIELD usr_Initials AS CHARACTER FORMAT "X(10)":U LABEL "Initials":T10 /* SERIALIZE-NAME "usr_Initials":U */
    FIELD usr_LastName AS CHARACTER FORMAT "X(60)":U LABEL "Last name":T16 /* SERIALIZE-NAME "usr_LastName":U */
    FIELD usr_FirstName AS CHARACTER FORMAT "X(40)":U LABEL "First name":T13 /* SERIALIZE-NAME "usr_FirstName":U */
    FIELD usr_LoginName AS CHARACTER FORMAT "X(128)":U LABEL "Login name":T24 /* SERIALIZE-NAME "usr_LoginName":U */
  /*  FIELD RolesList AS CHARACTER FORMAT "X(240)":U LABEL "Roles":T6 /* SERIALIZE-NAME "RolesList":U */
    FIELD usr_Enabled AS LOGICAL FORMAT "yes /no":U LABEL "Enabled":T16 /* SERIALIZE-NAME "usr_Enabled":U */
    FIELD usr_SessionType AS INTEGER FORMAT "->>>>>>>>>9":U LABEL "Session type":T15 /* SERIALIZE-NAME "usr_SessionType":U */
    FIELD usr_AutoLoginAllowed AS LOGICAL FORMAT "yes /no":U LABEL "Autologin allowed":T36 /* SERIALIZE-NAME "usr_AutoLoginAllowed":U */
    FIELD usr_PasswordVerification AS INTEGER FORMAT "->>>>>>9":U LABEL "Password verification":T26 /* SERIALIZE-NAME "usr_PasswordVerification":U */
    FIELD usr_MinimumPasswordLength AS INTEGER FORMAT ">9":U LABEL "Minimum password length":T31 /* SERIALIZE-NAME "usr_MinimumPasswordLength":U */
    FIELD usr_MaximumPasswordAge AS INTEGER FORMAT ">>>9":U LABEL "Maximum password age":T33 /* SERIALIZE-NAME "usr_MaximumPasswordAge":U */
    FIELD usr_AuthorizationTimeout AS INTEGER FORMAT ">>>>9":U LABEL "Authorization timeout":T33 /* SERIALIZE-NAME "usr_AuthorizationTimeout":U */
    FIELD usr_ContextTimeout AS INTEGER FORMAT ">>>>9":U LABEL "Context timeout":T29 /* SERIALIZE-NAME "usr_ContextTimeout":U */
    FIELD usr_Email AS CHARACTER FORMAT "X(80)":U LABEL "E-mail address":T18 /* SERIALIZE-NAME "usr_Email":U */
    FIELD usr_MailMethod AS INTEGER FORMAT "->>>>>>9":U LABEL "Mail method":T18 /* SERIALIZE-NAME "usr_MailMethod":U */
    FIELD usr_Phone AS CHARACTER FORMAT "X(20)":U LABEL "Phone":T11 /* SERIALIZE-NAME "usr_Phone":U */
    FIELD usr_HomePage AS INTEGER FORMAT ">>>>>>>9":U LABEL "Home page":T9 /* SERIALIZE-NAME "usr_HomePage":U */
    FIELD usr_StartTool AS INTEGER FORMAT ">>>>>>>9":U LABEL "Start tool":T10 /* SERIALIZE-NAME "usr_StartTool":U */
    FIELD usr_Language AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Language":T8 /* SERIALIZE-NAME "usr_Language":U */
    FIELD usr_Printer AS INTEGER FORMAT ">>>>>>>9":U LABEL "Printer":T7 /* SERIALIZE-NAME "usr_Printer":U */*/
    FIELD usr_Id AS INTEGER FORMAT ">>>>>>>9":U LABEL "Identifier":T10 /* SERIALIZE-NAME "usr_Id":U */

    FIELD HomePageMnemonic AS CHARACTER FORMAT "X(60)":U LABEL "Home page":T14 /* SERIALIZE-NAME "HomePageMnemonic":U */ INITIAL ?
    FIELD HomePageId AS INTEGER FORMAT ">>>>>>>9":U LABEL "Id":T2 /* SERIALIZE-NAME "HomePageId":U */ INITIAL ?

    FIELD StartToolMnemonic AS CHARACTER FORMAT "X(100)":U LABEL "Start tool":T19 /* SERIALIZE-NAME "StartToolMnemonic":U */ INITIAL ?
    FIELD StartToolTable AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Start tool!Table":T16 /* SERIALIZE-NAME "StartToolTable":U */ INITIAL ?
    FIELD StartToolId AS INTEGER FORMAT ">>>>>>>9":U LABEL "Id":T2 /* SERIALIZE-NAME "StartToolId":U */ INITIAL ?

    FIELD LanguageName AS CHARACTER FORMAT "X(32)":U LABEL "Language":T8 /* SERIALIZE-NAME "LanguageName":U */ INITIAL ?
    FIELD LanguageId AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Identifier":T10 /* SERIALIZE-NAME "LanguageId":U */ INITIAL ?

    FIELD PrinterName AS CHARACTER FORMAT "X(32)":U LABEL "Printer":T11 /* SERIALIZE-NAME "PrinterName":U */ INITIAL ?
    FIELD PrinterId AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Identification":T14 /* SERIALIZE-NAME "PrinterId":U */ INITIAL ?

    INDEX usr_Id IS UNIQUE PRIMARY usr_Id
    INDEX usr_LoginName usr_LoginName.
    
    DEFINE DATASET DsUser FOR esc_UserFlat.
    
    DEFINE PRIVATE VARIABLE bindingSource2 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    
    &IF DEFINED(AbstractWindowManagerClient)
    &THEN
    DEFINE PRIVATE VARIABLE ultraGrid1 AS MipsDataBrowser NO-UNDO.
    &ELSE
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    &ENDIF   
   
    DEFINE PRIVATE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE QueryHandle AS HANDLE NO-UNDO.
        
    CONSTRUCTOR PUBLIC BrwUser2 (  ):
        
        
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        
        BindingSource:OffEnd:Subscribe(OffEndHandler).
        
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
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("LanguageName":U).
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
        DisplayTempTable().  /*simulate binding data on client side*/
    END.
    
    /*****************************************************************************/
    
    /*simulate fill data on server side*/
    METHOD PRIVATE VOID FillTempTable():       
        
        DEFINE VARIABLE QueryString AS CHARACTER NO-UNDO.
        DEFINE VARIABLE DataSourceHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE DataSetHandle AS HANDLE NO-UNDO.
        DEFINE BUFFER b_User FOR sc_User.  
        DEFINE BUFFER b_Language FOR gp_Language. 
        
        ASSIGN BufferHandle = TEMP-TABLE esc_UserFlat:DEFAULT-BUFFER-HANDLE.    
        
        BufferHandle:EMPTY-TEMP-TABLE().
               
        CREATE DATA-SOURCE DataSourceHandle.
        
        ASSIGN QueryString = "FOR EACH sc_User FIELDS( usr_AutoLoginAllowed usr_Enabled usr_FirstName usr_Id 
            usr_Initials usr_Language usr_LastName usr_LoginName ) WHERE sc_User.usr_Enabled = yes  NO-LOCK  , 
            FIRST gp_Language FIELDS( lng_Id lng_Name ) NO-LOCK  OUTER-JOIN WHERE gp_Language.lng_Id = sc_User.usr_Language  
            BY sc_User.usr_LoginName INDEXED-REPOSITION":U.  
             
        CREATE QUERY QueryHandle.
        QueryHandle:ADD-BUFFER(BUFFER sc_User:HANDLE).
        QueryHandle:ADD-BUFFER(BUFFER gp_Language:HANDLE).
        QueryHandle:QUERY-PREPARE(QueryString).
        QueryHandle:QUERY-OPEN().
        
        DataSourceHandle:QUERY = QueryHandle.        
       
        BufferHandle:ATTACH-DATA-SOURCE(DataSourceHandle, "LanguageId,lng_Id,LanguageName,lng_Name":U, ?, ?).
        BufferHandle:BATCH-SIZE = 50.  /*fill temp-table with 50 records*/
        BufferHandle:FILL-MODE = "REPLACE":U.
        
        FOR b_User NO-LOCK WHERE b_User.usr_Id = 272, 
            FIRST b_Language NO-LOCK WHERE b_Language.lng_Id = b_User.usr_Language:   
            
            DEFINE VARIABLE RepositionSuccessed AS LOGICAL NO-UNDO.
                      
            RepositionSuccessed = QueryHandle:REPOSITION-TO-ROWID(BUFFER b_User:ROWID, BUFFER b_Language:RowId). /*not working yet*/
            QueryHandle:GET-NEXT().
            BufferHandle:DATA-SOURCE:RESTART-ROWID(1) = BUFFER b_User:ROWID.
            BufferHandle:DATA-SOURCE:RESTART-ROWID(2) = BUFFER b_Language:ROWID.
          
        END. 
       
        BufferHandle:FILL().
        
        QueryHandle:QUERY-CLOSE().
 
    END. 
    
    /*****************************************************************************/
    
    /*simulate binding data on client side*/
    METHOD PRIVATE VOID DisplayTempTable():
         
        DEFINE VARIABLE QueryForTempTable AS HANDLE NO-UNDO.
        DEFINE VARIABLE BufferHandle AS HANDLE NO-UNDO.
        
        ASSIGN BufferHandle = TEMP-TABLE esc_UserFlat:DEFAULT-BUFFER-HANDLE.
        
        CREATE QUERY QueryForTempTable.
        
        QueryForTempTable:ADD-BUFFER(BufferHandle).
        QueryForTempTable:QUERY-PREPARE("FOR EACH esc_UserFlat by usr_LoginName":U).
        QueryForTempTable:QUERY-OPEN().
        BindingSource = NEW Progress.Data.BindingSource(QueryForTempTable, "usr_LoginName, usr_Initials, usr_LastName, 
            usr_FirstName, LanguageName":U, ?).
        //BindingSource = NEW Progress.Data.BindingSource(BufferHandle, "usr_LoginName, usr_Initials, usr_LastName, usr_FirstName, LanguageName":U, ?).
        BindingSource:AllowEdit = FALSE.
        BindingSource:AllowRemove = FALSE.
        BindingSource:AllowNew = FALSE.
        BindingSource:AutoSort = TRUE.
        UltraGrid1:SetDataBinding(BindingSource, ?, YES).  
    END.    
    
    /*****************************************************************************/
    
    METHOD PROTECTED VOID OffEndHandler (sender AS System.Object, 
                                         e AS Progress.Data.OffEndEventArgs):
        
        /* NOOP */
        
    END METHOD.
    
    /*****************************************************************************/
    DESTRUCTOR PUBLIC BrwUser2 ( ):
        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.
    END DESTRUCTOR.

END CLASS.
