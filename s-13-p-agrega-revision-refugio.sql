--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: procedimiento para añadir registro a revision_refugio

/*Para todas las mascotas perros que aun no han sido adoptadas se requiere registrar 
una nueva revision en refugio, el procedimiento a usar recibe como entrada 
al identificador del veterinario que hará las revisiones, en caso de que este no
tenga asignado como rol 'veterinario' se lanzará una excepcion.
El campo diagnostico debera especificar 'Revision de rutina' y la foto será un 
asignada mediante la funcion fx_blob 
*/

set serveroutput on

create or replace procedure p_agrega_revision_refugio(
  p_veterinario_id in number
) is

cursor cur_mascota_sin_adoptar is
select m.mascota_id 
from mascota m, tipo_mascota tm
where adoptante_id is null
and m.tipo_mascota_id=tm.tipo_mascota_id
and tm.tipo='perro';

v_empleado_rol number;
v_diagnostico varchar2(40) := 'Revision de rutina';
v_foto blob:=empty_blob();

begin

  select es_veterinario into v_empleado_rol 
  from empleado
  where empleado_id=p_veterinario_id;

  if v_empleado_rol=1 then

    for r in cur_mascota_sin_adoptar loop
      v_foto:=empty_blob();
      select fx_blob(r.mascota_id) into v_foto from dual;
      insert into revision_refugio values (revision_refugio_seq.nextval,
        v_diagnostico,v_foto,r.mascota_id,p_veterinario_id);
    end loop;

  else 

    raise_application_error(-20020, 'El empleado seleccionado no cuenta con el'
      ||' rol de veterinario por lo tanto, no puede hacer la revision');

  end if;  

end;
/ 
show errors
