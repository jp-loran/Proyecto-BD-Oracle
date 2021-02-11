--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: funcion para encontrar la distancia entre dos refugios
-- dando el id de los refugios

set serveroutput on

create or replace function fx_distancia_refugios(
  v_refugio_1 number,
  v_refugio_2 number
) return number is

v_latitud_1 number;
v_longitud_1 number;
v_latitud_2 number;
v_longitud_2 number;

v_existe_1 number;
v_existe_2 number;

v_distancia number;

begin

  select count(*) into v_existe_1
  from centro_operativo
  where centro_operativo_id=v_refugio_1;

  select count(*) into v_existe_2
  from centro_operativo
  where centro_operativo_id=v_refugio_2;

  if v_existe_1=1 and v_existe_2=1 then 

    select latitud,longitud into v_latitud_1, v_longitud_1
    from centro_operativo
    where centro_operativo_id=v_refugio_1;

    select latitud,longitud into v_latitud_2, v_longitud_2
    from centro_operativo
    where centro_operativo_id=v_refugio_2;

    select round(sqrt(power(v_latitud_2-v_latitud_1,2)+
    power(v_longitud_2-v_longitud_1,2)),5) into v_distancia
    from dual;

    return v_distancia;

  elsif v_existe_1=0 then
    return 1;
    
  elsif v_existe_2=0 then
    return 1;
  end if;

end;
/
show errors