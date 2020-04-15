
 /*------------------------------------------------------------------------
    File        : BrowserDefinition
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Tue Nov 06 11:08:09 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Playground.NetBrowser.client.brw.BrowserDefinition.BrowserColumnDefinition FROM PROPATH.
USING Consultingwerk.Framework.Base.GenericList FROM PROPATH.
USING Playground.NetBrowser.client.brw.BrowserDefinition.BrowserDefinition FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Playground.NetBrowser.client.brw.BrowserDefinition.BrowserDefinition INHERITS GenericList:

    { Consultingwerk/Framework/Base/GenericList.i BrowserColumnDefinition BrowserDefinition}

/*
    DEFINE PUBLIC PROPERTY BrowserColumns AS BrowserColumnDefinition EXTENT NO-UNDO
    GET.
    SET.
*/
    DEFINE PUBLIC PROPERTY BrowserName AS CHARACTER NO-UNDO
    GET.
    SET.

END CLASS.
