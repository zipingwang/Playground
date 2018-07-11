 
 /*------------------------------------------------------------------------
    File        : SortingDirection
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Mar 26 16:57:39 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

ENUM Playground.NetBrowser.shared.SortingDirection: 
    DEFINE ENUM ASC DESC.
    
END ENUM.