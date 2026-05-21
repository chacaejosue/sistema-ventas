---------tabla linea --------------

CREATE PROCEDURE sp_insertar_linea @idlinea VARCHAR(20),@nombre VARCHAR(50)
AS INSERT INTO linea (idlinea, nombre) VALUES(@idlinea, @nombre)
GO  

CREATE PROCEDURE sp_modificar_linea @idlinea VARCHAR(20),@nombre VARCHAR(50)
AS UPDATE linea SET nombre = @nombre WHERE idlinea = @idlinea
GO  

CREATE PROCEDURE sp_listar_linea
AS SELECT * FROM linea
GO

CREATE PROCEDURE sp_buscar_linea
    @idlinea VARCHAR(20)
AS SELECT * FROM linea WHERE idlinea = @idlinea
GO
-------tabla producto-------
CREATE PROCEDURE sp_insertar_producto @codprod VARCHAR(20),@nombre VARCHAR(50),@preciocom SMALLMONEY,@precioven SMALLMONEY,@categ VARCHAR(20),@stock SMALLINT,@idlinea VARCHAR(20)
AS INSERT INTO producto(codproducto, nombre, preciocompra, precioventa, categoria, stock, idlinea)
VALUES( @codprod,@nombre,@preciocom, @precioven,@categ,@stock,@idlinea )
GO

CREATE PROCEDURE sp_modificar_producto @codprod VARCHAR(20),@nombre VARCHAR(50),@preciocom SMALLMONEY, @precioven SMALLMONEY,@categ VARCHAR(20), @stock SMALLINT, @idlinea VARCHAR(20)
AS UPDATE producto SET nombre = @nombre,preciocompra = @preciocom,precioventa = @precioven,categoria=@categ,stock = @stock,idlinea = @idlinea
WHERE codproducto = @codprod
GO

CREATE PROCEDURE sp_listar_producto
AS SELECT * FROM producto
GO

CREATE PROCEDURE sp_buscar_producto @codprod VARCHAR(20)
AS SELECT * FROM producto WHERE codproducto = @codprod
GO
---------venta -------------

CREATE PROCEDURE sp_insertarventa @fechav SMALLDATETIME,  @importe SMALLMONEY, @estado CHAR(1), @tipo CHAR(1),@usuario INT
AS INSERT INTO venta(fechaventa, importe, estado, tipo, idusuario)
    VALUES (@fechav, @importe, @estado, @tipo, @usuario)
GO
CREATE PROCEDURE sp_modificarventa @idvent INT,@fechav SMALLDATETIME, @importe SMALLMONEY, @estado CHAR(1), @tipo CHAR(1), @usuario INT
AS UPDATE venta SET fechaventa = @fechav, importe = @importe, estado = @estado, tipo = @tipo, idusuario = @usuario
WHERE idventa = @idvent
GO


----------compra------------------

CREATE PROCEDURE sp_insertarcompra @fechac SMALLDATETIME, @importe SMALLMONEY, @estado CHAR(1), @proveedor INT, @usuario INT
AS INSERT INTO compra(fechacompra, importe, estado, idproveedor, idusuario)
VALUES ( @fechac, @importe, @estado, @proveedor, @usuario)
GO

CREATE PROCEDURE sp_modificarcompra @idcomp INT, @fechac SMALLDATETIME, @importe SMALLMONEY, @estado CHAR(1), @proveedor INT, @usuario INT
AS UPDATE compra SET fechacompra = @fechac,importe = @importe,estado = @estado, idproveedor = @proveedor,  idusuario = @usuario
WHERE idcompra = @idcomp
GO

