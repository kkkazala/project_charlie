-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: changelog/master.xml
-- Ran at: 18.11.2022, 11:45
-- Against: ADMIN@jdbc:oracle:thin:@charliedev_high
-- Liquibase version: 4.8.0
-- *********************************************************************

-- Lock Database
UPDATE WKSP_CHARLIEDEV.DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = 'unknown (unknown)', LOCKGRANTED = SYSTIMESTAMP WHERE ID = 1 AND LOCKED = 0;

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
    dbms_utility.compile_schema('WKSP_CHARLIEDEV');
    dbms_utility.compile_schema('WKSP_CHARLIEDEV');

    for rec_invalid_object in lcu_invalid_objects loop
      l_compilation_errors := l_compilation_errors || chr(10) || ' ' || rpad(rec_invalid_object.object_type, 20) ||
                              rec_invalid_object.object_name;
    end loop;

    if l_compilation_errors is not null
    then
      l_compilation_errors := chr(10) || chr(10) || 'Invalid objects in schema ' || 'WKSP_CHARLIEDEV' ||
                              ':' || l_compilation_errors;
      raise_application_error(-20000, l_compilation_errors || chr(10));
    end if;
  end if;
exception
  when no_data_found then
    dbms_output.put_line('No invalid objects to compile in schema');
end;
/

UPDATE WKSP_CHARLIEDEV.DATABASECHANGELOG SET COMMENTS = '', CONTEXTS = NULL, DATEEXECUTED = SYSTIMESTAMP, DEPLOYMENT_ID = '8768319512', EXECTYPE = 'RERAN', LABELS = NULL, MD5SUM = '8:1bce45205f2fe43451281efa151382ed', ORDEREXECUTED = 120 WHERE ID = 'compile_schema' AND AUTHOR = 'kkazala' AND FILENAME = 'changelog/master.xml';

-- Release Database Lock
UPDATE WKSP_CHARLIEDEV.DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

