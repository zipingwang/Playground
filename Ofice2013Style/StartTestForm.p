
USING Playground.Ofice2013Style.TestForm FROM PROPATH.
USING System.Windows.Forms.Application FROM ASSEMBLY.

Infragistics.Win.AppStyling.StyleManager:Load
    ("C:\workspace\OE117\glims_dev_pro\glims-bin\styles\Office2013Test\Office2010Blue.isl").

DEFINE VARIABLE TestForm AS TestForm.

Consultingwerk.Util.LogManager:WriteMessage("ZWA: " +  "ok" + " @" + PROGRAM-NAME(1)).

TestForm = NEW TestForm().
WAIT-FOR APPLICATION:Run(TestForm).
QUIT.
