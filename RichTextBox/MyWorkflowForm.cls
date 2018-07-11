/* Copyright (c)2017 MIPS NV. All rights reserved. */


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Be.Mips.Ui.CustomToolbarsManagerCreationFilter FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraButton FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraLabel FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraPanel FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraPanelClientArea FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.BeforeDockChangeEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.CancelablePanesEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.DockAreaPane FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.DockAreasCollection FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.DockableControlPane FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.DockedLocation FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.UltraDockManager FROM ASSEMBLY.
USING Infragistics.Win.UltraWinEditors.UltraTextEditor FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.BeforeToolbarListDropdownEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolClickEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolEventArgs FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.ToolTipDisplayStyle FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.UltraToolbarsManager FROM ASSEMBLY.
USING Progress.Lang.AppError FROM PROPATH.
USING Progress.Lang.Class FROM PROPATH.
USING Progress.Reflect.Property FROM PROPATH.
USING Progress.Windows.Form FROM ASSEMBLY.
USING System.ComponentModel.LicenseManager FROM ASSEMBLY.
USING System.ComponentModel.LicenseUsageMode FROM ASSEMBLY.
USING System.Drawing.Point FROM ASSEMBLY.
USING System.Drawing.Size FROM ASSEMBLY.
USING System.EventArgs FROM ASSEMBLY.
USING System.Globalization.CultureInfo FROM ASSEMBLY.
USING System.Object FROM ASSEMBLY.
USING System.Windows.Forms.AutoSizeMode FROM ASSEMBLY.
USING System.Windows.Forms.CloseReason FROM ASSEMBLY.
USING System.Windows.Forms.Control FROM ASSEMBLY.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING System.Windows.Forms.FormClosingEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.KeyEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.Keys FROM ASSEMBLY.
USING System.Windows.Forms.Padding FROM ASSEMBLY.
USING System.Windows.Forms.SplitContainer FROM ASSEMBLY.
USING System.Windows.Forms.Timer FROM ASSEMBLY.
USING System.Windows.Forms.UserControl FROM ASSEMBLY.
USING be.mips.ablframework.Framework FROM PROPATH.
USING be.mips.ablframework.client.dialog.MessageBox FROM PROPATH.
USING be.mips.ablframework.gui.AutoRefreshChangedEventArgs FROM PROPATH.
USING be.mips.ablframework.gui.CombinedSubtitleProvider FROM PROPATH.
USING be.mips.ablframework.gui.FormTimerParams FROM PROPATH.
USING be.mips.ablframework.gui.IAutoRefreshable FROM PROPATH.
USING be.mips.ablframework.gui.IOptionsProvider FROM PROPATH.
USING be.mips.ablframework.gui.ISubtitleProvider FROM PROPATH.
USING be.mips.ablframework.gui.IWindowManagerClient FROM PROPATH.
USING be.mips.ablframework.gui.IWorkflowForm FROM PROPATH.
USING be.mips.ablframework.gui.ImageCache FROM PROPATH.
USING be.mips.ablframework.gui.ModalityMode FROM PROPATH.
USING be.mips.ablframework.gui.SubtitleChangedEventArgs FROM PROPATH.
USING be.mips.ablframework.gui.ToolbarProxy FROM PROPATH.
USING be.mips.ablframework.gui.WindowManagerClientType FROM PROPATH.
USING be.mips.ablframework.gui.WindowManagerPlaceMode FROM PROPATH.
USING be.mips.ablframework.gui.bwc.IWindowContainer FROM PROPATH.
USING be.mips.ablframework.gui.context.ContextType FROM PROPATH.
USING be.mips.ablframework.gui.context.IContextualControl FROM PROPATH.
USING be.mips.ablframework.gui.context.IContextualToolbarProvider FROM PROPATH.
USING be.mips.ablframework.gui.inputchecker.IInputChecker FROM PROPATH.
USING be.mips.ablframework.gui.inputchecker.NonAsciiInputChecker FROM PROPATH.
USING be.mips.ablframework.gui.inputchecker.event.InputBlockedEventArgs FROM PROPATH.
USING be.mips.ablframework.gui.inputchecker.event.InputChangedEventArgs FROM PROPATH.
USING be.mips.ablframework.gui.inputchecker.event.InputChangingEventArgs FROM PROPATH.
USING be.mips.util.GenericGlobals FROM PROPATH.
USING be.mips.ablframework.gui.statusbar.IObjectStatusBar FROM PROPATH.
USING System.Windows.Forms.Screen FROM ASSEMBLY.

/* DON'T CREATE ABSTRACT PROPERTIES IN THIS FILE
    Visual Designer can't show classes that inherit from abstract classes like this one.
    To have them open we use the DesignMode trick which temporarily removes all ABSTRACT keywords.
    In order to be able to open the derived class in the Visual Designer without changes, no abstract properties
    should be used (since non abstract properties can't be overridden in ABL you would get an error at compile time).

    The workaround is to provide an abstract method as implementation of the property you want to be abstract */

{ gp_debug.i }
{ DesignMode.i FALSE }

CLASS Playground.RichTextBox.MyWorkflowForm
    INHERITS FORM:
   // IMPLEMENTS IWorkflowForm {&ABSTRACT}:

    /**** Events ****/
/*
    DEFINE PUBLIC EVENT SubtitleChanged SIGNATURE VOID (sender AS Object, e AS SubtitleChangedEventArgs).
    DEFINE PUBLIC EVENT ToolClick SIGNATURE VOID (sender AS Progress.Lang.Object, e AS ToolClickEventArgs).
    DEFINE PUBLIC EVENT ToolValueChanged SIGNATURE VOID (sender AS Progress.Lang.Object, e AS ToolEventArgs).
*/
    /*****************************************************************************/

    /**** Global private variables ****/

    DEFINE PRIVATE VARIABLE CachedPreferenceId AS CHARACTER INITIAL ? NO-UNDO.
    DEFINE PRIVATE VARIABLE CachedCustomGeometryData AS CHARACTER INITIAL ? NO-UNDO.
    DEFINE PRIVATE VARIABLE CloseOnTimeout AS LOGICAL NO-UNDO.
    DEFINE PRIVATE VARIABLE ClosingUsingTimer AS LOGICAL NO-UNDO.

    /* FormTimer is used to postpone execution to the next event handling loop */
 //   DEFINE PRIVATE VARIABLE FormTimer AS Timer NO-UNDO.

    /* When tightly coupled controls are attempted to be placed next to each other,
       only allow this if it downscales the existing component up to a certain limit, as defined here.
       Note that the TightCouplingMayEnlargeForm variable may be set TRUE to allow the entire form to
       be resized (up to the current screen size) to be able to abide by this rule. */
    DEFINE PRIVATE VARIABLE TightCouplingScalingThreshold AS DECIMAL NO-UNDO INITIAL 0.3.
    /* TODO: provide datastructure if multiple tightly coupled children should be supported.
       Although in that case you may not even need this storage anymore. */
    DEFINE PRIVATE VARIABLE TightlyCoupledClient AS IWindowManagerClient NO-UNDO.
    DEFINE PRIVATE VARIABLE AreaCount AS INTEGER INITIAL 0 NO-UNDO.
    DEFINE PRIVATE VARIABLE NAlignedClients AS INTEGER INITIAL 0 NO-UNDO.
    /* The maximal amount of clients than can be 'aligned' inside this workflow. For 'alignment', see WindowManager. */
    /* Don't use an extent here. OpenEdge Visual Designer bug, case 00393124, bug PSC00356382 */
    DEFINE PRIVATE VARIABLE SplitContainer1 AS SplitContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE SplitContainer2 AS SplitContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE AlignedClients AS IWindowManagerClient EXTENT 2 NO-UNDO.

    /* Unpinning of a dockable area has an inherent delay. There seems to be no away around the Infragistics API
       to forego with this delay. Therefore, we provide a manual timer to handle with immedtiate unpinning (by closing the dockable area
       and then unclosing it after some time). */
    DEFINE PRIVATE VARIABLE SideArea AS DockAreaPane NO-UNDO.
    DEFINE PRIVATE VARIABLE SideAreaTimer AS Timer NO-UNDO.
    DEFINE PRIVATE VARIABLE MinMaxSizeIsSet AS LOGICAL NO-UNDO INITIAL NO.

    DEFINE PRIVATE VARIABLE AlreadyLoaded AS LOGICAL NO-UNDO. /* If the UserControl is part of an MDI child form, the Load
    event will occur each time the child form is shown. To prevent one time initialization code to be run more than
    once, we'll remember if the load has already happened. More info:
    http://msdn.microsoft.com/en-us/library/system.windows.forms.usercontrol.load.aspx*/

    DEFINE PRIVATE VARIABLE LastFittedSize AS Size NO-UNDO.

    DEFINE PRIVATE VARIABLE DisallowNonAsciiDataInUI AS LOGICAL NO-UNDO.

    DEFINE PRIVATE VARIABLE FormBorderWidth AS INTEGER NO-UNDO.
    DEFINE PRIVATE VARIABLE FormBorderHeight AS INTEGER NO-UNDO.
    DEFINE PRIVATE VARIABLE AutoSized AS LOGICAL NO-UNDO.

    &IF DEFINED(DEBUG)
    &THEN
    DEFINE PROTECTED VARIABLE DesignTime AS LOGICAL NO-UNDO.
    &ENDIF

    /*****************************************************************************/

    /**** Properties ****/

    DEFINE PRIVATE PROPERTY SubtitleLabel AS UltraLabel NO-UNDO
    GET:
        RETURN GetSubtitleLabel().
    END GET.

    DEFINE PRIVATE PROPERTY OptionsButton AS UltraButton NO-UNDO
    GET:
        RETURN GetOptionsButton().
    END GET.

    DEFINE PRIVATE PROPERTY ContentPanel AS UltraPanel NO-UNDO
    GET:
        RETURN GetContentPanel().
    END GET.

    DEFINE PRIVATE PROPERTY OptionsAndSubtitlePanel AS UltraPanel NO-UNDO
    GET:
        RETURN GetOptionsAndSubtitlePanel().
    END GET.

    DEFINE PRIVATE PROPERTY DockManager AS UltraDockManager NO-UNDO
    GET:
        RETURN GetDockManager().
    END GET.

    DEFINE PUBLIC PROPERTY DockAreaTop AS UltraToolbarsDockArea NO-UNDO
    GET:
        RETURN GetDockAreaTop().
    END GET.

    DEFINE PUBLIC PROPERTY AsControl AS Control NO-UNDO
    GET:
        RETURN THIS-OBJECT.
    END GET.
    SET.

    DEFINE PUBLIC PROPERTY AsForm AS Form NO-UNDO
    GET:
        RETURN THIS-OBJECT.
    END GET.
    SET.

    DEFINE PUBLIC PROPERTY IsClosing AS LOGICAL NO-UNDO
    GET.
    PRIVATE SET.

    DEFINE PRIVATE VARIABLE IsClosed AS LOGICAL NO-UNDO.
