

//USING Playground.Serializer.Serializer FROM PROPATH.
USING Consultingwerk.OERA.FetchDataRequest FROM PROPATH.
USING be.mips.ablframework.shared.serialization.Serializer FROM PROPATH.

DEFINE VARIABLE TheObject AS FetchDataRequest NO-UNDO.

TheObject = NEW FetchDataRequest(). // NEW Serializer().

MESSAGE STRING(TheObject:Serialize()) VIEW-AS ALERT-BOX.

//Serializer:SerializeToJson(TheObject).

//Serializer:SaveObjectToTempFolder("Serializer.json", TheObject).

//MESSAGE "done save to " SESSION:TEMP-DIRECTORY VIEW-AS ALERT-BOX.



