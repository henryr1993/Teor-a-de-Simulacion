CREATE VIEW vw_VentasPorVendedor AS
SELECT 
    v.VendedorID,
    ve.Nombre AS VendedorNombre,
    COUNT(v.VentaID) AS TotalVentas,
    SUM(v.MontoTotal) AS TotalMonto,
    COUNT(v.PromocionID) AS PromocionesAsociadas
FROM Vendedores ve
LEFT JOIN Ventas v ON ve.VendedorID = v.VendedorID
GROUP BY v.VendedorID, ve.Nombre;
