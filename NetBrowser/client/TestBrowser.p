
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

USING Playground.NetBrowser.client.brw.BrwUser11 FROM PROPATH.

DEFINE VARIABLE BrwUser AS BrwUser11.

ASSIGN BrwUser = NEW BrwUser11().

WAIT-FOR System.Windows.Forms.Application:Run ( BrwUser ).
