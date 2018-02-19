 /* Copyright ©2017 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

 /*------------------------------------------------------------------------
    File        : BrowserExtension
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Mar 09 11:26:13 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.
USING System.EventArgs FROM ASSEMBLY.
USING System.Exception FROM ASSEMBLY.
USING System.Object FROM ASSEMBLY.
USING System.Windows.Forms.DataFormats FROM ASSEMBLY.
USING System.Windows.Forms.DragDropEffects FROM ASSEMBLY.
USING System.Windows.Forms.DragEventArgs FROM ASSEMBLY.
USING System.Windows.Forms.Form FROM ASSEMBLY.
USING System.Windows.Forms.FormClosingEventArgs FROM ASSEMBLY.
USING Playground.BrowserExtension.SimpleStringEventArgs FROM PROPATH.
USING Playground.BrowserExtension.BrowserExtension FROM PROPATH.
USING Playground.BrowserExtension.BrowserFastPositionHelper FROM PROPATH.
USING Playground.BrowserExtension.BrowserHelper FROM PROPATH.
USING be.mips.ablframework.gui.components.widget.FastPositionTextWidget FROM PROPATH.

CLASS Playground.BrowserExtension.BrowserExtension:

    DEFINE PRIVATE VARIABLE UltraGrid AS UltraGrid.
    DEFINE PRIVATE VARIABLE BrowserHelper AS BrowserHelper.
    DEFINE PRIVATE VARIABLE BrowserFastPositionHelper AS BrowserFastPositionHelper NO-UNDO.
    DEFINE PRIVATE VARIABLE AddDropFileFeatureDone AS LOGICAL NO-UNDO INITIAL NO.
    DEFINE PRIVATE VARIABLE AddAutoSaveAndLoadLayoutPreferenceFeatureDone AS LOGICAL NO-UNDO INITIAL NO.
    DEFINE PRIVATE VARIABLE AddFastPositioningFeatureDone AS LOGICAL NO-UNDO INITIAL NO.

    DEFINE PUBLIC EVENT FileDropped SIGNATURE VOID (sender AS Progress.Lang.Object, e AS SimpleStringEventArgs).
    DEFINE PUBLIC EVENT FastPositioningRequestSerch SIGNATURE VOID (sender AS  Progress.Lang.Object, e AS SimpleStringEventArgs).

    /*****************************************************************************/

    DEFINE PUBLIC PROPERTY FastPositionTextWidget AS FastPositionTextWidget NO-UNDO
    GET:
        IF AddFastPositioningFeatureDone = NO
        THEN DO:
           UNDO, THROW NEW Progress.Lang.AppError("Please first add FastPositioningFeature":U, 1).
        END.

        RETURN BrowserFastPositionHelper:FastPositionTextWidget.
    END.
    SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC BrowserExtension(UltraGrid AS UltraGrid):

        THIS-OBJECT:UltraGrid = UltraGrid.
        BrowserHelper = NEW BrowserHelper().

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD PUBLIC BrowserExtension AddDropFileFeature():

        IF AddDropFileFeatureDone = NO
        THEN DO:
           BrowserHelper:AddDropFileFeature(THIS-OBJECT:UltraGrid).
           BrowserHelper:FileDropped:Subscribe(THIS-OBJECT:BrowserHelper_FileDropped).
           AddDropFileFeatureDone = YES.
        END.
        RETURN THIS-OBJECT.

    END METHOD.

    /*****************************************************************************/

    METHOD PUBLIC BrowserExtension AddAutoSaveAndLoadLayoutPreferenceFeature():

        DEFINE VARIABLE ParentForm AS FORM.

        IF AddAutoSaveAndLoadLayoutPreferenceFeatureDone = NO AND VALID-OBJECT(ParentForm)
        THEN DO:
            ParentForm:FormClosing:Subscribe(ParentForm_FormClosing).
            ParentForm:Load:Subscribe(ParentForm_Load).
            AddAutoSaveAndLoadLayoutPreferenceFeatureDone = YES.
        END.
        RETURN THIS-OBJECT.

    END METHOD.

 /*****************************************************************************/

    METHOD PUBLIC BrowserExtension AddFastPositioningFeature(UseDefaultSearchMethod AS LOGICAL):

        IF AddFastPositioningFeatureDone = NO
        THEN DO:
            BrowserFastPositionHelper = NEW BrowserFastPositionHelper().
            BrowserFastPositionHelper:AddFastPostionAbilityToBrowser(UltraGrid, UseDefaultSearchMethod).

            IF UseDefaultSearchMethod = NO
            THEN BrowserFastPositionHelper:RequestSerch:Subscribe(THIS-OBJECT:BrowserFastPositionHelper_RequestSerch).

            AddFastPositioningFeatureDone = YES.
        END.

        RETURN THIS-OBJECT.

    END METHOD.


    /*****************************************************************************/

    METHOD PRIVATE VOID BrowserFastPositionHelper_RequestSerch(sender AS Progress.Lang.Object, e AS SimpleStringEventArgs):

        THIS-OBJECT:FastPositioningRequestSerch:Publish(sender, e).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID BrowserHelper_FileDropped(sender AS Progress.Lang.Object, e AS SimpleStringEventArgs):

        THIS-OBJECT:FileDropped:Publish(sender, e).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID ParentForm_FormClosing(sender AS System.Object, e AS FormClosingEventArgs):

        BrowserHelper:SaveGridLayout(THIS-OBJECT:UltraGrid).

    END METHOD.

    /*****************************************************************************/

    METHOD PRIVATE VOID ParentForm_Load(sender AS System.Object, e AS EventArgs):

        BrowserHelper:ApplySavedGridLayout(THIS-OBJECT:UltraGrid).

    END METHOD.

END CLASS.
