
 /*------------------------------------------------------------------------
    File        : AssetManager
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : yvesvw
    Created     : Tue Jun 25 15:46:00 CEST 2013
    Notes       :
  ----------------------------------------------------------------------*/

USING be.mips.ablframework.AssetManager FROM PROPATH.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS be.mips.ablframework.AssetManager:

    { gp_debug.i }

    DEFINE PRIVATE STATIC VARIABLE AppRootPath AS CHARACTER NO-UNDO INITIAL ?.

    DEFINE PUBLIC STATIC PROPERTY Instance AS AssetManager
    GET:
        IF NOT VALID-OBJECT(Instance)
        THEN ASSIGN Instance = NEW AssetManager().
        RETURN Instance.
    END.
    PRIVATE SET(args AS AssetManager):
        Instance = args.
    END.

    /* ---------------------------------------------------------------------- */

    CONSTRUCTOR PRIVATE AssetManager():
        SUPER().
    END CONSTRUCTOR.

    /* ********************************************************************** */

    METHOD PUBLIC CHARACTER SearchAsset(RelativeFileName AS CHARACTER):

        DEFINE VARIABLE AbsolutePath AS CHARACTER NO-UNDO.

        /* ------------------------------------------------------------------ */

        IF AppRootPath = ?
        THEN DO:
            RUN gp_genv("MA_ROOT":U, OUTPUT AppRootPath).
            ASSIGN
                AppRootPath = REPLACE(AppRootPath, "~\":U, "/":U)
                AppRootPath = REPLACE(AppRootPath, "//":U, "/":U)
                AppRootPath = TRIM(AppRootPath, "/":U).
        END.

        /* search relative to the current working directory */
        ASSIGN FILE-INFO:FILE-NAME = SUBSTITUTE("assets/&1":U, RelativeFileName).
        ASSIGN AbsolutePath = FILE-INFO:FULL-PATHNAME.
        IF AbsolutePath > "":U
        THEN RETURN AbsolutePath.

        /* if not found, try the root directory */
        ASSIGN AbsolutePath = SUBSTITUTE("&1/&2":U, AppRootPath, RelativeFileName).
        IF FileExists(AbsolutePath)
        THEN RETURN AbsolutePath.

        ASSIGN AbsolutePath = SUBSTITUTE("&1/glims-abl-sources/gen/brw/&2":U, AppRootPath, RelativeFileName).
        IF FileExists(AbsolutePath)
        THEN RETURN AbsolutePath.

        /* if not found, try the local eclipse location */
        ASSIGN AbsolutePath = SUBSTITUTE("&1/4gl/gen/brw/&2":U, AppRootPath, RelativeFileName).
        IF FileExists(AbsolutePath)
        THEN RETURN AbsolutePath.
        /* if not found, try the server environment */
        ASSIGN AbsolutePath = SUBSTITUTE("&1/psrc/gen/brw/&2":U, AppRootPath, RelativeFileName).
        IF FileExists(AbsolutePath)
        THEN RETURN AbsolutePath.
        /* if not found, try PROPATH as last resort */
        RETURN SEARCH(RelativeFileName).

    END METHOD. /* SearchAsset */

    /* ********************************************************************** */

    METHOD PRIVATE LOGICAL FileExists(ThePath AS CHARACTER):

        ASSIGN FILE-INFO:FILE-NAME = ThePath.
        RETURN FILE-INFO:FULL-PATHNAME <> ?.

    END METHOD. /* FileExists */

END CLASS.
