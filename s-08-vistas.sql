--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 03/02/2021
--@Descripción: creación de vistas

/*Muestra los empleados y sus titulos*/

create or replace view v_empleado(
  nombre, apellido_pat, apellido_mat, CURP,titulo
) as 
select e.nombre,e.ap_paterno,e.ap_materno,e.curp,g.titulo
from empleado e, grado_academico_empleado g 
where e.empleado_id=g.empleado_id;

/*Clientes que hayan adoptado una mascota*/
create or replace view v_cliente(
  nombre,ap_pat,ap_mat,nombre_mascota,fecha_adopcion
) as 
select c.nombre,c.ap_paterno,c.ap_materno,m.nombre,m.fecha_adopcion
from cliente c, mascota m
where c.cliente_id=m.adoptante_id;

/*Muestra el aforo de los refugios que cuentan con mascotas*/
create or replace view v_mascota_refugio(
 nombre_centro, codigo_centro, registro_refugio, capacidad_maxima, aforo_actual
) as
select c.nombre,c.codigo,r.numero_registro,r.capacidad_maxima, count(*)
from centro_operativo c, refugio r, mascota m 
where c.centro_operativo_id=r.centro_operativo_id
and r.centro_operativo_id=m.origen_refugio_id
group by c.nombre,c.codigo,r.numero_registro,r.capacidad_maxima;