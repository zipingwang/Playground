 
 /*------------------------------------------------------------------------
    File        : SortingElement
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : ZipingWa
    Created     : Mon Mar 26 16:56:10 CEST 2018
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.SortingDirection FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.SortingElement: 

    DEFINE PUBLIC PROPERTY FieldName AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY SortingDirection AS SortingDirection NO-UNDO 
    GET.
    SET. 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
        
    CONSTRUCTOR PUBLIC SortingElement(FieldName AS CHARACTER, SortingDirection AS SortingDirection ):
        SUPER ().
        
        ASSIGN 
            THIS-OBJECT:FieldName = FieldName
            THIS-OBJECT:SortingDirection = SortingDirection.
        
    END CONSTRUCTOR.
    
    

END CLASS.