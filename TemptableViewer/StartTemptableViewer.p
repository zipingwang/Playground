
USING Playground.TemptableViewer.TemptableViewer FROM PROPATH.
USING System.Windows.Forms.Application FROM ASSEMBLY.


DEFINE VARIABLE TemptableViewer AS TemptableViewer.

Infragistics.Win.AppStyling.StyleManager:Load("C:\workspace\OE117\glims_dev_pro\glims-bin\styles\CentraLink.isl").

Consultingwerk.Util.LogManager:WriteMessage("ZWA: " +  "ok" + " @" + PROGRAM-NAME(1)).

TemptableViewer = NEW TemptableViewer().
WAIT-FOR APPLICATION:Run(TemptableViewer).
QUIT.
