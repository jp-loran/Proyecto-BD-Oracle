--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: script de validacion trigger
set serveroutput on

Prompt ===============================================================
Prompt Prueba 1
Prompt Seleccionando mascota con menos de 15 días desde su primer seleccion
Prompt ===============================================================

declare
  v_codigo number;
	v_mensaje varchar2(1000);

begin
  dbms_output.put_line('Cliente con id=5 selecciona por primera vez a la'||
   ' mascota con id=1 en la fecha 01/02/2021');
  insert into cliente_interesado_mascota 
    values(cliente_interesado_mascota_seq.nextval,null,0,
      to_date('01/02/2021','dd/mm/yyyy'),1,5);

  dbms_output.put_line(chr(5));

  dbms_output.put_line('Cliente con id=2 selecciona a la mascota con id=1'
    ||' en la fecha 04/02/2021');

  insert into cliente_interesado_mascota 
    values(cliente_interesado_mascota_seq.nextval,null,0,
      to_date('04/02/2021','dd/mm/yyyy'),1,2);

  dbms_output.put_line(chr(5));

exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line(chr(5));

    if v_codigo = -20010 then
      dbms_output.put_line('Prueba 1 exitosa');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;

end;
/

Prompt ===============================================================
Prompt Prueba 2
Prompt Seleccionando mascota con mas de 15 días desde su primer seleccion
Prompt ===============================================================

begin

  dbms_output.put_line('Cliente con id=7 selecciona por primera vez a la'||
   ' mascota con id=2 en la fecha 01/02/2021');
  insert into cliente_interesado_mascota 
    values(cliente_interesado_mascota_seq.nextval,null,0,
      to_date('01/02/2021','dd/mm/yyyy'),2,7);

  dbms_output.put_line(chr(5));

  dbms_output.put_line('Cliente con id=8 selecciona a la mascota con id=2'
    ||' en la fecha 20/02/2021');
  insert into cliente_interesado_mascota 
    values(cliente_interesado_mascota_seq.nextval,null,0,
      to_date('20/02/2021','dd/mm/yyyy'),2,8);

  dbms_output.put_line(chr(5));

end;
/
 Prompt Prueba 2 exitosa
 Prompt Limpiando base de datos 
rollback;
