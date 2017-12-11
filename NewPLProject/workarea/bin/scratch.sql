

--Suffixes applicable', 'Media type and subtype(s)


create unique index "APX$CFG_UNQ2" on "APX$CFG"(upper(apx_config_name), apx_config_ctx_id, app_id);
create index "APX$CFG_STAT" on "APX$CFG"(apx_config_status_id);
create index "APX$CFG_CONTEXT" on "APX$CFG"(apx_config_ctx_id);

create sequence "APX$CFG_SEQ" minvalue 0 start with 0 increment by 5 nocache;

create or replace trigger "APX$CFG_BIU_TRG"
before insert or update on "APX$CFG"
referencing old as old new as new
for each row
begin
  if inserting then
    if (:new.apx_config_id is null) then
        select "APX$CFG_SEQ".NEXTVAL
        into :new.apx_config_id
        from dual;
    end if;
    select sysdate, nvl(v('APP_USER'), user)
    into :new.created, :new.created_by
    from dual;
  elsif updating then
    select sysdate, nvl(v('APP_USER'), user)
    into :new.modified, :new.modified_by
    from dual;
  end if;
end;
/

create synonym  "APEX_CONFIG"           for "APX$CFG";
create synonym  "APEX_SETTING"         for "APX$CFG";

/*
--File Type Icons


'fa-file'
'fa-file-archive-o'
'fa-file-audio-o'
'fa-file-code-o'
'fa-file-excel-o'
'fa-file-image-o'
'fa-file-movie-o'
'fa-file-o'
'fa-file-pdf-o'
'fa-file-photo-o'
'fa-file-picture-o'
'fa-file-powerpoint-o'
'fa-file-sound-o'
'fa-file-text'
'fa-file-text-o'
'fa-file-video-o'
'fa-file-word-o'
'fa-file-zip-o'
*/

update APX$MIME_TYPE m
set M.MIME_TYPE_MEDIA_CLASS_ID = (
select apx_id from (
select a.apx_id
from APX$ a
where lower(a.apx_object) = substr(m.mime_type, 1, instr(m.mime_type, '/') -1)
and a.apx_parent_object_id = 65)
);

commit;

create function  "APX_GET_VERSION" (
p_comp_id varchar2
) return varchar2
is
l_version          VARCHAR2 (20) := null;
db_version         VARCHAR2 (20) := '12.1.0.2.0';
apx_version        VARCHAR2 (20) := '5.1.3.00.05';
BEGIN
-- // TODO
---- Find alternative ways to get version without dba_registry
-- select substr(version, 1,2)
-- into l_version
-- from dba_registry
-- where comp_id = (p_comp_id);
case upper(p_comp_id)
    when 'CATALOG'
    then
    return  db_version;
    when 'APEX'
    then
    return apx_version;
    else
    return l_version;
end case;
exception when others then
return null;
END "APX_GET_VERSION";
/

select apx_get_version('APEX') from dual;



create or replace view "APEX_SEC_CODE3"
as
select substr(to_char(abs(dbms_random.random())), 1, 3) code1,
       substr(to_char(abs(dbms_random.random())), 3, 3) code2,
       substr(to_char(abs(dbms_random.random())), 5, 3) code3,
       substr(to_char(abs(dbms_random.random())), 2, 3) code4
from dual;

create or replace view "APEX_SEC_CODE4"
as
select substr(to_char(abs(dbms_random.random())), 1, 4) code1,
       substr(to_char(abs(dbms_random.random())), 3, 4) code2,
       substr(to_char(abs(dbms_random.random())), 5, 4) code3,
       substr(to_char(abs(dbms_random.random())), 2, 5) code4
from dual;

create or replace view "APEX_SEC_CODE6"
as
select substr(to_char(abs(dbms_random.random())), 1, 6) code1,
       substr(to_char(abs(dbms_random.random())), 3, 6) code2,
       substr(to_char(abs(dbms_random.random())), 5, 6) code3,
       substr(to_char(abs(dbms_random.random())), 2, 6) code4
from dual;


select * from "APEX_SEC_CODE3";
select * from "APEX_SEC_CODE4";
select * from "APEX_SEC_CODE6";

create or replace view "APEX_SEC_CODE_PICKER"
as
select pickcode1, case when pickcode2 = pickcode1 then decode(pickcode2-1, 0, 4, pickcode2-1) else pickcode2 end as pickcode2
from (
select trunc(dbms_random.value(1,4)) as pickcode1,trunc(dbms_random.value(1,4)) pickcode2
from dual
);

select * from "APEX_SEC_CODE_PICKER";

declare
l_sql varchar2(4000);
pc1 number;
pc2 number;
c1 pls_integer;
c2 pls_integer;
begin
select pickcode1, pickcode2
into pc1, pc2
from "APEX_SEC_CODE_PICKER";
l_sql := 'select code'||pc1||', code'||pc2||' from "APEX_SEC_CODE3"';
execute immediate l_sql into c1, c2;
dbms_output.put_line('c'||pc1||': '|| c1||' c'||pc2||': '||c2);
end;
/

declare
l_input_str varchar2(1000) := 'MyString';
l_token varchar2(4000);
begin
  l_token := replace(UTL_RAW.CAST_TO_VARCHAR2(||
                       UTL_ENCODE.BASE64_ENCODE(||
                         UTL_RAW.CAST_TO_RAW(ABS(DBMS_RANDOM.random())||
                           l_input_str||ABS(DBMS_RANDOM.random())))), CHR(13)||CHR(10),'');
end;
/

