-- Declarar el número de asociaciones a generar
DECLARE @NumAsociaciones INT = 100;

WHILE @NumAsociaciones > 0
BEGIN
    -- Seleccionar un cliente y una promoción aleatoria
    DECLARE @ID_Cliente INT = (SELECT TOP 1 ID_Cliente FROM Clientes ORDER BY NEWID());
    DECLARE @ID_Promocion INT = (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID());
    
    -- Generar una fecha aleatoria para la participación
    DECLARE @Fecha_Participacion DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 3650), GETDATE());

    -- Insertar la relación si no existe
    IF NOT EXISTS (
        SELECT 1 
        FROM Cliente_Promocion 
        WHERE ID_Cliente = @ID_Cliente AND ID_Promocion = @ID_Promocion
    )
    BEGIN
        INSERT INTO Cliente_Promocion (ID_Cliente, ID_Promocion, Fecha_Participacion)
        VALUES (@ID_Cliente, @ID_Promocion, @Fecha_Participacion);

        SET @NumAsociaciones = @NumAsociaciones - 1;
    END;
END;

PRINT 'Asociaciones entre Clientes y Promociones generadas exitosamente.';
