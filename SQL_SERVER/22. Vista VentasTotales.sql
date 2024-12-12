CREATE VIEW vw_VentasTotales AS
SELECT 
    v.VentaID,
    v.ClienteID,
    v.VendedorID,
    v.MontoTotal,
    v.FechaVenta,
    v.PromocionID,
    c.Nombre AS ClienteNombre,
    p.Nombre AS PromocionNombre
FROM Ventas v
LEFT JOIN Clientes c ON v.ClienteID = c.ID_Cliente
LEFT JOIN Promociones p ON v.PromocionID = p.ID_Promocion;
