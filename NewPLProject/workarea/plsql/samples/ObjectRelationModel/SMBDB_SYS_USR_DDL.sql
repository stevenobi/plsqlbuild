--------------------------------------------------------------------------------
-- tablespaces for linux XE
--------------------------------------------------------------------------------
/***
create tablespace "SMBDB_SYS"
datafile '/usr/lib/oracle/xe/oradata/XE/smbdb_sys01.dbf' size 100m
autoextend on next 10240k maxsize unlimited;

create tablespace "SMBDB_IDX"
datafile '/usr/lib/oracle/xe/oradata/XE/smbdb_idx01.dbf' size 100m
autoextend on next 10240k maxsize unlimited;

create temporary tablespace "SMBDB_TMP"
tempfile '/usr/lib/oracle/xe/oradata/XE/smbdb_tmp01.dbf' size 100m
autoextend on next 10240k maxsize unlimited;

***/
--------------------------------------------------------------------------------

DROP ROLE "SMBDB_ADMIN" ;
DROP ROLE "SMBDB_DEVELOPER" ;
DROP ROLE "SMBDB_USER" ;

DROP  USER "SMBDB_SYS" CASCADE;

---------------------------------------------------------------------------

CREATE ROLE "SMBDB_ADMIN" NOT IDENTIFIED;
GRANT CREATE SESSION, RESOURCE TO "SMBDB_ADMIN";

CREATE ROLE "SMBDB_DEVELOPER" NOT IDENTIFIED;
GRANT CREATE SESSION TO "SMBDB_DEVELOPER";

CREATE ROLE "SMBDB_USER" NOT IDENTIFIED;
GRANT CREATE SESSION TO "SMBDB_USER";

GRANT "SMBDB_USER" TO "SMBDB_ADMIN";
GRANT "SMBDB_DEVELOPER" TO "SMBDB_ADMIN";

GRANT "SMBDB_USER" TO "SMBDB_DEVELOPER";

CREATE USER "SMBDB_SYS"
    IDENTIFIED BY "SMBDB_SYS"
    DEFAULT TABLESPACE "SMBDB_SYS"
    TEMPORARY TABLESPACE "SMBDB_TMP"
    QUOTA UNLIMITED ON "SMBDB_SYS"
    QUOTA UNLIMITED ON "SMBDB_IDX"
    ACCOUNT UNLOCK;

GRANT "SMBDB_ADMIN" TO "SMBDB_SYS";

GRANT DBA TO "SMBDB_SYS";
GRANT SELECT ANY TABLE TO "SMBDB_SYS";
GRANT CREATE ANY TABLE TO "SMBDB_SYS";
GRANT DROP ANY TABLE TO "SMBDB_SYS";
GRANT CREATE ANY SEQUENCE TO "SMBDB_SYS";
GRANT SELECT ANY DICTIONARY TO "SMBDB_SYS";
GRANT "EXECUTE_CATALOG_ROLE" TO "SMBDB_SYS";
GRANT EXECUTE ON "UTL_FILE" TO "SMBDB_SYS";

ALTER USER "SMBDB_SYS" DEFAULT ROLE ALL;
