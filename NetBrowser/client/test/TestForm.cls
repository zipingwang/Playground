
 /*------------------------------------------------------------------------
    File        : TestForm
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Wed Mar 07 08:44:11 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Playground.NetBrowser.client.brw.BrwUser11 FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.client.test.TestForm INHERITS Form:

    DEFINE PRIVATE VARIABLE buttonStartBrwUser AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.


    CONSTRUCTOR PUBLIC TestForm (  ):


        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID buttonStartBrwUser_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

		DEFINE VARIABLE BrwUser AS BrwUser11.

        ASSIGN BrwUser = NEW BrwUser11().

        BrwUser:Show().

	END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:buttonStartBrwUser = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonStartBrwUser */
        /*  */
        THIS-OBJECT:buttonStartBrwUser:Location = NEW System.Drawing.Point(128, 209).
        THIS-OBJECT:buttonStartBrwUser:Name = "buttonStartBrwUser".
        THIS-OBJECT:buttonStartBrwUser:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonStartBrwUser:TabIndex = 0.
        THIS-OBJECT:buttonStartBrwUser:Text = "brw user".
        THIS-OBJECT:buttonStartBrwUser:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonStartBrwUser:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:buttonStartBrwUser:Click:Subscribe(THIS-OBJECT:buttonStartBrwUser_Click).
        /*  */
        /* TestForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:buttonStartBrwUser).
        THIS-OBJECT:Name = "TestForm".
        THIS-OBJECT:Text = "TestForm".
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC TestForm ( ):

    END DESTRUCTOR.

END CLASS.