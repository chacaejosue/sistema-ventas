@ECHO OFF
REM ============================================================================

IF NOT EXIST logs MKDIR logs
DEL /F /Q logs\* 2>NUL

ECHO COMENZANDO LA CREACION COMPLETA DE LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" ...

sqlcmd -S [NOMBRE-SERVIDOR] -i 1-CreacionTablas.sql -o logs\log_creacion.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 2-Restricciones.sql -o logs\log_restricciones.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 3-ProcedimientosAlmacenados.sql -o logs\log_procedimientos.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 4-RNprocedures.sql -o logs\log_reglasnegocio.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 5-RNDesencadenadores.sql -o logs\log_desencadenadores.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 6-InserciondeDatos.sql -o logs\log_insercion.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 7-Vistas.sql -o logs\log_vistas.txt

sqlcmd -S [NOMBRE-SERVIDOR] -i 8-Indices.sql -o logs\log_indices.txt

ECHO LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" SE HA CREADO EXITOSAMENTE.
PAUSE