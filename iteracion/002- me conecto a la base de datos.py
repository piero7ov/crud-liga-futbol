import mysql.connector

# Me conecto a la base de datos
conexion = mysql.connector.connect(
    host="localhost",
    user="superfutbol",      
    password="superfutbol",
    database="liga_futbol"
)

print("Gestión multitabla de la Liga de Fútbol v0.1")
print("Este programa permite gestionar varias tablas de la base de datos 'liga_futbol'.")
print("Primero seleccionaremos una tabla y luego realizaremos operaciones sobre ella.\n")

cursor = conexion.cursor()

# Mostrar todas las tablas de la base de datos
cursor.execute("SHOW TABLES;")

filas = cursor.fetchall()

print("\nTablas en la base de datos:")

tablas = []                  # lista donde guardaremos los nombres limpios
for fila in filas:
    tablas.append(fila[0])
    print("-", fila[0])

