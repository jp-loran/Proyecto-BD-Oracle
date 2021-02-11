--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: Prueba compound trigger

set serveroutput on

Prompt =================================================
Prompt Prueba
Prompt Actualizando capacidad_maxima de la tabla refugio 
Prompt =================================================

declare
v_col_actualizadas number;

begin
  update refugio 
  set capacidad_maxima=capacidad_maxima-10;
  
  select count(*) into v_col_actualizadas
  from refugio_log;

  dbms_output.put_line('Se han actualizado un total de '||v_col_actualizadas
    ||' registros');
  
end;
/

Prompt Prueba exitosa
Prompt Limpiando base de datos
rollback;