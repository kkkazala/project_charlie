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