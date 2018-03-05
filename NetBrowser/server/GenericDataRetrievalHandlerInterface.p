
 /*------------------------------------------------------------------------
    File        : GenericDataRetriver
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : zipingwa
    Created     : Tue Feb 13 11:57:54 CET 2018
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Playground.NetBrowser.shared.DataRetrievalRequest FROM PROPATH.
USING Playground.NetBrowser.shared.DataRetrievalResponse FROM PROPATH.
USING Playground.NetBrowser.server.GenericDataRetrievalHandler FROM PROPATH.

/* --------------------------------------------------------------------- */

DEFINE INPUT PARAMETER DataRetrievalRequest AS DataRetrievalRequest NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE-HANDLE LastTempTableHandle.
//DEFINE OUTPUT PARAMETER DATASET-HANDLE phDataset .
DEFINE OUTPUT PARAMETER DataRetrievalResponse AS DataRetrievalResponse NO-UNDO.

/* --------------------------------------------------------------------- */

DEFINE VARIABLE GenericDataRetrievalHandler AS GenericDataRetrievalHandler NO-UNDO.

ASSIGN GenericDataRetrievalHandler = NEW GenericDataRetrievalHandler().
ASSIGN DataRetrievalResponse = NEW DataRetrievalResponse().

ASSIGN LastTempTableHandle = GenericDataRetrievalHandler:RetrievalData(DataRetrievalRequest, OUTPUT DataRetrievalResponse).




