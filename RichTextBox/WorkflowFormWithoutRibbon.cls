
 /*------------------------------------------------------------------------
    File        : WorkflowFormWithoutRibbon
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu May 24 10:02:16 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.Misc.UltraButton FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraLabel FROM ASSEMBLY.
USING Infragistics.Win.Misc.UltraPanel FROM ASSEMBLY.
USING Infragistics.Win.UltraWinDock.UltraDockManager FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea FROM ASSEMBLY.
USING Infragistics.Win.UltraWinToolbars.UltraToolbarsManager FROM ASSEMBLY.
USING System.EventArgs FROM ASSEMBLY.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING System.Windows.Forms.FormClosingEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.Padding FROM ASSEMBLY.
USING be.mips.ablframework.Framework FROM PROPATH.
USING be.mips.ablframework.gui.IWindowManagerClient FROM PROPATH.
USING be.mips.ablframework.gui.WorkflowFormBase FROM PROPATH.
USING be.mips.ablframework.gui.context.IContextualToolbarProvider FROM PROPATH.
USING be.mips.ablframework.gui.statusbar.IObjectStatusBar FROM PROPATH.
USING Playground.RichTextBox.MyWorkflowForm FROM PROPATH.
USING Playground.RichTextBox.MyWorkflowFormWithNothing FROM PROPATH.

//CLASS be.mips.ablframework.gui.WorkflowFormWithoutRibbon INHERITS PROGRESS.Windows.Form: ok

//CLASS be.mips.ablframework.gui.WorkflowFormWithoutRibbon INHERITS WorkflowFormBase: /*MyWorkflowForm:*/

CLASS Playground.RichTextBox.WorkflowFormWithoutRibbon INHERITS MyWorkflowForm:
//CLASS Playground.RichTextBox.WorkflowFormWithoutRibbon INHERITS MyWorkflowFormWithNothing: //ok


    DEFINE PRIVATE VARIABLE ContentPanel AS UltraPanel NO-UNDO.



    DEFINE PUBLIC PROPERTY MyContentPanel AS UltraPanel NO-UNDO
    GET(): RETURN THIS-OBJECT:ContentPanel. END.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC WorkflowFormWithoutRibbon (  ):
        SUPER ().

        THIS-OBJECT:ContentPanel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ContentPanel:Dock = DockStyle:FILL.
        THIS-OBJECT:ContentPanel:Margin = NEW System.Windows.Forms.Padding(0).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ContentPanel).

    END CONSTRUCTOR.

  /*  METHOD OVERRIDE PROTECTED VOID OnResize(e AS EventArgs):
    END.*/
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    DESTRUCTOR PUBLIC WorkflowFormWithoutRibbon ( ):

    END DESTRUCTOR.

