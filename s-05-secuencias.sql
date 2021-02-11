--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 02/02/2021
--@Descripción: creación de sequencias

create sequence centro_operativo_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence empleado_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence grado_academico_empleado_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence mascota_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence historico_estatus_mascota_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence revision_refugio_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence tipo_mascota_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence cliente_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence donativo_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence cliente_interesado_mascota_seq
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;
 