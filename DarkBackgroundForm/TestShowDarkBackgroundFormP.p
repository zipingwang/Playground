USING Playground.DarkBackgroundForm.ChildForm FROM PROPATH.
USING Playground.DarkBackgroundForm.TestShowDarkBackgroundFrom FROM PROPATH.

DEFINE VARIABLE Frm AS TestShowDarkBackgroundFrom.

ASSIGN Frm = NEW TestShowDarkBackgroundFrom().

WAIT-FOR System.Windows.Forms.Application:Run(Frm).
MESSAGE "done" VIEW-AS ALERT-BOX.