/*
    METHOD PROTECTED OVERRIDE UltraLabel GetSubtitleLabel():

        RETURN ?.

    END METHOD. /* GetSubtitleLabel */

    METHOD PROTECTED OVERRIDE UltraButton GetOptionsButton():

        RETURN ?.

    END METHOD. /* GetOptionsButton */

    METHOD PROTECTED OVERRIDE UltraToolbarsManager GetToolbarsManager():

        RETURN ?.

    END METHOD. /* GetToolbarsManager */

    METHOD PROTECTED OVERRIDE UltraPanel GetContentPanel():

        RETURN THIS-OBJECT:ContentPanel.

    END METHOD. /* GetContentPanel */

    METHOD PROTECTED OVERRIDE UltraPanel GetOptionsAndSubtitlePanel():

        RETURN ?.

    END METHOD. /* GetOptionsAndSubtitlePanel */

    METHOD PROTECTED OVERRIDE UltraDockManager GetDockManager():

        RETURN ?.

    END METHOD. /* GetDockManager */

    METHOD PROTECTED OVERRIDE UltraToolbarsDockArea GetDockAreaTop():

        RETURN ?.

    END METHOD. /* GetDockAreaTop */

    METHOD PROTECTED OVERRIDE IContextualToolbarProvider GetRealContextualToolbarProviderForMdiChildren():

        RETURN ?.

    END METHOD. /* GetRealContextualToolbarProviderForMdiChildren */

    METHOD PROTECTED OVERRIDE IObjectStatusBar GetObjectStatusBar():

        RETURN ?.

    END METHOD. /* GetObjectStatusBar */

    METHOD PUBLIC OVERRIDE VOID ShowContent():


    END METHOD.

    METHOD PUBLIC OVERRIDE VOID HideContent():


    END METHOD.

    METHOD PUBLIC OVERRIDE VOID SetContextEnabled(Enabled AS LOGICAL):

    END METHOD. /* SetContextEnabled */

    /*****************************************************************************/

    METHOD PUBLIC OVERRIDE VOID SetToolEnabled(ToolKey AS CHARACTER, Enabled AS LOGICAL):

    END METHOD. /* SetToolEnabled */

    METHOD PUBLIC OVERRIDE VOID AfterConstructor():
      //  ASSIGN ModalityMode = be.mips.ablframework.gui.ModalityMode:None.
      //  Framework:FormGeometryManager:RegisterForm(THIS-OBJECT).
    END.


    METHOD PUBLIC OVERRIDE LOGICAL Place(Client AS IWindowManagerClient):

        DEFINE VARIABLE PlaceResult AS LOGICAL NO-UNDO INITIAL FALSE.
        DEFINE VARIABLE TheControl AS System.Windows.Forms.control NO-UNDO.

        /* ----------------------------------------------------------------------*/

        /* If this is the first control, we should fill the entire form with it. */
        ASSIGN TheControl= Client:AsControl.

        IF NOT VALID-OBJECT(MainWMChild)
        THEN DO:

            TheControl:Margin = NEW Padding(0). /* To ensure AutoSize works correctly, remove any Margin */
            TheControl:Dock = DockStyle:FILL.
            ContentPanel:ClientArea:Controls:Add(Client:AsControl).
            //THIS-OBJECT:Controls:ADD(TheControl).

            ASSIGN MainWMChild = Client. /* MainWMChild needs to be set as it is used by DisableAutoSize */



            //TheControl:VisibleChanged:Subscribe(Client_VisibleChanged).


            ASSIGN PlaceResult = TRUE.
        END.
        ELSE DO:
            /* Floating mode?
                - If the WIndowManager state explicitly is set to "Floating"
                - If there is already a docked child (TODO: multiple tightly coupleds?)
                - If this already is a floating form
                - If this is a floating form (no MDIChild)
             */
         /*   IF Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Default OR
                Framework:WindowManager:PlaceMode = WindowManagerPlaceMode:Docking
                OR VALID-OBJECT(TightlyCoupledClient)
                OR MdiParent = ?
            THEN DO:
                /* Creates and places the form... */
                Framework:Factories:FormFactory:CreateFloatingWorkflowForm(Client).
                ASSIGN AreaCount = AreaCount + 1.
            END.

            ASSIGN PlaceResult = TRUE.*/
        END.

        RETURN PlaceResult.

    END METHOD. /* Place */

    METHOD OVERRIDE PROTECTED VOID OnLoad(e AS EventArgs):
        SUPER:OnLoad(e).
    END.

    //DEFINE VARIABLE IsClosing AS LOGICAL NO-UNDO.

    METHOD OVERRIDE PROTECTED VOID OnFormClosing(e AS FormClosingEventArgs):

      SUPER:OnFormClosing(e).
    END METHOD. /* OnFormClosing */


    METHOD OVERRIDE PROTECTED VOID OnFormClosed(e AS System.Windows.Forms.FormClosedEventArgs):
       SUPER:OnFormClosed(e).
       /* IF VALID-OBJECT(MainWMChild)
        THEN DO:
            IF VALID-OBJECT(MainWMChild:AsControl)
            THEN MainWMChild:AsControl:Dispose(). /* In Siemens UI (CentraLink) this seems to cause an Activate of the Form... */
            DELETE OBJECT MainWMChild.
        END.*/
    END.

*/
END CLASS.
