
 /*------------------------------------------------------------------------
    File        : FormLayoutSetting
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Fri Nov 02 10:32:57 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.UI.Setting.FormLayoutSetting SERIALIZABLE:

    DEFINE PUBLIC PROPERTY Height AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Width AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Top AS INTEGER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Left AS INTEGER NO-UNDO
    GET.
    SET.

END CLASS.
