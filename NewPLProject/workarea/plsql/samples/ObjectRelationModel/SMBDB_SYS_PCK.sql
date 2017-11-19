--------------------------------------------------------------------------------
-- Package containing generic functions and procedures
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Package containing system functions and procedures
--------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE "SYSADM"
AS
function "GET_ID" (
  value_in in varchar2
, tab_name_in in varchar2
, id_col_in in varchar2 := null
, val_col_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'XT$'
, sql_text_in varchar2 := null
)
return number;

function "GET_VAL" (
  id_in in number
, tab_name_in in varchar2
, id_col_in in varchar2 := null
, val_col_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'XT$'
, sql_text_in varchar2 := null
)
return varchar2;

procedure "CREATE_OBJ_TAB" (
  tab_name_in in varchar2
, col_name_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'T$'
, tablespace_in in varchar2 := user
, idx_tablespace_in in varchar2 := 'SMBDB_IDX'
, create_id_seq in boolean := true
, create_unique_name_idx in boolean := true
, replace_if_exists boolean := false
, p_debug boolean := false );

end; -- EOS
/

SHOW ERRORS PACKAGE "SYSADM";

-- Body
CREATE OR REPLACE PACKAGE BODY "SYSADM"
AS

function "GET_ID" (
  value_in in varchar2
, tab_name_in in varchar2
, id_col_in in varchar2 := null
, val_col_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'XT$'
, sql_text_in varchar2 := null
)
return number
is
l_id_col varchar2(30);
l_val_col varchar2(30);
l_id number;
str varchar2(2000);
begin
    if id_col_in is null then
        l_id_col := upper(tab_name_in) || '_ID';
    else
        l_id_col := upper(id_col_in);
    end if;
    if val_col_in is null then
        l_val_col := upper(tab_name_in) || '_NAME';
    else
        l_val_col := upper(val_col_in);
    end if;
    str := 'SELECT "'||l_id_col||'" ';
    str := str|| 'FROM "'||upper(tab_owner_in)||'"."'||tab_prefix_in||upper(tab_name_in)||'" ';
    str := str|| 'WHERE upper("'||l_val_col||'") = upper(:a)';
    --DBMS_OUTPUT.PUT_LinE(str);
    if sql_text_in is not null then
        execute immediate sql_text_in into l_id using value_in;
    else
        execute immediate str into l_id using value_in;
    end if;
return l_id;
exception when others then
return null;
end;

function "GET_VAL" (
  id_in in number
, tab_name_in in varchar2
, id_col_in in varchar2 := null
, val_col_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'XT$'
, sql_text_in varchar2 := null
)
return varchar2
is
l_id_col varchar2(30);
l_val_col varchar2(30);
l_val varchar2(512);
str varchar2(2000);
begin
    if id_col_in is null then
        l_id_col := upper(tab_name_in) || '_ID';
    else
        l_id_col := upper(id_col_in);
    end if;
    if val_col_in is null then
        l_val_col := upper(tab_name_in) || '_NAME';
    else
        l_val_col := upper(val_col_in);
    end if;
    str := 'SELECT "'||l_val_col||'" ';
    str := str|| 'FROM "'||upper(tab_owner_in)||'"."'||tab_prefix_in||upper(tab_name_in)||'" ';
    str := str|| 'WHERE "'||l_id_col||'" = :a';
    --DBMS_OUTPUT.PUT_LINE(str);
    if sql_text_in is not null then
        execute immediate sql_text_in into l_val using id_in;
    else
        execute immediate str into l_val using id_in;
    end if;
return l_val;
exception when others then
return null;
end;

procedure "CREATE_OBJ_TAB" (
  tab_name_in in varchar2
, col_name_in in varchar2 := null
, tab_owner_in in varchar2 := user
, tab_prefix_in in varchar2 := 'T$'
, tablespace_in in varchar2 := user
, idx_tablespace_in in varchar2 := 'SMBDB_IDX'
, create_id_seq in boolean := true
, create_unique_name_idx in boolean := true
, replace_if_exists boolean := false
, p_debug boolean := false )
is
str varchar2(2000);
l_tab_name ALL_TABLES.TABLE_NAME%TYPE;
l_col_name ALL_TAB_COLUMNS.COLUMN_NAME%TYPE;
l_obj ALL_OBJECTS.OBJECT_NAME%TYPE;
l_msg varchar2(512);
    procedure exec_str (
      msg_in in varchar2
    , obj_type_in in varchar2
    , obj_name_in in varchar2)
    is
    begin
        if not p_debug then
            if replace_if_exists AND dbxt_ver.isobject(obj_type_in, tab_owner_in, l_obj) then
                dbxt_sys.drop_object(tab_owner_in, obj_type_in, obj_name_in);
            end if;
            execute immediate str;
            dbxt_sys.p (msg_in, 80, false, dbxt_sys.pad);
            dbxt_sys.p (dbxt_sys.ok);
        else
            dbxt_sys.p (str);
        end if;
    end;
begin
    -- set local variables
    l_tab_name := upper(tab_name_in);
    if col_name_in is null then
        l_col_name := upper(l_tab_name);
    else
        l_col_name := upper(col_name_in);
    end if;

    -- set object
    l_obj := upper(tab_prefix_in)||l_tab_name;
    -- set stage message
    l_msg := 'Creating Table: "'||upper(tab_owner_in)||'"."'||l_obj||'"';
    -- set string
    str := 'create table "'||upper(tab_owner_in)||'"."'||upper(tab_prefix_in)||l_tab_name||'" (';
    str := str ||'"'||l_col_name||'_ID" number  not null';
    str := str ||', "'||l_col_name||'_NAME" varchar2(512) not null';
    str := str ||', constraint "'||upper(tab_prefix_in)||l_tab_name||'_PK" primary key ("'||l_col_name||'_ID")';
    str := str ||') tablespace "'||upper(tablespace_in)||'" logging';

    exec_str (l_msg, 'TABLE', l_obj);

    if create_unique_name_idx then
        -- set object
        l_obj := upper(tab_prefix_in)||l_tab_name||'_NAME_UQ';
        -- set stage message
        l_msg := 'Creating Unique Index for Table: "'||upper(tab_owner_in)||'"."'||l_obj||'"';
        -- set string
        str := 'CREATE UNIQUE inDEX "'||upper(tab_owner_in)||'"."'||l_obj||'"';
        str := str ||' ON "'||upper(tab_owner_in)||'"."'||upper(tab_prefix_in)||l_tab_name;
        str := str ||'" (upper("'||l_col_name||'_NAME")) TABLESPACE "'||upper(idx_tablespace_in)||'"';

        exec_str (l_msg, 'inDEX', l_obj);

    end if;

    if create_id_seq then
        -- set object
        l_obj := upper(tab_prefix_in)||l_tab_name||'_ID_SEQ';
        -- set stage message
        l_msg := 'Creating ID Sequence for Table: "'||upper(tab_owner_in)||'"."'||l_obj||'"';
        -- set string
        str := 'CREATE SEQUENCE "'||upper(tab_owner_in)||'"."'||l_obj||'"';
        str := str ||' START WITH 1 inCREMENT BY 1 NOCACHE';

        exec_str (l_msg, 'SEQUENCE', l_obj);

    end if;

exception when others then
        dbxt_sys.pl (CHR(10)||l_msg ||' failed:');
        dbxt_sys.pl (SQLERRM);
end;


end; -- EOB
/

SHOW ERRORS PACKAGE BODY "SYSADM";
