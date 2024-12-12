-- Declarar el número de asociaciones a generar
DECLARE @NumAsociaciones INT = 100;

WHILE @NumAsociaciones > 0
BEGIN
    -- Insertar una asociación aleatoria entre Promociones y Planes
    INSERT INTO Promocion_Plan (ID_Promocion, ID_Plan)
    SELECT 
        (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID()),  -- Promoción aleatoria
        (SELECT TOP 1 ID_Plan FROM Planes ORDER BY NEWID())  -- Plan aleatorio
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Promocion_Plan 
        WHERE ID_Promocion = (SELECT TOP 1 ID_Promocion FROM Promociones ORDER BY NEWID())
          AND ID_Plan = (SELECT TOP 1 ID_Plan FROM Planes ORDER BY NEWID())
    ); -- Evitar duplicados

    SET @NumAsociaciones = @NumAsociaciones - 1;
END;

PRINT 'Asociaciones entre Promociones y Planes generadas exitosamente.';
