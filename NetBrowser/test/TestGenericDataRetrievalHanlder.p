
/*------------------------------------------------------------------------
    File        : TestGenericDataRetrievalHanlder.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Feb 16 10:17:35 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Playground.NetBrowser.test.TestGenericDataRetrievalHandler FROM PROPATH.
USING Consultingwerk.Util.ErrorHelper FROM PROPATH.

DEFINE VARIABLE TestGenericDataRetrievalHanlder AS TestGenericDataRetrievalHandler NO-UNDO.

ASSIGN TestGenericDataRetrievalHanlder = NEW TestGenericDataRetrievalHandler().

TestGenericDataRetrievalHanlder:TestGetData().
TestGenericDataRetrievalHanlder:TestGetData().

CATCH Err AS Progress.Lang.Error :
    ErrorHelper:ShowErrorMessage(Err).		
END CATCH.
