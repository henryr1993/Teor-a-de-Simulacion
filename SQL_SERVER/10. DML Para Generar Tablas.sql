-- Llenar la tabla Ventas con datos sint�ticos
DECLARE @NumVentas INT = 1000;  -- N�mero de ventas a generar
DECLARE @MinMonto DECIMAL(10,2) = 500;  -- Monto m�nimo de venta
DECLARE @MaxMonto DECIMAL(10,2) = 5000; -- Monto m�ximo de venta

WHILE @NumVentas > 0
BEGIN
    INSERT INTO Ventas (ClienteID, VendedorID, FechaVenta, MontoTotal, PromocionID)
    SELECT
        (SELECT TOP 1 ID_Cliente FROM Clientes ORDER BY NEWID()),  -- Cliente aleatorio
        (SELECT TOP 1 VendedorID FROM Vendedores ORDER BY NEWID()),  -- Vendedor aleatorio
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3650) * -1, GETDATE()),  -- Fecha aleatoria en los �ltimos 10 a�os
        ROUND(@MinMonto + (RAND() * (@MaxMonto - @MinMonto)), 2),  -- Monto aleatorio
        (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID())  -- Promoci�n aleatoria
    WHERE
        RAND() > 0.5  -- 50% de las ventas tienen promoci�n, el resto ser� NULL
    OPTION (MAXDOP 1);  -- Evitar paralelismo si hay mucha carga

    SET @NumVentas = @NumVentas - 1;
END;

PRINT 'Datos generados exitosamente en la tabla Ventas.';
