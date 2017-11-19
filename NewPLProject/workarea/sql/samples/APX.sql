-----------------------------------------------------------------------------------------------------
-- Apex Object Table to provides Types and Indetifiers to the APX Schema

-- drop first
drop synonym  "APEX_APX";

drop sequence "APX$_ID_SEQ";
drop trigger "APX$_BIU_TRG";

drop table "APX$" purge;

-----------------------------------------------------------------------------------------------------
-- Apex Object Table to provides Types and Indetifiers to the APX Schema
create table "APX$"(
apx_id number not null,
apx_obj_type varchar2(64) not null,
apx_code varchar2(12),
apx_parent_apx_obj_type_id number,
apx_sec_level number default 0,
app_id number,
created date,
created_by varchar2(64),
modified date,
modified_by varchar2(64),
constraint "APX$_ID" primary key (apx_id),
constraint "APX$_PARENT_FK" foreign key (apx_parent_apx_obj_type_id) references "APX$"(APX_ID)
);

create unique index "APX$_UNQ1" on "APX$"(apx_id,  app_id);
create unique index "APX$_UNQ2" on "APX$"(upper(apx_obj_type),  upper(apx_code),  app_id);

create sequence "APX$_ID_SEQ" start with 1 increment by 1 nocache;

create or replace trigger "APX$_BIU_TRG"
before insert or update on "APX$"
referencing old as old new as new
for each row
begin
  if inserting then
    if (:new.apx_id is null) then
        select "APX$_ID_SEQ".NEXTVAL
        into :new.apx_id
        from dual;
    end if;
    select sysdate,  nvl(v('APP_USER'),  user)
    into :new.created, :new.created_by
    from dual;
  elsif updating then
    select sysdate,  nvl(v('APP_USER'),  user)
    into :new.modified, :new.modified_by
    from dual;
  end if;
end;
/

create synonym  "APEX_APX"               for "APX$";

-------------------------------------------------------------------------------------------------
-- INSERTING into APX$
set define off;

insert into "APX$" (APX_ID, APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values (0,  'DEFAULT', null, null, '0', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('APPLICATION', 'APP', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('SECURITY', 'SEC', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('SERVER', 'SRV', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('BROWSER', 'BRW', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('USER', 'USR', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PROCESS', 'PRC', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('LANGUAGE', 'LANG', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('METHOD', 'METH', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('ARGUMENT', 'ARG', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('APPLICATION PROGRAMMING INTERFACE', 'API', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('FRAMEWORK', 'FRW', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PROTOCOL', 'PROT', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('FORMAT', 'FRM', null, '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('APPLICATION_PROCESS', 'APPRC', '1', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PL/SQL', 'PLSQL', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('JAVASCRIPT', 'JS', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('JQUERY', 'JQ', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('ANGULAR', 'NG', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('TYPESCRIPT', 'TS', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('SASS', 'SASS', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('SCSS', 'SCSS', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('CSS', 'CSS', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('HTML', 'HTML', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('JSON', 'JSON', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('CSV', 'CVS', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('XML', 'XML', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('XTD', 'XTD', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PDF', 'PDF', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('IMAGE', 'IMG', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('BINARY', 'BIN', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('CHARACTER', 'CHAR', '13', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('SOAP', 'SOAP', '12', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('REST_API', 'REST', '12', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('ASYNC_CALL', 'AJAX', '12', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('CALLBACK', 'CB', '12', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('STREAM', 'STREAM', '12', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('TYPE', 'TYPE', '7', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('OBJECT', 'OBJ', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('ARRAY', 'ARR', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('STRING', 'STR', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('NUMBER', 'INT', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('DATE', 'DATE', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('BOOLEAN', 'BOOL', '37', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('IDENTIFIER', 'ID', '38', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('VALUE', 'VAL', '38', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
 values ('REALM', 'REALM', '2', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('TOKEN', 'TKN', '2', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('CALL', 'CALL', '8', '1', null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PACKAGE', 'PKG', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PACKAGE_SPEC', 'PKS', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PACKAGE_BODY', 'PKB', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PROCEDURE', 'PRC', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('FUNCTION', 'FNC', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('FUNCTION_BODY_RETURNING_BOOLEAN', 'FNCRB', 2, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('TRIGGER', 'TRG', 15, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('FUNCTION', 'JSFNC', 16, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('VARIABLE', 'JSVAR', 16, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('OBJECT', 'JSOBJ', 16, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('REQUEST', 'REQ', 12, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('RESPONSE', 'RSP', 58, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('GET', 'GET', 58, 1, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('PUT', 'PUT', 58, 2, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('POST', 'POST', 58, 3, null);
insert into "APX$" (APX_OBJ_TYPE, APX_CODE, APX_PARENT_APX_OBJ_TYPE_ID, APX_SEC_LEVEL, APP_ID)
values ('DELETE', 'DEL', 58, 4, null);


commit;
