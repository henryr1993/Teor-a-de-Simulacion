CREATE VIEW vw_RegalosPromocionados AS
SELECT 
    pr.ID_Promocion,
    prg.ID_Regalo,
    r.Nombre AS RegaloNombre,
    SUM(prg.Cantidad) AS TotalEntregado
FROM Promociones pr
JOIN Promocion_Regalo prg ON pr.ID_Promocion = prg.ID_Promocion
JOIN Regalos r ON prg.ID_Regalo = r.ID_Regalo
GROUP BY pr.ID_Promocion, prg.ID_Regalo, r.Nombre;
