--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 02/02/2021
--@Descripción: creación de tabla externa con datos

/*Se tienen registros de donativos antiguos a la empresa, almacenados en formato
CSV ya que se deseaba liberar espacio de la base de datos, se desea poder leer 
dichos donativos para cuestiones de contabilidad de la empresa. Los donativos
son del periodo de 1999 a 2015*/

Prompt Conectado como usuario sys
connect sys as sysdba
Prompt Creando directorio
create or replace directory tmp_dir as '/tmp/donativo_datos';

grant read, write on directory tmp_dir to jpal_proy_admin;

Prompt Conectado como JPAL_PROY_ADMIN
connect jpal_proy_admin/juan

Prompt Creando tabla externa
create table donativo_ext(
  num_donativo number(10,0),
  monto number(6,0),
  fecha_donativo date,
  cliente_id number(10,0)
)
organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters (
    records delimited by newline
    badfile tmp_dir:'donativo_ext_bad.log'
    logfile tmp_dir:'donativo_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
    num_donativo, monto, fecha_donativo date mask "dd/mm/yyyy",cliente_id
    )
  )
  location ('donativo_ext.csv')
)
reject limit unlimited;

!mkdir -p /tmp/donativo_datos

!cp donativo_ext.csv /tmp/donativo_datos

!chmod 777 /tmp/donativo_datos

select * from donativo_ext;