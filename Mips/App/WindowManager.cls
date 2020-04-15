
 /*------------------------------------------------------------------------
    File        : WindowManager
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Oct 18 11:14:19 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.Mips.App.WindowManager FROM PROPATH.
USING Progress.Windows.Form FROM ASSEMBLY.
USING Playground.Mips.UI.Interface.IView FROM PROPATH.
USING Playground.Mips.UI.EventArgs.NotifyObjectChangedEventArgs FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.Mips.App.WindowManager:

    DEFINE STATIC TEMP-TABLE w_WindowObject NO-UNDO
    FIELD WindowObject AS OBJECT
    FIELD ParentWindowObject AS OBJECT
    INDEX Index_Id IS UNIQUE WindowObject.

    DEFINE PUBLIC STATIC PROPERTY Instance AS WindowManager NO-UNDO
    GET():
        IF NOT VALID-OBJECT(Instance)
        THEN ASSIGN Instance = NEW WindowManager().
        RETURN Instance.
    END.
    PRIVATE SET.

    /*****************************************************************************/

    METHOD PUBLIC STATIC VOID ShowView(Frm AS IView, ParentForm AS IView):

        FOR FIRST w_WindowObject WHERE WindowObject = Frm:
        END.

        IF NOT AVAILABLE(w_WindowObject)
        THEN DO:
            CREATE w_WindowObject.
            ASSIGN
                w_WindowObject.WindowObject = Frm
                w_WindowObject.ParentWindowObject = ParentForm
                .
        END.
/*
        IF VALID-OBJECT(ParentForm)
        THEN DO:
            ParentForm:NotifyObjectChanged:Subscribe(Frm:ParentChangedHandler).
        END.
*/
    END.

    /*****************************************************************************/

    METHOD PUBLIC STATIC VOID NotifyObjectChanged(Frm AS IView, NotifyObjectChangedEventArgs AS NotifyObjectChangedEventArgs):

        FOR FIRST w_WindowObject WHERE ParentWindowObject = Frm:
        END.

        IF AVAILABLE(w_WindowObject)
        THEN DO:
           CAST(w_WindowObject.WindowObject, IView):ParentChangedHandler(Frm, NotifyObjectChangedEventArgs).
        END.
        //TODO: Iterate children

    END.

END CLASS.
