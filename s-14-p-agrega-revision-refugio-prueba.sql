--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: procedimiento para añadir registro a revision_refugio

set serveroutput on

Prompt =======================================
Prompt Prueba 1
Prompt Empleado con rol de veterinario
Prompt =======================================

declare
  v_reg_esperados number;
  v_reg_obtenidos number;
  v_veterinario_id number := 1;
begin

  select count(*) into v_reg_esperados
  from mascota m, tipo_mascota tm
  where adoptante_id is null
  and m.tipo_mascota_id=tm.tipo_mascota_id
  and tm.tipo='perro';

  p_agrega_revision_refugio(v_veterinario_id);

  select count(*) into v_reg_obtenidos
  from revision_refugio rf, mascota m, tipo_mascota tm
  where rf.mascota_id=m.mascota_id
  and m.tipo_mascota_id=tm.tipo_mascota_id
  and m.adoptante_id is null
  and tm.tipo='perro'
  and rf.veterinario_id= v_veterinario_id;

  if v_reg_esperados=v_reg_obtenidos then 
   dbms_output.put_line('Registros esperados: '||v_reg_esperados
   ||' Registros obtenidos: '||v_reg_obtenidos);
  else
    raise_application_error(-20000, 'Se esperaban '||v_reg_esperados
    ||' y se obtuvieron: '||v_reg_obtenidos);
  end if;

end;
/

Prompt Imagenes Insertadas:
select mascota_id,dbms_lob.getlength(foto) "Tamanio_foto" 
from revision_refugio
where dbms_lob.getlength(foto)>0;  

Prompt Prueba 1 exitosa

Prompt =======================================
Prompt Prueba 2
Prompt Empleado sin rol de veterinario
Prompt =======================================

declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_veterinario_id number := 2;
begin
  p_agrega_revision_refugio(v_veterinario_id);  
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line(chr(5));

    if v_codigo = -20020 then
      dbms_output.put_line('Prueba 2 exitosa');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt Limpiando base de datos
rollback; 