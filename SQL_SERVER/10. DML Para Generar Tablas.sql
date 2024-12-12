-- Llenar la tabla Ventas con datos sintéticos
DECLARE @NumVentas INT = 1000;  -- Número de ventas a generar
DECLARE @MinMonto DECIMAL(10,2) = 500;  -- Monto mínimo de venta
DECLARE @MaxMonto DECIMAL(10,2) = 5000; -- Monto máximo de venta

WHILE @NumVentas > 0
BEGIN
    INSERT INTO Ventas (ClienteID, VendedorID, FechaVenta, MontoTotal, PromocionID)
    SELECT
        (SELECT TOP 1 ID_Cliente FROM Clientes ORDER BY NEWID()),  -- Cliente aleatorio
        (SELECT TOP 1 VendedorID FROM Vendedores ORDER BY NEWID()),  -- Vendedor aleatorio
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3650) * -1, GETDATE()),  -- Fecha aleatoria en los últimos 10 años
        ROUND(@MinMonto + (RAND() * (@MaxMonto - @MinMonto)), 2),  -- Monto aleatorio
        (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID())  -- Promoción aleatoria
    WHERE
        RAND() > 0.5  -- 50% de las ventas tienen promoción, el resto será NULL
    OPTION (MAXDOP 1);  -- Evitar paralelismo si hay mucha carga

    SET @NumVentas = @NumVentas - 1;
END;

PRINT 'Datos generados exitosamente en la tabla Ventas.';
