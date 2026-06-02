# Configuración del archivo .env (basado en .env.example)

Este documento explica cómo preparar y configurar el archivo de entorno para trabajar con este proyecto Laravel.

## Resumen rápido
- Copia `.env.example` a `.env`
- Instala dependencias
- Genera la clave de la aplicación
- Configura variables principales (`APP`, `DB`, `MAIL`, `STORAGE`, `CACHE`, `QUEUE`)

> Nota: este proyecto usa SQL Server; la lógica de BD (tablas, restricciones, procedimientos, datos iniciales) se aplica mediante scripts `.sql` en `database/scripts/` ejecutados con un archivo por lotes (`.bat`). No se usan seeders de Laravel.

## Preparación rápida
- Clona el repositorio y sitúate en la rama de trabajo
- Instala dependencias con Composer y NPM si aplica

```bash
composer install
npm install
npm run build # o npm run dev en desarrollo
```

## 1. Crear el archivo .env
- Copia el ejemplo y añade tus credenciales locales

```powershell
copy .env.example .env
# Unix: cp .env.example .env
```

## 2. Generar la APP_KEY
- Laravel requiere una `APP_KEY` válida para encriptación y sesiones

```bash
php artisan key:generate
```

Esto actualizará `APP_KEY` en tu `.env`.

## 3. Variables esenciales y su significado

### `APP_*`
- `APP_NAME`: nombre de la aplicación, útil para correos y vistas
- `APP_ENV`: `local`, `development`, `production`
- `APP_KEY`: generada con `php artisan key:generate`
- `APP_DEBUG`: `true` en desarrollo, `false` en producción
- `APP_URL`: URL base de la app (ej. `http://localhost`)

### Logging
- `LOG_CHANNEL` / `LOG_LEVEL`: configuración de logging

### Base de datos (`DB_*`)
- `DB_CONNECTION`: `mysql`, `pgsql`, `sqlite`, `sqlsrv`
- `DB_HOST`: host de la base de datos (ej. `127.0.0.1`)
- `DB_PORT`: puerto (ej. `3306` o `1433`)
- `DB_DATABASE`: nombre de la base de datos
- `DB_USERNAME`: usuario de la BD
- `DB_PASSWORD`: contraseña de la BD

#### Ejemplo mínimo (SQL Server)

```env
DB_CONNECTION=sqlsrv
DB_HOST=127.0.0.1
DB_PORT=1433
DB_DATABASE=sistema_ventas
DB_USERNAME=sa
DB_PASSWORD=YourStrong!Passw0rd
```

### Cache y sesiones
- `CACHE_DRIVER`: `file`, `redis`, `memcached`
- `SESSION_DRIVER`: `file`, `cookie`, `database`, `redis`
- `QUEUE_CONNECTION`: `sync`, `database`, `redis`, `sqs`

## Mail (nota rápida)
- Si no usas correo en desarrollo, deja el driver en `log` o `array` para evitar envíos reales

```env
MAIL_MAILER=log
MAIL_FROM_ADDRESS=testing@example.com
MAIL_FROM_NAME="Sistema Ventas"
```

### Filesystem / S3
- `FILESYSTEM_DRIVER`: `public` o `s3`
- Si usas S3, configura `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`, `AWS_BUCKET`, `AWS_URL`

### Broadcasting / Pusher
- Si usas broadcasting, configura `BROADCAST_DRIVER`, `PUSHER_APP_ID`, `PUSHER_APP_KEY`, `PUSHER_APP_SECRET`, `PUSHER_APP_CLUSTER`

### Redis
- Configura `REDIS_HOST`, `REDIS_PASSWORD`, `REDIS_PORT` si usas Redis

## 4. Valores típicos para desarrollo
- Usa contraseñas sencillas en local, pero NUNCA subas `.env` al repositorio

```env
APP_NAME=SistemaVentas
APP_ENV=local
APP_KEY=base64:GENERADA_POR_ARTISAN
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sistema_ventas
DB_USERNAME=root
DB_PASSWORD=

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=
MAIL_PASSWORD=
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=testing@example.com
MAIL_FROM_NAME="Sistema Ventas"
```

## 5. Permisos y storage
- En Windows no suele ser necesario cambiar permisos
- En Linux asegúrese de que `storage/` y `bootstrap/cache` sean escribibles por el usuario del servidor web

```bash
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
```

## 6. Base de datos: aplicar scripts SQL (SQL Server)
- La lógica de BD (tablas, restricciones, SP, datos) está en `database/scripts/`
- Archivo principal privado: `database/scripts/Script-SistemaVentasBD.bat` — pensado para uso local y excluido por `gitignore`
- Archivo base público: `database/scripts/example.bat` — copie/renombre y ajuste credenciales locales

Consulte el orden recomendado en: [database/scripts/README.md](database/scripts/README.md).

> Nota: para que PHP pueda conectar directamente con SQL Server en Windows es necesario instalar los drivers de PHP (`sqlsrv` y `pdo_sqlsrv`). Siga la guía en: [docs/sqlserver.md](docs/sqlserver.md).

### Pasos rápidos (Windows)
1. Verifica que SQL Server está activo
2. Ajusta `DB_*` en tu `.env` (ver ejemplo SQL Server arriba)
3. Copia `database/scripts/example.bat` a `database/scripts/Script-SistemaVentasBD.bat` y edítalo con tus credenciales
4. Ejecuta desde la raíz del proyecto

Seguridad: no subas `Script-SistemaVentasBD.bat` con credenciales; usa `example.bat` como plantilla.

## 7. Buenas prácticas y seguridad
- Nunca subas tu `.env` al repositorio
- Mantén `APP_DEBUG=false` en producción
- Usa contraseñas y claves seguras en producción

## 8. Comandos útiles (resumen rápido)

```powershell
copy .env.example .env        # cp .env.example .env
composer install
npm install && npm run dev
php artisan key:generate
```

## 9. Solución de problemas
- Si `APP_KEY` no se genera: verifica permisos del archivo `.env` y ejecuta `php artisan key:generate --force`
- Fallos de conexión a BD: revisa `DB_HOST`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD` y que el servicio de BD esté activo