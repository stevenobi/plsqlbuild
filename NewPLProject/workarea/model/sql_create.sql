-- SQL File created
set pages 0 line 120 define on verify off set feed off
alter session set nls_date_format='DD.MM.YYYY HH24:MI:SS';
select sysdate || '     Creating: "&1. Database Model"' as install_message
from dual;
exit;