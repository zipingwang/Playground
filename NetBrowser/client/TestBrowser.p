
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

USING Playground.NetBrowser.client.brw.BrwUser13 FROM PROPATH.
USING System.Windows.Forms.DockStyle FROM ASSEMBLY.
USING Playground.NetBrowser.client.brw.BrwSiteAttribute FROM PROPATH.

//DEFINE VARIABLE BrwUser AS BrwUser13.
//ASSIGN BrwUser = NEW BrwUser13().

DEFINE VARIABLE BrwUser AS BrwSiteAttribute.
ASSIGN BrwUser = NEW BrwSiteAttribute().

DEFINE VARIABLE Frm AS Progress.Windows.Form NO-UNDO.

ASSIGN
    Frm = NEW Progress.Windows.Form()
    Frm:WIDTH = 600
    Frm:HEIGHT = 800
    .

Frm:Controls:Add(BrwUser).
BrwUser:Dock = DockStyle:FILL.

WAIT-FOR System.Windows.Forms.Application:Run (Frm).
