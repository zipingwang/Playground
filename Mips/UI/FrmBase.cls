
 /*------------------------------------------------------------------------
    File        : FrmBase
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 10:13:33 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.EventArgs FROM ASSEMBLY.
USING Playground.Mips.UI.Setting.FormLayoutSetting FROM PROPATH.
USING Consultingwerk.Util.FileHelper FROM PROPATH.
USING Infragistics.Win.SaveSettingsFormat FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.FrmBase INHERITS Form:

    DEFINE PUBLIC PROPERTY LayoutSettingFileName AS CHARACTER NO-UNDO
    GET:
        /* TODO: if directory "FormLayoutSetting" not exit create one*/
        RETURN SESSION:TEMP-DIRECTORY + "FormLayoutSetting\" + THIS-OBJECT:NAME.
    END.
    PRIVATE SET.

    /*****************************************************************************/

    CONSTRUCTOR PUBLIC FrmBase():
        SUPER().

    END CONSTRUCTOR.

    /*****************************************************************************/

    METHOD OVERRIDE VOID OnLoad(e AS EventArgs):

        SUPER:OnLoad(e).

        LoadLayoutSetting().

    END.

    /*****************************************************************************/

    METHOD OVERRIDE VOID OnClosed(e AS EventArgs):

        SUPER:OnClosed(e).

        SaveLayoutSetting().

    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID LoadLayoutSetting():

        DEFINE VARIABLE MyFileInStream AS Progress.IO.FileInputStream.
        DEFINE VARIABLE MySerializer AS Progress.IO.JsonSerializer.
        DEFINE VARIABLE FormLayoutSetting AS FormLayoutSetting.

        /* --------------------------------------------------------------------- */

        IF FileHelper:Exists(LayoutSettingFileName)
        THEN DO:
            mySerializer = NEW Progress.IO.JsonSerializer(FALSE).
            MyFileInStream = NEW Progress.IO.FileInputStream(LayoutSettingFileName).
            FormLayoutSetting = CAST(mySerializer:Deserialize(myFileInStream), FormLayoutSetting).
            MyFileInStream:Close().

            ASSIGN
                Width = FormLayoutSetting:Width
                Height = FormLayoutSetting:Height
                Top = FormLayoutSetting:Top
                Left = FormLayoutSetting:Left
                .
        END.
    END.

    /*****************************************************************************/

    METHOD PRIVATE VOID SaveLayoutSetting():

        DEFINE VARIABLE MyFileOutStream AS Progress.IO.FileOutputStream.
        DEFINE VARIABLE MySerializer AS Progress.IO.JsonSerializer.
        DEFINE VARIABLE FormLayoutSetting AS FormLayoutSetting.

        /* --------------------------------------------------------------------- */

        ASSIGN
            FormLayoutSetting = NEW FormLayoutSetting()
            FormLayoutSetting:Width = Width
            FormLayoutSetting:Height = Height
            FormLayoutSetting:Top = Top
            FormLayoutSetting:Left = Left
            .

        mySerializer = NEW Progress.IO.JsonSerializer(FALSE).
        myFileOutStream = NEW Progress.IO.FileOutputStream(LayoutSettingFileName).
        mySerializer:Serialize(FormLayoutSetting, myFileOutStream).
        myFileOutStream:Close().

    END.

    /*****************************************************************************/

    DESTRUCTOR PUBLIC FrmBase():

    END DESTRUCTOR.

END CLASS.
