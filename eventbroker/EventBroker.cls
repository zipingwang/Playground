
 /*------------------------------------------------------------------------
    File        : EventBroker
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Mar 29 14:39:46 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING be.mips.glims.manual.core.Instances FROM PROPATH.
USING System.ComponentModel.CancelEventArgs FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.eventbroker.EventBroker:

    DEFINE PRIVATE EVENT DataChanged  SIGNATURE VOID (Data AS CHARACTER).

    DEFINE PUBLIC STATIC PROPERTY Instance AS Playground.eventbroker.EventBroker NO-UNDO
    GET():
        IF NOT VALID-OBJECT(Instance)
        THEN Instance = NEW Playground.eventbroker.EventBroker().
        RETURN Instance.
    END.
    PRIVATE SET.


    METHOD PUBLIC VOID PublishDataChanged(NewData AS CHARACTER):
        DataChanged:Publish(NewData).
    END.

    METHOD PUBLIC VOID SubscribeDataChanged():
        DataChanged:Subscribe(PublishDataChanged).
    END.

    DEFINE PUBLIC EVENT NoExactBeginsFoundForFastPosition
       SIGNATURE VOID(InitialSearhString AS CHARACTER, RealSearchString AS CHARACTER, CancelEventArgs AS CancelEventArgs).

    METHOD PUBLIC VOID InvokeNoExactBeginsFoundForFastPosition
       (InitialSearhString AS CHARACTER, RealSearchString AS CHARACTER, CancelEventArgs AS CancelEventArgs):

       NoExactBeginsFoundForFastPosition:Publish(InitialSearhString, RealSearchString, CancelEventArgs).

    END METHOD.

END CLASS.
