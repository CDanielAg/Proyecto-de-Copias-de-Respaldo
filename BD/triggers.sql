-- Triggers de auditoría para ventas

-- Trigger para tabla Ventas
CREATE TRIGGER trg_Ventas_Auditoria
ON Ventas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Para INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Auditoria (
            TablaAfectada,
            TipoOperacion,
            DatosNuevos,
            Usuario,
            Host,
            Ip
        )
        SELECT 
            'Ventas',
            'INSERT',
            (SELECT IdVenta, IdCliente, FechaVenta, MontoTotal, Estado 
             FROM inserted 
             FOR JSON AUTO),
            SUSER_SNAME(),
            HOST_NAME(),
            CONNECTIONPROPERTY('client_net_address')
        FROM inserted;
    END
    
    -- Para UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Auditoria (
            TablaAfectada,
            TipoOperacion,
            DatosAnteriores,
            DatosNuevos,
            Usuario,
            Host,
            Ip
        )
        SELECT 
            'Ventas',
            'UPDATE',
            (SELECT IdVenta, IdCliente, FechaVenta, MontoTotal, Estado 
             FROM deleted 
             FOR JSON AUTO),
            (SELECT IdVenta, IdCliente, FechaVenta, MontoTotal, Estado 
             FROM inserted 
             FOR JSON AUTO),
            SUSER_SNAME(),
            HOST_NAME(),
            CONNECTIONPROPERTY('client_net_address')
        FROM inserted
        INNER JOIN deleted ON inserted.IdVenta = deleted.IdVenta;
    END
    
    -- Para DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Auditoria (
            TablaAfectada,
            TipoOperacion,
            DatosAnteriores,
            Usuario,
            Host,
            Ip
        )
        SELECT 
            'Ventas',
            'DELETE',
            (SELECT IdVenta, IdCliente, FechaVenta, MontoTotal, Estado 
             FROM deleted 
             FOR JSON AUTO),
            NULL,
            SUSER_SNAME(),
            HOST_NAME(),
            CONNECTIONPROPERTY('client_net_address')
        FROM deleted;
    END
END;
GO