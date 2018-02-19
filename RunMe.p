
/*------------------------------------------------------------------------
    File        : RunMe.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Mon May 02 10:44:30 CEST 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

DEFINE VARIABLE TestForm AS TestForm NO-UNDO.

/*MESSAGE "start"   */
/*VIEW-AS ALERT-BOX.*/

TestForm = NEW TestForm().
/*TestForm:Show().*/
    WAIT-FOR System.Windows.Forms.Application:Run(TestForm).

/*MESSAGE "stop"    */
/*VIEW-AS ALERT-BOX.*/