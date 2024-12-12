CREATE VIEW vw_PromocionesAprovechadas AS
SELECT 
    p.ID_Promocion,
    p.Nombre AS PromocionNombre,
    COUNT(cp.ID_Cliente) AS ClientesQueParticiparon,
    SUM(v.MontoTotal) AS MontoGenerado
FROM Promociones p
LEFT JOIN Cliente_Promocion cp ON p.ID_Promocion = cp.ID_Promocion
LEFT JOIN Ventas v ON p.ID_Promocion = v.PromocionID
GROUP BY p.ID_Promocion, p.Nombre;
