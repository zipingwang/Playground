DEFINE BUFFER b_File FOR dictdb._File.
FOR EACH b_File WHERE NOT b_File._Hidden NO-LOCK:
   
    //ASSIGN ttTables.TableName = dictdb._File._File-Name .  
    
    FOR EACH VALUE(b_File._File-Nam):
       LEAVE.
    END.
END. 
