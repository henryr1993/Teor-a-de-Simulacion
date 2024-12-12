import csv
from mimesis import Person, Datetime
from mimesis.locales import Locale
from datetime import date, timedelta
import random

# Configuración
FILE_NAME = "clientes.csv"
NUM_RECORDS = 500_000
START_DATE = date(2000, 1, 1)
END_DATE = date(2024, 12, 31)

person = Person(Locale.ES)
datetime = Datetime(Locale.ES)

# Conjuntos para evitar duplicados
generated_phone_numbers = set()
generated_names = set()

# Función para generar números únicos
def generate_unique_phone(prefix, generated_set):
    while True:
        phone = f"{prefix}{random.randint(100000, 999999)}"
        if phone not in generated_set:
            generated_set.add(phone)
            return phone

# Función para generar nombres únicos
def generate_unique_name(generated_set):
    while True:
        name = f"{person.first_name()} {person.first_name()} {person.last_name()} {person.last_name()}"
        if name not in generated_set:
            generated_set.add(name)
            return name

# Crear archivo CSV
with open(FILE_NAME, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow([
        "ID_Cliente", "Nombre", "Correo", "NumeroTelefono", "TipoUsuario",
        "FechaRegistro", "Estado", "NombreFiador", "TelefonoFiador",
        "CentralRiesgo", "UbicacionID"
    ])
    
    for i in range(1, NUM_RECORDS + 1):
        # Generar nombres y correos únicos
        nombre = generate_unique_name(generated_names)
        correo = f"{nombre.replace(' ', '').lower()}@example.com"

        # Generar números únicos
        numero_telefono = generate_unique_phone("+50433", generated_phone_numbers)
        telefono_fiador = generate_unique_phone("+50499", generated_phone_numbers)

        tipo_usuario = random.choice(['P', 'R'])
        delta = (END_DATE - START_DATE).days
        fecha_registro = START_DATE + timedelta(days=random.randint(0, delta))
        estado = random.choice(['A', 'I'])
        nombre_fiador = generate_unique_name(generated_names)
        central_riesgo = random.choice([0, 1])
        ubicacion_id = random.randint(1, 291)

        writer.writerow([
            i, nombre, correo, numero_telefono, tipo_usuario,
            fecha_registro, estado, nombre_fiador,
            telefono_fiador, central_riesgo, ubicacion_id
        ])

print(f"Archivo CSV generado: {FILE_NAME}")
