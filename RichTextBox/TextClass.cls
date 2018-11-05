 
 /*------------------------------------------------------------------------
    File        : TextClass
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Wed Sep 26 16:26:38 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING be.mips.ablframework.gui.AbstractWindowManagerClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.RichTextBox.TextClass INHERITS AbstractWindowManagerClient: 

    DEFINE PRIVATE VARIABLE checkBox1 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.


    METHOD PRIVATE VOID InitializeComponent ( ):
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:checkBox1 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* checkBox1 */
        /*  */
        THIS-OBJECT:checkBox1:Location = NEW System.Drawing.Point(70, 85).
        THIS-OBJECT:checkBox1:Name = "checkBox1":U.
        THIS-OBJECT:checkBox1:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox1:TabIndex = 0.
        THIS-OBJECT:checkBox1:Text = "checkBox1":U.
        THIS-OBJECT:checkBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(70, 127).
        THIS-OBJECT:button1:Name = "button1":U.
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:button1:TabIndex = 1.
        THIS-OBJECT:button1:Text = "button1":U.
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        /*  */
        /* TextClass */
        /*  */
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox1).
        THIS-OBJECT:Name = "TextClass":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.
END CLASS.