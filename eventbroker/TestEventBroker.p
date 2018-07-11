
/*------------------------------------------------------------------------
    File        : TestEventBroker.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : ZipingWa
    Created     : Fri Mar 30 13:55:25 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

Playground.eventbroker.EventBroker:Instance:DataChanged:Subscribe(THIS-PROCEDURE:DataChangedEventhandler).

PROCEDURE DataChangedEventhandler:
    DEFINE INPUT PARAMETER Data AS CHARACTER NO-UNDO.

END.


