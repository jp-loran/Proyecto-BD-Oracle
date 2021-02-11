--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 19/01/2021
--@Descripción: creación de tablas del modelo


Prompt Conectado como JPAL_PROY_ADMIN para crear entidades
connect jpal_proy_admin/juan

create table empleado(
  empleado_id number(10,0) constraint empleado_pk primary key,
  nombre      varchar2(40) not null,
  ap_paterno  varchar2(40) not  null,
  ap_materno  varchar2(40) not  null,
  curp        varchar2(18) not null,
  email       varchar2(40) not null,
  sueldo_mensual number(8,2) not null,
  es_gerente  number(1,0) not null constraint empleado_es_gerente_chk 
    check (es_gerente in (1,0)),
  es_veterinario  number(1,0) not null constraint empleado_es_veterinario_chk 
    check (es_veterinario in (1,0)),
  es_administrativo number(1,0) not null constraint empleado_es_admin_chk 
    check (es_administrativo in (1,0))
);

create table grado_academico_empleado(
  grado_academico_empleado_id number(10,0) constraint grado_academico_empleado_pk
    primary key,
  titulo varchar2(40) not null,
  fecha_titulacion date not null,
  cedula_profesional number(8,0),
  empleado_id number(10,0) not null,
  constraint grado_academico_empleado_id_fk foreign key(empleado_id) 
    references empleado(empleado_id)
);

create table centro_operativo(
  centro_operativo_id number(10,0) constraint centro_operativo_pk primary key,
  nombre varchar2(40) not null,
  direccion varchar2(100) not null,
  codigo varchar2(5) not null,
  latitud number(15,12) not null,
  longitud number(15,12) not null,
  es_refugio number(1,0) not null constraint centro_operativo_refugio_chk 
    check (es_refugio in (1,0)),
  es_clinica number(1,0) not null constraint centro_operativo_clinica_chk 
    check (es_clinica in (1,0)),
  es_oficina number(1,0) not null constraint centro_operativo_oficina_chk 
    check (es_oficina in (1,0)),
  gerente_id number(10,0) not null constraint centro_operativo_gerente_uk unique,
  constraint centro_operativo_gerente_id_fk foreign key(gerente_id)
    references empleado(empleado_id),
  constraint centro_operativo_tipo_chk check (
    (es_refugio=1 and es_clinica=0 and es_oficina=0) or 
    (es_refugio=0 and es_clinica=1 and es_oficina=0) or
    (es_refugio=0 and es_clinica=0 and es_oficina=1) or
    (es_refugio=1 and es_clinica=1 and es_oficina=0)
    )
);

create table refugio(
  centro_operativo_id number(10,0) constraint refugio_pk primary key,
  numero_registro varchar2(8) not null,
  capacidad_maxima number(4,0) not null,
  logo blob not null,
  lema varchar2(100) not null,
  refugio_alterno_id number(10,0) null,
  constraint refugio_centro_operativo_id_fk foreign key(centro_operativo_id)
    references centro_operativo(centro_operativo_id),
  constraint refugio_alterno_id_fk foreign key(refugio_alterno_id) 
    references refugio(centro_operativo_id)
);

create table direccion_web_refugio(
  --Columna auto incrementable
  direccion_web_id number generated always as identity 
    constraint direccion_web_pk primary key,
  direccion_web varchar2(500) not null,
  refugio_id number(10,0) not null,
  constraint direccion_web_refugio_id foreign key(refugio_id)
    references refugio(centro_operativo_id)
);

create table clinica(
  centro_operativo_id number(10,0) constraint clinica_pk primary key,
  telefono_emergencia number(10,0) not null,
  telefono_atencion number(10,0) not null,
  hora_inicio number(4,0) not null,
  hora_fin number(4,0) not null,
  constraint clinica_centro_operativo_id_fk foreign key(centro_operativo_id)
    references centro_operativo(centro_operativo_id)
);

create table oficina(
  centro_operativo_id number(10,0) constraint oficina_pk primary key,
  rfc_persona_moral varchar2(12) not null,
  firma_electronica blob not null,
  responsable_legal varchar2(100) not null,
  constraint oficina_centro_operativo_id_fk foreign key(centro_operativo_id)
    references centro_operativo(centro_operativo_id)
);

create table estatus_mascota(
  --Columna autoincrementable
  estatus_mascota_id number generated always as identity 
    constraint estatus_mascota_pk primary key,
  descripcion varchar2(40) not null 
);

create table cliente(
  cliente_id number(10,0) constraint cliente_pk primary key,
  nombre varchar2(40) not null,
  ap_paterno varchar2(40) not null,
  ap_materno varchar2(40) not null,
  direccion varchar2(200) not null,
  ocupacion varchar2(40) not null,
  username varchar2(65) generated always as (substr(nombre,1,2)
    ||substr(ap_paterno,1,2)||substr(ap_materno,1,2)||'_'||cliente_id) virtual,
  password varchar2(300) not null
);

