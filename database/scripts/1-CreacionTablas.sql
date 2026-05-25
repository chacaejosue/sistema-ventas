USE MASTER;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'SistemaVentasBD')
BEGIN
    ALTER DATABASE SistemaVentasBD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE SistemaVentasBD;
	PRINT 'Base de datos SistemaVentasBD eliminada.';
END
GO

CREATE DATABASE SistemaVentasBD;
GO

USE SistemaVentasBD;
GO

CREATE TABLE linea (
    idlinea VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE usuario (
    idusuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    direccion VARCHAR(255) NULL,
    rol CHAR(1) NOT NULL
);

CREATE TABLE producto (
    codproducto VARCHAR (20) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    preciocompra SMALLMONEY NOT NULL,
    precioventa SMALLMONEY NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    stock SMALLINT NOT NULL,
    idlinea VARCHAR(50) NOT NULL
);

CREATE TABLE proveedor (
    idproveedor INT IDENTITY(1,1) PRIMARY KEY,
    empresa VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE compra (
    idcompra INT IDENTITY(1,1) PRIMARY KEY,
    fechacompra SMALLDATETIME NOT NULL,
    importe SMALLMONEY NOT NULL,
    estado CHAR(1) NOT NULL,
    idproveedor INT,
    idusuario INT
);

CREATE TABLE venta (
    idventa INT IDENTITY(1,1) PRIMARY KEY,
    fechaventa SMALLDATETIME NOT NULL,
    importe SMALLMONEY NOT NULL,
    estado CHAR (1) NOT NULL,
    tipo CHAR(1) NOT NULL,
    idusuario INT
);

CREATE TABLE credito (
    idcredito INT IDENTITY(1,1) PRIMARY KEY,
    saldo SMALLMONEY NOT NULL,
    idventa INT NOT NULL UNIQUE
);

CREATE TABLE cuota (
    idcuota INT IDENTITY(1,1) PRIMARY KEY,
    monto SMALLMONEY NOT NULL,
    fechavencimiento SMALLDATETIME NOT NULL,
    estado CHAR(1) NOT NULL,
    idcredito INT
);

CREATE TABLE detalleventa (
    idventa INT NOT NULL,
    codproducto VARCHAR(20) NOT NULL,
    cantidad SMALLINT NOT NULL,
    preciounitario SMALLMONEY NOT NULL,
    subimporte SMALLMONEY NOT NULL,
    PRIMARY KEY (idventa, codproducto)
);

CREATE TABLE detallecompra (
    idcompra INT NOT NULL,
    codproducto VARCHAR(20)NOT NULL,
    cantidad SMALLINT NOT NULL,
    preciounitario SMALLMONEY NOT NULL,
    subimporte SMALLMONEY NOT NULL,
    PRIMARY KEY (idcompra, codproducto)
);

CREATE TABLE lote(
    idlote INT IDENTITY(1,1) PRIMARY KEY,
    fechacompra SMALLDATETIME NOT NULL,
    cantidadcompra SMALLINT NOT NULL,
    fechavencimiento SMALLDATETIME NOT NULL,
    stock SMALLINT NOT NULL,
    codproducto VARCHAR(20),
    idcompra INT
);
