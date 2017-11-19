------------------------------------------------------------------
-- Usage: @show_trg_errors.sql [TRIGGER_NAME]
------------------------------------------------------------------
SET VERIFY OFF FEEDBACK OFF
SET LINE 400
COL "TEXT" FORM a80 WORD_WRAPPED
COL "SOURCE_TEXT" FORM a200 WORD_WRAPPED

-- Script Variables for Debugging
VARIABLE trg VARCHAR2(30);
BEGIN
    SELECT UPPER('&1') INTO :trg FROM DUAL;
END;
/

VARIABLE min_line NUMBER;
VARIABLE max_line NUMBER;

SELECT TYPE, LINE, TEXT
FROM user_errors
WHERE name = :trg
AND TYPE = 'TRIGGER'
ORDER BY LINE;

BEGIN
    SELECT NVL(MIN(LINE),0), NVL(MAX(LINE),0)
    INTO :min_line, :max_line
    FROM user_errors
    WHERE name = :trg
    AND TYPE = 'TRIGGER' ORDER BY LINE;
END;
/

SELECT TYPE, line, text "SOURCE_TEXT"
FROM user_source
WHERE LINE BETWEEN :min_line AND :max_line AND name = :trg AND type = 'TRIGGER';

PROMPT

SET VERIFY ON FEEDBACK ON
