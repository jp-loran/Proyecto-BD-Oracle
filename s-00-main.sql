--@Autor(es): Juan Pablo Alvarez Loran
--@Fecha creación: 05/02/2021
--@Descripción: script maestro para invocar todos los archivos

whenever sqlerror exit rollback;
Prompt **********************************************************************
Prompt ............................USUARIOS..................................
Prompt **********************************************************************
start s-01-usuarios.sql

Prompt **********************************************************************
Prompt ............................ENTIDADES.................................
Prompt **********************************************************************
start s-02-entidades.sql

Prompt **********************************************************************
Prompt .........................TABLAS TEMPORALES............................
Prompt **********************************************************************
start s-03-tablas-temporales.sql

Prompt **********************************************************************
Prompt .........................TABLAS EXTERNAS..............................
Prompt **********************************************************************
start s-04-tablas-externas.sql

Prompt **********************************************************************
Prompt ............................SECUENCIAS................................
Prompt **********************************************************************
start s-05-secuencias.sql

Prompt **********************************************************************
Prompt .............................INDICES..................................
Prompt **********************************************************************
start s-06-indices.sql

Prompt **********************************************************************
Prompt .............................SINONIMOS................................
Prompt **********************************************************************
start s-07-sinonimos.sql

Prompt **********************************************************************
Prompt .............................VISTAS..................................
Prompt ********************************************************************** 
start s-08-vistas.sql

Prompt **********************************************************************
Prompt ............................CARGA INICIAL.............................
Prompt ********************************************************************** 
start s-09-carga-inicial.sql

Prompt **********************************************************************
Prompt ............................CONSULTAS.................................
Prompt **********************************************************************
start s-10-consultas.sql 

Prompt **********************************************************************
Prompt ............................TRIGGERS.................................
Prompt **********************************************************************
Prompt Creando trigger TR_AGREGA_REGISTRO_HIST
start s-11-tr-agrega-registro-hist.sql
Prompt Creando trigger TR_VALIDA_MASCOTA_SELECCIONADA
start s-11-tr-valida-mascota-seleccionada.sql
Prompt Creando trigger TR_REFUGIO_LOG
start s-11-tr-compound-refugio-log.sql

Prompt **********************************************************************
Prompt ..........................PRUEBA TRIGGERS.............................
Prompt **********************************************************************
Prompt Iniciando prueba del trigger TR_AGREGA_REGISTRO_HIST
start s-12-tr-agrega-registro-hist-prueba.sql
Prompt Iniciando prueba del trigger TR_VALIDA_MASCOTA_SELECCIONADA
start s-12-tr-valida-mascota-seleccionada-prueba.sql
Prompt Iniciando prueba del trigger TR_REFUGIO_LOG
start s-12-tr-compound-refugio-log-prueba.sql

Prompt **********************************************************************
Prompt ............................FUNCIONES.................................
Prompt **********************************************************************
Prompt Creando funcion FX_DISTANCIA_REFUGIOS
start s-15-fx-distancia-refugios.sql
Prompt Creando funcion FX_GENERA_REPORTE_DONATIVO
start s-15-fx-genera-reporte-donativo.sql
Prompt Creando funcion FX_BLOB
start s-15-fx-blob.sql

Prompt **********************************************************************
Prompt .........................PROCEDIMIENTOS...............................
Prompt **********************************************************************
Prompt Creando procedimiento P_ACTUALIZA_LOGO_REFUGIO
start s-13-p-actualiza-logo-refugio.sql
Prompt Creando procedimiento P_AGREGA_REVISION_REFUGIO
start s-13-p-agrega-revision-refugio.sql

Prompt **********************************************************************
Prompt ..........................PRUEBA FUNCIONES............................
Prompt **********************************************************************
Prompt Iniciando prueba de la funcion FX_DISTANCIA_REFUGIO
start s-16-fx-distancia-refugio-prueba.sql
Prompt Iniciando prueba de la funcion FX_GENERA_REPORTE_DONATIVO
start s-16-fx-genera-reporte-donativo-prueba.sql

Prompt **********************************************************************
Prompt ........................PRUEBA PROCEDIMIENTOS.........................
Prompt **********************************************************************
Prompt Iniciando prueba del procedimiento P_ACTUALIZA_LOGO_REFUGIO
start s-14-p-actualiza-logo-refugio-prueba.sql
Prompt Iniciando prueba del procedimiento P_AGREGA_REVISION_REFUGIO
start s-14-p-agrega-revision-refugio-prueba.sql

Prompt **********************************************************************
Prompt .............................VALIDADOR................................
Prompt **********************************************************************
start resultados-proyecto-final.sql