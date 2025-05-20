-- Crear tabla de auditoría
CREATE TABLE Auditoria (
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    TablaAfectada NVARCHAR(100),
    Operacion NVARCHAR(50),
    DatosAnteriores NVARCHAR(MAX),
    DatosNuevos NVARCHAR(MAX),
    Usuario NVARCHAR(100),
    FechaHora DATETIME DEFAULT GETDATE(),
    Host NVARCHAR(100)
);

-- Trigger para tabla Clientes
CREATE TRIGGER trg_Clientes_Insert
ON Clientes
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Clientes',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Clientes_Update
ON Clientes
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Clientes',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Clientes_Delete
ON Clientes
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Clientes',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
END;
GO

-- Trigger para tabla Productos
CREATE TRIGGER trg_Productos_Insert
ON Productos
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Productos',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Productos_Update
ON Productos
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Productos',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Productos_Delete
ON Productos
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Productos',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
END;
GO

-- Trigger para tabla Ventas
CREATE TRIGGER trg_Ventas_Insert
ON Ventas
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Ventas',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Ventas_Update
ON Ventas
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Ventas',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Ventas_Delete
ON Ventas
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Ventas',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
END;
GO

-- Trigger para tabla Ventas_detalle
CREATE TRIGGER trg_VentasDetalle_Insert
ON Ventas_detalle
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Ventas_detalle',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_VentasDetalle_Update
ON Ventas_detalle
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Ventas_detalle',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_VentasDetalle_Delete
ON Ventas_detalle
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Ventas_detalle',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
END;
GO

-- Trigger para tabla Proveedores
CREATE TRIGGER trg_Proveedores_Insert
ON Proveedores
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Proveedores',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Proveedores_Update
ON Proveedores
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Proveedores',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_Proveedores_Delete
ON Proveedores
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Proveedores',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
END;
GO

-- Trigger para tabla Comprobante_Pago
CREATE TRIGGER trg_ComprobantePago_Insert
ON Comprobante_Pago
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Comprobante_Pago',
        'INSERT',
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_ComprobantePago_Update
ON Comprobante_Pago
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        DatosNuevos,
        Usuario,
        Host
    )
    SELECT 
        'Comprobante_Pago',
        'UPDATE',
        (SELECT * FROM deleted FOR JSON AUTO),
        (SELECT * FROM inserted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM inserted;
END;
GO

CREATE TRIGGER trg_ComprobantePago_Delete
ON Comprobante_Pago
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (
        TablaAfectada,
        Operacion,
        DatosAnteriores,
        Usuario,
        Host
    )
    SELECT 
        'Comprobante_Pago',
        'DELETE',
        (SELECT * FROM deleted FOR JSON AUTO),
        SUSER_SNAME(),
        HOST_NAME()
    FROM deleted;
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
