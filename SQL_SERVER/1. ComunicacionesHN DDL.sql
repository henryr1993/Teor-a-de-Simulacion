-- Crear la base de datos
CREATE DATABASE ComunicacionesHN;
GO

USE ComunicacionesHN;
GO

-- Tabla: Departamentos
CREATE TABLE Departamentos (
    DepartamentoID INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL
);

-- Tabla: Municipios
CREATE TABLE Municipios (
    MunicipioID INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    DepartamentoID INT NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

-- Tabla: Ubicaciones
CREATE TABLE Ubicaciones (
    UbicacionID INT IDENTITY PRIMARY KEY,
    DepartamentoID INT NOT NULL,
    MunicipioID INT NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID),
    FOREIGN KEY (MunicipioID) REFERENCES Municipios(MunicipioID)
);

-- Tabla: Clientes
CREATE TABLE Clientes (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Correo NVARCHAR(255) UNIQUE,
    NumeroTelefono NVARCHAR(15) UNIQUE NOT NULL,
    TipoUsuario CHAR(1) CHECK (TipoUsuario IN ('P', 'R')), -- P: Postpago, R: Prepago
    FechaRegistro DATE NOT NULL,
    Estado CHAR(1) CHECK (Estado IN ('A', 'I')) DEFAULT 'A', -- A: Activo, I: Inactivo
    NombreFiador NVARCHAR(255),
    TelefonoFiador NVARCHAR(15),
    CentralRiesgo BIT DEFAULT 0, -- 0: No reportado, 1: Reportado
    UbicacionID INT NOT NULL,
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);

-- Tabla Vendedores
CREATE TABLE Vendedores (
    VendedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(15) NOT NULL,
    Correo NVARCHAR(255),
    Estado CHAR(1) CHECK (Estado IN ('A', 'I')) DEFAULT 'A', -- A: Activo, I: Inactivo
    FechaIngreso DATE NOT NULL
);

-- Tabla: Promociones
CREATE TABLE Promociones (
    ID_Promocion INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Descripcion NVARCHAR(MAX),
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Activa BIT NOT NULL DEFAULT 1
);

-- Tabla: Planes
CREATE TABLE Planes (
    ID_Plan INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Descripcion NVARCHAR(MAX)
);

-- Tabla: Productos
CREATE TABLE Productos (
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Tipo NVARCHAR(50) NOT NULL, -- Ejemplo: 'Móvil', 'Accesorio'
    Precio_Base DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(10,2) DEFAULT 0 -- En porcentaje
);

-- Tabla: Regalos
CREATE TABLE Regalos (
    ID_Regalo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Cantidad_Stock INT NOT NULL
);

-- Tabla: Ventas
CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    VendedorID INT NOT NULL,
    FechaVenta DATETIME DEFAULT GETDATE(),
    MontoTotal DECIMAL(10,2) NOT NULL,
    PromocionID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (VendedorID) REFERENCES Vendedores(VendedorID),
    FOREIGN KEY (PromocionID) REFERENCES Promociones(ID_Promocion)
);

-- Tabla intermedia: Promoción_Plan (Relación N:M entre Promociones y Planes)
CREATE TABLE Promocion_Plan (
    ID_Promocion INT NOT NULL,
    ID_Plan INT NOT NULL,
    PRIMARY KEY (ID_Promocion, ID_Plan),
    FOREIGN KEY (ID_Promocion) REFERENCES Promociones(ID_Promocion),
    FOREIGN KEY (ID_Plan) REFERENCES Planes(ID_Plan)
);

-- Tabla intermedia: Plan_Producto (Relación N:M entre Planes y Productos)
CREATE TABLE Plan_Producto (
    ID_Plan INT NOT NULL,
    ID_Producto INT NOT NULL,
    Precio_Promocion DECIMAL(10,2) NOT NULL, -- Precio en la promoción
    PRIMARY KEY (ID_Plan, ID_Producto),
    FOREIGN KEY (ID_Plan) REFERENCES Planes(ID_Plan),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

-- Tabla intermedia: Promoción_Regalo (Relación N:M entre Promociones y Regalos)
CREATE TABLE Promocion_Regalo (
    ID_Promocion INT NOT NULL,
    ID_Regalo INT NOT NULL,
    Cantidad INT NOT NULL,
    PRIMARY KEY (ID_Promocion, ID_Regalo),
    FOREIGN KEY (ID_Promocion) REFERENCES Promociones(ID_Promocion),
    FOREIGN KEY (ID_Regalo) REFERENCES Regalos(ID_Regalo)
);

-- Tabla: Cliente_Promocion (Registra clientes que aprovechan promociones)
CREATE TABLE Cliente_Promocion (
    ID_Cliente INT NOT NULL,
    ID_Promocion INT NOT NULL,
    Fecha_Participacion DATE NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (ID_Cliente, ID_Promocion),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Promocion) REFERENCES Promociones(ID_Promocion)
);

-- Índices recomendados
CREATE INDEX IX_Productos_Tipo ON Productos(Tipo);
CREATE INDEX IX_Promociones_Activa ON Promociones(Activa);
CREATE INDEX IX_Regalos_Cantidad_Stock ON Regalos(Cantidad_Stock);

-- Mensaje de confirmación
PRINT 'Tablas y relaciones creadas correctamente para el control de promociones.';