//--point1
    /* Defines whether the WorkflowForm has been set to modal or not. */
    DEFINE PUBLIC PROPERTY ModalityMode AS ModalityMode NO-UNDO GET.
    SET(arg AS ModalityMode):
        IF arg = ?
        THEN UNDO, THROW NEW AppError("WorkflowForm Modality property cannot be set to unkown.":U).
        ELSE ModalityMode = arg.
    END SET.

    DEFINE PUBLIC PROPERTY MainWMChild AS IWindowManagerClient NO-UNDO
    GET.
    SET(arg AS IWIndowManagerClient):
        ASSIGN MainWMChild = arg.
        IF VALID-OBJECT(MainWMChild)
        THEN CachedPreferenceId = MainWMChild:PreferenceId.
            /* Don't reset CachedPreferenceId to ? when MainWMChild is invalidated. That way we can still store the
               preference after MainWMCHild has already been cleaned up */
    END SET.

    DEFINE PUBLIC PROPERTY PreferredWindowManagerPlaceMode AS WindowManagerPlaceMode NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY RealProvider AS IContextualToolbarProvider NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY SubtitleProvider AS ISubtitleProvider NO-UNDO
    GET.
    SET (arg AS ISubtitleProvider):
      /*  IF VALID-OBJECT(arg)
        THEN DO:
            IF NOT VALID-OBJECT(SubtitleProvider)
            THEN DO:
                ASSIGN SubtitleProvider = NEW CombinedSubtitleProvider().
                SubtitleProvider:SubtitleChanged:Subscribe(SubtitleProvider_SubtitleChanged).
            END.

            CAST(SubtitleProvider, CombinedSubtitleProvider):AddSubtitleProvider(arg).

            ASSIGN
                SubtitleLabel:Visible = TRUE
                SubtitleLabel:Text = SubtitleProvider:Subtitle.
        END.
        ELSE ASSIGN
                SubtitleLabel:Visible = FALSE
                SubtitleLabel:Text = "":U.

        OnSubtitleChanged(NEW SubtitleChangedEventArgs(SubtitleLabel:Text)).
*/
    END SET.

    DEFINE PUBLIC PROPERTY OptionsProvider AS IOptionsProvider NO-UNDO
    GET.
    SET(arg AS IOptionsProvider):

        DEFINE VARIABLE OldProvider AS IOptionsProvider NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN OldProvider = OptionsProvider.

        IF arg <> OldProvider
        THEN DO:
            IF VALID-OBJECT(arg)
            THEN ASSIGN
                    OptionsButton:Visible = TRUE
                    SubtitleLabel:Left = OptionsButton:Right + 9.
            ELSE IF VALID-OBJECT(OldProvider)
            THEN ASSIGN
                    OptionsButton:Visible = FALSE
                    SubtitleLabel:Left = OptionsButton:Left.
            ASSIGN OptionsProvider = arg.
        END.
    END SET.

    DEFINE PUBLIC PROPERTY Title AS CHARACTER NO-UNDO
    GET:
        IF VALID-OBJECT(MainWMChild)
        THEN RETURN MainWMChild:Title.
        ELSE RETURN "Workflow":U.
    END GET.
    SET(arg AS CHARACTER):
        IF NOT VALID-OBJECT(SubtitleProvider) AND NOT VALID-OBJECT(MainWMChild:SubtitleProvider)
        THEN ASSIGN THIS-OBJECT:Text = arg.
    END SET.

    /* IContextualToolbarProvider */
    DEFINE PUBLIC PROPERTY ToolbarsManager AS UltraToolbarsManager NO-UNDO
    GET:
        RETURN GetToolbarsManager().
    END GET.

    DEFINE PUBLIC PROPERTY Type AS WindowManagerClientType NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY TightCouplingMayEnlargeForm AS LOGICAL NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY UniqueId AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY PreferenceId AS CHARACTER NO-UNDO
    GET:
        RETURN CachedPreferenceId.
    END GET.

    DEFINE PUBLIC PROPERTY GeometryOptions AS CHARACTER NO-UNDO
    GET:
        DEFINE VARIABLE GeometryOptions AS CHARACTER INITIAL ? NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF TYPE-OF(MainWMChild, IWindowContainer)
        THEN ASSIGN GeometryOptions = CAST(MainWMChild, IWindowContainer):GetGeometryOptions().

        IF GeometryOptions = ?
        THEN ASSIGN GeometryOptions = "All":U.

        RETURN GeometryOptions.

    END GET.

    DEFINE PUBLIC PROPERTY CustomGeometryData AS CHARACTER NO-UNDO INITIAL ?
    GET:
        RETURN CachedCustomGeometryData.
    END GET.
    SET(arg AS CHARACTER):
        ASSIGN CachedCustomGeometryData = CustomGeometryData.
    END SET.

    DEFINE PUBLIC PROPERTY ApplyDefaultVerticalPositioning AS LOGICAL NO-UNDO INITIAL TRUE
    GET.
    SET.

    DEFINE PUBLIC PROPERTY ApplyDefaultHorizontalPositioning AS LOGICAL NO-UNDO INITIAL TRUE
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Subtitle AS CHARACTER NO-UNDO
    GET:
        RETURN SubtitleLabel:Text.
    END GET.

    DEFINE PRIVATE PROPERTY NonAsciiInputChecker AS IInputChecker NO-UNDO
    GET.
    SET.

    DEFINE PRIVATE PROPERTY MinimumWidth AS INTEGER NO-UNDO
    GET:
        RETURN 100. //GetMinimumWidth().
    END GET.

    DEFINE PRIVATE PROPERTY MinimumHeight AS INTEGER NO-UNDO
    GET:
        RETURN 100. //GetMinimumHeight().
    END GET.

    /*****************************************************************************/
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    CONSTRUCTOR PUBLIC MyWorkflowForm():
        SUPER().
     /*   &IF DEFINED(DEBUG)
        &THEN
            ASSIGN DesignTime = LicenseManager:UsageMode = LicenseUsageMode:Designtime.
        &ENDIF
*/
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:SuspendLayout().
        THIS-OBJECT:Name = "MyWorkflowForm".
        THIS-OBJECT:Text = "MyWorkflowForm".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END METHOD.
//--point2
    /*****************************************************************************/

    METHOD PUBLIC VOID AfterConstructor():

        /* Method called by FormFactory:CreateWorkflowForm right AFTER constructing the object.
            This ensures all constructor (base and derived) are fully completed and the object is created.
            This is usefull when code accesses overridden members that might not be there yet during the
            constructor of the base class (i.e. everything that gets created in the derived class InitializeComponent) */

        ASSIGN ModalityMode = be.mips.ablframework.gui.ModalityMode:None.

        DisallowNonAsciiDataInUI = GenericGlobals:Instance:DisallowNonAsciiDataInUI.
        IF DisallowNonAsciiDataInUI
        THEN DO:
            KeyPreview = TRUE.
            NonAsciiInputChecker = NEW NonAsciiInputChecker().
        END.

        IF CultureInfo:CurrentCulture:ToString() = "nl-BE":U
        THEN ASSIGN
                ToolbarsManager:CreationFilter = NEW CustomToolbarsManagerCreationFilter(CultureInfo:CurrentCulture)
                ToolbarsManager:ToolTipDisplayStyle = ToolTipDisplayStyle:None.

        SetOptionsButtonImage().
//        Framework:FormGeometryManager:RegisterForm(THIS-OBJECT).

        SubscribeEvents().

    END METHOD. /* AfterConstructor */

    /*****************************************************************************/

    METHOD PRIVATE VOID SubscribeEvents():

      /*  DockManager:BeforeDockChange:Subscribe(DockManager_BeforeDockChange).
        DockManager:BeforeSplitterDrag:Subscribe(DockManager_BeforeSplitterDrag).
        OptionsButton:Click:Subscribe(OptionsButton_Click).
        ToolbarsManager:BeforeToolbarListDropdown:Subscribe(ToolbarsManager_BeforeToolbarListDropdown).
        ToolbarsManager:ToolClick:Subscribe(ToolbarsManager_ToolClick).
        ToolbarsManager:ToolValueChanged:Subscribe(ToolbarsManager_ToolValueChanged).

        IF DisallowNonAsciiDataInUI
        THEN DO:
            NonAsciiInputChecker:SubscribeToEvents(THIS-OBJECT).
            NonAsciiInputChecker:InputBlocked:Subscribe(NonAsciiInputChecker_InputBlocked).
        END.
*/
    END METHOD. /* SubscribeEvents */

    /*****************************************************************************/

    METHOD PRIVATE VOID AddSidePanel(ParentClient AS IWindowManagerClient, SidePanel AS UserControl):
