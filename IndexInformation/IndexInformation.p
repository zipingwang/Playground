/*
    run next command. in xref file contains information about index used.  
    .lst file contains transaction it used. must run it it prowin32 process editor. not in eclipse, otherwise .lst
    file has no information about transaction.  
*/

/*
    COMPILE C:\workspace\EclipseOE116Workspace\glims_dev_pro\Playground\IndexInformation\IndexInformation.p 
    XREF d:\temp\IndexInformation.XREF
    SAVE LISTING d:\temp\IndexInformation.lst NO-ERROR.
*/

    
DEFINE BUFFER b_User FOR genrw.sc_User.

FOR EACH b_User NO-LOCK WHERE b_User.usr_LoginName BEGINS 'W':U BY b_User.usr_FirstName:
    
END.

FOR EACH b_User NO-LOCK BY b_User.usr_Initials:
    
END.  
