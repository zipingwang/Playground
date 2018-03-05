
 /*------------------------------------------------------------------------
    File        : DataRetrievalConstant
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Thu Mar 01 11:44:49 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.shared.DataRetrievalConstant FINAL:

    DEFINE PUBLIC STATIC PROPERTY FastPosition AS CHARACTER NO-UNDO
    GET():
        RETURN "FastPostition".
    END.

    DEFINE PUBLIC STATIC PROPERTY PageUp AS CHARACTER NO-UNDO
    GET():
        RETURN "PageUp".
    END.

    DEFINE PUBLIC STATIC PROPERTY PageDown AS CHARACTER NO-UNDO
    GET():
        RETURN "PageDown".
    END.

    DEFINE PUBLIC STATIC PROPERTY KeyUp AS CHARACTER NO-UNDO
    GET():
        RETURN "KeyUp".
    END.

    DEFINE PUBLIC STATIC PROPERTY KeyDown AS CHARACTER NO-UNDO
    GET():
        RETURN "KeyDown".
    END.

    DEFINE PUBLIC STATIC PROPERTY HomeKey AS CHARACTER NO-UNDO
    GET():
        RETURN "Home".
    END.
        DEFINE PUBLIC STATIC PROPERTY EndKey AS CHARACTER NO-UNDO
    GET():
        RETURN "End".
    END.

    DEFINE PUBLIC STATIC PROPERTY ScrollUp AS CHARACTER NO-UNDO
    GET():
        RETURN "ScrollUp".
    END.

    DEFINE PUBLIC STATIC PROPERTY ChangeSorting AS CHARACTER NO-UNDO
    GET():
        RETURN "ChangeSorting".
    END.

    DEFINE PUBLIC STATIC PROPERTY OffEnd AS CHARACTER NO-UNDO
    GET():
        RETURN "OffEnd".
    END.

    DEFINE PUBLIC STATIC PROPERTY Forwards AS CHARACTER NO-UNDO
    GET():
        RETURN "Forwards".
    END.

    DEFINE PUBLIC STATIC PROPERTY Backwards AS CHARACTER NO-UNDO
    GET():
        RETURN "Backwards".
    END.

END CLASS.