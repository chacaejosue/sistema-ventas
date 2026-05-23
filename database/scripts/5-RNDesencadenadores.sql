USE SistemaVentasBD;
GO

CREATE TRIGGER des_detalleventa
ON detalleventa
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @idventa INT,
            @codproducto VARCHAR(20);

    SELECT @idventa = idventa,
           @codproducto = codproducto
    FROM INSERTED;

    IF @idventa IS NULL
    BEGIN
        SELECT @idventa = idventa,
               @codproducto = codproducto
        FROM DELETED;
    END

    EXEC sp_calcularimporteventa @idventa;
    EXEC sp_actualizarstock @codproducto;
END
GO

CREATE TRIGGER des_detallecompra
ON detallecompra
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @idcompra INT,
            @codproducto VARCHAR(20);

    SELECT @idcompra = idcompra,
           @codproducto = codproducto
    FROM INSERTED;

    IF @idcompra IS NULL
    BEGIN
        SELECT @idcompra = idcompra,
               @codproducto = codproducto
        FROM DELETED;
    END

    EXEC sp_calcularimportecompra @idcompra;
    EXEC sp_actualizarstock @codproducto;
END
GO

CREATE TRIGGER des_cuota
ON cuota
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @idcredito INT;

    SELECT @idcredito = idcredito
    FROM INSERTED;

    EXEC sp_ActualizarSaldoCredito @idcredito;
END
GO
