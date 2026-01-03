import mysql.connector

# Me conecto a la base de datos
conexion = mysql.connector.connect(
    host="localhost",
    user="superfutbol",      
    password="superfutbol",
    database="liga_futbol"
)

cursor = conexion.cursor()

print("Gestión multitabla de la Liga de Fútbol v0.1")
print("Este programa permite gestionar varias tablas de la base de datos 'liga_futbol'.")

# ------------------ BUCLE PRINCIPAL: ELECCIÓN DE TABLA ------------------

while True:

    print("\nTablas disponibles en la base de datos:")

    cursor.execute("SHOW TABLES;")
    filas = cursor.fetchall()

    tablas = []
    for fila in filas:
        tablas.append(fila[0])

    for indice, nombre_tabla in enumerate(tablas):
        print(indice, "-", nombre_tabla)

    print(len(tablas), "- Salir del programa")

    opcion_tabla = int(input("\nSelecciona el número de la tabla: "))

    # Opción para salir del programa
    if opcion_tabla == len(tablas):
        print("Saliendo del programa...")
        break

    tabla_elegida = tablas[opcion_tabla]

    print("\nHas seleccionado la tabla:", tabla_elegida)

    # ------------------ MINI-CRUD PARA ESA TABLA ------------------

    while True:
        print("\n¿Qué operación quieres realizar sobre la tabla", tabla_elegida, "?")
        print("1.- Insertar")
        print("2.- Listar")
        print("3.- Actualizar")
        print("4.- Eliminar")
        print("5.- Volver a elegir otra tabla")

        opcion_crud = int(input("Escoge una opción: "))

        if opcion_crud == 1:
            print("\nINSERTAR (pendiente de implementar)...")

        elif opcion_crud == 2:
            print("\nLISTAR registros de:", tabla_elegida)
            peticion = "SELECT * FROM " + tabla_elegida + ";"
            cursor.execute(peticion)
            filas = cursor.fetchall()
            for fila in filas:
                print(fila)

        elif opcion_crud == 3:
            print("\nACTUALIZAR (pendiente de implementar)...")

        elif opcion_crud == 4:
            print("\nELIMINAR (pendiente de implementar)...")

        elif opcion_crud == 5:
            print("\nVolviendo al menú de selección de tabla...")
            break  # <- aquí volvemos arriba al menú de tablas

        else:
            print("Opción no válida.")
