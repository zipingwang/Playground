
 /*------------------------------------------------------------------------
    File        : TemptableViewer
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Thu Jan 11 10:33:16 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.BrowserExtension.BrowserHelper FROM PROPATH.
USING Playground.BrowserExtension.BrowserFastPositionHelper FROM PROPATH.
USING Playground.BrowserExtension.BrowserExtension FROM PROPATH.
USING Playground.BrowserExtension.SimpleStringEventArgs FROM PROPATH.
USING System.IO.Path FROM ASSEMBLY.
USING System.Runtime.Remoting.Metadata.XmlFieldOrderOption FROM ASSEMBLY.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.TemptableViewer.TemptableViewer INHERITS Form:

    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraButtonReset AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraButtonFilter AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE textBoxFilterText AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE splitContainer1 AS System.Windows.Forms.SplitContainer NO-UNDO.
    DEFINE VARIABLE BrowserExtension AS BrowserExtension NO-UNDO.
    DEFINE VARIABLE BrowserFastPositionHelper AS BrowserFastPositionHelper NO-UNDO.
    DEFINE VARIABLE BindingSource AS Progress.Data.BindingSource NO-UNDO.
    DEFINE VARIABLE QueryHandle AS HANDLE NO-UNDO.
    DEFINE VARIABLE DataTableHandle AS HANDLE NO-UNDO.

    CONSTRUCTOR PUBLIC TemptableViewer (  ):

        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).

        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:TemptableViewer_Load).
        ultraButtonFilter:Click:Subscribe(THIS-OBJECT:ultraButtonFilter_Click).
        ultraButtonReset:Click:Subscribe(THIS-OBJECT:ultraButtonReset_Click).

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
        THIS-OBJECT:splitContainer1 = NEW System.Windows.Forms.SplitContainer().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraButtonReset = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraButtonFilter = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:textBoxFilterText = NEW System.Windows.Forms.TextBox().
        CAST(THIS-OBJECT:splitContainer1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:splitContainer1:Panel1:SuspendLayout().
        THIS-OBJECT:splitContainer1:Panel2:SuspendLayout().
        THIS-OBJECT:splitContainer1:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* splitContainer1 */
        /*  */
        THIS-OBJECT:splitContainer1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:splitContainer1:FixedPanel = System.Windows.Forms.FixedPanel:Panel2.
        THIS-OBJECT:splitContainer1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:splitContainer1:Name = "splitContainer1":U.
        THIS-OBJECT:splitContainer1:Orientation = System.Windows.Forms.Orientation:Horizontal.
        /*  */
        /* splitContainer1.Panel1 */
        /*  */
        THIS-OBJECT:splitContainer1:Panel1:Controls:Add(THIS-OBJECT:ultraGrid1).
        /*  */
        /* splitContainer1.Panel2 */
        /*  */
        THIS-OBJECT:splitContainer1:Panel2:Controls:Add(THIS-OBJECT:ultraButtonReset).
        THIS-OBJECT:splitContainer1:Panel2:Controls:Add(THIS-OBJECT:ultraButtonFilter).
        THIS-OBJECT:splitContainer1:Panel2:Controls:Add(THIS-OBJECT:textBoxFilterText).
        THIS-OBJECT:splitContainer1:Size = NEW System.Drawing.Size(840, 510).
        THIS-OBJECT:splitContainer1:SplitterDistance = 459.
        THIS-OBJECT:splitContainer1:TabIndex = 0.
        /*  */
        /* ultraGrid1 */
        /*  */
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        //THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance1.
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
        //THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance6.
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
        //THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1":U.
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(840, 459).
        THIS-OBJECT:ultraGrid1:TabIndex = 0.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1":U.
        /*  */
        /* ultraButtonReset */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ultraButtonReset:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ultraButtonReset:Location = NEW System.Drawing.Point(737, 12).
        THIS-OBJECT:ultraButtonReset:Name = "ultraButtonReset":U.
        THIS-OBJECT:ultraButtonReset:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:ultraButtonReset:TabIndex = 2.
        THIS-OBJECT:ultraButtonReset:Text = "Reset":U.
        /*  */
        /* ultraButtonFilter */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ultraButtonFilter:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ultraButtonFilter:Location = NEW System.Drawing.Point(637, 12).
        THIS-OBJECT:ultraButtonFilter:Name = "ultraButtonFilter":U.
        THIS-OBJECT:ultraButtonFilter:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:ultraButtonFilter:TabIndex = 1.
        THIS-OBJECT:ultraButtonFilter:Text = "Filter":U.
        /*  */
        /* textBoxFilterText */
        /*  */
        DEFINE VARIABLE nestedvar2 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar2 = System.Windows.Forms.AnchorStyles:Left.
        THIS-OBJECT:textBoxFilterText:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar2, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:textBoxFilterText:Location = NEW System.Drawing.Point(3, 15).
        THIS-OBJECT:textBoxFilterText:Name = "textBoxFilterText":U.
        THIS-OBJECT:textBoxFilterText:Size = NEW System.Drawing.Size(616, 20).
        THIS-OBJECT:textBoxFilterText:TabIndex = 0.
        /*  */
        /* TemptableViewer */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(840, 510).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:splitContainer1).
        THIS-OBJECT:Name = "TemptableViewer":U.
        THIS-OBJECT:Text = "Temp-table Viewer":U.
        THIS-OBJECT:splitContainer1:Panel1:ResumeLayout(FALSE).
        THIS-OBJECT:splitContainer1:Panel2:ResumeLayout(FALSE).
        THIS-OBJECT:splitContainer1:Panel2:PerformLayout().
        CAST(THIS-OBJECT:splitContainer1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:splitContainer1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /****************************************************************************/

    METHOD PRIVATE VOID TemptableViewer_Load(INPUT sender AS System.Object, INPUT e AS System.EventArgs):

        BrowserExtension = NEW BrowserExtension(THIS-OBJECT:ultraGrid1).
        BrowserExtension
            :AddFastPositioningFeature(YES)
            :AddDropFileFeature()
            :FileDropped:Subscribe(THIS-OBJECT:FileDropped).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID FileDropped(sender AS Progress.Lang.Object, e AS SimpleStringEventArgs):

         LoadXmlFile(e:StringValue).

    END METHOD.

    /*****************************************************************************/

     METHOD PRIVATE VOID ultraButtonFilter_Click(sender AS System.Object, e AS System.EventArgs):

        IF NOT VALID-HANDLE(QueryHandle)
        THEN RETURN.

        QueryHandle:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1 where &2":U, DataTableHandle:Name, textBoxFilterText:Text)).
        QueryHandle:QUERY-OPEN().

    END METHOD.

    /*****************************************************************************/

     METHOD PRIVATE VOID ultraButtonReset_Click(sender AS System.Object, e AS System.EventArgs):

        IF NOT VALID-HANDLE(QueryHandle)
        THEN RETURN.

        QueryHandle:QUERY-PREPARE("FOR EACH &1":U).
        QueryHandle:QUERY-OPEN().

    END METHOD.

    /*****************************************************************************/

     METHOD PRIVATE VOID LoadXmlFile(XmlFile AS CHARACTER):

        DEFINE VARIABLE XsdFileName AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF System.IO.File:Exists(XmlFile) = NO
        THEN DO:
           MESSAGE SUBSTITUTE("File not exists: &1", XmlFile) VIEW-AS ALERT-BOX.
           RETURN.
        END.

        ASSIGN XsdFileName = Path:GetDirectoryName(XmlFile) + "\" + Path:GetFileNameWithoutExtension(XmlFile) + ".xsd".
        IF System.IO.File:Exists(XsdFileName) = NO
        THEN DO:
           MESSAGE SUBSTITUTE("XSD File not exists: &1", XsdFileName) VIEW-AS ALERT-BOX.
           RETURN.
        END.

        IF VALID-HANDLE(QueryHandle)
        THEN DELETE OBJECT QueryHandle.

        IF VALID-HANDLE(DataTableHandle)
        THEN DELETE OBJECT DataTableHandle.

        IF VALID-OBJECT(BindingSource)
        THEN DELETE OBJECT BindingSource.

        CREATE TEMP-TABLE DataTableHandle.

        DataTableHandle:READ-XMLSCHEMA(
                                        "FILE",                 /*cSourceType*/
                                        XsdFileName,            /*cFile*/
                                        ?,                      /*lOverrideDefaultMapping*/
                                        ?,                      /*cFieldTypeMapping*/
                                        ?                       /*cVerifySchemaMode*/
                                    ).

        DataTableHandle:READ-XML(
                                    "FILE",                 /*cSourceType,*/
                                    XmlFile,                /*cFile,*/
                                    "EMPTY",                /*cReadMode,*/
                                    ?,                      /*cSchemaLocation,*/
                                    ?,                      /*lOverrideDefaultMapping,*/
                                    ?,                      /*cFieldTypeMapping,*/
                                    ?                       /*cVerifySchemaMode*/
                                ).
        CREATE QUERY QueryHandle.
        QueryHandle:SET-BUFFERS(DataTableHandle:DEFAULT-BUFFER-HANDLE).
        QueryHandle:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1":U, DataTableHandle:Name)).
        QueryHandle:FORWARD-ONLY = FALSE.

        BindingSource = NEW Progress.Data.BindingSource(QueryHandle).
        BindingSource:AllowEdit = FALSE.
        BindingSource:AllowRemove = FALSE.
        BindingSource:AllowNew = FALSE.
        BindingSource:AutoSort = TRUE.
        ultraGrid1:SetDataBinding(BindingSource, ?).

        CATCH err AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessageBox(err).
        END CATCH.

    END METHOD.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC TemptableViewer ( ):

    END DESTRUCTOR.

END CLASS.
