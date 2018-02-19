DEFINE VARIABLE SourceFile AS CHARACTER NO-UNDO.
DEFINE VARIABLE CheckResult AS CHARACTER NO-UNDO.
ASSIGN SourceFile ="c:\temp\test.txt". //"C:\workspace\EclipseOE116Workspace\glims_dev_pro\mate-abl-sources\be\mips\ablframework\gui\context\ContextBuilder.cls".

RUN CodeConventionChecker(SourceFile, OUTPUT CheckResult).

MESSAGE "CheckResult" CheckResult VIEW-AS ALERT-BOX.
  