/*
        DEFINE VARIABLE SidePanelWMClient AS IWindowManagerClient NO-UNDO.
        DEFINE VARIABLE SidePanelContextualControl AS IContextualControl NO-UNDO.
        DEFINE VARIABLE SidePanelToolbarProxy AS ToolbarProxy NO-UNDO.

        /* ------------------------------------------------------------------------------------ */

        /* Create a dock manager area or reuse existing one */
        ASSIGN SideArea = CreateDockManagerPane(SidePanel, DockedLocation:DockedRight,
            SidePanel:Text + STRING(AreaCount), "_SideArea":U, SidePanel:Text).

        /* HACK kn: do not change the following few lines */
        ASSIGN
            DockManager:Visible = FALSE /* hide all tabs */
            DockManager:AnimationEnabled = FALSE. /* set AnimationEnabled to FALSE before BeginInit */
        CAST(DockManager, System.ComponentModel.ISupportInitialize):BeginInit().
        SideArea:Panes[0]:Unpin(). /* Unpin between BeginInit and EndInit */
        CAST(DockManager, System.ComponentModel.ISupportInitialize):EndInit().
        /* should be 1201 ms after onload, but 3000 ms after instantiation will do */
        ASSIGN
            SideAreaTimer = NEW Timer()
            SideAreaTimer:Interval = 3000.
        SideAreaTimer:Tick:Subscribe(SideAreaTimer_Tick).
        /* END HACK kn */

        /* Is the SidePanel control a WM client? Let it play with the hierarchy. */
        IF(TYPE-OF(SidePanel, IWindowManagerClient))
        THEN DO:
            SidePanelWMClient = CAST(SidePanel, IWindowManagerClient).
            /* Register the side panel as a child of the parent client */
            Framework:WindowManager:DeclareAndPlaceObject(SidePanelWMClient, ParentClient).
        END.

        /* Is the Side Panel control contextual? Then it needs ribbon support. */
        IF(TYPE-OF(SidePanel, IContextualControl))
        THEN DO:
            ASSIGN
                SidePanelContextualControl = CAST(SidePanel, IContextualControl)
                SidePanelToolbarProxy = NEW ToolbarProxy(). /* Make a new ToolbarProxy for this object */
                SidePanelToolbarProxy:RealProvider = Framework:WindowManager:GetContextualToolbarProvider(MainWMChild).

            /* If this workflowform is an MDI child, then ApplicationForm will handle Ribbon management */
            IF MdiParent <> ?
            THEN SidePanelToolbarProxy:RealProvider = Framework:WindowManager:GetContextualToolbarProvider(MainWMChild).

            Framework:WindowManager:SetContextualToolbarProvider(CAST(SidePanel, IContextualControl), SidePanelToolbarProxy).
        END.

        RETURN.
*/
    END METHOD. /* AddSidePanel */

    /*****************************************************************************/

    METHOD PROTECTED VOID SetOptionsButtonImage():

        ASSIGN OptionsButton:Appearance:Image = ImageCache:Instance:ImageForPath(
            "img/IconsGenericFunctions/16x16/Configuration.png":U).

    END METHOD. /* SetOptionsButtonImage */

    /*****************************************************************************/

    METHOD PRIVATE VOID ShowFloatingForms():

        SetFloatingFormsVisibility(TRUE).

    END METHOD. /* ShowFloatingForms */

    /*****************************************************************************/

    METHOD PRIVATE VOID HideFloatingForms():

        SetFloatingFormsVisibility(FALSE).

    END METHOD. /* HideFloatingForms */

    /*****************************************************************************/

    METHOD PRIVATE VOID SetFloatingFormsVisibility(Visible_ AS LOGICAL):

 //       IF NOT(VALID-OBJECT(MainWMChild) AND MainWMChild:HandleSetChildFormsVisiblity(Visible_))
 //       THEN Framework:WindowManager:SetAllChildFormsVisibility(THIS-OBJECT /* Parent */, Visible_).

    END METHOD. /* SetFloatingFormsVisibility */

    /*****************************************************************************/

    /**
     * Enables or disables the WorkflowForm.
     *
     * In case of WorkflowForm having a MdiParent (and being part of a tab), disabling the workflowform also
     * disables the tab. As a result, when clicking another tab, you cannot return to the disabled tab. So, in
     * this case we iterate over the Controls to disable them. In all other cases we can just disable the
     * WorkflowForm.
     *
     * @param Enabled TRUE  --> Enable WorkflowForm
     *                FALSE --> Disable WorkflowForm
     */
    METHOD PRIVATE VOID SetEnabled(Enabled AS LOGICAL):

        IF VALID-OBJECT(MainWMChild) AND Enabled = FALSE
        THEN MainWMChild:BeforeDisable().

        /* Is the Form an MdiChild? */
        IF VALID-OBJECT(MdiParent)
        THEN DO:
            Framework:WindowManager:EnableObjectContext(MainWMChild, Enabled).
            { Consultingwerk/foreach.i Control Control_ in THIS-OBJECT:Controls }
                Control_:Enabled = Enabled.
            END.
        END.
        ELSE THIS-OBJECT:Enabled = Enabled.

        IF VALID-OBJECT(MainWMChild) AND Enabled = TRUE
        THEN MainWMChild:AfterEnable().

    END METHOD. /* SetEnabled */

    /*****************************************************************************/

    /**
     * Schedule the FormTimer to make things happen in the next event handling loop
     */
  /*  METHOD PRIVATE VOID ScheduleTimer(TheParams AS CHARACTER):

        ScheduleTimer(NEW FormTimerParams(TheParams)).

    END METHOD. /* ScheduleTimer */
*/
    /*****************************************************************************/

    /**
     * Schedule the FormTimer to make things happen in the next event handling loop
     */
/*    METHOD PRIVATE VOID ScheduleTimer(FormTimerParams AS FormTimerParams):

        IF NOT VALID-OBJECT(FormTimer)
        THEN DO:
            ASSIGN
                FormTimer = NEW Timer()
                FormTimer:Interval = 1. /* make it happen in the next event handling loop */
            FormTimer:Tick:Subscribe(FormTimer_Tick).
        END.

        ASSIGN FormTimer:Tag = FormTimerParams.
        FormTimer:Start().

    END METHOD.
*/
    /*****************************************************************************/

    /**
     * Enables the WorkflowForm (differentiating between a MdiChild and a Floating Form)
     */
    METHOD PUBLIC VOID Enable():

        SetEnabled(TRUE).

    END METHOD. /* Enable */

    /*****************************************************************************/

    /**
     * Disables the WorkflowForm (differentiating between a MdiChild and a Floating Form)
     */
    METHOD PUBLIC VOID Disable():

        SetEnabled(FALSE).

    END METHOD. /* Disable */

    /*****************************************************************************/

    METHOD PUBLIC VOID AfterRegistered():

    END METHOD. /* AfterRegistered */

    /*****************************************************************************/

    METHOD PUBLIC VOID BeforeDisable():

    END METHOD. /* BeforeDisable */

    /*****************************************************************************/

    METHOD PUBLIC VOID AfterEnable():

    END METHOD. /* AfterEnable */

    /*****************************************************************************/

    METHOD PUBLIC VOID HandleRibbonContentsChanged():

        /* This method seems to be the correct place to execute the code below, although we should probably change its
           name to something more appropriate */

        ComputeAndApplyMinMaxSize(). /* this won't be executed for child browsers because these are not visible at this moment */

    END METHOD. /* HandleRibbonContentsChanged */

    /*****************************************************************************/

    METHOD PRIVATE VOID ComputeAndApplyMinMaxSize():

        DEFINE VARIABLE MinimumWidth_ AS INTEGER NO-UNDO.
        DEFINE VARIABLE MinimumHeight_ AS INTEGER NO-UNDO.
        DEFINE VARIABLE MaximumWidth_ AS INTEGER NO-UNDO.
        DEFINE VARIABLE MaximumHeight_ AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        /* Actually, setting the Minimum and/or Maximum size triggers a OnDeactivated and OnActivated.
           Because of that we have to check if the form is visible before setting these sizes. (focus issues)
        */

        IF Visible AND VALID-OBJECT(MainWMChild) AND NOT MinMaxSizeIsSet
        THEN DO:
            /* MinimumSize */
            ASSIGN
                MinimumWidth_ = MAXIMUM(MinimumWidth, MainWMChild:AsControl:MinimumSize:Width) + FormBorderWidth
                MinimumHeight_ = MAXIMUM(MinimumHeight, MainWMChild:AsControl:MinimumSize:Height) + FormBorderHeight
                MinimumSize = NEW Size(MinimumWidth_, MinimumHeight_).

            /* MaximumSize */
            ASSIGN
                MaximumWidth_ = MainWMChild:AsControl:MaximumSize:Width
                MaximumHeight_ = MainWMChild:AsControl:MaximumSize:Height.

            IF MaximumWidth_ > 0 AND MaximumHeight_ > 0
            THEN ASSIGN MaximumSize = NEW Size(MaximumWidth_ + FormBorderWidth, MaximumHeight_ + FormBorderHeight).

            ASSIGN MinMaxSizeIsSet = YES.
        END.

    END METHOD. /* ComputeAndApplyMinMaxSize */

    /*****************************************************************************/

    METHOD PROTECTED INTEGER GetMinimumWidth():

        RETURN 0.

    END METHOD. /* GetMinimumWidth */

    /*****************************************************************************/

    METHOD PROTECTED INTEGER GetMinimumHeight():

        RETURN 0.

    END METHOD. /* GetMinimumHeight */

    /*****************************************************************************/

    METHOD PUBLIC LOGICAL HandleToolClick(e AS ToolClickEventArgs):

        RETURN FALSE.

    END METHOD. /* HandleToolClick */

    /*****************************************************************************/

    METHOD PUBLIC LOGICAL HandleToolValueChanged(e AS ToolEventArgs):

        RETURN FALSE.

    END METHOD. /* HandleToolValueChanged */

    /*****************************************************************************/
//point 3, restart ok

    METHOD PUBLIC LOGICAL Place(Client AS IWindowManagerClient):

        DEFINE VARIABLE PlaceResult AS LOGICAL NO-UNDO INITIAL FALSE.
        DEFINE VARIABLE ClientAsContextualControl AS IContextualControl.
        DEFINE VARIABLE ClientOptionsProvider AS IOptionsProvider.
        DEFINE VARIABLE ClientSubtitleProvider AS ISubtitleProvider.
        DEFINE VARIABLE ToolbarProxy AS ToolbarProxy.
        DEFINE VARIABLE SidePanels AS "System.Windows.Forms.UserControl[]":U NO-UNDO.
        DEFINE VARIABLE SidePanelCounter AS INTEGER NO-UNDO.
        DEFINE VARIABLE RealProvider AS IContextualToolbarProvider NO-UNDO.

        /* ----------------------------------------------------------------------*/
