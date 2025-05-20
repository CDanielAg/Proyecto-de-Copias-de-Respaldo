-- Crear tabla de auditoría
CREATE TABLE Auditoria (
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    TablaAfectada NVARCHAR(50) NOT NULL,
    TipoOperacion NVARCHAR(10) NOT NULL,
    DatosAnteriores NVARCHAR(MAX),
    DatosNuevos NVARCHAR(MAX),
    Usuario NVARCHAR(100) NOT NULL,
    Host NVARCHAR(100) NOT NULL,
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    Ip NVARCHAR(50)
);
