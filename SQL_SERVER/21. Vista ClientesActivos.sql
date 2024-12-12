CREATE VIEW vw_ClientesActivos AS
SELECT 
    c.ID_Cliente,
    c.Nombre,
    c.TipoUsuario,
    c.Estado,
    c.FechaRegistro,
    u.DepartamentoID,
    u.MunicipioID
FROM Clientes c
JOIN Ubicaciones u ON c.UbicacionID = u.UbicacionID
WHERE c.Estado = 'A';