/*
        /* If this is the first control, we should fill the entire form with it. */
        IF NOT VALID-OBJECT(MainWMChild)
        THEN DO:
            /* Make a new ToolbarProxy for this object */
            ASSIGN
                ToolbarProxy = NEW ToolbarProxy()
                ToolbarProxy:RealProvider = THIS-OBJECT.

            /* Remove the placeholder */
            IF ToolbarsManager:Ribbon:Tabs:Count > 0
                AND ToolbarsManager:Ribbon:Tabs:Item[0]:Key = "placeholder":U
            THEN ToolbarsManager:Ribbon:Tabs:RemoveAt(0).

            /* Check if the client has an OptionsProvider and/or SubtitleProvider */
            ASSIGN
                ClientOptionsProvider = Client:OptionsProvider
                ClientSubtitleProvider = Client:SubtitleProvider.

            IF ClientOptionsProvider = ? AND ClientSubtitleProvider = ?
            THEN ASSIGN OptionsAndSubtitlePanel:Visible = FALSE.
            ELSE DO:
                /* Show/hide + position the button and label as appropriate */
                IF ClientOptionsProvider = ?
                THEN ASSIGN
                        OptionsButton:Visible = NO
                        SubtitleLabel:Left = OptionsButton:Left.
                IF ClientSubtitleProvider = ?
                THEN ASSIGN SubtitleLabel:Visible = NO.
                /* Update the internal properties */
                ASSIGN
                    OptionsProvider = ClientOptionsProvider
                    SubtitleProvider = ClientSubtitleProvider.
            END.

            IF TYPE-OF(Client, IContextualControl)
            THEN ASSIGN ClientAsContextualControl = CAST(Client, IContextualControl).

            IF ClientAsContextualControl <> ?
            THEN DO:
                Framework:WindowManager:SetContextualToolbarProvider(ClientAsContextualControl, ToolbarProxy).
                /* If there is no table context then just hide the ribbon altogether -
                   otherwise things may not fit due to Office2010 ribbon minimize widget */
                IF NOT (ClientAsContextualControl:ContextType = ContextType:ArrayEditor OR
                    ClientAsContextualControl:ContextType = ContextType:Outliner)
                    AND (ClientAsContextualControl:ContextTableId = 0 OR ClientAsContextualControl:ContextTableId = ?)
                THEN ASSIGN ToolbarsManager:Ribbon:Visible = NO.
            END.
            ELSE ASSIGN ToolbarsManager:Ribbon:Visible = NO.

            /* We need to show the StatusBar here so AutoSizing works correctly... */
            ShowStatusBarIfNeeded(Client).

            Client:AsControl:Margin = NEW Padding(0). /* To ensure AutoSize works correctly, remove any Margin */
            ContentPanel:ClientArea:Controls:Add(Client:AsControl).

            ASSIGN MainWMChild = Client. /* MainWMChild needs to be set as it is used by DisableAutoSize */

            /* If this is an MDI child WorkflowForm (top-level), mark this 'main' client as a passively sizing one.
               Also, in that case, set the 'real' (merge target) context provider of this embedded control to the
               application form. */
            IF MdiParent <> ?
            THEN DO:
                /* Control is dynamically resizing */
                IF TYPE-OF(MainWMChild, IWindowContainer)
                THEN ASSIGN CAST(MainWMChild, IWindowContainer):DynamicallyResizingClient = TRUE.

                ASSIGN
                    Client:AsControl:Dock = DockStyle:Fill
                    RealProvider = GetRealContextualToolbarProviderForMdiChildren()
                    ToolbarProxy:RealProvider = RealProvider.

                Framework:WindowManager:SetRealContextualToolbarProvider(Client, RealProvider).
            END.

            Client:AsControl:VisibleChanged:Subscribe(Client_VisibleChanged).

            /* Does the control come with any side panels? If so, add these. */
            IF(TYPE-OF(Client, IContextualControl))
            THEN DO:
                ASSIGN SidePanels = CAST(Client, IContextualControl):SidePanels.

                IF VALID-OBJECT(SidePanels) AND SidePanels:Length > 0
                THEN DO SidePanelCounter = 0 TO SidePanels:Length - 1:
                    AddSidePanel(Client, CAST(SidePanels:GetValue(SidePanelCounter), UserControl)).
                END.
            END.

            //Framework:StatusBarManager:SetObjectStatusBar(Client, GetObjectStatusBar()).

            ASSIGN PlaceResult = TRUE.
        END.
        ELSE DO:
            /* Floating mode?
                - If the WIndowManager state explicitly is set to "Floating"
                - If there is already a docked child (TODO: multiple tightly coupleds?)
                - If this already is a floating form
                - If this is a floating form (no MDIChild)
             */
            IF Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Default OR
                Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Docking
                OR VALID-OBJECT(TightlyCoupledClient)
                OR MdiParent = ?
            THEN DO:
                /* Creates and places the form... */
                Framework:Factories:FormFactory:CreateFloatingWorkflowForm(Client).
                ASSIGN AreaCount = AreaCount + 1.
            END.

            /* Docking mode?
                - If the WindowManager mode is explicitly set to "Docking"
             */
            ELSE IF Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Docking
            THEN DO:

                /* Do not dynamically resize this object or the object it contains */
                Framework:WindowManager:SetDynamicallySizeClient(Client, FALSE).
                /* Disable dynamic sizing for the embedded control as well to evade scaling live-lock issues. */
                IF VALID-OBJECT(Client:MainWMChild)
                THEN Framework:WindowManager:SetDynamicallySizeClient(Client:MainWMChild, FALSE).

                /* Set the 'real' (merge target) context provider of this embedded control to:
                    The MainWMChild's 'real' ContextualToolbarProvider
                */
                Framework:WindowManager:SetRealContextualToolbarProvider(Client,
                    Framework:WindowManager:GetRealContextualToolbarProvider(MainWMChild)).

                /* Only create a tightly coupled widget if it does't cause the other component to shrink
                   *too* much, even if the form may enlarge a bit when trying to squeeze it in anyway.
                   TODO: Maybe provide extra cleverness for multi-monitor setups. Keep it simple though. */
                IF (TightCouplingMayEnlargeForm AND
                        Screen:PrimaryScreen:WorkingArea:Width >
                        (Client:AsControl:Size:Width + MainWMChild:AsControl:Size:Width * TightCouplingScalingThreshold)) OR
                   (NOT TightCouplingMayEnlargeForm AND
                        THIS-OBJECT:Size:Width >
                        (Client:AsControl:Size:Width + MainWMChild:AsControl:Size:Width * TightCouplingScalingThreshold))
                THEN DO:
                    IF NOT VALID-OBJECT(TightlyCoupledClient)
                    THEN ASSIGN TightlyCoupledClient = Client.   /* Currently we only support one coupling at a time. */

                    CreateDockManagerPane(Client:AsControl,
                        DockedLocation:DockedRight,
                        Client:Title + STRING(AreaCount), "_NewArea":U + STRING(AreaCount), Client:Title).
                END.
                ELSE DO:
                    /* Try in floating mode */
                    &IF DEFINED(DEBUG)
                    &THEN
                        RUN gp_msg("Could not place tightly coupled control as dockable, there is not enough room.":U).
                    &ENDIF
                    Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Default.
                    RETURN Place(Client). /* Beware of infinite recursion.. Should not happen. */
                END.

                ASSIGN AreaCount = AreaCount + 1.

            END.
            /* Alignment mode?
                - If the WindowManager mode is explicitly set to "Align"
                NOTE: The difference between "Align" and "Docking" is that in alignment mode,
                the controls can dynamically resize with each other, and multi-alignment is possible.
                TODO: determine whether Docking mode is not a more simple Alignment mode and maybe remove it.
             */
            ELSE IF Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Aligned
            THEN DO:
                ContentPanel:SuspendLayout(). /* It is a good practice, suspendlayout before change the layout*/
                ASSIGN Client:AsControl:Visible = TRUE.

                /* TightlyCoupled windows.
                   In classic environment we have 2 windows with 2 titles. In .NET we only have 1 panel to show the subtitle.
                   We should listen to the last added Panel. (More specific)
                   TODO Make framework to support multiple subtitles and concatenate them on the screen .
                   Incident 1305-0263 created for this issue
                */
                IF VALID-OBJECT(Client:SubtitleProvider)
                THEN ASSIGN SubtitleProvider = Client:SubtitleProvider.

                CASE NAlignedClients:
                    WHEN 0
                    THEN DO:
                        /* Create the 1st level split container */
                        SplitContainer1 = NEW System.Windows.Forms.SplitContainer().
                        ContentPanel:ClientArea:Controls:Remove(MainWMChild:AsControl).
                        SplitContainer1:Panel1:Controls:Add(MainWMChild:AsControl).
                        Client:AsControl:Dock = DockStyle:Fill.
                        SplitContainer1:Panel2:Controls:Add(Client:AsControl).
                        SplitContainer1:Dock = DockStyle:Fill.
                        ContentPanel:ClientArea:Controls:Add(SplitContainer1).
                    END.
                    WHEN 1 /* Note: this will be very rare, three aligned clients.. May not ever happen in legacy code. */
                    THEN DO:
                        /* Create the 2nd level split container */
                        SplitContainer2 = NEW System.Windows.Forms.SplitContainer().
                        /* 'Don't try this at home': remove the control embedded in SplitContainers1 from it.. */
                        SplitContainer1:Panel2:Controls:Remove(AlignedClients[1]:AsControl).
                        /* ..and put it on the left side of SplitContainers */
                        SplitContainer2:Panel1:Controls:Add(AlignedClients[1]:AsControl).
                        Client:AsControl:Dock = DockStyle:Fill.
                        SplitContainer2:Panel2:Controls:Add(Client:AsControl).
                        SplitContainer2:Dock = DockStyle:Fill.
                        ContentPanel:ClientArea:Controls:Add(SplitContainer2).
                    END.
                    OTHERWISE DO:
                        RUN gp_msg("Only up to three clients can be aligned.":U).
                        ASSIGN Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Default. /* Revert to floating mode */
                        RETURN Place(Client). /* Beware of infinite recursion.. Should not happen. */
                    END.
                END CASE.

                /* Make a new ToolbarProxy for this object */
                ASSIGN
                    ToolbarProxy = NEW ToolbarProxy()
                    ToolbarProxy:RealProvider = THIS-OBJECT.

                IF THIS-OBJECT:MdiParent <> ?
                THEN ASSIGN ToolbarProxy:RealProvider = GetRealContextualToolbarProviderForMdiChildren().

                IF TYPE-OF(Client, IContextualControl)
                THEN Framework:WindowManager:SetContextualToolbarProvider(CAST(Client, IContextualControl), ToolbarProxy).

                /* Set the 'real' (merge target) context provider of this embedded control to:
                   The MainWMChild's 'real' ContextualToolbarProvider
                */
                /*
                Framework:WindowManager:SetRealContextualToolbarProvider(Client,
                    Framework:WindowManager:GetRealContextualToolbarProvider(MainWMChild)).
                */

                ASSIGN
                    NAlignedClients = NAlignedClients + 1
                    AlignedClients[NAlignedClients] = Client
                    AreaCount = AreaCount + 1.

                ContentPanel:ResumeLayout(TRUE).
            END.

            ASSIGN PlaceResult = TRUE.
        END.

        IF TYPE-OF(Client, IAutoRefreshable)
        THEN CAST(Client, IAutoRefreshable):AutoRefreshChanged:Subscribe(Client_AutoRefreshChanged).
