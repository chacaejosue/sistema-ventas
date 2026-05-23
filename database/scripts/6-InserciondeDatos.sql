USE SistemaVentasBD;
GO

INSERT INTO linea VALUES('CARA', 'Productos para la cara');
INSERT INTO linea VALUES('CABELLO', 'Cuidado capilar');
INSERT INTO linea VALUES('PERFUME', 'Fragancias');

INSERT INTO usuario VALUES('Usuario 1', 'u1@local', '123', '900001', 'Dir 1', 'a');
INSERT INTO usuario VALUES('Usuario 2', 'u2@local', '123', '900002', 'Dir 2', 'v');
INSERT INTO usuario VALUES('Usuario 3', 'u3@local', '123', '900003', 'Dir 3', 'c');

INSERT INTO proveedor VALUES('Proveedor 1', '800001', 'p1@local');
INSERT INTO proveedor VALUES('Proveedor 2', '800002', 'p2@local');
INSERT INTO proveedor VALUES('Proveedor 3', '800003', 'p3@local');

INSERT INTO producto VALUES('P001', 'Gel limpiador facial', 10, 12, 'Limpieza', 0, 'CARA');
INSERT INTO producto VALUES('P002', 'Shampoo fortalecedor', 5, 7, 'Cabello', 0, 'CABELLO');
INSERT INTO producto VALUES('P003', 'Colonia cítrica', 20, 25, 'Fragancia', 0, 'PERFUME');

INSERT INTO compra VALUES(GETDATE(), 0, 'a', 1, 1);
INSERT INTO compra VALUES(GETDATE(), 0, 'a', 2, 2);
INSERT INTO compra VALUES(GETDATE(), 0, 'a', 3, 3);

INSERT INTO lote VALUES(GETDATE(), 100, DATEADD(DAY, 365, GETDATE()), 100, 'P001', 1);
INSERT INTO lote VALUES(GETDATE(), 50, DATEADD(DAY, 365, GETDATE()), 50, 'P002', 2);
INSERT INTO lote VALUES(GETDATE(), 75, DATEADD(DAY, 365, GETDATE()), 75, 'P003', 3);

INSERT INTO venta VALUES(GETDATE(), 0, 'a', 'e', 1);
INSERT INTO venta VALUES(GETDATE(), 0, 'a', 'e', 2);
INSERT INTO venta VALUES(GETDATE(), 0, 'a', 'c', 3);

INSERT INTO credito VALUES(0, 1);
INSERT INTO credito VALUES(0, 2);
INSERT INTO credito VALUES(0, 3);
