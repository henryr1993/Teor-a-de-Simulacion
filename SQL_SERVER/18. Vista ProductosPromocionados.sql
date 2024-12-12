CREATE VIEW vw_ProductosPromocionados AS
SELECT 
    pp.ID_Producto,
    pr.Nombre AS ProductoNombre,
    COUNT(pp.ID_Plan) AS TotalPlanesAsociados,
    AVG(pp.Precio_Promocion) AS PrecioPromedioPromocional
FROM Plan_Producto pp
JOIN Productos pr ON pp.ID_Producto = pr.ID_Producto
GROUP BY pp.ID_Producto, pr.Nombre;