*/
        RETURN PlaceResult.

    END METHOD. /* Place */

    /*****************************************************************************/

    METHOD PUBLIC VOID ShowHelp():

        IF VALID-OBJECT(MainWMChild)
        THEN MainWMChild:ShowHelp().

    END METHOD. /* ShowHelp */

    /*****************************************************************************/

    /* User pressed the F2 button */
    METHOD PUBLIC VOID HandleGo():

        IF VALID-OBJECT(MainWMChild)
        THEN MainWMChild:HandleGo().

    END METHOD. /* HandleGo */

    /*****************************************************************************/

    /** @InheritDoc **/
    METHOD PUBLIC LOGICAL HandleSetChildFormsVisiblity(Visible AS LOGICAL):

        RETURN NO.

    END METHOD. /* HandleSetChildFormsVisiblity */

    /*****************************************************************************/

    METHOD PRIVATE DockAreaPane CreateDockManagerPane(Client AS Control, DockedLocation AS DockedLocation,
        Key AS CHARACTER, AreaKey AS CHARACTER, Caption AS CHARACTER):

        DEFINE VARIABLE Areas AS DockAreasCollection NO-UNDO.
        DEFINE VARIABLE Area AS DockAreaPane NO-UNDO.
        DEFINE VARIABLE Pane AS DockableControlPane NO-UNDO.
        DEFINE VARIABLE ControlSize AS Size NO-UNDO.

        DEFINE VARIABLE TheIndex AS INTEGER NO-UNDO.

        /* ----------------------------------------------------------------------*/

        ASSIGN
            ControlSize = NEW Size(Client:Width, Client:Height)
            Areas = DockManager:DockAreas
            TheIndex = Areas:IndexOf(AreaKey).

        IF TheIndex > -1
        THEN ASSIGN Area = Areas:Item[AreaKey].
        ELSE ASSIGN Area = Areas:Add(DockedLocation, AreaKey).

        IF Area:Panes:Count = 0
        THEN ASSIGN Area:Size = ControlSize.

        ASSIGN
            Pane = NEW DockableControlPane(Key, Caption, Client)
            Pane:FlyoutSize = ControlSize
            Pane:Size = ControlSize
            Pane:IsMdiChild = TRUE.

        &IF DEFINED(DEBUG)
        &THEN
            /* Maybe the form needs to be enlarged before placing it? */
            IF TightCouplingMayEnlargeForm
            THEN DO:
                IF Pane:Size:Width + MainWMChild:AsControl:Size:Width * TightCouplingScalingThreshold >
                    THIS-OBJECT:Size:Width OR Pane:Size:Height > THIS-OBJECT:Size:Height
                THEN RUN gp_msg("Could not place tightly coupled, will have to resize the form.":U).
            END.
        &ENDIF

        /* TODO: perhaps use a more clever heuristic for placing the newly created control. */
        Area:FloatingLocation = NEW Point((AreaCount + 1) * 50 + 50,
            (AreaCount + 1) * 50 + 50).

        Area:Panes:Add(Pane).

        RETURN Area.

    END METHOD. /* CreateDockManagerPane */

    /*****************************************************************************/

    METHOD PUBLIC VOID EnableAutoSize():

        DEFINE VARIABLE AutoSizeControl AS Control NO-UNDO.

        /* --------------------------------------------------------------------- */

        ASSIGN AutoSizeControl = ContentPanel.

        /* Set AutoSize of the ContentPanel and all its predecessors up to the form to have correct AutoSizing behaviour */
        DO WHILE VALID-OBJECT(AutoSizeControl):
            SetAutoSize(AutoSizeControl, TRUE, AutoSizeMode:GrowAndShrink).
            AutoSizeControl = GetAutoSizeParent(AutoSizeControl).
        END.

        ASSIGN AutoSized = TRUE.

    END METHOD. /* SetAutoSize */

    /*****************************************************************************/

    METHOD PUBLIC VOID DisableAutoSize():

        DEFINE VARIABLE AutoSizeControl AS Control NO-UNDO.
        DEFINE VARIABLE MinimumSize AS Size NO-UNDO.
        DEFINE VARIABLE MaximumSize AS Size NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF NOT AutoSized THEN RETURN.

        /* First disable AutoSize on the Form to prevent implosion... */
        ASSIGN AutoSizeControl = THIS-OBJECT.

        DO WHILE VALID-OBJECT(AutoSizeControl):
            /* When disabling AutoSize the Control jumps back to its original size. To prevent this
                we temporarily set it's Minimum/MaximumSize to it's current size so it stays fixed. Afterwards we
                reset the original Minimum/MaximumSize */
            ASSIGN
                MinimumSize = AutoSizeControl:MinimumSize
                MaximumSize = AutoSizeControl:MaximumSize
                AutoSizeControl:MinimumSize = AutoSizeControl:Size
                AutoSizeControl:MaximumSize = AutoSizeControl:Size.

            SetAutoSize(AutoSizeControl, FALSE, AutoSizeMode:GrowOnly).

            ASSIGN
                AutoSizeControl:MinimumSize = MinimumSize
                AutoSizeControl:MaximumSize = MaximumSize
                AutoSizeControl = IF AutoSizeControl = THIS-OBJECT
                    THEN ContentPanel
                    ELSE GetAutoSizeParent(AutoSizeControl).

            IF AutoSizeControl = THIS-OBJECT
            THEN LEAVE.
        END.

        IF VALID-OBJECT(MainWMChild)
        THEN ASSIGN MainWMChild:AsControl:Dock = DockStyle:Fill.

        IF TYPE-OF(MainWMChild, IWindowContainer)
        THEN CAST(MainWMChild, IWindowContainer):DynamicallyResizingClient = TRUE.

        ASSIGN AutoSized = FALSE.

    END METHOD. /* DisableAutoSize */

    /*****************************************************************************/

    METHOD PRIVATE Control GetAutoSizeParent(AutoSizeControl AS Control):

        DEFINE VARIABLE AutoSizeParentControl AS Control NO-UNDO.

        /* --------------------------------------------------------------------- */

        AutoSizeParentControl = AutoSizeControl:Parent.

        /*
          Infragistics doesn't allow us to set the MinimumSize, MaximumSize and AutoSizeMode property of
          an UltraPanelClientArea control. That's why we need to retrieve the parent of the UltraPanelClientArea,
          which is the actual UltraPanel, when we want to get the AutoSizeParentControl (i.e. the first parent control
          to which we can apply these properties).
        */

        IF TYPE-OF(AutoSizeParentControl, UltraPanelClientArea)
        THEN AutoSizeParentControl = AutoSizeParentControl:Parent.

        RETURN AutoSizeParentControl.

    END METHOD. /* GetAutoSizeParent */

    /*****************************************************************************/

    METHOD PRIVATE VOID SetAutoSize(AutoSizeControl AS Control, AutoSize_ AS LOGICAL, AutoSizeMode_ AS AutoSizeMode):

        DEFINE VARIABLE AutoSizeControlClass AS CLASS Class NO-UNDO.
        DEFINE VARIABLE AutoSizeModeProperty AS Property NO-UNDO.
        DEFINE VARIABLE AutoSizeModePropertyName AS CHARACTER NO-UNDO INITIAL "AutoSizeMode":U.

        /* --------------------------------------------------------------------- */

        ASSIGN
            AutoSizeControl:AutoSize = AutoSize_
            AutoSizeControlClass = AutoSizeControl:GetClass()
            AutoSizeModeProperty = AutoSizeControlClass:GetProperty(AutoSizeModePropertyName).
        IF VALID-OBJECT(AutoSizeModeProperty)
        THEN AutoSizeControlClass:SetPropertyValue(AutoSizeControl, AutoSizeModePropertyName, AutoSizeMode_).

    END METHOD. /* SetAutoSize */

    /*****************************************************************************/

//point 4 -ok

    /** {@inheritDoc} */
    METHOD OVERRIDE PROTECTED VOID OnShown(e AS EventArgs):
SUPER:OnShown(e).
RETURN.
        DEFINE VARIABLE SplitterDistance AS INTEGER NO-UNDO.

        /* ----------------------------------------------------------------------*/

        &IF DEFINED(DEBUG)
        &THEN
            IF DesignTime THEN RETURN.
        &ENDIF

        SUPER:OnShown(e).

        /* set the distance of the splitters once everything is loaded (sizing logic resets the distance...) */
