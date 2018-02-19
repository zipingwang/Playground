
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

USING Playground.NetBrowser.client.BrwUser4 FROM PROPATH.

DEFINE VARIABLE BrwUser AS BrwUser4.

ASSIGN BrwUser = NEW BrwUser4().

WAIT-FOR System.Windows.Forms.Application:Run ( BrwUser ).
