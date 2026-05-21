CREATE DATABASE SistemaVentasBD;
GO
USE SistemaVentasBD;
GO

-- 1. TABLA LINEA
CREATE TABLE linea (
    idlinea VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. TABLA USUARIO
CREATE TABLE usuario (
    idusuario INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(50) NULL,
    rol CHAR(1) NOT NULL -- Según tu diagrama es un enum(cliente"C", adm"A", consultor"V"
);

-- 3. TABLA PRODUCTO
CREATE TABLE producto (
    codproducto VARCHAR (20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    preciocompra SMALLMONEY NOT NULL,
    precioventa SMALLMONEY NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    stock SMALLINT NOT NULL,
    idlinea VARCHAR(20)

);

-- 4. TABLA PROVEEDOR
CREATE TABLE proveedor (
    idproveedor INT PRIMARY KEY,
    empresa VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL -- Añadido según tu diagrama
);

-- 5. TABLA COMPRA
CREATE TABLE compra (
    idcompra INT IDENTITY(1,1) PRIMARY KEY,
    fechacompra SMALLDATETIME NOT NULL,
    importe SMALLMONEY NOT NULL,
    estado CHAR(1) NOT NULL, -- Ej: 'A'bierta, 'C'errada, 'x' anulada
    idproveedor INT,
    idusuario INT
);

-- 6. TABLA VENTA
CREATE TABLE venta (
    idventa INT IDENTITY(1,1) PRIMARY KEY,
    fechaventa SMALLDATETIME NOT NULL,
    importe SMALLMONEY NOT NULL,
    estado CHAR (1) NOT NULL, -- Ej: 'A'bierta, 'C'ancelada, 'X' anulada
    tipo CHAR(1) NOT NULL, -- Según tu diagrama enum(contado 'c', efectivo 'e')
    idusuario INT
    
);

-- 7. TABLA CREDITO
CREATE TABLE credito (
    idcredito INT PRIMARY KEY,
    saldo SMALLMONEY NOT NULL,
    idventa INT
);

-- 8. TABLA CUOTA
CREATE TABLE cuota (
    idcuota INT PRIMARY KEY,
    monto SMALLMONEY NOT NULL,
    fechavencimiento SMALLDATETIME NOT NULL,
    estado CHAR(1), --tipo 'p'agado, 'e' espera
    idcredito INT
);

-- 9. TABLA DETALLEVENTA
CREATE TABLE detalleventa (
    idventa INT NOT NULL,
    codproducto VARCHAR(20) NOT NULL,
    cantidad SMALLINT NOT NULL,
    preciounitario SMALLMONEY NOT NULL,
    subimporte AS (cantidad * preciounitario), -- Columna calculada como en tus otros proyectos
    PRIMARY KEY (idventa, codproducto)
);

-- 10. TABLA DETALLECOMPRA
CREATE TABLE detallecompra (
    idcompra INT NOT NULL,
    codproducto VARCHAR(20)NOT NULL,
    cantidad SMALLINT NOT NULL,
    preciounitario SMALLMONEY NOT NULL,
    subimporte AS (cantidad * preciounitario), -- Columna calculada
    PRIMARY KEY (idcompra, codproducto)
);
---11. TABLA LOTE
CREATE TABLE lote( 
    idlote INT IDENTITY(1,1) PRIMARY KEY,
    fechacompra SMALLDATETIME NOT NULL,
    cantidadcompra SMALLINT NOT NULL,
    fechavencimiento SMALLDATETIME NOT NULL,
    stock SMALLINT NOT NULL,
    codproducto VARCHAR(20),
    idcompra int)