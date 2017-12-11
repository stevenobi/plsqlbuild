-- SQL File created
set pages 0 line 120 define on verify off set feed off
alter session set nls_date_format='DD.MM.YYYY HH24:MI:SS';
select sysdate || '     Building: "&1. Version &2."' as install_message
from dual;

exit;