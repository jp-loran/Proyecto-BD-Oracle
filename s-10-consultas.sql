--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 03/02/2021
--@Descripción: Consultas

set linesize window
/*Se desea conocer a aquellos empleados que tengan más de un grado academico
y en caso de ser gerentes de un centro operativo, mostrar el nombre de este */

col nombre format a20
col username format a20
col ap_paterno format a20
col ap_materno format a20

Prompt Empleados con más de un grado academico, se muestra si son gerentes de algun centro
select e.nombre,e.ap_paterno,e.ap_materno,co.nombre "CENTRO_OPERATIVO",
  count(*) "NUM_GRADO_ACADEMICO"
from empleado e
join grado_academico_empleado gae
  on e.empleado_id=gae.empleado_id
left join centro_operativo co
  on co.gerente_id=e.empleado_id
group by e.nombre,e.ap_paterno,e.ap_materno,co.nombre
having count(*)>1;

/*Se desea conocer los refugios que cuenten con un refugio alterno y que no 
cuenten con una direccion web registrada*/

Prompt Refugios que cuentan con un refugio altenro y no tienen direccion web
select r.centro_operativo_id,r.numero_registro,r.capacidad_maxima
from refugio r, refugio ra 
where r.centro_operativo_id=ra.centro_operativo_id
minus
select r.centro_operativo_id,r.numero_registro,r.capacidad_maxima
from refugio r, refugio ra, direccion_web_refugio dw
where r.centro_operativo_id=ra.centro_operativo_id
and dw.refugio_id=r.centro_operativo_id;

/*Se desea conocer el donativo más grande de la tabla donativo_ext y la
informacion del cliente en caso de que exista*/

Prompt Consulta usando tabla externa
Prompt Donativo más grande de la tabla donativo_ext e informacion del cliente
select de.monto "MONTO_MAX", de.cliente_id, c.nombre,c.ap_paterno,c.username
from donativo_ext de, cliente c 
where de.monto=(select max(monto) from donativo_ext)
and de.cliente_id=c.cliente_id;

/*Se desea conocer aquellas mascotas que en su historico tienen registrada
el status de adoptada, esto utilizando el sinónimo mascota_historico*/

Prompt Consulta usando sinonimo MASCOTA_HISTORICO
Prompt Mascotas que cuentan con el estatus ADOPTADA en su historico 
select mh.fecha_estatus, m.nombre, m.folio
from mascota_historico mh, mascota m 
where mh.mascota_id=m.mascota_id
and mh.estatus_mascota_id=
  (select estatus_mascota_id
  from estatus_mascota
  where descripcion='ADOPTADA');

/*Al final de día se hace un recuento de los casos atendidos de las clinicas
, se desea saber el identifiacdor, el nombre y el numero de casos atendidos*/

Prompt Consulta usando tabla temporal
Prompt Casos atendidos en un día por clínica
select ra.clinica_id, co.nombre, count(*) "CASOS_ATENDIDOS"
from registro_aforo_temp ra, centro_operativo co
where ra.clinica_id=co.centro_operativo_id
group by clinica_id, co.nombre; 