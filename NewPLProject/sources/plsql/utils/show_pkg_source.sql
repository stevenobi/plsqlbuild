
------------------------------------------------------------------
-- Usage: @show_pgk_source.sql [PACKAGE_NAME]
------------------------------------------------------------------
SET VERIFY OFF FEEDBACK OFF
SET PAGES 9999
SET LINE 400
COL TEXT FORM a80 WRAP
COL "SOURCE_TEXT" FORM a200 WRAP

-- Script Variables for Debugging
VARIABLE pkg VARCHAR2(30);
BEGIN
    SELECT UPPER('&1') INTO :pkg FROM DUAL;
END;
/

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE name = :pkg
AND type = 'PACKAGE';

PROMPT

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE name = :pkg
AND type = 'PACKAGE BODY';

PROMPT

SET VERIFY ON FEEDBACK ON
