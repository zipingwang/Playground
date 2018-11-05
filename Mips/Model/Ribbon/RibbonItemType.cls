
 /*------------------------------------------------------------------------
    File        : RibbonItemType
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 14:17:58 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

ENUM Playground.Mips.Model.Ribbon.RibbonItemType:

    DEFINE ENUM
        Button
        ComboBox
        .

END ENUM.
