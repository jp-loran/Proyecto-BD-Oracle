--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 04/02/2021
--@Descripción: funcion que dvuelve un binario de una imagen

Prompt Conectando como sys

connect sys as sysdba

Prompt Creando objeto directory MASCOTA_DIR
create or replace directory mascota_dir as '/media/sf_BDORACLE/PROYECTO/mascota';

Prompt Otorgando permisos de lectura al usuario jpal_proy_admin
grant read on directory mascota_dir to jpal_proy_admin;
connect jpal_proy_admin/juan

create or replace function fx_blob(
  v_mascota_id number
) return blob is 

v_nombre_foto varchar2(30);
v_bfile bfile;
v_foto blob;
v_src_offset number;
v_dest_offset number;
v_src_lenght number;
v_blob_lenght number;

begin
  DBMS_LOB.CREATETEMPORARY(v_foto, TRUE);
  v_nombre_foto:= 'mascota-'||v_mascota_id||'.jpg';
  v_bfile:=bfilename('MASCOTA_DIR',v_nombre_foto);

  if dbms_lob.fileexists(v_bfile)=0 then
    raise_application_error(-20000, 'El archivo: '||v_nombre_foto
      ||' no existe en el objeto mascota_dir');
  end if;

  if dbms_lob.fileisopen(v_bfile)=1 then
    raise_application_error(-20000, 'El archivo: '||v_nombre_foto
      ||' se encuentra abierto, debe estar cerrado');
  end if;

  dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
  v_src_offset:=1;
  v_dest_offset:=1;
  v_src_lenght:=dbms_lob.getlength(v_bfile);

  dbms_lob.loadblobfromfile(
    dest_lob   => v_foto,
    src_bfile  => v_bfile,
    amount     => v_src_lenght,
    src_offset => v_src_offset,
    dest_offset=> v_dest_offset);
  
  dbms_lob.close(v_bfile);

  return v_foto;
end;
/
show errors