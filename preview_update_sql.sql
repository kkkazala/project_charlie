-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: changelog/master.xml
-- Ran at: 21.10.2022, 13:25
-- Against: ADMIN@jdbc:oracle:thin:@charliedev_high
-- Liquibase version: 4.8.0
-- *********************************************************************

-- Create Database Lock Table
CREATE TABLE ADMIN.DATABASECHANGELOGLOCK (ID INTEGER NOT NULL, LOCKED NUMBER(1) NOT NULL, LOCKGRANTED TIMESTAMP, LOCKEDBY VARCHAR2(255), CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

-- Initialize Database Lock Table
DELETE FROM ADMIN.DATABASECHANGELOGLOCK;

INSERT INTO ADMIN.DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

-- Lock Database
UPDATE ADMIN.DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = 'unknown (unknown)', LOCKGRANTED = SYSTIMESTAMP WHERE ID = 1 AND LOCKED = 0;

-- Create Database Change Log Table
CREATE TABLE ADMIN.DATABASECHANGELOG (ID VARCHAR2(255) NOT NULL, AUTHOR VARCHAR2(255) NOT NULL, FILENAME VARCHAR2(255) NOT NULL, DATEEXECUTED TIMESTAMP NOT NULL, ORDEREXECUTED INTEGER NOT NULL, EXECTYPE VARCHAR2(10) NOT NULL, MD5SUM VARCHAR2(35), DESCRIPTION VARCHAR2(255), COMMENTS VARCHAR2(255), TAG VARCHAR2(255), LIQUIBASE VARCHAR2(20), CONTEXTS VARCHAR2(255), LABELS VARCHAR2(255), DEPLOYMENT_ID VARCHAR2(10));

-- Changeset changelog/master.xml::compile_schema::kkazala
declare
  l_compilation_errors varchar2(32767);
  l_exists number;
  cursor lcu_invalid_objects is
    select
      object_type,
      object_name
    from user_objects
    where status = 'INVALID'
    group by object_type, object_name
    order by object_type, object_name;
begin

  select count(*)
  into l_exists
  from user_objects
  where status = 'INVALID';

  if l_exists > 0 then
    dbms_utility.compile_schema('AGREE');
    dbms_utility.compile_schema('AGREE');

    for rec_invalid_object in lcu_invalid_objects loop
      l_compilation_errors := l_compilation_errors || chr(10) || ' ' || rpad(rec_invalid_object.object_type, 20) ||
                              rec_invalid_object.object_name;
    end loop;

    if l_compilation_errors is not null
    then
      l_compilation_errors := chr(10) || chr(10) || 'Invalid objects in schema ' || 'AGREE' ||
                              ':' || l_compilation_errors;
      raise_application_error(-20000, l_compilation_errors || chr(10));
    end if;
  end if;
exception
  when no_data_found then
    dbms_output.put_line('No invalid objects to compile in schema');
end;
/

INSERT INTO ADMIN.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('compile_schema', 'kkazala', 'changelog/master.xml', SYSTIMESTAMP, 1, '8:109583d0b10c5535f10bcbe97d0375e1', 'sqlFile', '', 'EXECUTED', NULL, NULL, '4.8.0', '6351554739');

-- Release Database Lock
UPDATE ADMIN.DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

