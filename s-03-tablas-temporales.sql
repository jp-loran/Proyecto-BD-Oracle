--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 02/02/2021
--@Descripción: creación de tabla temporale para aforo de clinicas

/*Durante el horario de atención de las clínicas se desea llevar un registro
sobre el aforo de las clínicas, se desea registrar la mascota que ingresó, 
el cliente que la ingresó, así como su hora de llegada y salida, una vez que 
termina el día, no es necesario conservar dichos registros.*/

create global temporary table registro_aforo_temp(
  cliente_id number(10,0),
  mascota_id number(10,0),
  clinica_id number(10,0),
  hora_llegada number(4,0),
  hora_salida number(4,0)   
)on commit preserve rows;