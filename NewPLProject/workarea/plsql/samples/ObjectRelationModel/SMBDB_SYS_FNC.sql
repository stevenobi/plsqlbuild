
--------------------------------------------------------------------------------
-- return a unique identifier
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION "SMBDB_SYS"."OBJUID"
RETURN NUMBER
IS
retval NUMBER(32);
BEGIN
    retval := TO_NUMBER(SUBSTR(REPLACE(TO_CHAR(SYSTIMESTAMP,'DDMMYYYYHH24MISSXFF'), ',', ''), 1, 17)) ||
                 TO_NUMBER(SUBSTR(dbms_random.value(1,999999999),1, 3));
    RETURN retval;
EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
/
