
 /*------------------------------------------------------------------------
    File        : BrowserExtensionEnums
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon Nov 05 15:13:07 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

ENUM Playground.BrowserExtension.SearchDataSourceOrigin:

    DEFINE ENUM
        Grid
        Database
        .

END ENUM.
