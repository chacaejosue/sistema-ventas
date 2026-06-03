# Sistema de Ventas y Finanzas para Asesores de Venta (Web)

Proyecto universitario en desarrollo. Aplicación web orientada a asesores de venta (p. ej. ventas por catálogo) que suelen registrar ventas/finanzas en Excel o cuadernos.  
El sistema busca centralizar: **catálogo de productos, contacto, solicitudes de pedido por WhatsApp** (inicialmente) y **control financiero** (ingresos, egresos, inversión, utilidades).

> Estado: **En desarrollo (no finalizado)**  
> Stack: **Laravel (Blade/PHP) + SQL Server (T-SQL)**

---

## Contexto y motivación
En ventas por catálogo o ventas independientes, es común que el asesor gestione su negocio con herramientas manuales (Excel, notas). Esto puede generar:
- información duplicada o desactualizada,
- dificultad para llevar control de ingresos/egresos/inversión,
- poca visibilidad del catálogo para clientes,
- falta de un lugar único para registrar pedidos y dar seguimiento.

Este sistema propone una alternativa web enfocada en **organización, visibilidad y control**.

---

## Objetivo general
Desarrollar una plataforma web que permita:
- Mostrar un **catálogo** de productos con precios e información relevante.
- Facilitar que el cliente realice una **solicitud de compra/pedido** (actualmente por WhatsApp).
- Mantener la información de contacto del asesor accesible.
- Gestionar el **registro financiero** del negocio.
- (Proyectado) Simular un flujo de compra tipo e-commerce para demostrar arquitectura (sin pasarela real).

---

## Funcionalidades (plan / en progreso)
### Catálogo
- [ ] CRUD de productos (administración)
- [ ] Listado público de productos (cliente)
- [ ] Búsqueda y filtrado básico
- [ ] Imágenes y precios

### Pedidos / Ventas
- [ ] Solicitud de pedido vía WhatsApp (flujo principal actual)
- [ ] Registro interno de pedidos (opcional / en evaluación)
- [ ] Estados de pedido (pendiente, confirmado, entregado, cancelado)
- [ ] Historial

### Finanzas
- [ ] Registro de ingresos
- [ ] Registro de egresos
- [ ] Registro de inversión (compra de stock)
- [ ] Reportes/resúmenes por fechas

### Seguridad / Accesos
- [ ] Login para administrador/asesor
- [ ] Login para clientes (en evaluación: podría afectar conversión/UX)

### Arquitectura e-commerce (demo)
- [ ] “Simulación” de pago (UI + flujo) para fines académicos/arquitectónicos
- [ ] Sin integración real con pasarelas (por ahora)

---

## Enfoque de base de datos (SQL Server)
Este proyecto **NO utiliza Eloquent Models, Migrations ni Seeders**.

La base de datos se gestiona con:
- Scripts `.sql` (creación de tablas, relaciones, restricciones, índices, vistas, etc.)
- Procedimientos almacenados (SP) para lógica de negocio
- Consultas parametrizadas desde Laravel hacia SQL Server

Los scripts se encuentran en:
- [`database/scripts/`](database/scripts/)

Documentación adicional del enfoque (decisiones, configuración y notas):
- [`docs/`](docs/)

> Recomendación: revisa primero `docs/` antes de correr el proyecto si es tu primera vez.

---

## Tecnologías
- **Backend:** Laravel (PHP)
- **Frontend:** Blade
- **Base de datos:** Microsoft SQL Server (T-SQL)
- **Acceso a datos:** Procedimientos almacenados + consultas SQL desde Laravel
- **Control de versiones:** Git / GitHub

---

## Requisitos (desarrollo)
- PHP (según `composer.json`)
- Composer
- SQL Server
- Extensiones de PHP para SQL Server:
  - `sqlsrv`
  - `pdo_sqlsrv`
- Node.js / NPM (si el proyecto usa Vite o build de assets)

---

## Instalación (desarrollo)
1) Clonar repositorio
```bash
git clone https://github.com/chacaejosue/sistema-ventas.git
cd sistema-ventas
```

2) Dependencias PHP
```bash
composer install
```

3) Variables de entorno
```bash
cp .env.example .env
php artisan key:generate
```

4) Configurar SQL Server en `.env` (ejemplo)
```env
DB_CONNECTION=sqlsrv
DB_HOST=localhost
DB_PORT=1433
DB_DATABASE=SistemaVentasBD
DB_USERNAME=sa
DB_PASSWORD=tu_password
```

5) Crear la base de datos (scripts)
- Ejecuta los scripts `.sql` ubicados en [`database/scripts/`](database/scripts/) en tu SQL Server (tablas, SP, vistas, etc.).
  - Puedes ejecutarlos **uno por uno** en el orden indicado, o usar el archivo **`.bat`** incluido en esa carpeta para automatizar la ejecución.
  - Revisa las instrucciones detalladas en: [`database/scripts/README.md`](database/scripts/README.md)

6) Ejecutar servidor
```bash
php artisan serve
```

---

## Ejecución y demostración (acceso externo)
Para fines de demostración al docente, el proyecto puede exponerse de forma temporal mediante:
- Port forwarding de VS Code (Ports)
- Túneles como ngrok / cloudflared / etc.

> Importante: no exponer credenciales reales ni datos sensibles en despliegues de demostración.

---

## Estructura del repositorio (orientativa)
- `resources/views/` → vistas Blade
- `routes/web.php` → rutas web
- `app/Http/Controllers/` → controladores
- `database/scripts/` → scripts SQL Server (tablas, SP, etc.)
- `docs/` → documentación del proyecto (decisiones técnicas, configuración, etc.)

---

## Capturas (pendiente)
- [ ] Página principal / catálogo
- [ ] Detalle de producto
- [ ] Solicitud de pedido (WhatsApp)
- [ ] Panel admin
- [ ] Panel finanzas

---

## Licencia
Aún no se ha definido la licencia del proyecto (proyecto académico en desarrollo).

---

## Autoría / contexto académico
Proyecto desarrollado con fines académicos (universidad).  