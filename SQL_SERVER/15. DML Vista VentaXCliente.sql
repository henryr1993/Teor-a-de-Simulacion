CREATE VIEW vw_VentasPorCliente AS
SELECT 
    c.ID_Cliente,
    c.Nombre AS ClienteNombre,
    COUNT(v.VentaID) AS TotalVentas,
    SUM(v.MontoTotal) AS TotalGastado,
    COUNT(cp.ID_Promocion) AS PromocionesAprovechadas
FROM Clientes c
LEFT JOIN Ventas v ON c.ID_Cliente = v.ClienteID
LEFT JOIN Cliente_Promocion cp ON c.ID_Cliente = cp.ID_Cliente
GROUP BY c.ID_Cliente, c.Nombre;
