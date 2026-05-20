# Scripts de base de datos

Este directorio agrupa los scripts de inicialización, configuración y carga de una base de datos SQL Server.

El archivo principal de entrada es [example.bat](example.bat), que ejecuta los scripts `.sql` en el orden requerido para construir la base de datos completa.

## Propósito

`example.bat` funciona como plantilla de ejecución. Está pensado para:

- centralizar el orden de ejecución de los scripts
- evitar que cada archivo `.sql` se ejecute manualmente
- facilitar la reutilización en distintos entornos cambiando solo el servidor y el nombre de la base de datos

## Dependencias

Antes de ejecutar el script verifica lo siguiente:

- SQL Server instalado y accesible
- Utilidad `sqlcmd` disponible en el sistema
- Archivos `.sql` presentes en este mismo directorio
- Permisos suficientes para crear y modificar objetos en el servidor destino

## Configuración

El archivo [example.bat](example.bat) incluye valores de marcador que debes reemplazar antes de usarlo:

| Marcador | Descripción | Ejemplo |
|---|---|---|
| `[NOMBRE-SERVIDOR]` | Nombre o instancia de SQL Server | `DESKTOP-ABC123\SQLEXPRESS` |
| `[NOMBRE-BASE-DATOS]` | Nombre de la base de datos destino | `MiBaseDatos` |

Ejemplo:

```batch
sqlcmd -S DESKTOP-ABC123\SQLEXPRESS -i 1-CreacionTablas.sql
```

Si el proyecto no incluye todos los componentes previstos, elimina o comenta en `example.bat` las líneas que invoquen scripts que no formen parte de la entrega final, por ejemplo índices, vistas o procedimientos auxiliares.

## Orden de ejecución

El archivo `example.bat` ejecuta los scripts en esta secuencia:

1. Creación de tablas
2. Restricciones
3. Procedimientos almacenados
4. Reglas de negocio para procedimientos
5. Desencadenadores
6. Inserción de datos
7. Vistas
8. Índices

## Ejecución

### Desde el Explorador de Windows

1. Entra a `database/scripts/`.
2. Doble clic en `example.bat`.

### Desde terminal

> Nota: ejecuta `example.bat` desde `database/scripts/`.  
> Las rutas `-i <archivo>.sql` son relativas al directorio actual.

```powershell
cd "<ruta-a-la-raiz-del-repositorio>\sistema-ventas\database\scripts"
.\example.bat
```

## Salida esperada

Si la ejecución es correcta, la consola mostrará mensajes de inicio y cierre. La línea `Presione una tecla para continuar . . .` corresponde a la salida estándar del comando `PAUSE`, que mantiene la ventana abierta hasta que se presione una tecla.

Ejemplo de salida correcta:

```text
COMENZANDO LA CREACION COMPLETA DE LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" ...
LA BASE DE DATOS "[NOMBRE-BASE-DATOS]" SE HA CREADO EXITOSAMENTE.
Presione una tecla para continuar . . .
```

## Diagnóstico básico

Si ocurre un error, revisa primero estos puntos:

| Síntoma | Causa probable | Acción recomendada |
|---|---|---|
| `sqlcmd` no se reconoce | La herramienta no está instalada o no está en `PATH` | Instalar las herramientas de cliente de SQL Server o corregir el entorno |
| No encuentra la instancia | El marcador `[NOMBRE-SERVIDOR]` no fue reemplazado correctamente | Verificar el nombre del servidor en SQL Server Management Studio |
| No abre un archivo `.sql` | El archivo no existe o el nombre no coincide | Confirmar que todos los scripts están en esta carpeta |
| Error de permisos | El usuario no puede crear objetos en la base de datos | Ejecutar con un usuario con permisos adecuados |

## Consideraciones de seguridad

Este archivo está redactado como plantilla para evitar exponer información sensible.

- No incluye credenciales
- No fija nombres reales de servidor
- No depende de un entorno específico

Este formato está pensado para compartirse como plantilla sin exponer valores reales de servidor o base de datos.

## Estructura del directorio

La siguiente estructura corresponde al contenido interno del repositorio, tomando como referencia la carpeta `database/scripts`. La lista es referencial y puede variar según la entrega final; si algún script no forma parte del proyecto, puede omitirse del flujo de ejecución.

```text
database/scripts/
├── README.md
├── example.bat
├── 1-CreacionTablas.sql
├── 2-Restricciones.sql
├── 3-ProcedimientosAlmacenados.sql
├── 4-RNprocedures.sql
├── 5-RNDesencadenadores.sql
├── 6-InserciondeDatos.sql
├── 7-Vistas.sql
└── 8-Indices.sql
```
