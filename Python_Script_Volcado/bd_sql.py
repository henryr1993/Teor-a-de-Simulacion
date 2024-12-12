import pyodbc

try:
    connection=pyodbc.connect('DRIVER={SQL Server};SERVER=DESKTOP-3F07ECQ;DATABASE=ComunicacionesHN;UID=sa;PWD=1234')
    print("Conexion Exitosa")
    cursor=connection.cursor()
# Habilitar IDENTITY_INSERT
    cursor.execute("SET IDENTITY_INSERT Clientes ON;")

# Leer y cargar registros desde CSV
    with open("clientes.csv", "r", encoding="utf-8") as file:
        next(file)  # Saltar la cabecera
        for line in file:
            columns = line.strip().split(",")
            cursor.execute("""
                INSERT INTO Clientes (
                    ID_Cliente, Nombre, Correo, NumeroTelefono, TipoUsuario,
                    FechaRegistro, Estado, NombreFiador, TelefonoFiador,
                    CentralRiesgo, UbicacionID
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, columns)

    # Confirmar cambios
    cursor.commit()

    # Deshabilitar IDENTITY_INSERT
    cursor.execute("SET IDENTITY_INSERT Clientes OFF;")
    cursor.close()
    
    
except Exception as ex:
    print("Error de Conexión: ",ex)