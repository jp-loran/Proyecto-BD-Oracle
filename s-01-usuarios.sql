--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 19/01/2021
--@Descripción: creación de usuarios y roles

whenever sqlerror exit rollback;

connect sys as sysdba
set serveroutput on 

Prompt Creando ROL_ADMIN

declare 
  v_count number;
begin
  select count(*) into v_count
  from dba_roles
  where role='ROL_ADMIN';

  if v_count=0 then
    dbms_output.put_line('El rol no existe. Creandolo');
  else 
    execute immediate 'drop role ROL_ADMIN';   
  end if;

  execute immediate 'create role ROL_ADMIN';
  execute immediate 'grant create session, create table, create sequence, 
    create procedure,create synonym, create public synonym, create view, 
    create trigger
    to ROL_ADMIN';

end;
/

Prompt Creando ROL_INVITADO

declare 
  v_count number;
begin
  select count(*) into v_count
  from dba_roles
  where role='ROL_INVITADO';

  if v_count=0 then
    dbms_output.put_line('El rol no existe. Creandolo');
  else 
    execute immediate 'drop role ROL_INVITADO';   
  end if;

  execute immediate 'create role ROL_INVITADO';
  execute immediate 'grant create session,create synonym to ROL_INVITADO';

end;
/

Prompt Creando usuario JPAL_PROY_ADMIN

declare
  v_count number; 
begin
  select count(*) 
  into v_count
  from all_users
  where username='JPAL_PROY_ADMIN';

  if v_count=0 then
    dbms_output.put_line('El usuario no existe. Creandolo');

  else
    dbms_output.put_line('El usuario ya existe. Se eliminara y se creara de nuevo');

    execute immediate
    'drop user JPAL_PROY_ADMIN cascade';    

  end if;

    execute immediate 
    'create user JPAL_PROY_ADMIN 
    identified by juan
    quota unlimited on users';

    execute immediate
    'grant rol_admin
    to JPAL_PROY_ADMIN'; 

    dbms_output.put_line('Usuario creado');
end;
/  

Prompt Creando usuario JPAL_PROY_INVITADO

declare
  v_count number; 
begin
  select count(*) 
  into v_count
  from all_users
  where username='JPAL_PROY_INVITADO';

  if v_count=0 then
    dbms_output.put_line('El usuario no existe. Creandolo');

  else
    dbms_output.put_line('El usuario ya existe. Se eliminara y se creara de nuevo');

    execute immediate
    'drop user JPAL_PROY_INVITADO cascade';    

  end if;

    execute immediate 
    'create user JPAL_PROY_INVITADO 
    identified by juan
    quota unlimited on users';

    execute immediate
    'grant rol_invitado
    to JPAL_PROY_INVITADO'; 

    dbms_output.put_line('Usuario creado');
end;
/  
