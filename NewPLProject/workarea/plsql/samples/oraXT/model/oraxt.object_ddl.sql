
------------------------------------------------------------------------------------------------------------------------
-- Cleanup Section
------------------------------------------------------------------------------------------------------------------------

drop table"X$DSC" cascade constraints purge;
drop table "X$DEF" cascade constraints purge;
drop table "X$TYP" cascade constraints purge;
drop table "X$AUD" cascade constraints purge;
drop table "X$HST" cascade constraints purge;


-- Synonyms
drop public synonym "HIST_TABLES";

-- Views
drop view "XTV$TYPE";
drop view "XTV$DEFAULT";

------------------------------------------------------------------------------------------------------------------------
-- System Tables
------------------------------------------------------------------------------------------------------------------------

create table "X$REG" (
  reg_id number not null
, reg_pid number
, reg_name varchar2(30)
, reg_value varchar2(512)
, constraint "X$REG_PK" primary key ("REG_ID")
) organization index;


create table "X$DSC" (
  desc_id number not null
, description varchar2(10000)
, constraint "X$DSC_PK" primary key ("DESC_ID")
) organization index overflow;

create sequence "X$DSC_SEQ" start with 1 nocache;


------------------------------------------------------------------------------------------------------------------------
-- Class and Object Tables
------------------------------------------------------------------------------------------------------------------------

create table "X$ATTR" (
  attr_id number not null
, attr_pid number
, attr_name varchar2(30)
, attr_value varchar2(512)
) organization index ;

create table "X$PARAM" (
  param_id number not null
, param_pid number
, param_name varchar2(30)
, param_value varchar2(512)
) organization index ;


create table "X$PROP" (
  prop_id number not null
, prop_pid number
, prop_name varchar2(30)
, prop_value varchar2(512)
) organization index ;





create table "X$CLASS" (
  class_id number not null
, class_pid number
, class_name varchar2(30)
, class_value varchar2(512)
) organization index overflow;


create table "X$OBJ" (
  obj_id number not null
, obj_pid number
, obj_name varchar2(30)
, obj_value varchar2(512)
) organization index overflow;





create table "X$TYP" (
  type_id number not null
, type_pid number
, create_object number default 0
, create_class number default 0
, type_name varchar2(30)
, type_value varchar2(512)
, type_description varchar2(512)
, constraint "X$TYP_PK" primary key ("TYPE_ID")
, constraint "X$TYP_CO_CHK" check ("CREATE_OBJECT" in (0, 1))
, constraint "X$TYP_CO_CHK" check ("CREATE_CLASS" in (0, 1))
) organization index;

alter table "X$TYP" add constraint"X$TYP_PID" foreign key ("TYPE_PID") references "X$TYP" ("TYPE_ID");

insert into "X$TYP" values( 0, null, 1, 1, 'SYSTEM', 'SYSXT', 'Systemroot');
insert into "X$TYP" values( 1, 0, 1, 1, 'DATABASE', 'XE', 'System Database');
insert into "X$TYP" values( 2, 1, 1, 1, 'TYPE', null, 'Database Datatype');
insert into "X$TYP" values( 3, 1, 1, 1, 'TABLE', null, 'Database Table');
insert into "X$TYP" values( 4, 3, 1, 1, 'COLUMN', null, 'Database Table Column');
insert into "X$TYP" values( 5, 4, 1, 1, 'TABLE_AUDIT_COLUMN', null, 'Database Table Audit Column');

commit;

create table X$DEF (
  def_id number not null
, def_pid number
, def_name varchar2(30)
, def_value varchar2(512)
, def_type_id number
, def_description varchar2(512)
, constraint "X$DEF_PK" primary key ("DEF_ID")
) organization index;

alter table "X$DEF" add constraint"X$DEF_PID" foreign key ("DEF_PID") references "X$DEF" ("DEF_ID");
alter table "X$DEF" add constraint"X$DEF_TYPEID" foreign key ("DEF_TYPE_ID") references "X$TYP" ("TYPE_ID");

insert into "X$DEF" values ( 0, null, 'DEFAULT', 'NULL', null, null);
insert into "X$DEF" values ( 1, 0, 'CREATED', 'sysdate', 5, null);
insert into "X$DEF" values ( 2, 0, 'CREATED_BY', 'user', 5, null);
insert into "X$DEF" values ( 3, 0, 'MODIFIED', 'sysdate', 5, null);
insert into "X$DEF" values ( 4, 0, 'MODIFIED_BY', 'user', 5, null);
insert into "X$DEF" values ( 5, 0, 'MODIFY_DML_CMD', 'user', 5, null);

commit;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Views
create or replace view "XTV$TYPE"
as
select
  t1.type_id
, t1.type_pid
, t1.type_name
, t2.type_name parent_type_name
, t1.type_value
, t1.type_description
, t2.type_description as parent_type_description
from "X$TYP" t1 left join "X$TYP" t2
on t1.type_pid = t2.type_id
order by 1;

create or replace view "XTV$DEFAULT"
as
select
    def.def_id,
    def.def_pid,
    def.def_name as default_name,
    def.def_value as default_value,
    typ.type_name as default_type,
    typ.parent_type_name as default_parent_type,
    def.def_description as default_description
from "X$DEF" def
left join "XTV$TYPE" typ
on  def.def_type_id = typ.type_id
order by 1;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Audit
create table "X$AUD" (
  aud_id number not null
, aud_seq number not null
, aud_date date default sysdate not null
, aud_owner varchar2(30)  default user not null
, aud_table_name varchar2(30) not null
, aud_table_pk varchar2(128) not null
, aud_default_value_id number
, created date default sysdate
, created_by varchar2(30) default user
, modified date default sysdate
, modified_by varchar2(30) default user
, modify_dml_cmd varchar2(10) default 'UPDATE'
, aud_value varchar2(512)
, aud_description varchar2(4000)
, constraint "X$AUD_PK" primary key ("AUD_ID")
, constraint "X$AUD_DEFVAL_FK" foreign key ("AUD_DEFAULT_VALUE_ID") references "X$DEF" ("DEF_ID")
) organization index overflow;

-- History Tables (Registry)
create table "X$HSTREG" (
  table_owner varchar2(30) not null
, table_name varchar2(30) not null
, hst_enabled number default 1 not null
, constraint "X$HSTREG_UQ" unique (table_owner, table_name)
);

create public synonym history_registry for x$hstreg;
grant select on history_registry to public;

/**
insert into "X$HST" (table_owner, table_name) values ('HR', 'BS');
commit;
**/


