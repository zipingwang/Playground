
 /*------------------------------------------------------------------------
    File        : ApplicationContext
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 11:12:33 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING System.Windows.Forms.ApplicationContext FROM ASSEMBLY.
USING Playground.Mips.UI.FrmLogin FROM PROPATH.
USING System.Windows.Forms.DialogResult FROM ASSEMBLY.
USING Playground.Mips.UI.FrmApplication FROM PROPATH.
USING System.Windows.Forms.FormStartPosition FROM ASSEMBLY.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.App.ApplicationContext INHERITS ApplicationContext:

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC ApplicationContext():

        DEFINE VARIABLE FrmLogin AS FrmLogin NO-UNDO.
        DEFINE VARIABLE DialogResult AS DialogResult NO-UNDO.
        DEFINE VARIABLE FrmApplication AS FrmApplication NO-UNDO.
        DEFINE VARIABLE AppStyleLib AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        SUPER().

        ASSIGN AppStyleLib = SEARCH("Mips/Resource/Style/Office2013LightGray.isl").

        IF AppStyleLib <> ?
        THEN Infragistics.Win.AppStyling.StyleManager:Load(AppStyleLib).

        FrmLogin = NEW FrmLogin().
        FrmLogin:StartPosition = FormStartPosition:CenterScreen.

        WAIT-FOR FrmLogin:ShowDialog() SET DialogResult.

        IF DialogResult = System.Windows.Forms.DialogResult:OK
        THEN DO:
            FrmApplication = NEW FrmApplication().
            WAIT-FOR FrmApplication:ShowDialog() SET DialogResult.
        END.

        CATCH ex AS Progress.Lang.Error :
            ErrorHelper:ShowErrorMessage(ex).
        END CATCH.

    END CONSTRUCTOR.

END CLASS.
