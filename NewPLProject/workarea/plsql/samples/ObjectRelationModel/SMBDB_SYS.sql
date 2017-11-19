-- Generated by Oracle SQL Developer Data Modeler Version: 2.0.0 Build: 570
--   at:        2009-12-15 23:38:34
--   site:      Oracle Database 10g
--   type:      Oracle Database 10g



DROP VIEW SMBDB_SYS.ALL_OBJECT_ATTRIBUTES
;
DROP TABLE SMBDB_SYS.CTX_ATTR_MAP CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.OBJ_ATTR_MAP CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.TYPE_ATTR_MAP CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.X$ATTR CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.X$AUD CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.X$CTX CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.X$OBJ CASCADE CONSTRAINTS
;
DROP TABLE SMBDB_SYS.X$TYPES CASCADE CONSTRAINTS
;
CREATE ROLE SMBDB_USER
    NOT IDENTIFIED
;

GRANT CREATE SESSION TO SMBDB_USER
;

CREATE USER SMBDB_SYS
    IDENTIFIED BY SMBDB_SYS
    DEFAULT TABLESPACE SMBDB_SYS
        TEMPORARY TABLESPACE SMBDB_TMP01
    QUOTA UNLIMITED ON SMBDB_SYS
    QUOTA UNLIMITED ON SMBDB_IDX
    ACCOUNT UNLOCK
;

GRANT SMBDB_USER TO SMBDB_SYS
;

