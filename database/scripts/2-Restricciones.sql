USE SistemaVentasBD;
GO

------------------ LLAVES FORÁNEAS (RELACIONES) ------------------

-- Producto -> linea
ALTER TABLE producto
ADD CONSTRAINT fk_producto_idlinea
FOREIGN KEY (idlinea) 
REFERENCES linea(idlinea)
ON UPDATE CASCADE;

-- Compra -> Proveedor
ALTER TABLE compra
ADD CONSTRAINT fk_compra_idproveedor
FOREIGN KEY (idproveedor) 
REFERENCES proveedor(idproveedor)
ON UPDATE CASCADE;

-- Compra -> Usuario 
ALTER TABLE compra
ADD CONSTRAINT fk_compra_idusuario
FOREIGN KEY (idusuario) 
REFERENCES usuario(idusuario)
ON UPDATE CASCADE;

-- Venta -> Usuario
ALTER TABLE venta
ADD CONSTRAINT fk_venta_idusuario
FOREIGN KEY (idusuario)
REFERENCES usuario(idusuario)
ON UPDATE CASCADE;

-- Credito -> Venta
ALTER TABLE credito
ADD CONSTRAINT fk_credito_idventa
FOREIGN KEY (idventa)
REFERENCES venta(idventa)
ON UPDATE CASCADE;

-- Cuota -> Credito
ALTER TABLE cuota
ADD CONSTRAINT fk_cuota_idcredito
FOREIGN KEY (idcredito) 
REFERENCES credito(idcredito)
ON UPDATE CASCADE;

-- DetalleVenta -> Venta 
ALTER TABLE detalleventa
ADD CONSTRAINT fk_detalleventa_idventa
FOREIGN KEY (idventa) 
REFERENCES venta(idventa)
--como idventa, es identity, no debe ir ON UPDATE CASCADE,ASI SE GENERARA AUTOMATICAMENTE CUANDO SE HAGA UNA Y OTRA VENTA.

-- DetalleVenta -> producto
ALTER TABLE detalleventa
ADD CONSTRAINT fk_detalleventa_codproducto
FOREIGN KEY (codproducto) 
REFERENCES producto(codproducto)
ON UPDATE CASCADE;

-- DetalleCompra -> Compra 
ALTER TABLE detallecompra
ADD CONSTRAINT fk_detallecompra_idcompra
FOREIGN KEY (idcompra) 
REFERENCES compra(idcompra)
--como idcompra, es identity, no debe ir ON UPDATE CASCADE,ASI SE GENERARA AUTOMATICAMENTE CUANDO SE HAGA UNA Y OTRA COMPRA.

-- DetalleCompra -> Producto
ALTER TABLE detallecompra
ADD CONSTRAINT fk_detallecompra_codproducto
FOREIGN KEY (codproducto) 
REFERENCES producto(codproducto)
ON UPDATE CASCADE;

-- LOTE -> PRODUCTO 
ALTER TABLE lote
ADD CONSTRAINT fk_lote_codpoducto
FOREIGN KEY(codproducto)
REFERENCES producto(codproducto)
ON UPDATE CASCADE

--LOTE -> COMPRA
ALTER TABLE lote
ADD CONSTRAINT fk_lote_idcompra
FOREIGN KEY(idcompra)
REFERENCES compra (idcompra)
ON UPDATE CASCADE




------------------ RESTRICCIONES DE VALIDACIÓN (CHECKS) ------------------

-- Roles de usuario (ajustado a los nombres del diagrama)
ALTER TABLE usuario
ADD CONSTRAINT ch_usuario_rol
CHECK (rol IN ('c', 'a', 'v'));

-- Tipo de venta
ALTER TABLE venta
ADD CONSTRAINT ch_venta_tipo
CHECK (tipo IN ('e', 'c'));

-- Estado de venta
ALTER TABLE venta
ADD CONSTRAINT ch_venta_estado
CHECK (estado IN ('a', 'c','x'));

-- Estado de cuota
ALTER TABLE cuota
ADD CONSTRAINT ch_cuota_estado
CHECK (estado IN ('p', 'e')); -- 'P'agado, 'E'spera

-- Estado de compra
ALTER TABLE compra
ADD CONSTRAINT ch_compra_estado
CHECK (estado IN ('a', 'c', 'x'));

-- Valores no negativos
ALTER TABLE compra
ADD CONSTRAINT ch_compra_importe
CHECK (importe >= 0);
ALTER TABLE venta
ADD CONSTRAINT ch_venta_importe
CHECK (importe >= 0);

ALTER TABLE producto
ADD CONSTRAINT ch_producto_stock
CHECK (stock >= 0);

ALTER TABLE producto
ADD CONSTRAINT ch_producto_preciocompra
CHECK (preciocompra >= 0);

ALTER TABLE producto
ADD CONSTRAINT ch_producto_precioventa
CHECK (precioventa >= 0);

ALTER TABLE credito
ADD CONSTRAINT ch_credito_saldo
CHECK (saldo >= 0);

ALTER TABLE cuota
ADD CONSTRAINT ch_cuota_monto
CHECK (monto >= 0);

ALTER TABLE detalleventa
ADD CONSTRAINT ch_detalleventa_cantidad
CHECK(cantidad>=0)

ALTER TABLE detallecompra
ADD CONSTRAINT ch_detallecompra_cantidad
CHECK (cantidad>=0)

ALTER TABLE lote
ADD CONSTRAINT ch_lote_stock
CHECK (stock>=0)

ALTER TABLE lote
ADD CONSTRAINT ch_lote_cantidadcompra
CHECK (cantidadcompra>0)

------------------ VALORES POR DEFECTO (DEFAULTS) ------------------

ALTER TABLE cuota
ADD CONSTRAINT df_cuota_estado 
DEFAULT 'e' FOR estado;

ALTER TABLE compra
ADD CONSTRAINT df_compra_estado 
DEFAULT 'a' FOR estado;

ALTER TABLE venta
ADD CONSTRAINT df_venta_estado
 DEFAULT 'a' FOR estado;

ALTER TABLE venta
ADD CONSTRAINT df_venta_tipo 
DEFAULT 'e' FOR tipo;  

ALTER TABLE producto
ADD CONSTRAINT df_producto_stock 
DEFAULT 0 FOR stock;

ALTER TABLE venta
ADD CONSTRAINT df_venta_importe
DEFAULT 0 FOR importe;

ALTER TABLE compra
ADD CONSTRAINT df_compra_importe
DEFAULT 0 FOR importe ;

ALTER TABLE lote
ADD CONSTRAINT df_lote_stock
DEFAULT 0 FOR stock  
