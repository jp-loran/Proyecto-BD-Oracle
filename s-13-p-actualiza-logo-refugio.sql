--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: procedimiento para añadir logo a los refugios

Prompt Conectando como sys 
connect sys as sysdba

Prompt Creando objeto directory
create or replace directory fotos_dir as '/media/sf_BDORACLE/PROYECTO/img';

Prompt Otorgando permisos de lectura al usuario jpal_proy_admin
grant read on directory fotos_dir to jpal_proy_admin;

Prompt Conectando como jpal_proy_admin
connect jpal_proy_admin/juan


--Creando procedimiento
create or replace procedure p_actualiza_logo_refugio(
  p_centro_operativo_id_inicio number,
  p_num_imagenes number  
) is

cursor cur_refugio is
select centro_operativo_id
from refugio 
where centro_operativo_id between p_centro_operativo_id_inicio
and (p_centro_operativo_id_inicio+p_num_imagenes-1);

v_nombre_foto varchar(30);
--Referencia al archivo
v_bfile bfile;
v_foto blob;
--Se requieren porque el procedimiento loadfromfile necesita parametros de 
--salida
v_src_offset number;
v_dest_offset number;

v_src_lenght number;
v_blob_lenght number;

begin
  for r in cur_refugio loop
    v_nombre_foto:= 'logo-'||r.centro_operativo_id||'.jpg';
    v_bfile:=bfilename('FOTOS_DIR',v_nombre_foto);

    --Verificar si el archivo existe
    if dbms_lob.fileexists(v_bfile)=0 then
      raise_application_error(-20000, 'El archivo: '||v_nombre_foto
        ||' no existe en el objeto fotos_dir');
    end if;

    --Verificando si el archivo esta en uso
    if dbms_lob.fileisopen(v_bfile)=1 then
      raise_application_error(-20000, 'El archivo: '||v_nombre_foto
        ||' se encuentra abierto, debe estar cerrado');
    end if;

    select logo into v_foto
    from refugio
    where centro_operativo_id=r.centro_operativo_id for update; 
    --for update evita que otro usuario intente leer o escribir en foto

    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
    v_src_offset:=1;
    v_dest_offset:=1;
    v_src_lenght:=dbms_lob.getlength(v_bfile);
    --Se lee el contenido completo del archivo ya que el tamaño es pequeño
    --Para archivos grandes la carga se hace por partes para evitar consumo
    --excesivo de RAM de la instancia
    dbms_lob.loadblobfromfile(
      dest_lob   => v_foto,
      src_bfile  => v_bfile,
      amount     => v_src_lenght,
      src_offset => v_src_offset,
      dest_offset=> v_dest_offset);
    
    --Cerrando archivo
    dbms_lob.close(v_bfile);

    --Verificando la cantidad de bites en el objeto blob
    v_blob_lenght:=dbms_lob.getlength(v_foto);
    if v_src_lenght=v_blob_lenght then
      dbms_output.put_line('Carga exitosa para la foto: '||v_nombre_foto
        ||', centro_operativo_id: '||r.centro_operativo_id||' cantidad de bytes: '||v_blob_lenght);
    else
      raise_application_error(-20000, 'Longitud cargada invalida para centro_operativo_id: '
        ||r.centro_operativo_id);
    end if;

  end loop;
end;
/
show errors