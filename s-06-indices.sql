--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 02/02/2021
--@Descripción: creación de indices

Prompt Creando indice non unique en la tabla EMPLEADO en el campo email
create index empleado_email_ix on empleado(email);

Prompt Creando indice non unique en la tabla MASCOTA en el campo adpotante_id
create index mascota_adoptante_ix on mascota(adoptante_id);

Prompt Creando indice non unique en la tabla REVISION en el campo mascota_id
create index revision_mascota_ix on revision(mascota_id);

Prompt Creando indice non unique en la tabla OFICINA en el campo RFC
create index oficina_folio_ix on oficina(rfc_persona_moral);

Prompt Creando indice non unique en REFUGIO en el campo numero_registro
create index refugio_folio_ix on refugio(numero_registro);

Prompt Creando indice unique basado en funciones en la tabla CLIENTE en los campos del nombre 
create unique index cliente_nombre_iuk 
  on cliente(upper(nombre),upper(ap_paterno),upper(ap_materno));