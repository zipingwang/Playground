
 /*------------------------------------------------------------------------
    File        : BrowserColumnDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 11:10:27 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.client.brw.BrowserDefinition.BrowserColumnDefinition:

    DEFINE PUBLIC PROPERTY DataSourceName AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Caption AS CHARACTER NO-UNDO
    GET.
    SET.

    DEFINE PUBLIC PROPERTY Hidden AS LOGICAL INITIAL NO NO-UNDO
    GET.
    SET.

END CLASS.
