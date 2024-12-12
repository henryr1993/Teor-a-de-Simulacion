CREATE VIEW vw_PromocionesActivas AS
SELECT 
    p.ID_Promocion,
    p.Nombre,
    COUNT(cp.ID_Cliente) AS ClientesParticipantes,
    SUM(v.MontoTotal) AS TotalGenerado
FROM Promociones p
LEFT JOIN Cliente_Promocion cp ON p.ID_Promocion = cp.ID_Promocion
LEFT JOIN Ventas v ON p.ID_Promocion = v.PromocionID
WHERE p.Activa = 1
GROUP BY p.ID_Promocion, p.Nombre;
