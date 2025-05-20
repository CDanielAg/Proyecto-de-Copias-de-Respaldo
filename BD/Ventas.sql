-- Crear base de datos si no existe
IF DB_ID('Ventas') IS NULL
BEGIN
    CREATE DATABASE [Ventas];
END

GO
-- Crear tablas 
USE [Ventas];
GO

-- Tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    DNI NVARCHAR(20) UNIQUE NOT NULL,
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    Direccion NVARCHAR(200),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1
);
CREATE INDEX IX_Clientes_DNI ON Clientes(DNI);
GO

-- Tabla Proveedores
CREATE TABLE Proveedores (
    ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Contacto NVARCHAR(100),
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    Direccion NVARCHAR(200),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1
);
CREATE INDEX IX_Proveedores_Nombre ON Proveedores(Nombre);
GO

-- Tabla Productos
CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    Categoria NVARCHAR(50),
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    ProveedorID INT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);
CREATE INDEX IX_Productos_Nombre ON Productos(Nombre);
CREATE INDEX IX_Productos_Categoria ON Productos(Categoria);
GO

-- Tabla Ventas
CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    Fecha DATETIME DEFAULT GETDATE(),
    Total DECIMAL(12, 2),
    Estado NVARCHAR(50),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
CREATE INDEX IX_Ventas_Fecha ON Ventas(Fecha);
GO

-- Tabla Ventas_detalle
CREATE TABLE Ventas_detalle (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(12,2),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
CREATE INDEX IX_VentasDetalle_Venta ON Ventas_detalle(VentaID);
CREATE INDEX IX_VentasDetalle_Producto ON Ventas_detalle(ProductoID);
GO

-- Tabla Comprobante_Pago
CREATE TABLE Comprobante_Pago (
    ComprobanteID INT IDENTITY(1,1) PRIMARY KEY,
    Tipo NVARCHAR(50),
    Descripcion NVARCHAR(255),
    Fecha DATETIME DEFAULT GETDATE(),
    Monto DECIMAL(10, 2),
    VentaID INT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME NULL,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);
CREATE INDEX IX_Comprobante_Fecha ON Comprobante_Pago(Fecha);
GO