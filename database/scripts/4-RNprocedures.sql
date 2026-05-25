USE SistemaVentasBD;
GO

CREATE PROCEDURE sp_actualizarstock @codproducto VARCHAR(20) AS
BEGIN
    DECLARE @cant SMALLINT;

    SELECT @cant = SUM(stock)
    FROM lote
    WHERE codproducto = @codproducto;

    UPDATE producto
    SET stock = ISNULL(@cant,0)
    WHERE codproducto = @codproducto;
END
GO

CREATE PROCEDURE sp_calcularimporteventa @idventa INT AS
BEGIN
    DECLARE @total SMALLMONEY;

    SELECT @total = SUM(subimporte)
    FROM detalleventa
    WHERE idventa = @idventa;

    UPDATE venta
    SET importe = ISNULL(@total,0)
    WHERE idventa = @idventa;
END
GO

CREATE PROCEDURE sp_calcularimportecompra @idcompra INT AS
BEGIN
    DECLARE @total SMALLMONEY;

    SELECT @total = SUM(subimporte)
    FROM detallecompra
    WHERE idcompra = @idcompra;

    UPDATE compra
    SET importe = ISNULL(@total,0)
    WHERE idcompra = @idcompra;
END
GO

CREATE PROCEDURE sp_ActualizarSaldoCredito @idcredito INT AS
BEGIN
    DECLARE @montopagado SMALLMONEY, @totalventa SMALLMONEY;

    SELECT @montopagado = SUM(monto)
    FROM cuota
    WHERE idcredito = @idcredito
      AND estado = 'p';

    SELECT @totalventa = v.importe
    FROM venta v
    INNER JOIN credito c
        ON v.idventa = c.idventa
    WHERE c.idcredito = @idcredito;

    UPDATE credito
    SET saldo = @totalventa - ISNULL(@montopagado,0)
    WHERE idcredito = @idcredito;
END
GO

CREATE PROCEDURE sp_InsertarDetalleVenta @idventa INT, @codproducto VARCHAR(20), @cantidad SMALLINT, @preciounitario SMALLMONEY AS
BEGIN
    DECLARE @stockactual SMALLINT;

    SELECT @stockactual = stock
    FROM producto
    WHERE codproducto = @codproducto;

    IF @stockactual < @cantidad
    BEGIN
        PRINT 'STOCK INSUFICIENTE';
        RETURN;
    END

    INSERT INTO detalleventa(idventa, codproducto, cantidad, preciounitario, subimporte)
    VALUES(@idventa, @codproducto, @cantidad, @preciounitario, (@cantidad * @preciounitario));

    UPDATE lote
    SET stock = stock - @cantidad
    WHERE idlote =
    (
        SELECT TOP 1 idlote
        FROM lote
        WHERE codproducto = @codproducto AND stock >= @cantidad
        ORDER BY fechacompra
    );
END
GO

CREATE PROCEDURE sp_InsertarDetalleCompra @idcompra INT, @codproducto VARCHAR(20), @cantidad SMALLINT, @preciounitario SMALLMONEY, @fechavencimiento SMALLDATETIME AS
BEGIN
    INSERT INTO detallecompra(idcompra, codproducto, cantidad, preciounitario, subimporte)
    VALUES(@idcompra, @codproducto, @cantidad, @preciounitario, (@cantidad * @preciounitario));

    INSERT INTO lote(fechacompra, cantidadcompra, fechavencimiento, stock, codproducto, idcompra)
    VALUES(GETDATE(), @cantidad, @fechavencimiento, @cantidad, @codproducto, @idcompra);
END
GO

CREATE PROCEDURE sp_PagarCuota @idcuota INT AS
BEGIN
    DECLARE @idcredito INT;

    UPDATE cuota
    SET estado = 'p'
    WHERE idcuota = @idcuota;

    SELECT @idcredito = idcredito
    FROM cuota
    WHERE idcuota = @idcuota;

    EXEC sp_ActualizarSaldoCredito @idcredito;
END
GO