/*
        IF VALID-OBJECT(SplitContainer1)
        THEN DO:
            RUN gp_taggi(CachedCustomGeometryData, "SplitterDistance_1":U, TRUE, INPUT-OUTPUT SplitterDistance).
            IF SplitterDistance > 0 THEN ASSIGN SplitContainer1:SplitterDistance  = SplitterDistance.
            SplitContainer1:SplitterMoved:Subscribe(SplitContainer1_SplitterMoved).
        END.
        IF VALID-OBJECT(SplitContainer2)
        THEN DO:
            RUN gp_taggi(CachedCustomGeometryData, "SplitterDistance_2":U, TRUE, INPUT-OUTPUT SplitterDistance).
            IF SplitterDistance > 0 THEN ASSIGN SplitContainer2:SplitterDistance  = SplitterDistance.
            SplitContainer2:SplitterMoved:Subscribe(SplitContainer2_SplitterMoved).
        END.
*/
    END METHOD. /* OnShown */

    /*****************************************************************************/

    /**
     * Excerpt from MSDN:
     *
     *  http://msdn.microsoft.com/en-us/library/system.windows.forms.form.formclosing.aspx
     *  If the form is a multiple-document interface (MDI) parent form, the FormClosing events
     *  of all MDI child forms are raised before the MDI parent form's FormClosing event is raised.
     *  Likewise, the FormClosed events of all MDI child forms are raised before the FormClosed event
     *  of the MDI parent form is raised. Canceling the FormClosing event of an MDI child form does
     *  not prevent the FormClosing event of the MDI parent form from being raised. However, canceling
     *  the event will set to true the Cancel property of the FormClosingEventArgs class that is passed
     *  as a parameter to the parent form. To force all MDI parent and child forms to close, set the Cancel
     *  property to false in the MDI parent form.
     **/
    METHOD OVERRIDE PROTECTED VOID OnFormClosing(e AS FormClosingEventArgs):
 SUPER:OnFormClosing(e).
 RETURN.
 /*       DEFINE VARIABLE PreviousModalityMode AS ModalityMode NO-UNDO.

        /* ----------------------------------------------------------------------*/

        ASSIGN IsClosing = TRUE.

        /* If the Closing event is already cancelled, then don't bother with the rest of the logic.
           We return here because .NET will call OnFormClosing for any floating child forms of our
           MDI child forms even when the event is cancelled, with CloseReason:OwnerFormClosing */
        IF e:Cancel = TRUE
        THEN RETURN.

        /* MDI child forms will receive CloseReason:MdiFormClosing when ApplicationForm is closed.
           In that case, we cancel the event so that the MDI child is not automatically closed.
           Either way, eventually .NET will call ApplicationForm:OnFormClosing which shows ExitDialog ;
           if you cancel there, nothing has been closed ; if you proceed there, the MDI child forms
           will go through another OnFormClosing round but with CloseReason:UserClosing */
        IF e:CloseReason = CloseReason:MdiFormClosing
        THEN DO:
            ASSIGN e:Cancel = TRUE.
            RETURN.
        END.

        /* If the WorkflowForm is disabled, then closing it is always canceled.
           How can you close a WorkflowForm when it's disabled?
           - A tabbed WorkflowForm is not disabled, only its contents are. So it's still possible to either click the
             X in the tab or press Escape when it has focus.
           - You can still give focus to floatable WorkflowForms by selecting it in the task bar. Pressing Escape
             afterwards tries to close the WorkflowForm. */
        IF ContentPanel:Enabled = FALSE
        THEN DO:
            ASSIGN e:Cancel = TRUE.
            RETURN.
        END.

        /* If this is one of the MDI tabs, then we must Activate the form first
           otherwise the ApplicationForm ribbon contextual tab groups go haywire */
        IF e:CloseReason = CloseReason:UserClosing
            AND MdiParent <> ?
        THEN Activate().

        /* When the form is closing (either by the user (click X or ALT-F4 etc.) or by code (Close())), and this is NOT
           originating from the classic code, then we start a Timer to apply a END-ERROR to the FRAME. That way we can
           break the WAIT-FOR some classic screens can't seem to get out of. */
        IF NOT ClosingUsingTimer AND VALID-OBJECT(MainWMChild) AND TYPE-OF(MainWMChild, IWindowContainer)
            AND NOT CAST(MainWMChild, IWindowContainer):IsClosing
        THEN DO:
            ScheduleTimer("CloseWindowContainer":U).
            ASSIGN e:Cancel = TRUE. /* Cancel the FormClosing event and let the Tick initiate a close from the classic
            framework. This will eventually call Close() on the .net side too */
            RETURN.
        END.

        SUPER:OnFormClosing(e).
        IF e:Cancel
        THEN RETURN.

        IF e:CloseReason = CloseReason:UserClosing
        THEN DO ON ERROR UNDO, THROW:
            ASSIGN PreviousModalityMode = ModalityMode.
            IF ModalityMode <> be.mips.ablframework.gui.ModalityMode:None
            THEN Framework:WindowManager:SetModality(THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).
            /* Resetting modality needs to be done before dropping the object, since the object is needed in SetModality */
            Framework:WindowManager:DropObjectForParent(MainWMChild).
            CATCH err AS Progress.Lang.Error:
                IF PreviousModalityMode <> ModalityMode
                THEN Framework:WindowManager:SetModality(THIS-OBJECT, PreviousModalityMode).
                ASSIGN e:Cancel = TRUE.
            END CATCH.
        END.
        ELSE ASSIGN e:Cancel = TRUE.

        FINALLY:
            ASSIGN IsClosing = FALSE.
        END.
*/
    END METHOD. /* OnFormClosing */

    /*****************************************************************************/

    /** {@inheritDoc} */
    METHOD OVERRIDE PROTECTED VOID OnFormClosed(e AS System.Windows.Forms.FormClosedEventArgs):
 SUPER:OnFormClosed(e).
 RETURN.
        /* OpenEdge bug, case 00430406:
            When showing the Form as Dialog (ShowDialog), and DisposeDialogOnClose is true (default), then the Dispose()
            is called by OpenEdge when doing SUPER:OnFormClosed(), but this is too soon, as SaveGridLayout() in
            DynamicBrowser is called as response to FormClosed, but the grid is already disposed...
            Workaround: postpone the dispose until the end of this method. Not ideal sinceMicrosoft calls dispose AFTER
            Close() (but we can't do that), and an inherited class can still do things after this... Be careful and hope
            for a fix from Progress... */
 /*       DEFINE VARIABLE DisposeOnClose AS LOGICAL NO-UNDO.

        /* --------------------------------------------------------------------- */

        IF Modal AND DisposeDialogOnClose
        THEN ASSIGN
                DisposeOnClose = TRUE
                DisposeDialogOnClose = FALSE.

        ASSIGN IsClosed = TRUE.

        /* The unsubscribe must be executed before the SUPER is called, because some child controls are not available anymore.*/
        UnsubscribeNonAsciiInputChecker().

        SUPER:OnFormClosed(e).

        IF VALID-OBJECT(MainWMChild)
        THEN DO:
            IF VALID-OBJECT(MainWMChild:AsControl)
            THEN MainWMChild:AsControl:Dispose(). /* In Siemens UI (CentraLink) this seems to cause an Activate of the Form... */
            DELETE OBJECT MainWMChild.
        END.

        IF VALID-OBJECT(AlignedClients[1])
        THEN DELETE OBJECT AlignedClients[1].

        IF VALID-OBJECT(AlignedClients[2])
        THEN DELETE OBJECT AlignedClients[2].

        CleanupSubtitleProvider().
        CleanupFormTimer().

        IF DisposeOnClose
        THEN Dispose().
*/
    END METHOD. /* OnFormClosed */

    /*****************************************************************************/

    METHOD PUBLIC VOID CloseOnTimeout():
/*
        /* This method is supposed to be called on Context timeout, for each form that needs to be closed (last ones first).
           See ApplicationForm:CloseOpenForms(). */
        ASSIGN CloseOnTimeout = TRUE.

        IF VALID-OBJECT(MainWMChild) AND TYPE-OF(MainWMChild, IWindowContainer)
        THEN CloseWindowContainer().
        ELSE Framework:WindowManager:DropObjectForParent(MainWMChild).

        FINALLY:
            ASSIGN CloseOnTimeout = FALSE.
        END FINALLY.
*/
    END METHOD. /* CloseOnTimeout */

    /*****************************************************************************/
//point 5 restart ok

    /** {@inheritDoc} */
    METHOD OVERRIDE PROTECTED VOID OnKeyDown(e AS KeyEventArgs):

        SUPER:OnKeyDown(e).

        /**
         * We catch the Escape key on the WorkflowForm instead of on individual controls. Setting handled to true
         * stops the event from being triggered on the individual controls.
         */
        IF NOT e:Handled
        THEN DO:
            CASE TRUE:
                WHEN e:KeyCode = Keys:Escape
                THEN DO:
                    Close().
                    e:Handled = TRUE.
                END.

                WHEN e:KeyCode = Keys:F1
                THEN DO:
                    ShowHelp().
                    e:Handled = TRUE.
                END.

                WHEN e:KeyCode = Keys:F2
                THEN HandleGo().
            END CASE.
        END.

    END METHOD. /* OnKeyDown */

    /*****************************************************************************/

    /** {@inheritDoc} */
    METHOD OVERRIDE PROTECTED VOID OnLoad(e AS EventArgs):
SUPER:OnLoad(e).
RETURN.

        &IF DEFINED(DEBUG)
        &THEN
            IF DesignTime THEN RETURN.
        &ENDIF

        /* If the form is closing, no need to execute the logic. */
        IF AlreadyLoaded OR IsClosing THEN RETURN.

        DisableAutoSize().
      //  CalculateFormBorderSizes().
        ComputeAndApplyMinMaxSize().

        SUPER:OnLoad(e).

        IF VALID-OBJECT(SideAreaTimer)
        THEN SideAreaTimer:Start().

        ASSIGN AlreadyLoaded = TRUE.

    END METHOD. /* OnLoad */
//point 6 ok restart ok
    /*****************************************************************************/
/*start problem
    /** {@inheritDoc} */
    METHOD OVERRIDE PROTECTED VOID OnResize(e AS EventArgs):

SUPER:OnResize(e).
RETURN.
        DEFINE VARIABLE WindowContainer AS IWindowContainer NO-UNDO.

        /* ----------------------------------------------------------------------*/

        &IF DEFINED(DEBUG)
        &THEN
            IF DesignTime THEN RETURN.
        &ENDIF

        SUPER:OnResize(e).

        /* When using MDI tab groups (split horizontal/vertical) the classic frames aren't automatically resized to fit.
           that's because 'WindowContainer:DynamicallyResizingClient' has value NO.
           We can set the value from DynamicallyResizingClient to YES and call the method DynamicallyChangeClientSize
           to solve this issue. See incident 1304-0408*/
        IF VALID-OBJECT(MainWMChild) AND TYPE-OF(MainWMChild, IWindowContainer)
        THEN DO:
            IF VALID-OBJECT(LastFittedSize) AND LastFittedSize <> Size
            THEN DO:
                ASSIGN
                    WindowContainer = CAST(MainWMChild, IWindowContainer)
                    WindowContainer:DynamicallyResizingClient = YES.
                WindowContainer:DynamicallyChangeClientSize().
            END.
        END.

    END METHOD. /* OnResize */
