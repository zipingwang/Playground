USING Consultingwerk.Util.FileHelper FROM PROPATH.

DEFINE VARIABLE MyFile AS CHARACTER NO-UNDO.
ASSIGN MyFile = "text.xml".
DEFINE VARIABLE DirName AS CHARACTER NO-UNDO.
DEFINE VARIABLE ShortFileName AS CHARACTER NO-UNDO.

ASSIGN
    DirName = Consultingwerk.Util.FileHelper:DirectoryName(MyFile)
    ShortFileName = Consultingwerk.Util.FileHelper:ShortFileName(MyFile).
MESSAGE DirName ShortFileName VIEW-AS ALERT-BOX.
