
USING Playground.Mips.App.ApplicationContext FROM PROPATH.

DEFINE VARIABLE ApplicationContext AS ApplicationContext NO-UNDO.

ASSIGN ApplicationContext = NEW ApplicationContext().

WAIT-FOR System.Windows.Forms.Application:Run(ApplicationContext).