*/ //end problem
    /*****************************************************************************/

    /**
     * OnActivated is triggered each time the tab gets focus. Also when:
     * - The Form is created
     * - Alt-tabbing back and forth.
     * - Clicking from a Floating Form onto a tab.
     */
    METHOD PROTECTED OVERRIDE VOID OnActivated(e AS EventArgs):
 SUPER:OnActivated(e).
 RETURN.
 /*       &IF DEFINED(DEBUG)
        &THEN
            IF DesignTime THEN RETURN.
        &ENDIF

        SUPER:OnActivated(e).

        IF IsClosing OR IsClosed THEN RETURN.

        IF MdiParent = ? /* Set the floating form as the highest form in the current hierarchic branch */
        THEN Framework:WindowManager:SetClientZOrderFrontMost(THIS-OBJECT).
        ELSE DO:
            /* Control is dynamically resizing */
            IF VALID-OBJECT(MainWMChild) AND TYPE-OF(MainWMChild, IWindowContainer)
            THEN DO:
                CAST(MainWMChild, IWindowContainer):DynamicallyResizingClient = TRUE.
                IF VALID-OBJECT(LastFittedSize) AND LastFittedSize <> Size
                THEN CAST(MainWMChild, IWindowContainer):DynamicallyChangeClientSize().
            END.
            /* Postpone actual showing to the next event handling loop */
            ScheduleTimer("ShowFloatingForms":U).
        END.

        IF VALID-OBJECT(MainWMChild)
        THEN DO:
            IF TYPE-OF(MainWMChild, IContextualControl)
            THEN Framework:WindowManager:ActivateObjectContext(MainWMChild).
            /* Using Focus instead of Select doesn't give focus to floating new browsers... */
            MainWMChild:AsControl:Select().
        END.
*/
    END METHOD. /* OnActivated */

    /*****************************************************************************/

    /**
     * Triggered when
     * - Changing focus from this WorkflowForm to another.
     * - Closing the WorkflowForm.
     * - Creating a floating WorkflowForm because at given moment focus is set on MainWMClient.
     * - Focus is on Floatable Form, and you click on another tab than the one that's currently selected. In this case
     *   you'll get a OnDeactivate for the floating Form and for the tab Form that was selected.
     */
    METHOD PROTECTED OVERRIDE VOID OnDeactivate(e AS EventArgs):
  SUPER:OnDeactivate(e).
  RETURN.
 /*       &IF DEFINED(DEBUG)
        &THEN
            IF DesignTime THEN RETURN.
        &ENDIF

        SUPER:OnDeactivate(e).

        IF MdiParent = ? OR IsClosing THEN RETURN.

        IF VALID-OBJECT(MainWMChild)
        THEN DO:
            /* Actually this is only need when switching from a tab to the Home tab. Without this code,
               the contextual ribbon tabs from the previous tab will remain visible... */
            IF TYPE-OF(MainWMChild, IContextualControl)
            THEN Framework:WindowManager:DeactivateObjectContext(MainWMChild).

            /* Control is no longer dynamically resizing */
            IF TYPE-OF(MainWMChild, IWindowContainer)
            THEN DO:
                CAST(MainWMChild, IWindowContainer):DynamicallyResizingClient = FALSE.
                LastFittedSize = Size.
            END.
        END.

        /* Postpone actual hiding to the next event handling loop */
        ScheduleTimer("HideFloatingForms":U).
*/
    END METHOD. /* OnDeactivate */

  //end problem

    /*****************************************************************************/

    /* Using a Timer allows the FormClosing event to complete. Instead of executing the code inside the FormClosing
    event, it gets executed immediatelly after in a Tick event. This helps to break some hard to crack WAIT-FORs (eg.
    crsp_src.p) */
    METHOD PRIVATE VOID CloseWindowContainer():

        DEFINE VARIABLE WindowContainer AS IWindowContainer NO-UNDO.
        DEFINE VARIABLE FrameHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE ProcedureHandle AS HANDLE NO-UNDO.

        /* ----------------------------------------------------------------------*/

        ASSIGN WindowContainer = CAST(MainWMCHild, IWindowContainer).

        IF CloseOnTimeOut /* Close without questions on ContextTimeout */
        THEN DO:
            ASSIGN ProcedureHandle = WindowContainer:ProcedureHandle.
            Framework:WindowManager:DropObjectForParent(ProcedureHandle).
        END.
        ELSE DO:
            ASSIGN
                FrameHandle = WindowContainer:FrameHandle
                ClosingUsingTimer = TRUE.
            IF VALID-HANDLE(FrameHandle)
            THEN APPLY "END-ERROR":U TO FrameHandle.
            ELSE Close(). /* If the frame is already gone we should close the Form or it will stay open forever... */
        END.

        FINALLY:
            ASSIGN ClosingUsingTimer = FALSE.
        END.

    END METHOD. /* CloseWindowContainer */

    /*****************************************************************************/

    METHOD PRIVATE VOID DockManager_BeforeDockChange(sender AS Object, e AS BeforeDockChangeEventArgs):

        ASSIGN e:Cancel = TRUE. /* Disallow dock changes. */

    END METHOD. /* DockManager_BeforeDockChange*/

    /*****************************************************************************/

    METHOD PRIVATE VOID OptionsButton_Click(sender AS Object, e AS EventArgs):

        /* Focus problem: First select the MainWMChild before show options.
           This because the OnEnter is not triggered when the option window is closed and focus stays on OptionsButton */
        IF VALID-OBJECT(MainWMChild)
        THEN DO:
            MainWMChild:AsControl:Select().
            IF VALID-OBJECT(MainWMChild:OptionsProvider)
            THEN MainWMChild:OptionsProvider:ShowOptions().
        END.

    END METHOD. /* OptionsButton_Click */

    /*****************************************************************************/

    /**
     * MainWMClient SubtitleProvider SubtitleChanged event handler (Demeter law kind off ignored here)
     */
/*    METHOD PRIVATE VOID SubtitleProvider_SubtitleChanged(sender AS Object, e AS SubtitleChangedEventArgs):

        SetSubtitle(e:Subtitle).

    END METHOD. /* SubtitleProvider_SubtitleChanged */
*/
    /*****************************************************************************/

    METHOD PRIVATE VOID SetSubtitle(Subtitle AS CHARACTER):

  //      ASSIGN SubtitleLabel:Text = SUBSTRING(REPLACE(Subtitle, "~n":U, " ":U), 1, 250, "CHARACTER":U).
  //      OnSubtitleChanged(NEW SubtitleChangedEventArgs(SubtitleLabel:Text)).

    END METHOD. /* SetSubtitle */

    /*****************************************************************************/
/*
    METHOD PROTECTED VOID OnSubtitleChanged(e AS SubtitleChangedEventArgs):

        SubtitleChanged:Publish(THIS-OBJECT, e).

    END METHOD. /* OnSubtitleChanged */
*/
    /*****************************************************************************/
/*
    METHOD PRIVATE VOID SideAreaTimer_Tick(sender AS Object, e AS EventArgs):

        SideAreaTimer:Stop().
        ASSIGN
            SideAreaTimer = ?
            DockManager:AnimationEnabled = TRUE
            DockManager:Visible = TRUE.

    END METHOD. /* SideAreaTimer_Tick */
*/
    /*****************************************************************************/

    METHOD PRIVATE VOID Client_VisibleChanged(sender AS Object, e AS EventArgs):

        /* LDF: my best guess for the code here is:
           Once the client is made visible, it can start to react on size changes of the WorkflowForm (only needed for
           classic UI, .NET controls can do this pretty much automatically (classic needs gp_size for this) */
        IF MdiParent <> ?
        THEN Framework:WindowManager:SetDynamicallySizeClient(MainWMChild, TRUE).

    END METHOD. /* Client_VisibleChanged */

    /*****************************************************************************/

    METHOD PRIVATE VOID DockManager_BeforeSplitterDrag(sender AS Object, e AS CancelablePanesEventArgs):

        /* No, you may not. */
        ASSIGN e:Cancel = TRUE.

    END METHOD. /* DockManager_BeforeSplitterDrag */

    /*****************************************************************************/

    /**
     * A workflowform is always contextual, so nothing can be added to the QuickAccessToolbar.
     */
    METHOD PRIVATE VOID ToolbarsManager_BeforeToolbarListDropdown(sender AS Object,
        e AS BeforeToolbarListDropdownEventArgs):

        ASSIGN e:Cancel = TRUE.

    END METHOD. /* ToolbarsManager_BeforeToolbarListDropdown */

    /*****************************************************************************/

    METHOD PRIVATE VOID SplitContainer1_SplitterMoved(sender AS Object, e AS EventArgs):

        RUN gp_tagpi("SplitterDistance_1":U, SplitContainer1:SplitterDistance, INPUT-OUTPUT CachedCustomGeometryData).

    END METHOD. /* splitContainers_1_SplitterMoved */

    /* *************************************************************************** */

    METHOD PRIVATE VOID SplitContainer2_SplitterMoved(sender AS Object, e AS EventArgs):

        RUN gp_tagpi("SplitterDistance_2":U, SplitContainer2:SplitterDistance, INPUT-OUTPUT CachedCustomGeometryData).

    END METHOD. /* splitContainers_2_SplitterMoved */

    /*****************************************************************************/

   /* METHOD PRIVATE VOID FormTimer_Tick(sender AS Object, e AS EventArgs):

        DEFINE VARIABLE FormTimerParams AS FormTimerParams NO-UNDO.

        /* ----------------------------------------------------------------------*/

        /* stop the timer right away to avoid multiple executions */
        FormTimer:Stop().

        IF TYPE-OF(FormTimer:Tag, FormTimerParams)
        THEN ASSIGN FormTimerParams = CAST(FormTimer:Tag, FormTimerParams).

        IF VALID-OBJECT(FormTimerParams)
        THEN DO:
            CASE FormTimerParams:Params:
                WHEN "CloseWindowContainer":U THEN CloseWindowContainer().
                WHEN "HideFloatingForms":U THEN HideFloatingForms().
                WHEN "ShowFloatingForms":U THEN ShowFloatingForms().
                WHEN "ShowMessageBox":U THEN ShowMessageBox(FormTimerParams:SubParams).
            END CASE.
        END.

        /* set FormTimer:Tag to ? because we do not use it any more and FormTimer will get a new tag once it is started again */
        IF VALID-OBJECT(FormTimer)
        THEN ASSIGN FormTimer:Tag = ?.

    END METHOD. /* FormTimer_Tick */
