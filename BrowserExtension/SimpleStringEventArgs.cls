 /* Copyright ©2017 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

 /*------------------------------------------------------------------------
    File        : SimpleStringEventArgs
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : ZipingWa
    Created     : Thu Mar 09 09:27:09 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.EventArgs FROM PROPATH.

CLASS Playground.BrowserExtension.SimpleStringEventArgs INHERITS EventArgs:

    DEFINE PUBLIC PROPERTY StringValue AS CHARACTER NO-UNDO
    GET.
    SET.

    CONSTRUCTOR PUBLIC SimpleStringEventArgs(StringValue AS CHARACTER):

        THIS-OBJECT:StringValue = StringValue.

    END CONSTRUCTOR.

END CLASS.
