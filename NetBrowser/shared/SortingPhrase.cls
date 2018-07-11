
 /*------------------------------------------------------------------------
    File        : SortingPhrase
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Mon Mar 26 17:01:21 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.shared.SortingElement FROM PROPATH.
USING Playground.NetBrowser.shared.SortingDirection FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.SortingPhrase:

    DEFINE PUBLIC PROPERTY HasSorting AS LOGICAL NO-UNDO
    GET():
        RETURN EXTENT(THIS-OBJECT:SortingElements) > 0.
    END.
    SET.

    DEFINE PUBLIC PROPERTY SortingElements AS SortingElement EXTENT NO-UNDO
    GET.
    SET.

    METHOD PUBLIC VOID AddSortingElement(FieldName AS CHARACTER, SortingDirection AS SortingDirection):

        EXTENT(SortingElements) = EXTENT(SortingElements) + 1.
        SortingElements[EXTENT(SortingElements)] =  NEW SortingElement(FieldName, SortingDirection).

    END METHOD.

    METHOD PUBLIC VOID AddSortingElement(SortingElement AS SortingElement):

        EXTENT(SortingElements) = EXTENT(SortingElements) + 1.
        SortingElements[EXTENT(SortingElements)] =  SortingElement.

    END METHOD.


    METHOD PUBLIC CHARACTER GetStringExpression():
        DEFINE VARIABLE Counter AS INTEGER NO-UNDO.
        DEFINE VARIABLE SortingString AS CHARACTER NO-UNDO INITIAL "":U.

        /* --------------------------------------------------------------------- */
        
        IF HasSorting
        THEN DO:
            DO Counter = 1 TO EXTENT(SortingElements):
                IF Counter = 1
                THEN DO:
                    SortingString = SUBSTITUTE("BY &1 &2":U, SortingElements[1]:FieldName,
                        IF SortingElements[1]:SortingDirection = SortingDirection:ASC THEN "":U ELSE "DESCENDING":U).
                END.
                ELSE DO:
                    SortingString = SortingString + " ":U + SUBSTITUTE("BY &1 &2":U, SortingElements[1]:FieldName,
                        IF SortingElements[1]:SortingDirection = SortingDirection:ASC THEN "":U ELSE "DESCENDING":U).
                END.
            END.
        END.

        RETURN SortingString.

    END.

END CLASS.
