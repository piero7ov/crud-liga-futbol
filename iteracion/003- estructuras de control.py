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

print("Tablas en la base de datos:")

tablas = []   # lista donde guardaremos los nombres de las tablas

# Recorremos las filas y llenamos la lista
for fila in filas:
    tablas.append(fila[0])

# Mostramos las tablas con un índice numérico
for indice, nombre_tabla in enumerate(tablas):
    print(indice, "-", nombre_tabla)

# El usuario selecciona una tabla por número
opcion_tabla = int(input("\nSelecciona el número de la tabla con la que quieres trabajar: "))

# Guardamos la tabla elegida
tabla_elegida = tablas[opcion_tabla]

print("\nHas seleccionado la tabla:", tabla_elegida)
