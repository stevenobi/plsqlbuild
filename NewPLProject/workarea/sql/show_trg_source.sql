------------------------------------------------------------------
-- Usage: @show_trg_source.sql [TRIGGER_NAME]
------------------------------------------------------------------
SET VERIFY OFF FEEDBACK OFF
SET PAGES 9999
SET LINE 400
COL TEXT FORM a80 WRAP
COL "SOURCE_TEXT" FORM a200 WRAP

-- Script Variables for Debugging
VARIABLE trg VARCHAR2(30);
BEGIN
    SELECT UPPER('&1') INTO :trg FROM DUAL;
END;
/

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE name = :trg
AND type = 'TRIGGER';

PROMPT

SET VERIFY ON FEEDBACK ON
