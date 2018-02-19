 DEFINE TEMP-TABLE esc_UserFlat NO-UNDO
    FIELD Selection_ AS LOGICAL  LABEL 'Selection_':U  /* SERIALIZE-NAME 'Selection_':U */
    FIELD RecId_ AS RECID LABEL 'RecId_':U /* SERIALIZE-NAME 'RecId_':U */
    FIELD usr_Initials AS CHARACTER FORMAT "X(10)":U LABEL "Initials":T10 /* SERIALIZE-NAME "usr_Initials":U */
    FIELD usr_LastName AS CHARACTER FORMAT "X(60)":U LABEL "Last name":T16 /* SERIALIZE-NAME "usr_LastName":U */
    FIELD usr_FirstName AS CHARACTER FORMAT "X(40)":U LABEL "First name":T13 /* SERIALIZE-NAME "usr_FirstName":U */
    FIELD usr_LoginName AS CHARACTER FORMAT "X(128)":U LABEL "Login name":T24 /* SERIALIZE-NAME "usr_LoginName":U */
  /*  FIELD RolesList AS CHARACTER FORMAT "X(240)":U LABEL "Roles":T6 /* SERIALIZE-NAME "RolesList":U */
    FIELD usr_Enabled AS LOGICAL FORMAT "yes /no":U LABEL "Enabled":T16 /* SERIALIZE-NAME "usr_Enabled":U */
    FIELD usr_SessionType AS INTEGER FORMAT "->>>>>>>>>9":U LABEL "Session type":T15 /* SERIALIZE-NAME "usr_SessionType":U */
    FIELD usr_AutoLoginAllowed AS LOGICAL FORMAT "yes /no":U LABEL "Autologin allowed":T36 /* SERIALIZE-NAME "usr_AutoLoginAllowed":U */
    FIELD usr_PasswordVerification AS INTEGER FORMAT "->>>>>>9":U LABEL "Password verification":T26 /* SERIALIZE-NAME "usr_PasswordVerification":U */
    FIELD usr_MinimumPasswordLength AS INTEGER FORMAT ">9":U LABEL "Minimum password length":T31 /* SERIALIZE-NAME "usr_MinimumPasswordLength":U */
    FIELD usr_MaximumPasswordAge AS INTEGER FORMAT ">>>9":U LABEL "Maximum password age":T33 /* SERIALIZE-NAME "usr_MaximumPasswordAge":U */
    FIELD usr_AuthorizationTimeout AS INTEGER FORMAT ">>>>9":U LABEL "Authorization timeout":T33 /* SERIALIZE-NAME "usr_AuthorizationTimeout":U */
    FIELD usr_ContextTimeout AS INTEGER FORMAT ">>>>9":U LABEL "Context timeout":T29 /* SERIALIZE-NAME "usr_ContextTimeout":U */
    FIELD usr_Email AS CHARACTER FORMAT "X(80)":U LABEL "E-mail address":T18 /* SERIALIZE-NAME "usr_Email":U */
    FIELD usr_MailMethod AS INTEGER FORMAT "->>>>>>9":U LABEL "Mail method":T18 /* SERIALIZE-NAME "usr_MailMethod":U */
    FIELD usr_Phone AS CHARACTER FORMAT "X(20)":U LABEL "Phone":T11 /* SERIALIZE-NAME "usr_Phone":U */
    FIELD usr_HomePage AS INTEGER FORMAT ">>>>>>>9":U LABEL "Home page":T9 /* SERIALIZE-NAME "usr_HomePage":U */
    FIELD usr_StartTool AS INTEGER FORMAT ">>>>>>>9":U LABEL "Start tool":T10 /* SERIALIZE-NAME "usr_StartTool":U */
    FIELD usr_Language AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Language":T8 /* SERIALIZE-NAME "usr_Language":U */
    FIELD usr_Printer AS INTEGER FORMAT ">>>>>>>9":U LABEL "Printer":T7 /* SERIALIZE-NAME "usr_Printer":U */*/
    FIELD usr_Id AS INTEGER FORMAT ">>>>>>>9":U LABEL "Identifier":T10 /* SERIALIZE-NAME "usr_Id":U */

    FIELD HomePageMnemonic AS CHARACTER FORMAT "X(60)":U LABEL "Home page":T14 /* SERIALIZE-NAME "HomePageMnemonic":U */ INITIAL ?
    FIELD HomePageId AS INTEGER FORMAT ">>>>>>>9":U LABEL "Id":T2 /* SERIALIZE-NAME "HomePageId":U */ INITIAL ?

    FIELD StartToolMnemonic AS CHARACTER FORMAT "X(100)":U LABEL "Start tool":T19 /* SERIALIZE-NAME "StartToolMnemonic":U */ INITIAL ?
    FIELD StartToolTable AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Start tool!Table":T16 /* SERIALIZE-NAME "StartToolTable":U */ INITIAL ?
    FIELD StartToolId AS INTEGER FORMAT ">>>>>>>9":U LABEL "Id":T2 /* SERIALIZE-NAME "StartToolId":U */ INITIAL ?

    FIELD LanguageName AS CHARACTER FORMAT "X(32)":U LABEL "Language":T8 /* SERIALIZE-NAME "LanguageName":U */ INITIAL ?
    FIELD LanguageId AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Identifier":T10 /* SERIALIZE-NAME "LanguageId":U */ INITIAL ?

    FIELD PrinterName AS CHARACTER FORMAT "X(32)":U LABEL "Printer":T11 /* SERIALIZE-NAME "PrinterName":U */ INITIAL ?
    FIELD PrinterId AS INTEGER FORMAT ">>>>>>>>>9":U LABEL "Identification":T14 /* SERIALIZE-NAME "PrinterId":U */ INITIAL ?

    INDEX usr_Id IS UNIQUE PRIMARY usr_Id
    INDEX usr_LoginName usr_LoginName.
    
    DEFINE DATASET DsUser FOR esc_UserFlat.
