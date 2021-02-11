set serveroutput on

update refugio set logo=empty_blob();

Prompt  ==================================
Prompt |Prueba 1 insertando fotos de 1 a 5|
Prompt  ==================================

begin
  p_actualiza_logo_refugio(1,5);
end;
/

select centro_operativo_id, dbms_lob.getlength(logo)
from refugio;


Prompt Prueba 1 exitosa


rollback;