-- Declarar el número de asociaciones a generar
DECLARE @NumAsociaciones INT = 100;

WHILE @NumAsociaciones > 0
BEGIN
    -- Seleccionar un plan y un producto aleatorio
    DECLARE @ID_Plan INT = (SELECT TOP 1 ID_Plan FROM Planes ORDER BY NEWID());
    DECLARE @ID_Producto INT = (SELECT TOP 1 ID_Producto FROM Productos ORDER BY NEWID());
    
    -- Obtener el precio base del producto
    DECLARE @PrecioBase DECIMAL(10,2) = (SELECT Precio_Base FROM Productos WHERE ID_Producto = @ID_Producto);

    -- Calcular el precio promocional (descuento aleatorio entre 10% y 30%)
    DECLARE @PrecioPromocion DECIMAL(10,2) = ROUND(@PrecioBase * (1 - (CAST(ABS(CHECKSUM(NEWID()) % 21) + 10 AS DECIMAL(10,2)) / 100)), 2);

    -- Insertar si la combinación no existe
    IF NOT EXISTS (
        SELECT 1 
        FROM Plan_Producto 
        WHERE ID_Plan = @ID_Plan AND ID_Producto = @ID_Producto
    )
    BEGIN
        INSERT INTO Plan_Producto (ID_Plan, ID_Producto, Precio_Promocion)
        VALUES (@ID_Plan, @ID_Producto, @PrecioPromocion);

        SET @NumAsociaciones = @NumAsociaciones - 1;
    END;
END;

PRINT 'Asociaciones entre Planes y Productos generadas exitosamente.';
