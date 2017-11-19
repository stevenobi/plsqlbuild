-----------------------------------------------------------------------------------------------------
-- App Processes Table (Procedures,  Functions,  Authorization Items, ...)

-- drop first
drop synonym  "APX_APP_CONTEXT";

drop sequence "APX$CTX_ID_SEQ";
drop trigger "APX$CTX_BIU_TRG";

drop table "APX$CTX" purge;

-----------------------------------------------------------------------------------------------------
-- App Processes Table (Procedures,  Functions,  Authorization Items, ...)
create table "APX$CTX"(
app_ctx_id number not null,  -- extra field for certain predefined values like 0,  1, ...
app_context varchar2(128) not null,
app_context_value varchar2(4000),
app_context_code varchar2(12),
app_parent_context_id number,
app_context_type_id number,
app_context_sec_level number default 0,
app_process_type_id number,
app_id number,
created date,
created_by varchar2(64),
modified date,
modified_by varchar2(64),
constraint "APX$CTX_ID" primary key (app_ctx_id),
constraint "APX$CTX_TYPE_FK" foreign key (app_process_type_id) references "APX$"(apx_id) on delete set null,
constraint "APX$CTX_PARENT_FK" foreign key (app_parent_context_id) references "APX$CTX"(app_ctx_id)
);

create unique index "APX$CTX_UNQ1" on "APX$CTX"(app_ctx_id,  app_id);
create unique index "APX$CTX_UNQ2" on "APX$CTX"(upper(app_context),  upper(app_context_code),  app_id);

create sequence "APX$CTX_ID_SEQ" start with 1 increment by 1 nocache;

create or replace trigger "APX$CTX_BIU_TRG"
before insert or update on "APX$CTX"
referencing old as old new as new
for each row
begin
  if inserting then
    if (:new.app_ctx_id is null) then
        select "APX$CTX_ID_SEQ".NEXTVAL
        into :new.app_ctx_id
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

create synonym  "APX_APP_CONTEXT"               for "APX$CTX";


-------------------------------------------------------------------------------------------------
-- INSERTING into APX$CTX
set define off;

insert into "APX$CTX" (CTX_ID, APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values (0,  'DEFAULT', null, null, '0', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('HOST', 'HOST', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('SECURITY', 'SEC', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('SERVICE', 'SRV', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('DATABASE', 'DB', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('APPLICATION_SERVER', 'APPSRV', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('WEB_SERVER', 'WEBSRV', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('ORACLE_RESTFUL_SERVICE', 'ORDS', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('APEX', 'APX', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('WORKSPACE', 'WS', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('APPLICATION', 'APP', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('PAGE', 'PAGE', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('REGION', 'REGION', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('REPORT', 'REP', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('ITEM', 'ITEM', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('PROCESS', 'PRC', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('SUBSCRIBER', 'SUB', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('PUBLISHER', 'PUB', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('FILES', 'FILES', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('VIEW', 'VIEW', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('MODEL', 'MODL', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('TEMPLATE', 'TMPL', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('THEME', 'THM', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('USER', 'USR', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('GROUP', 'GRP', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('ROLE', 'ROLE', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('DOMAIN', 'DOM', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('SESSION', 'SES', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('AUTHENTICATION', 'AUTH', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('AUTHORIZATION', 'AUT', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('SERVER', 'SERVER', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('CLIENT', 'CLIENT', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('DESIGN', 'DESIGN', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('MEDIA', 'MEDIA', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('MODEL', 'MODEL', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('STAGING', 'STG', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('INTEGRATION', 'INT', null, '1', null);
insert into "APX$CTX" (APP_CONTEXT, APP_CONTEXT_CODE, APP_PARENT_CTX_ID, APP_CONTEXT_SEC_LEVEL, APP_ID)
values ('PRODUCTION', 'PRD', null, '1', null);


commit;
