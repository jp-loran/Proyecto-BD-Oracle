--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: script de prueba para la funcion fx-distancia-refugios

set serveroutput on

Prompt ========================================
Prompt Prueba 1 
Prompt Distancia entre dos refugios existentes
Prompt ========================================

declare
  distancia number;
begin
  select fx_distancia_refugios(1,2) into distancia 
  from dual;

  dbms_output.put_line('Distancia entre refugios: '||distancia||' km');
end;
/
