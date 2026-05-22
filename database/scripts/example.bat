@ECHO OFF
REM ============================================================================

ECHO COMENZANDO LA CREACION COMPLETA DE LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" ...

sqlcmd -S [NOMBRE-SERVIDOR] -i 1-CreacionTablas.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 2-Restricciones.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 3-ProcedimientosAlmacenados.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 4-RNprocedures.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 5-RNDesencadenadores.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 6-InserciondeDatos.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 7-Vistas.sql

sqlcmd -S [NOMBRE-SERVIDOR] -i 8-Indices.sql

ECHO LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" SE HA CREADO EXITOSAMENTE.
PAUSE
