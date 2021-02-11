--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: Prueba trigger

set serveroutput on

Prompt  ====================================
Prompt Prueba 1 Insertar registro en mascota
Prompt  ====================================

declare 
v_hist_id number(10,0);
v_existe_registro number;
v_mascota_id number;

begin
  select mascota_seq.nextval into v_mascota_id
  from dual;
  dbms_output.put_line('Insertando registro de prueba con mascota_id= '
    ||v_mascota_id);
  insert into mascota (mascota_id,nombre,folio,fecha_ingreso,fecha_nacimiento,
    fecha_estatus,origen_abandonado,tipo_mascota_id,estatus_mascota_id) 
  values (v_mascota_id,'Lobito','ABCD1234',sysdate,
    to_date('01/01/2002','dd/mm/yyyy'), sysdate,1,2,1);  

  select historico_estatus_mascota_id,count(*) into v_hist_id,v_existe_registro
  from historico_estatus_mascota
  where mascota_id=v_mascota_id
  and fecha_estatus=sysdate
  and estatus_mascota_id=1
  group by historico_estatus_mascota_id;

  if v_existe_registro=1 then
    dbms_output.put_line('Se ha registrado correctamente el historico con id= '
      ||v_hist_id|| ' para la mascota con id= '||v_mascota_id);
  else
  raise_application_error(-20000, 'No se ha encontrado registro en el historico'
    ||' para la mascota con id= '||v_mascota_id);
  end if;
end;
/

Prompt  ====================================
Prompt Prueba 2 Actualizar registro de mascota que requiera entrada en el historico 
Prompt  ====================================
declare
  v_hist_id number(10,0);
  v_mascota_id number;
  v_existe_registro number;
begin
  select mascota_seq.currval into v_mascota_id from dual;
  update mascota set estatus_mascota_id=2 where mascota_id=v_mascota_id;

  select historico_estatus_mascota_id,count(*) into v_hist_id,v_existe_registro
  from historico_estatus_mascota
  where mascota_id=v_mascota_id
  and fecha_estatus=sysdate
  and estatus_mascota_id=2
  group by historico_estatus_mascota_id;

  if v_existe_registro=1 then
    dbms_output.put_line('Se ha registrado correctamente el historico con id= '
      ||v_hist_id|| ' para la mascota con id= '||v_mascota_id);
  else
  raise_application_error(-20000, 'No se ha encontrado registro en el historico'
    ||' para la mascota con id= '||v_mascota_id);
  end if;
end;
/

Prompt  ====================================
Prompt Prueba 3 Actualizar registro de mascota que no requiera entrada en el historico 
Prompt  ====================================
declare
  v_mascota_id number;
begin
  select mascota_seq.currval into v_mascota_id from dual;
  update mascota set nombre='Poky' where mascota_id=v_mascota_id;  
end;
/

Prompt Prueba finalizada con exito
show errors
Prompt Limpiando la base de datos
rollback;