*/
    /*****************************************************************************/

    METHOD PRIVATE VOID Client_AutoRefreshChanged(sender AS Progress.Lang.Object, e AS AutoRefreshChangedEventArgs):

        DEFINE VARIABLE AutoRefreshSuffix AS CHARACTER NO-UNDO.
        DEFINE VARIABLE CurrentTitle AS CHARACTER NO-UNDO.

        /* ----------------------------------------------------------------------*/

        ASSIGN
            AutoRefreshSuffix = " (":U + "Auto refresh":T30 + ")":U
            CurrentTitle = THIS-OBJECT:Subtitle.

        IF e:AutoRefresh
        THEN DO:
            IF INDEX(CurrentTitle, AutoRefreshSuffix) = 0
            THEN ASSIGN CurrentTitle = CurrentTitle + AutoRefreshSuffix.
        END.
        ELSE DO:
            IF INDEX(CurrentTitle, AutoRefreshSuffix) > 0
            THEN ASSIGN CurrentTitle = REPLACE(CurrentTitle, AutoRefreshSuffix, "":U).
        END.
        SetSubtitle(CurrentTitle).

    END METHOD. /* Client_AutoRefreshChanged */

    /*****************************************************************************/

    METHOD PUBLIC VOID CloseClient():

        /* In case of Master/Detail Query, the classic Detail will try to close the Master (gp_brw:CloseMasterQuery),
           resulting in the WorkflowForm to be closed, while the Detail window is still there, causing warning 16679.
           We can prevent this by keeping the WorkflowForm open and closing it when the Detail closes. */
        IF NAlignedClients > 0
        THEN DO:
            IF (VALID-OBJECT(AlignedClients[1]) AND TYPE-OF(AlignedClients[1], IWindowContainer) OR
                VALID-OBJECT(AlignedClients[2]) AND TYPE-OF(AlignedClients[2], IWindowContainer))
            THEN DO:
                ASSIGN NAlignedClients = NAlignedClients - 1.
                RETURN.
            END.
        END.

        IF NOT IsClosing
        THEN DO:
            /* From MSDN: The two conditions when a form is not disposed on Close is when (1) it is part
               of a multiple-document interface (MDI) application, and the form is not visible; and (2)
               you have displayed the form using ShowDialog. In these cases, you will need to call Dispose
               manually to mark all of the form's controls for garbage collection.

               This means that when the WorkflowForm has never been set Visible, the OnLoad hasn't been
               executed and when Closing the WorkflowForm, the FormClosing event won't be triggered. As
               as result, the ELSE logica of this IF ELSE block wouldn't be called.

               So that's why we first set it to visible.
            */
            ASSIGN IsClosing = TRUE. /* Set to true so that the logic in the OnLoad isn't executed. */
            IF NOT Visible
            THEN ASSIGN Visible = TRUE.
            Close().
        END.

    END METHOD. /* CloseClient */

    /*****************************************************************************/

 /*   METHOD PRIVATE VOID CleanupFormTimer():

        IF VALID-OBJECT(FormTimer)
        THEN DO:
            FormTimer:Stop().
            FormTimer:Tick:Unsubscribe(FormTimer_Tick).
            ASSIGN
                FormTimer:Tag = ?
                FormTimer = ?.
        END.

    END METHOD. /* CleanupFormTimer */
*/
    /*****************************************************************************/

    METHOD PRIVATE VOID CleanupSubtitleProvider():
/*
        IF VALID-OBJECT(SubtitleProvider)
        THEN DO:
            SubtitleProvider:SubtitleChanged:Unsubscribe(SubtitleProvider_SubtitleChanged).
            DELETE OBJECT SubtitleProvider.
        END.
*/
    END METHOD. /* CleanupSubtitleProvider */

    /*****************************************************************************/

    METHOD PRIVATE VOID ToolbarsManager_ToolClick(sender AS Object, e AS ToolClickEventArgs):

        OnToolClick(e).

    END METHOD. /* ToolbarsManager_ToolClick */

    /*****************************************************************************/

    METHOD PROTECTED VOID OnToolClick(e AS ToolClickEventArgs):

    //    ToolClick:Publish(THIS-OBJECT, e).

    END METHOD. /* OnToolClick */

    /*****************************************************************************/

    METHOD PRIVATE VOID ToolbarsManager_ToolValueChanged(sender AS Object, e AS ToolEventArgs):

        OnToolValueChanged(e).

    END METHOD. /* ToolbarsManager_ToolValueChanged */

    /*****************************************************************************/

    METHOD PROTECTED VOID OnToolValueChanged(e AS ToolEventArgs):

//        ToolValueChanged:Publish(THIS-OBJECT, e).

    END METHOD. /* OnToolValueChanged */

    /*****************************************************************************/

    METHOD PRIVATE VOID NonAsciiInputChecker_InputBlocked(sender AS Progress.Lang.Object, e AS InputBlockedEventArgs):

/*        DEFINE VARIABLE UltraTextEditorControl AS UltraTextEditor NO-UNDO.
        DEFINE VARIABLE InputChangingEventArgs AS InputChangingEventArgs NO-UNDO.
        DEFINE VARIABLE InputChangedEventArgs AS InputChangedEventArgs NO-UNDO.
        DEFINE VARIABLE InputBlockingMessage AS CHARACTER NO-UNDO.

        /*-----------------------------------------------------------------------*/

        IF TYPE-OF(e:EventTrigger, InputChangingEventArgs)
        THEN DO:
            InputChangingEventArgs = CAST(e:EventTrigger, InputChangingEventArgs).

            RUN gp_gerr("GP$NonAsciiUIBlocked":U, InputChangingEventArgs:InputValue, OUTPUT InputBlockingMessage).
            ScheduleTimer(NEW FormTimerParams("ShowMessageBox":U, InputBlockingMessage)).
        END.
        ELSE IF TYPE-OF(e:EventTrigger, InputChangedEventArgs)
        THEN DO:
            InputChangedEventArgs = CAST(e:EventTrigger, InputChangedEventArgs).
            UltraTextEditorControl = CAST(sender, UltraTextEditor).

            UltraTextEditorControl:Text = ?.

            RUN gp_gerr("GP$NonAsciiUICleared":U, e:BlockedText, OUTPUT InputBlockingMessage).
            ScheduleTimer(NEW FormTimerParams("ShowMessageBox":U, InputBlockingMessage)).
        END.
        */
    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID ShowMessageBox(MessageToShow AS CHARACTER):

        MessageBox:Show(MessageToShow).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID UnsubscribeNonAsciiInputChecker():

        IF DisallowNonAsciiDataInUI
        THEN DO:
            NonAsciiInputChecker:UnsubscribeFromEvents(THIS-OBJECT).
            NonAsciiInputChecker:InputBlocked:Unsubscribe(NonAsciiInputChecker_InputBlocked).
        END.

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID CalculateFormBorderSizes():

        ASSIGN
            FormBorderWidth = Width - ContentPanel:Width
            FormBorderHeight = (Height - ContentPanel:Height).

        /*
         * Sometimes, when placing a small classic client, the calculation of FormBorderHeight goes wrong (the Ribbon
         * is not taken into account)
         * In case the Ribbon is visible but the FormBorderHeight appears to be less than 120 pixels (RibbonHeight),
         * we add 120 to get this corrected...
         */
        IF VALID-OBJECT(ToolbarsManager) AND VALID-OBJECT(ToolbarsManager:Ribbon) AND ToolbarsManager:Ribbon:Visible AND FormBorderHeight < 120
        THEN ASSIGN FormBorderHeight = FormBorderHeight + 120.

    END METHOD. /* CalculateFormBorderSizes */

    /*****************************************************************************/

    METHOD PRIVATE VOID ShowStatusBarIfNeeded(Client AS IWindowManagerClient):

        /* There might be other types needing a StatusBar as well. Either way, when a Client tries to show something
            in the StatusBar, it becomes Visible if needed. Doing it here is only needed to ensure correct border size
            calculations... */
        IF Client:Type = WindowManagerClientType:Browser OR Client:Type = WindowManagerClientType:Editor
        THEN ASSIGN GetObjectStatusBar():Visible = TRUE.

    END METHOD. /* ShowStatusBar */

    /*****************************************************************************/
/*
    METHOD PROTECTED {&ABSTRACT} UltraLabel GetSubtitleLabel(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraButton GetOptionsButton(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraToolbarsManager GetToolbarsManager(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraPanel GetContentPanel(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraPanel GetOptionsAndSubtitlePanel(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraDockManager GetDockManager(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} UltraToolbarsDockArea GetDockAreaTop(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} IContextualToolbarProvider GetRealContextualToolbarProviderForMdiChildren(){&EndMethod}.
    METHOD PROTECTED {&ABSTRACT} IObjectStatusBar GetObjectStatusBar(){&EndMethod}.
    METHOD PUBLIC {&ABSTRACT} VOID SetContextEnabled(Enabled AS LOGICAL){&EndMethod}.
    METHOD PUBLIC {&ABSTRACT} VOID SetToolEnabled(ToolKey AS CHARACTER, Enabled AS LOGICAL){&EndMethod}.
    METHOD PUBLIC {&ABSTRACT} VOID HideContent(){&EndMethod}.
    METHOD PUBLIC {&ABSTRACT} VOID ShowContent(){&EndMethod}.*/

    METHOD PROTECTED UltraLabel GetSubtitleLabel(): END.
    METHOD PROTECTED UltraButton GetOptionsButton(): END.
    METHOD PROTECTED UltraToolbarsManager GetToolbarsManager(): END.
    METHOD PROTECTED  UltraPanel GetContentPanel(): END.
    METHOD PROTECTED UltraPanel GetOptionsAndSubtitlePanel(): END.
    METHOD PROTECTED  UltraDockManager GetDockManager(): END.
    METHOD PROTECTED  UltraToolbarsDockArea GetDockAreaTop(): END.
    METHOD PROTECTED  IContextualToolbarProvider GetRealContextualToolbarProviderForMdiChildren(): END.
    METHOD PROTECTED  IObjectStatusBar GetObjectStatusBar(): END.
    METHOD PUBLIC VOID SetContextEnabled(Enabled AS LOGICAL): END.
    METHOD PUBLIC  VOID SetToolEnabled(ToolKey AS CHARACTER, Enabled AS LOGICAL): END.
    METHOD PUBLIC  VOID HideContent(): END.
    METHOD PUBLIC VOID ShowContent(): END.



END CLASS.