create table donativo(
  donativo_id number(10,0) constraint donativo_pk primary key,
  monto number(6,0) not null,
  fecha_donativo date not null,
  cliente_id number(10,0) not null,
  constraint donativo_cliente_id_fk foreign key(cliente_id)
    references cliente(cliente_id)
);

create table tipo_mascota(
  tipo_mascota_id number(10,0) constraint tipo_mascota_pk primary key,
  tipo varchar2(40) not null,
  subcategoria varchar2(40) not null,
  nivel_cuidado number(1,0) not null constraint tipo_mascota_nivel_cuidado_chk 
    check(nivel_cuidado between 1 and 5)
);

create table mascota(
  mascota_id number(10,0) constraint mascota_pk primary key,
  nombre varchar2(40) not null,
  folio varchar2(8) not null constraint mascota_folio_uk unique,
  descripcion_fallecido varchar2(500) null,
  fecha_ingreso date not null,
  fecha_nacimiento date not null,
  fecha_estatus date default sysdate,
  fecha_adopcion date null,
  origen_abandonado number(1,0) null,
  origen_refugio_id number(10,0) null,
  origen_cliente_id number(10,0) null,
  tipo_mascota_id number(10,0) not null,
  estatus_mascota_id number(1,0) not null,
  mascota_mama_id number(10,0) null,
  mascota_papa_id number(10,0) null,
  adoptante_id number(10,0) null,
  constraint mascota_origen_refugio_id_fk foreign key(origen_refugio_id)
    references refugio(centro_operativo_id),
  constraint mascota_origen_cliente_id_fk foreign key(origen_cliente_id)
    references cliente(cliente_id),
  constraint mascota_tipo_mascota_id_fk foreign key(tipo_mascota_id)
    references tipo_mascota(tipo_mascota_id),
  constraint mascota_estatus_mascota_id_fk foreign key(estatus_mascota_id)
    references estatus_mascota(estatus_mascota_id),
  constraint mascota_mama_id_fk foreign key(mascota_mama_id)
    references mascota(mascota_id),
  constraint mascota_papa_id_fk foreign key(mascota_papa_id)
    references mascota(mascota_id),       
  constraint mascota_adoptante_id_fk foreign key(adoptante_id)
    references cliente(cliente_id),
  constraint mascota_origen_chk check( 
    (origen_abandonado=1 and origen_refugio_id is null and origen_cliente_id is null)
    or(origen_abandonado=0 and origen_refugio_id is not null and origen_cliente_id is null)
    or(origen_abandonado=0 and origen_refugio_id is null and origen_cliente_id is not null))
);

create table historico_estatus_mascota(
  historico_estatus_mascota_id number(10,0) constraint 
    historico_estatus_mascota_pk primary key,
  fecha_estatus date default sysdate,
  mascota_id number(10,0) not null,
  estatus_mascota_id number(1,0) not null,
  constraint historico_estatus_mascota_mascota_id_fk foreign key(mascota_id)
    references mascota(mascota_id),
  constraint historico_estatus_mascota_id_fk foreign key(estatus_mascota_id)
    references estatus_mascota(estatus_mascota_id)
);

create table revision_refugio(
  revision_refugio_id number(10,0) constraint revision_refugio_pk primary key,
  diagnostico varchar2(1000) not null,
  foto blob,
  mascota_id number(10,0) not null,
  veterinario_id number(10,0) not null,
  constraint revision_refugio_mascota_id_fk foreign key(mascota_id)
    references mascota(mascota_id),
  constraint revision_refugio_veterinario_id_fk foreign key(veterinario_id)
    references empleado(empleado_id)
);

create table revision(
  mascota_id number(10,0) not null,
  num_revision number(4,0) not null,
  fecha_revision date not null,
  observaciones varchar2(500) not null,
  calificacion number(2,0) not null,
  costo number(4,0) not null,
  clinica_id number(10,0) not null,
  constraint revision_pk primary key (mascota_id,num_revision),
  constraint revision_clinica_id_fk foreign key(clinica_id)
    references clinica(centro_operativo_id),
  constraint revision_mascota_id_fk foreign key(mascota_id)
    references mascota(mascota_id)
);

create table cliente_interesado_mascota(
  cliente_interesado_mascota_id number(10,0) constraint
  cliente_interesado_mascota_pk primary key,
  descripcion_no_seleccionado varchar2(500) null,
  seleccionado number(1,0) default 0,
  fecha_seleccion date not null,
  mascota_id number(10,0) not null,
  cliente_id number(10,0) not null,
  constraint cliente_interesado_mascota_id_fk foreign key(mascota_id)
    references mascota(mascota_id),
  constraint cliente_interesado_cliente_id_fk foreign key(cliente_id)
    references cliente(cliente_id)    
);

--Tabla para escenario de compund trigger
create table refugio_log(
  refugio_log_id number generated always as identity  
    constraint refugio_log_pk primary key,
  centro_operativo_id number(10,0) not null,
  capacidad_max_anterior number(4,0) not null,
  capacidad_max_nueva number(4,0) not null,
  usuario_responsable varchar2(40)
);