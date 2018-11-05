 &GLOBAL-DEFINE FlatSelectedPageForeGround 91 /*border*/
    &GLOBAL-DEFINE FlatSelectedPageBackGround 92
    &GLOBAL-DEFINE FlatUnSelectedPageForeGround 93 /*border*/
    &GLOBAL-DEFINE FlatUnSelectedPageBackGround 94
    &GLOBAL-DEFINE FlatFolderBorderColor 95
    &GLOBAL-DEFINE FlatSelectedPageTextForeGround 96
    &GLOBAL-DEFINE FlatUnSelectedPageTextForeGround 97

    RUN SetColor(91, 0, 0, 0).
    RUN SetColor(92, 0, 0, 0).
    RUN SetColor(93, 0, 0, 0).
    RUN SetColor(94, 0, 0, 0).
    RUN SetColor(95, 0, 0, 0).
    RUN SetColor(96, 0, 0, 0).
    RUN SetColor(97, 0, 0, 0).

    RUN SetColor(97, 255, 0, 0).
    /* dark grey */
    /*
    RUN SetColor(91, 116, 116, 116).
    RUN SetColor(92, 116, 116, 116).
    RUN SetColor(93, 0, 0, 0).
    RUN SetColor(94, 255, 255, 255).
    RUN SetColor(95, 0, 0, 0).
    RUN SetColor(96, 255, 255, 255).
    RUN SetColor(97, 0, 0, 0).
    */

    /* light grey */
    /*
    RUN SetColor(91, 222, 222, 222).
    RUN SetColor(92, 166, 166, 166).
    RUN SetColor(93, 0, 0, 0).
    RUN SetColor(94, 255, 255, 255).
    RUN SetColor(95, 0, 0, 0).
    RUN SetColor(96, 255, 255, 255).
    RUN SetColor(97, 0, 0, 0).

    */

    /*white*/
    /*
    RUN SetColor(91, 235, 235, 235).
    RUN SetColor(92, 242, 242, 242).
    RUN SetColor(93, 170, 170, 170).
    RUN SetColor(94, 255, 255, 255).
    RUN SetColor(95, 170, 170, 170).
    RUN SetColor(96, 0, 0, 0).
    RUN SetColor(97, 0, 0, 0).
    */

    /*****************************************************************************/

    PROCEDURE SetColor:

        DEFINE INPUT PARAMETER ColorIndex AS INTEGER NO-UNDO.
        DEFINE INPUT PARAMETER RedValue AS INTEGER NO-UNDO.
        DEFINE INPUT PARAMETER GreenValue AS INTEGER NO-UNDO.
        DEFINE INPUT PARAMETER BlueValue AS INTEGER NO-UNDO.

        /* --------------------------------------------------------------------- */

        COLOR-TABLE:SET-DYNAMIC(ColorIndex, YES).
        COLOR-TABLE:SET-RED-VALUE(ColorIndex, RedValue).
        COLOR-TABLE:SET-GREEN-VALUE(ColorIndex, GreenValue).
        COLOR-TABLE:SET-BLUE-VALUE(ColorIndex, BlueValue).

    END PROCEDURE.
