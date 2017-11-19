set line 1000
col text form a100
select line, text
from dba_source
where name = UPPER('&1')
and type = 'PACKAGE BODY'
and line between &begin_line and &end_line;
cle col
