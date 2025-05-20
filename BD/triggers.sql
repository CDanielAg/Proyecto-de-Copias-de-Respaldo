-- TRIGGER: AFTER INSERT - Calcular Subtotal y Actualizar Total en Ventas
CREATE TRIGGER TR_CalcularSubtotal_Insert
ON Ventas_detalle
AFTER INSERT
AS
BEGIN
    UPDATE vd
    SET Subtotal = i.Cantidad * i.PrecioUnitario
    FROM Ventas_detalle vd
    INNER JOIN inserted i ON vd.DetalleID = i.DetalleID;

    UPDATE v
    SET v.Total = ISNULL(v.Total, 0) + (i.Cantidad * i.PrecioUnitario)
    FROM Ventas v
    INNER JOIN inserted i ON v.VentaID = i.VentaID;
END;
GO

-- TRIGGER: AFTER UPDATE - Recalcular Subtotal y Actualizar Total en Ventas
CREATE TRIGGER TR_CalcularSubtotal_Update
ON Ventas_detalle
AFTER UPDATE
AS
BEGIN
    UPDATE vd
    SET Subtotal = i.Cantidad * i.PrecioUnitario
    FROM Ventas_detalle vd
    INNER JOIN inserted i ON vd.DetalleID = i.DetalleID;

    UPDATE v
    SET v.Total = ISNULL(v.Total, 0)
                - (ISNULL(d.Cantidad, 0) * ISNULL(d.PrecioUnitario, 0))
                + (ISNULL(i.Cantidad, 0) * ISNULL(i.PrecioUnitario, 0))
    FROM Ventas v
    INNER JOIN deleted d ON v.VentaID = d.VentaID
    INNER JOIN inserted i ON v.VentaID = i.VentaID
    WHERE d.DetalleID = i.DetalleID;
END;
GO

-- TRIGGER: AFTER DELETE - Restar Subtotal eliminado del Total en Ventas
CREATE TRIGGER TR_CalcularSubtotal_Delete
ON Ventas_detalle
AFTER DELETE
AS
BEGIN
    UPDATE v
    SET v.Total = ISNULL(v.Total, 0) - (d.Cantidad * d.PrecioUnitario)
    FROM Ventas v
    INNER JOIN deleted d ON v.VentaID = d.VentaID;
END;
GO

-- TRIGGER: Mensaje al actualizar un Cliente
CREATE TRIGGER TR_Log_Clientes_Update
ON Clientes
AFTER UPDATE
AS
BEGIN
    PRINT 'Se actualizó un cliente con ID: ' + CAST((SELECT TOP 1 ClienteID FROM inserted) AS NVARCHAR);
END;
GO

-- TRIGGER: Mensaje al actualizar un Producto
CREATE TRIGGER TR_Log_Productos_Update
ON Productos
AFTER UPDATE
AS
BEGIN
    PRINT 'Producto actualizado con ID: ' + CAST((SELECT TOP 1 ProductoID FROM inserted) AS NVARCHAR);
END;
GO

-- TRIGGER: Actualizar FechaModificacion de Cliente
CREATE TRIGGER TR_Clientes_Update
ON Clientes
AFTER UPDATE
AS
BEGIN
    UPDATE Clientes
    SET FechaModificacion = GETDATE()
    FROM Clientes C
    INNER JOIN inserted i ON C.ClienteID = i.ClienteID;
END;
GO

-- TRIGGER: Restar stock del producto al insertar venta detalle
CREATE TRIGGER TR_RestarStock_AlInsertarVentaDetalle
ON Ventas_detalle
AFTER INSERT
AS
BEGIN
    UPDATE Productos
    SET Stock = Stock - i.Cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO

-- TRIGGER: Validar que cliente esté activo antes de insertar una venta
CREATE TRIGGER TR_ValidarClienteActivo
ON Ventas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Clientes c ON i.ClienteID = c.ClienteID
        WHERE c.Activo = 0
    )
    BEGIN
        RAISERROR('No se puede registrar venta. Cliente inactivo.', 16, 1);
        RETURN;
    END

    INSERT INTO Ventas (ClienteID, Fecha, Total, Estado, FechaCreacion, FechaModificacion, Activo)
    SELECT ClienteID, Fecha, Total, Estado, FechaCreacion, FechaModificacion, Activo
    FROM inserted;
END;
GO
