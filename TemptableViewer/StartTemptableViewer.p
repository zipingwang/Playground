
USING Playground.TemptableViewer.TemptableViewer FROM PROPATH.
USING System.Windows.Forms.Application FROM ASSEMBLY.

DEFINE VARIABLE TemptableViewer AS TemptableViewer.

TemptableViewer = NEW TemptableViewer().
WAIT-FOR APPLICATION:Run(TemptableViewer).
QUIT.
