/*in ContextCache.cls*/
/**/
/*common dataset*/
{ gp_ContextConfig.i &ACCESS=PROTECTED }
    METHOD PROTECTED HANDLE ReadContextConfigAsync(TableId AS INTEGER, LoadRibbonAndQat AS LOGICAL, AppServerHandle AS HANDLE):

        DEFINE VARIABLE RibbonId AS INTEGER NO-UNDO INITIAL ?.
        DEFINE VARIABLE AsyncRequestHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE ContextTitle AS CHARACTER NO-UNDO.

        /* --------------------------------------------------------------------- */

        RUN gp_ReadContextConfig ON AppServerHandle
                    ASYNCHRONOUS SET AsyncRequestHandle
                    EVENT-PROCEDURE "ReceiveCachedContext":U IN ContextCacheAsyncEventReceiver
                        (INPUT LoadRibbonAndQat,
                        INPUT-OUTPUT TableId,
                        INPUT-OUTPUT RibbonId,
                        INPUT-OUTPUT DynamicMenuItemId,
                        OUTPUT ContextTitle,
                        OUTPUT TABLE w_Tool APPEND,
                        OUTPUT TABLE w_MenuItem APPEND,
                        OUTPUT TABLE w_RibbonTab APPEND,
                        OUTPUT TABLE w_RibbonGroup APPEND,
                        OUTPUT TABLE w_RibbonItem APPEND,
                        OUTPUT TABLE w_QAT APPEND,
                        OUTPUT TABLE w_QATItem APPEND).

         RETURN AsyncRequestHandle.

    END METHOD. /* ReadContextConfigAsync */

    /*in ContextCache show you how to do aync call to AppServer*/

    /*bind dataset*/
    BuildContext IN ContextBuilder.cls
    Framework:ContextCache:GetContextConfig(
                ContextualControl:ContextType,
                ContextTableId,
                LoadRibbonAndQat,
                INPUT-OUTPUT RibbonId,
                OUTPUT ContextTitle,
                OUTPUT DATASET ds_ContextConfig BIND,
                OUTPUT DATASET ds_QAT BIND).
            GetExtraContextConfig(ContextTableId).

