--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 03/02/2021
--@Descripción: Este trigger valida la siguiente regla de negocio:

/*El sistema permite que todos los clientes que así lo deseen seleccionen a 
la misma mascota. Cuando la mascota ha sido seleccionada por el primer cliente 
interesado, el sistema esperará 15 días para permitir que otros clientes puedan 
seleccionarla.*/ 
set serveroutput on

create or replace trigger tr_valida_mascota_seleccionada 
before insert on cliente_interesado_mascota
for each row

declare
v_primer_fecha_seleccion date;
v_fecha_seleccion date;
v_mascota_id number;
v_existe_registro number;
v_dias number;
v_dias_restantes number;

begin
  v_mascota_id:= :new.mascota_id;
  v_fecha_seleccion:= :new.fecha_seleccion;

  select count(*) into v_existe_registro
  from cliente_interesado_mascota
  where mascota_id=v_mascota_id;

  if v_existe_registro>0 then
    select min(fecha_seleccion) into v_primer_fecha_seleccion
    from cliente_interesado_mascota
    where mascota_id=v_mascota_id;

    select (v_fecha_seleccion-v_primer_fecha_seleccion) into v_dias
    from dual;

    if v_dias<15 then
      select (15-v_dias) into v_dias_restantes
      from dual;
      raise_application_error(-20010, 'La mascota ya fue seleccionada previamente.'
        ||' Para poder seleccionarla debera esperar '||floor(v_dias_restantes)
        ||' dias');
    else
      dbms_output.put_line('Felicidades, ha seleccionado a una mascota');  
    end if;

  else
    dbms_output.put_line('Felicidades, ha seleccionado a una mascota');  
  end if;


end;
/
show errors
