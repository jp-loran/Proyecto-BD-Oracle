--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 03/02/2021
--@Descripción: Este trigger agrega una entrada al historico cuando se inserta o
--actualiza una mascota

create or replace trigger tr_agrega_registro_hist 
after insert or update on mascota
for each row

declare
v_hist_estatus_id number(10,0);
v_estatus_id number(1,0);
v_mascota_id number(10,0);
v_fecha_estatus date;

begin
  case 
    when inserting then
      select historico_estatus_mascota_seq.nextval into v_hist_estatus_id
      from dual;
      select mascota_seq.currval into v_mascota_id
      from dual;
      v_estatus_id:= :new.estatus_mascota_id;
      v_fecha_estatus:= :new.fecha_estatus;

      insert into historico_estatus_mascota values (v_hist_estatus_id,
        v_fecha_estatus,v_mascota_id,v_estatus_id);

    when updating then
      if :old.estatus_mascota_id != :new.estatus_mascota_id then
        select historico_estatus_mascota_seq.nextval into v_hist_estatus_id
        from dual;
        select mascota_seq.currval into v_mascota_id
        from dual;
        v_estatus_id:= :new.estatus_mascota_id;
        v_fecha_estatus:= :new.fecha_estatus;

        insert into historico_estatus_mascota values (v_hist_estatus_id,
          v_fecha_estatus,v_mascota_id,v_estatus_id);
      else
        dbms_output.put_line('Los campos actualizados no requieren de una'
        ||' entrada al historico');
      end if;
  end case;
end;
/
show errors