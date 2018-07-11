
/*subscribe key event, but can't find information about the "FIND, "CTRL-F" in progress documenttation*/
ON "FIND":U, "CTRL-F":U OF TheFrame ANYWHERE
DO:
    RUN OnCommandFind.
    RETURN NO-APPLY.
END.