CREATE TABLE SMBDB_SYS.CTX_ATTR_MAP
    (
     CTXATTR_ID NUMBER  NOT NULL ,
     CTX_ID NUMBER  NOT NULL ,
     ATTR_ID NUMBER  NOT NULL ,
     CREATED DATE ,
     LAST_MODIFIED DATE ,
     DESCRIPTION VARCHAR2 (512 CHAR)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE UNIQUE INDEX CTXATTR_PKX ON SMBDB_SYS.CTX_ATTR_MAP
    (
     CTXATTR_ID ASC
    )
;
CREATE INDEX CTXATTR_ATTR_FKX ON SMBDB_SYS.CTX_ATTR_MAP
    (
     ATTR_ID ASC
    )
;
CREATE INDEX CTXATTR_CTX_FKX ON SMBDB_SYS.CTX_ATTR_MAP
    (
     CTX_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.CTX_ATTR_MAP
    ADD CONSTRAINT CTXATTR_PK PRIMARY KEY ( CTXATTR_ID ) ;


CREATE TABLE SMBDB_SYS.OBJ_ATTR_MAP
    (
     OBJATTR_ID NUMBER  NOT NULL ,
     OBJ_ID NUMBER  NOT NULL ,
     ATTR_ID NUMBER  NOT NULL ,
     CREATED DATE ,
     LAST_MODIFIED DATE ,
     VALUE VARCHAR2 (512 CHAR) ,
     OBJATTR_VC_1 VARCHAR2 (10 CHAR) ,
     OBJATTR_VC_2 VARCHAR2 (10 CHAR) ,
     OBJATTR_VC_3 VARCHAR2 (10 CHAR) ,
     OBJATTR_VC_4 VARCHAR2 (10 CHAR) ,
     OBJATTR_N_1 NUMBER ,
     OBJATTR_N_2 NUMBER ,
     OBJATTR_N_3 NUMBER ,
     OBJATTR_N_4 NUMBER
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE UNIQUE INDEX OBJATTR_PKX ON SMBDB_SYS.OBJ_ATTR_MAP
    (
     OBJATTR_ID ASC
    )
;
CREATE INDEX OBJATTR_OBJ_FKX ON SMBDB_SYS.OBJ_ATTR_MAP
    (
     OBJ_ID ASC
    )
;
CREATE INDEX OBJATTR_ATTR_FKX ON SMBDB_SYS.OBJ_ATTR_MAP
    (
     ATTR_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.OBJ_ATTR_MAP
    ADD CONSTRAINT OBJATTR_PK PRIMARY KEY ( OBJATTR_ID ) ;


CREATE TABLE SMBDB_SYS.TYPE_ATTR_MAP
    (
     TYPEATTR_ID NUMBER  NOT NULL ,
     TYPE_ID NUMBER  NOT NULL ,
     ATTR_ID NUMBER  NOT NULL ,
     CREATED DATE ,
     LAST_MODIFIED DATE ,
     VALUE VARCHAR2 (512 CHAR)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE UNIQUE INDEX TYPEATTR_PKX ON SMBDB_SYS.TYPE_ATTR_MAP
    (
     TYPEATTR_ID ASC
    )
;
CREATE INDEX TYPEATTR_ATTR_FKX ON SMBDB_SYS.TYPE_ATTR_MAP
    (
     ATTR_ID ASC
    )
;
CREATE INDEX TYPEATTR_TYPES_FKX ON SMBDB_SYS.TYPE_ATTR_MAP
    (
     TYPE_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.TYPE_ATTR_MAP
    ADD CONSTRAINT TYPEATTR_PK PRIMARY KEY ( TYPEATTR_ID ) ;


CREATE TABLE SMBDB_SYS.X$ATTR
    (
     ATTR_ID NUMBER  NOT NULL ,
     ATTR_PARENT_ID NUMBER  NOT NULL ,
     ATTR_IS_DEFAULT NUMBER  NOT NULL ,
     ATTR_NAME VARCHAR2 (256 CHAR)  NOT NULL ,
     ATTR_DESCR VARCHAR2 (512)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;



COMMENT ON COLUMN SMBDB_SYS.X$ATTR.ATTR_IS_DEFAULT IS '0 resolves to NO, 1 = YES the Attribute is a default attribute.'
;
CREATE UNIQUE INDEX ATTR_PKX ON SMBDB_SYS.X$ATTR
    (
     ATTR_ID ASC
    )
;
CREATE INDEX ATTRPARENT_FKX ON SMBDB_SYS.X$ATTR
    (
     ATTR_PARENT_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.X$ATTR
    ADD CONSTRAINT ATTR_PK PRIMARY KEY ( ATTR_ID ) ;


CREATE TABLE SMBDB_SYS.X$AUD
    (
     AUD_ID NUMBER  NOT NULL ,
     CREATED DATE  NOT NULL ,
     AUD_TAB_ID NUMBER  NOT NULL ,
     AUD_USR_ID NUMBER  NOT NULL ,
     AUD_TEXT VARCHAR2 (4000 CHAR)  NOT NULL ,
     AUD_C01_1 VARCHAR2 (10) ,
     AUD_C01_2 VARCHAR2 (10) ,
     AUD_C01_3 VARCHAR2 (10) ,
     AUD_N01_1 NUMBER ,
     AUD_N01_2 NUMBER ,
     AUD_N01_3 NUMBER
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE INDEX AUD_TAB_IDX ON SMBDB_SYS.X$AUD
    (
     AUD_TAB_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE INDEX AUD_CREATED_IDX ON SMBDB_SYS.X$AUD
    (
     CREATED ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE INDEX AUD_USR_IDX ON SMBDB_SYS.X$AUD
    (
     AUD_USR_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE UNIQUE INDEX AUDIT_PKX ON SMBDB_SYS.X$AUD
    (
     AUD_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.X$AUD
    ADD CONSTRAINT AUDIT_PK PRIMARY KEY ( AUD_ID ) ;


CREATE TABLE SMBDB_SYS.X$CTX
    (
     CTX_ID NUMBER  NOT NULL ,
     CTX_PARENT_ID NUMBER  NOT NULL ,
     CTX_NAME VARCHAR2 (256 CHAR)  NOT NULL ,
     DESCRIPTION VARCHAR2 (512)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE INDEX CTX_PID_IDX ON SMBDB_SYS.X$CTX
    (
     CTX_PARENT_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE UNIQUE INDEX CONTEXT_PKX ON SMBDB_SYS.X$CTX
    (
     CTX_ID ASC
    )
;
CREATE UNIQUE INDEX CTX_CTX_NAME_UQX ON SMBDB_SYS.X$CTX
    (
     CTX_NAME ASC
    )
;

ALTER TABLE SMBDB_SYS.X$CTX
    ADD CONSTRAINT CONTEXT_PK PRIMARY KEY ( CTX_ID ) ;

ALTER TABLE SMBDB_SYS.X$CTX
    ADD CONSTRAINT CTX_CTX_NAME_UQ UNIQUE ( CTX_NAME )
;


CREATE TABLE SMBDB_SYS.X$OBJ
    (
     OBJ_ID NUMBER  NOT NULL ,
     OBJ_PARENT_ID NUMBER  NOT NULL ,
     OBJ_TYPE_ID NUMBER  NOT NULL ,
     OBJ_CTX_ID NUMBER  NOT NULL ,
     OBJ_NAME VARCHAR2 (256 CHAR)  NOT NULL ,
     CREATED DATE ,
     LAST_MODIFIED DATE ,
     DESCRIPTION VARCHAR2 (512 CHAR)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;



COMMENT ON COLUMN SMBDB_SYS.X$OBJ.OBJ_CTX_ID IS 'Context gets resolved from CONTEXT table.'
;
CREATE INDEX OBJ_NAME_IDX ON SMBDB_SYS.X$OBJ
    (
     OBJ_NAME ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE INDEX OBJ_CTXID_IDX ON SMBDB_SYS.X$OBJ
    (
     OBJ_CTX_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE INDEX OBJ_TYPEID_IDX ON SMBDB_SYS.X$OBJ
    (
     OBJ_TYPE_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE UNIQUE INDEX OBJECTS_PKX ON SMBDB_SYS.X$OBJ
    (
     OBJ_ID ASC
    )
;
CREATE UNIQUE INDEX OBJTYPECTX_UQX ON SMBDB_SYS.X$OBJ
    (
     OBJ_NAME ASC ,
     OBJ_TYPE_ID ASC ,
     OBJ_CTX_ID ASC
    )
;
CREATE INDEX OBJ_PARENT_FKX ON SMBDB_SYS.X$OBJ
    (
     OBJ_PARENT_ID ASC
    )
;

ALTER TABLE SMBDB_SYS.X$OBJ
    ADD CONSTRAINT OBJECTS_PK PRIMARY KEY ( OBJ_ID ) ;

ALTER TABLE SMBDB_SYS.X$OBJ
    ADD CONSTRAINT OBJTYPECTX_UQ UNIQUE ( OBJ_NAME , OBJ_TYPE_ID , OBJ_CTX_ID )
;


CREATE TABLE SMBDB_SYS.X$TYPES
    (
     TYPE_ID NUMBER  NOT NULL ,
     TYPE_PARENT_ID NUMBER  NOT NULL ,
     TYPE_NAME VARCHAR2 (256 CHAR)  NOT NULL ,
     DESCRIPTION VARCHAR2 (512)
    ) TABLESPACE SMBDB_SYS
    LOGGING
;


CREATE INDEX TYPES_PID_IDX ON SMBDB_SYS.X$TYPES
    (
     TYPE_PARENT_ID ASC
    )
    TABLESPACE SMBDB_SYS
    NOLOGGING
    NOCOMPRESS
    NOPARALLEL
;
CREATE UNIQUE INDEX TYPES_PKX ON SMBDB_SYS.X$TYPES
    (
     TYPE_ID ASC
    )
;
CREATE UNIQUE INDEX TYPES_TYPE_NAME_UQX ON SMBDB_SYS.X$TYPES
    (
     TYPE_NAME ASC
    )
;

ALTER TABLE SMBDB_SYS.X$TYPES
    ADD CONSTRAINT TYPES_PK PRIMARY KEY ( TYPE_ID ) ;

ALTER TABLE SMBDB_SYS.X$TYPES
    ADD CONSTRAINT TYPES_TYPE_NAME_UQ UNIQUE ( TYPE_NAME )
;



ALTER TABLE SMBDB_SYS.X$ATTR
    ADD CONSTRAINT ATTR_PARENTID_FK FOREIGN KEY
    (
     ATTR_PARENT_ID
    )
    REFERENCES SMBDB_SYS.X$ATTR
    (
     ATTR_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.CTX_ATTR_MAP
    ADD CONSTRAINT CTXATTR_ATTR_FK FOREIGN KEY
    (
     ATTR_ID
    )
    REFERENCES SMBDB_SYS.X$ATTR
    (
     ATTR_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.CTX_ATTR_MAP
    ADD CONSTRAINT CTXATTR_CTX_FK FOREIGN KEY
    (
     CTX_ID
    )
    REFERENCES SMBDB_SYS.X$CTX
    (
     CTX_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.X$CTX
    ADD CONSTRAINT CTX_PARENT_FK FOREIGN KEY
    (
     CTX_PARENT_ID
    )
    REFERENCES SMBDB_SYS.X$CTX
    (
     CTX_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.OBJ_ATTR_MAP
    ADD CONSTRAINT OBJATTR_ATTR_FK FOREIGN KEY
    (
     ATTR_ID
    )
    REFERENCES SMBDB_SYS.X$ATTR
    (
     ATTR_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.OBJ_ATTR_MAP
    ADD CONSTRAINT OBJATTR_OBJ_FK FOREIGN KEY
    (
     OBJ_ID
    )
    REFERENCES SMBDB_SYS.X$OBJ
    (
     OBJ_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.X$OBJ
    ADD CONSTRAINT OBJECTS_TYPES_FK FOREIGN KEY
    (
     OBJ_TYPE_ID
    )
    REFERENCES SMBDB_SYS.X$TYPES
    (
     TYPE_ID
    )
    ON DELETE CASCADE
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.X$OBJ
    ADD CONSTRAINT OBJ_CTX_FK FOREIGN KEY
    (
     OBJ_CTX_ID
    )
    REFERENCES SMBDB_SYS.X$CTX
    (
     CTX_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.X$OBJ
    ADD CONSTRAINT OBJ_PARENT_FK FOREIGN KEY
    (
     OBJ_PARENT_ID
    )
    REFERENCES SMBDB_SYS.X$OBJ
    (
     OBJ_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.TYPE_ATTR_MAP
    ADD CONSTRAINT TYPEATTR_ATTR_FK FOREIGN KEY
    (
     ATTR_ID
    )
    REFERENCES SMBDB_SYS.X$ATTR
    (
     ATTR_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.TYPE_ATTR_MAP
    ADD CONSTRAINT TYPEATTR_TYPES_FK FOREIGN KEY
    (
     TYPE_ID
    )
    REFERENCES SMBDB_SYS.X$TYPES
    (
     TYPE_ID
    )
    NOT DEFERRABLE
;


ALTER TABLE SMBDB_SYS.X$TYPES
    ADD CONSTRAINT TYPES_PARENT_FK FOREIGN KEY
    (
     TYPE_PARENT_ID
    )
    REFERENCES SMBDB_SYS.X$TYPES
    (
     TYPE_ID
    )
    NOT DEFERRABLE
;

CREATE OR REPLACE VIEW SMBDB_SYS.ALL_OBJECT_ATTRIBUTES ( OAID,
    ATTRID,
    OBJID,
    OBJECT_NAME,
    OBJECT_ATTRIBUTE,
    "VALUES" )
 AS SELECT
    OBJ_ATTR_MAP.OBJATTR_ID OAID,
    ATTR.ATTR_ID ATTRID,
    OBJ.OBJ_ID OBJID,
    OBJ.OBJ_NAME OBJECT_NAME,
    ATTR.ATTR_NAME OBJECT_ATTRIBUTE,
    OBJ_ATTR_MAP.VALUE "VALUES"
 FROM
    SMBDB_SYS.OBJ_ATTR_MAP OBJ_ATTR_MAP,
    SMBDB_SYS.X$ATTR ATTR,
    SMBDB_SYS.X$OBJ OBJ
 WHERE
    OBJ_ATTR_MAP.ATTR_ID = ATTR.ATTR_ID
AND OBJ_ATTR_MAP.OBJ_ID = OBJ.OBJ_ID
 ORDER BY
    OBJECT_NAME ASC,
    OBJECT_ATTRIBUTE ASC ;











-- Oracle SQL Developer Data Modeler Summary Report:
--
-- CREATE TABLE                             8
-- CREATE INDEX                            27
-- ALTER TABLE                             12
-- CREATE VIEW                              1
-- CREATE PROCEDURE                         0
-- CREATE TRIGGER                           0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              1
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE SNAPSHOT                          0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
--
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
--
-- ERRORS                                   0
-- WARNINGS                                 0
