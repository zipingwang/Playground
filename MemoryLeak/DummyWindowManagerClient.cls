
 /*------------------------------------------------------------------------
    File        : DummyWindowManagerClient
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Wed May 23 11:08:12 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.MemoryLeak.DummyWindowManagerClient INHERITS AbstractWindowManagerClient:

    DEFINE PRIVATE VARIABLE comboBox1 AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE checkBox1 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.


    CONSTRUCTOR PUBLIC DummyWindowManagerClient (  ):

        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    METHOD PUBLIC OVERRIDE LOGICAL HasOwnRibbon():

        RETURN YES.

    END METHOD. /* HasOwnRibbon */

    /*****************************************************************************/

    METHOD PROTECTED OVERRIDE CHARACTER GetPreferenceId():

        RETURN "DummyWindowManagerClient":U.

    END.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:checkBox1 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:comboBox1 = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(145, 111).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:button1:TabIndex = 0.
        THIS-OBJECT:button1:Text = "button1".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* checkBox1 */
        /*  */
        THIS-OBJECT:checkBox1:Location = NEW System.Drawing.Point(291, 109).
        THIS-OBJECT:checkBox1:Name = "checkBox1".
        THIS-OBJECT:checkBox1:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox1:TabIndex = 1.
        THIS-OBJECT:checkBox1:Text = "checkBox1".
        THIS-OBJECT:checkBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* comboBox1 */
        /*  */
        THIS-OBJECT:comboBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:comboBox1:Location = NEW System.Drawing.Point(145, 186).
        THIS-OBJECT:comboBox1:Name = "comboBox1".
        THIS-OBJECT:comboBox1:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:comboBox1:TabIndex = 2.
        /*  */
        /* DummyWindowManagerClient */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(579, 401).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:comboBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Name = "DummyWindowManagerClient".
        THIS-OBJECT:Text = "DummyWindowManagerClient".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC DummyWindowManagerClient ( ):

    END DESTRUCTOR.

END CLASS.
