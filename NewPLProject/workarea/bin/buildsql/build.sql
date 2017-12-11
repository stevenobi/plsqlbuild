-- SQL Drop File
-- whenever oserror exit;
-- whenever sqlerror exit sql.sqlcode; -- useful only if drop.sql is used or in production mode
set pages 0 line 120 define on verify off set feed off
alter session set nls_date_format='DD.MM.YYYY HH24:MI:SS';
select sysdate || '     Dropping: "&1. Objects"' as install_message
from dual;

---------------------------------------------------------------
prompt
prompt Dropping DB Model (Tables)
prompt

prompt Table, View, Synonym


prompt
---------------------------------------------------------------

set pages 0 line 120 define off verify off set feed off timing off

--exit;


---------------------------------------------------------------

-- SQL Create File
----whenever oserror exit;
whenever sqlerror exit sql.sqlcode; -- useful only if drop.sql is used or in production mode
set pages 0 line 120 define on verify off set feed off
alter session set nls_date_format='DD.MM.YYYY HH24:MI:SS';
select sysdate || '     Creating: "&1. Database Model"' as install_message
from dual;
set feed on timing on

---------------------------------------------------------------
prompt
prompt Creating DB Model (Tables)

prompt
prompt Package 1
@"/fullPath/My.sql"
prompt
prompt Package2


---------------------------------
prompt
---------------------------------

set pages 0 line 120 define off verify off set feed off timing off

EXIT SQL.SQLCODE;
