--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 03/02/2021
--@Descripción: Compund trigger para el siguiente escenario

/*Por problemas economicos los refugios deberán bajar su capacidad máxima
en 10 lugares, se desea registrar en la tabla refugio_log la capacidad anterior
así como la nueva, el usuario que hizo el cambio y el id del centro operativo*/

set serveroutput on

create or replace trigger tr_refugio_log
for update of capacidad_maxima on refugio
compound trigger

type refugio_capacidad_type is record(
  centro_operativo_id number(10,0),
  capacidad_max_anterior number(4,0),
  capacidad_max_nueva number(4,0),
  usuario_responsable varchar2(40)
);

type refugio_capacidad_list_type is table of refugio_capacidad_type;

refugio_capacidad_list refugio_capacidad_list_type:=refugio_capacidad_list_type();

before each row is 
v_usuario_responsable varchar2(40) := sys_context('USERENV','SESSION_USER');
v_index number;



begin
  refugio_capacidad_list.extend;
  v_index:=refugio_capacidad_list.last;

  refugio_capacidad_list(v_index).centro_operativo_id:= :new.centro_operativo_id;
  refugio_capacidad_list(v_index).capacidad_max_anterior:= :old.capacidad_maxima;
  refugio_capacidad_list(v_index).capacidad_max_nueva:= :new.capacidad_maxima;
  refugio_capacidad_list(v_index).usuario_responsable:= v_usuario_responsable;
end before each row;

after statement is 
begin
  forall i in refugio_capacidad_list.first .. refugio_capacidad_list.last
    insert into refugio_log(centro_operativo_id,capacidad_max_anterior,
      capacidad_max_nueva,usuario_responsable)
    values (refugio_capacidad_list(i).centro_operativo_id,
      refugio_capacidad_list(i).capacidad_max_anterior,
      refugio_capacidad_list(i).capacidad_max_nueva,
      refugio_capacidad_list(i).usuario_responsable); 


end after statement;
end;
/
show errors


