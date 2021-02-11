--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: script de prueba para procedimiento p-genera-reporte-donativo

set serveroutput on

Prompt ========================================
Prompt Prueba 1 
Prompt Reporte con anio existente
Prompt ========================================

declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_anio number;
  v_cadena varchar2(500);
begin
  v_anio:=2019;
  dbms_output.put_line('Reporte generado:');
  select fx_genera_reporte_donativo(v_anio) into v_cadena from dual;
  dbms_output.put_line(v_cadena);
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line(chr(5));
    dbms_output.put_line('Se obtuvo un error en los registros');
  
end;
/

Prompt Prueba 1 exitosa

Prompt ========================================
Prompt Prueba 2 
Prompt Reporte con anio inexistente
Prompt ========================================

declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_anio number;
  v_cadena varchar2(500);
begin
  v_anio:=2039;

  select fx_genera_reporte_donativo(v_anio) into v_cadena from dual;

exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line(chr(5));

    if v_codigo = -20000 then
      dbms_output.put_line('Prueba 2 exitosa');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/