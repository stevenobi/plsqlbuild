------------------------------------------------------------------
-- Usage: @show_errors.sql [PACKAGE_NAME]
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

VARIABLE min_line NUMBER;
VARIABLE max_line NUMBER;

SELECT TYPE, LINE, TEXT FROM user_errors
WHERE name = :pkg
AND TYPE = 'PACKAGE' ORDER BY LINE;

SELECT TYPE, LINE, TEXT FROM user_errors
WHERE name = :pkg
AND TYPE = 'PACKAGE BODY' ORDER BY LINE;

BEGIN
    SELECT NVL(MIN(LINE),0), NVL(MAX(LINE),0)
    INTO :min_line, :max_line
    FROM user_errors
    WHERE name = :pkg
    AND TYPE = 'PACKAGE' ORDER BY LINE;
END;
/

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE LINE BETWEEN :min_line AND :max_line
AND name = :pkg
AND type = 'PACKAGE';

BEGIN
    SELECT NVL(MIN(LINE),0), NVL(MAX(LINE),0)
    INTO :min_line, :max_line
    FROM user_errors
    WHERE name = :pkg
    AND TYPE = 'PACKAGE BODY' ORDER BY LINE;
END;
/

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE LINE BETWEEN :min_line AND :max_line
AND name = :pkg
AND type = 'PACKAGE BODY';

PROMPT

SET VERIFY ON FEEDBACK ON
