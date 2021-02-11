--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 02/02/2021
--@Descripción: creación de sinonimos


Prompt Creando sinonimos publicos

create or replace public synonym mascota_historico for historico_estatus_mascota;
create or replace public synonym mascota_interesado for cliente_interesado_mascota;
create or replace public synonym grados_academicos for grado_academico_empleado;

Prompt Asignando privilegios de lectura a JPAL_PROY_INVITADO

grant select on revision_refugio to jpal_proy_invitado;
grant select on centro_operativo to jpal_proy_invitado;
grant select on clinica to jpal_proy_invitado;

Prompt Conectando usuario JPAL_PROY_INVITADO
connect jpal_proy_invitado/juan
Prompt Creando sinonimos privados
create or replace synonym revisiones for jpal_proy_admin.revision_refugio; 
create or replace synonym centros for jpal_proy_admin.centro_operativo;
create or replace synonym veterinarias for jpal_proy_admin.clinica;

Prompt Conectando con usuario JPAL_PROY_ADMIN
connect jpal_proy_admin/juan
set serveroutput on

declare 
  cursor cur_tablas_proyecto is 
  select table_name 
  from all_tables
  where owner='JPAL_PROY_ADMIN';

begin
  for r in cur_tablas_proyecto loop
    execute immediate
      'create or replace synonym JP_'||r.table_name
      ||' for '||r.table_name;
    dbms_output.put_line('Sinonimo privado JP_'||r.table_name||' creado');  
  end loop;
end;
/
show errors;
