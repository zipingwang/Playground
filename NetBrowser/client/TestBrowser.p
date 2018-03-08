
/*------------------------------------------------------------------------
    File        : TestBrowser.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Fri Feb 16 09:45:20 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Playground.NetBrowser.client.brw.BrwUser10 FROM PROPATH.

DEFINE VARIABLE BrwUser AS BrwUser10.

ASSIGN BrwUser = NEW BrwUser10().

WAIT-FOR System.Windows.Forms.Application:Run ( BrwUser ).
