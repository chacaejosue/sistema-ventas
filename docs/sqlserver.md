
# Drivers PHP → SQL Server (Windows)

Este documento muestra los pasos mínimos para conectar Laravel a SQL Server desde PHP en Windows.

## Resumen rápido
- Detectar versión de PHP (versión, arquitectura, Thread Safety)
- Descargar los DLLs que coincidan con la versión/arquitectura/TS
- Copiar los DLLs a la carpeta `ext` del PHP (XAMPP o instalación independiente)
- Añadir las líneas `extension=...` al `php.ini`
- Comprobar con `php -m` o `phpinfo()`

## 1. Comprobar tu PHP
- Ejecuta en PowerShell

```powershell
php -v
php -i | findstr /i "Thread"  # para ver si es TS o NTS
php -i | findstr /i "Architecture" # o revisa phpinfo()
```

- Alternativa: crea un archivo `phpinfo.php` con `<?php phpinfo();` y ábrelo en el navegador

Apunta estos valores
- Versión de PHP (p. ej. 7.4, 8.0, 8.1, 8.2)
- Thread Safety: `enabled` (TS) o `disabled` (NTS)
- Arquitectura: `x86` o `x64`

## 2. Descargar los drivers
- Descarga los drivers oficiales (Microsoft Drivers for PHP for SQL Server) [Enlace oficial de Microsoft](https://go.microsoft.com/fwlink/?linkid=2362088)

- Nota sobre las etiquetas de versión (82, 83, 84, etc.): esos números representan la API/ABI de PHP y no son compatibles entre sí

	- `82` → PHP 8.2
	- `83` → PHP 8.3
	- `84` → PHP 8.4

	Debes descargar el paquete que coincida exactamente con tu versión de PHP (por ejemplo, para PHP 8.2 busca `82` en el nombre). Los builds para `83` no son compatibles con PHP 8.2

- Si la versión que buscas no aparece en la página principal, revisa las releases en GitHub del [Repositorio Oficial de Microsoft](https://github.com/microsoft/msphpsql) y el README del driver para la dependencia del Visual C++ Redistributable

## 3. Copiar los archivos .dll
- Copia los DLL descargados (normalmente dos: uno para `pdo_sqlsrv` y otro para `sqlsrv`) dentro de la carpeta `ext` de tu instalación de PHP

- XAMPP: `C:\xampp\php\ext\`
- PHP independiente: `C:\php\ext\` (o la ruta donde esté instalado PHP)

## 4. Editar `php.ini`
- Localiza el `php.ini` que usa Apache / CLI (`php --ini` o revisa `phpinfo()`)
- Añade las líneas correspondientes indicando el nombre exacto de los DLL que descargaste. Ejemplos (ajusta la versión/TS/arch)

```ini
; ejemplos — sustituye por el nombre de archivo real que descargaste
extension=pdo_sqlsrv_80_ts_x64.dll
extension=sqlsrv_80_ts_x64.dll
```

- En algunos paquetes los archivos llevan prefijo `php_`, por ejemplo `php_pdo_sqlsrv_74_ts_x64.dll`. Usa exactamente el nombre presente en la descarga

## 5. Reiniciar y comprobar
- Reinicia Apache (o el servicio de PHP-FPM) desde el Panel de Control de XAMPP o desde servicios de Windows
- Comprueba que las extensiones están cargadas

```powershell
php -m | findstr /i "sqlsrv"
```

- O crea una pequeña ruta con `phpinfo()` y busca `sqlsrv` / `pdo_sqlsrv`

## 6. Visual C++ Redistributable
- Si al intentar cargar las DLL recibes errores del tipo "missing DLL" o "MSVCR*.dll", instala la versión del Visual C++ Redistributable que corresponda (x64 o x86 según arquitectura)

## 7. Notas finales y comprobaciones
- Guarda una copia de seguridad de `php.ini` antes de editar
- Si usas Docker o contenedores, instala los drivers dentro de la imagen PHP correspondiente

## Documentación relacionada
- Ver también: [database/scripts/README.md](database/scripts/README.md) — contiene información importante sobre el script `bat`