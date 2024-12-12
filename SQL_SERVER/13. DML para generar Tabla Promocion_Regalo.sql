-- Declarar el número de asociaciones a generar
DECLARE @NumAsociaciones INT = 100;

WHILE @NumAsociaciones > 0
BEGIN
    -- Seleccionar una promoción y un regalo aleatorio
    DECLARE @ID_Promocion INT = (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID());
    DECLARE @ID_Regalo INT = (SELECT TOP 1 ID_Regalo FROM Regalos ORDER BY NEWID());
    
    -- Generar una cantidad aleatoria para el regalo (entre 1 y 10)
    DECLARE @Cantidad INT = ABS(CHECKSUM(NEWID()) % 10) + 1;

    -- Insertar la relación si no existe
    IF NOT EXISTS (
        SELECT 1 
        FROM Promocion_Regalo 
        WHERE ID_Promocion = @ID_Promocion AND ID_Regalo = @ID_Regalo
    )
    BEGIN
        INSERT INTO Promocion_Regalo (ID_Promocion, ID_Regalo, Cantidad)
        VALUES (@ID_Promocion, @ID_Regalo, @Cantidad);

        SET @NumAsociaciones = @NumAsociaciones - 1;
    END;
END;

PRINT 'Asociaciones entre Promociones y Regalos generadas exitosamente.';
