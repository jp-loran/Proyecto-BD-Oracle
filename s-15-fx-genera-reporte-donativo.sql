--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: funcion para generar un reporte de donativos
/*
Se desea generar un reporte de los donativos de cierto año 
registrados en la tabla externa y la tabla del modelo, realizados  por los clientes.
Se desea mostrar la suma de los donativos y el numero de donativos realizados 
*/

set serveroutput on

create or replace function fx_genera_reporte_donativo(
  p_anio in number
) return varchar2 is


v_existen_donativos number;
v_existen_donativos_ext number;
v_str varchar2(1000);
v_monto number;
v_num_donativos number;
v_monto_ext number;
v_num_donativos_ext number;


begin
  select count(*) into v_existen_donativos
  from donativo 
  where extract(year from fecha_donativo)=p_anio;

  select count(*) into v_existen_donativos_ext
  from donativo_ext 
  where extract(year from fecha_donativo)=p_anio;

  if v_existen_donativos>0 or v_existen_donativos_ext>0 then
    select sum(monto), count(*) into v_monto, v_num_donativos
    from donativo 
    where extract(year from fecha_donativo)=p_anio;

    select sum(monto), count(*) into v_monto_ext, v_num_donativos_ext
    from donativo_ext 
    where extract(year from fecha_donativo)=p_anio;

    v_monto:=v_monto+v_monto_ext;
    v_num_donativos:=v_num_donativos+v_num_donativos_ext;

    v_str:= 'En '||p_anio||' se obtuvieron '||v_monto||' pesos con un total de '
      ||v_num_donativos ||' donativos';
    return v_str;

  else
    raise_application_error(-20000, 'No existen donativos en el anio '||p_anio);
  end if;
end;
/
show errors