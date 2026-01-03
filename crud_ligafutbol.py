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

        # ============ INSERTAR ============
        if opcion_crud == 1:
            print("\nINSERTAR en", tabla_elegida)

            # INSERTAR EN EQUIPOS
            if tabla_elegida == "equipos":
                nombre = input("Nombre del equipo: ")
                ciudad = input("Ciudad: ")
                estadio = input("Estadio: ")
                fecha_fundacion = input("Fecha de fundación (YYYY-MM-DD): ")

                peticion = """
                    INSERT INTO equipos (nombre_equipo, ciudad, estadio, fecha_fundacion)
                    VALUES (%s, %s, %s, %s)
                """
                valores = (nombre, ciudad, estadio, fecha_fundacion)
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Equipo insertado correctamente.")

            # INSERTAR EN JUGADORES
            elif tabla_elegida == "jugadores":
                id_equipo = int(input("ID del equipo al que pertenece: "))
                nombre = input("Nombre: ")
                apellidos = input("Apellidos: ")
                dorsal = int(input("Dorsal: "))
                posicion = input("Posición: ")
                fecha_nacimiento = input("Fecha de nacimiento (YYYY-MM-DD): ")

                peticion = """
                    INSERT INTO jugadores (id_equipo, nombre, apellidos, dorsal, posicion, fecha_nacimiento)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """
                valores = (id_equipo, nombre, apellidos, dorsal, posicion, fecha_nacimiento)
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Jugador insertado correctamente.")

            # INSERTAR EN PARTIDOS
            elif tabla_elegida == "partidos":
                id_equipo_local = int(input("ID equipo local: "))
                id_equipo_visitante = int(input("ID equipo visitante: "))
                fecha_partido = input("Fecha del partido (YYYY-MM-DD): ")
                hora_partido = input("Hora del partido (HH:MM:SS): ")
                jornada = int(input("Jornada: "))
                goles_local = int(input("Goles equipo local: "))
                goles_visitante = int(input("Goles equipo visitante: "))
                estadio = input("Estadio: ")

                peticion = """
                    INSERT INTO partidos
                    (id_equipo_local, id_equipo_visitante, fecha_partido, hora_partido,
                     jornada, goles_local, goles_visitante, estadio)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """
                valores = (
                    id_equipo_local,
                    id_equipo_visitante,
                    fecha_partido,
                    hora_partido,
                    jornada,
                    goles_local,
                    goles_visitante,
                    estadio
                )
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Partido insertado correctamente.")

            else:
                print("Inserción no implementada para esta tabla.")

        # ============ LISTAR ============
        elif opcion_crud == 2:
            print("\nLISTAR registros de:", tabla_elegida)
            peticion = "SELECT * FROM " + tabla_elegida + ";"
            cursor.execute(peticion)
            filas = cursor.fetchall()
            for fila in filas:
                print(fila)

        # ============ ACTUALIZAR ============
        elif opcion_crud == 3:
            print("\nACTUALIZAR en", tabla_elegida)

            # ACTUALIZAR EQUIPOS
            if tabla_elegida == "equipos":
                id_equipo = int(input("ID del equipo que quieres actualizar: "))

                nuevo_nombre = input("Nuevo nombre del equipo: ")
                nueva_ciudad = input("Nueva ciudad: ")
                nuevo_estadio = input("Nuevo estadio: ")
                nueva_fecha = input("Nueva fecha de fundación (YYYY-MM-DD): ")

                peticion = """
                    UPDATE equipos
                    SET nombre_equipo = %s,
                        ciudad = %s,
                        estadio = %s,
                        fecha_fundacion = %s
                    WHERE id_equipo = %s
                """
                valores = (nuevo_nombre, nueva_ciudad, nuevo_estadio, nueva_fecha, id_equipo)
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Equipo actualizado correctamente.")

            # ACTUALIZAR JUGADORES
            elif tabla_elegida == "jugadores":
                id_jugador = int(input("ID del jugador que quieres actualizar: "))

                nuevo_id_equipo = int(input("Nuevo ID de equipo: "))
                nuevo_nombre = input("Nuevo nombre: ")
                nuevos_apellidos = input("Nuevos apellidos: ")
                nuevo_dorsal = int(input("Nuevo dorsal: "))
                nueva_posicion = input("Nueva posición: ")
                nueva_fecha_nac = input("Nueva fecha de nacimiento (YYYY-MM-DD): ")

                peticion = """
                    UPDATE jugadores
                    SET id_equipo = %s,
                        nombre = %s,
                        apellidos = %s,
                        dorsal = %s,
                        posicion = %s,
                        fecha_nacimiento = %s
                    WHERE id_jugador = %s
                """
                valores = (
                    nuevo_id_equipo,
                    nuevo_nombre,
                    nuevos_apellidos,
                    nuevo_dorsal,
                    nueva_posicion,
                    nueva_fecha_nac,
                    id_jugador
                )
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Jugador actualizado correctamente.")

            # ACTUALIZAR PARTIDOS
            elif tabla_elegida == "partidos":
                id_partido = int(input("ID del partido que quieres actualizar: "))

                nuevo_local = int(input("Nuevo ID equipo local: "))
                nuevo_visitante = int(input("Nuevo ID equipo visitante: "))
                nueva_fecha = input("Nueva fecha del partido (YYYY-MM-DD): ")
                nueva_hora = input("Nueva hora del partido (HH:MM:SS): ")
                nueva_jornada = int(input("Nueva jornada: "))
                nuevos_goles_local = int(input("Nuevos goles equipo local: "))
                nuevos_goles_visitante = int(input("Nuevos goles equipo visitante: "))
                nuevo_estadio = input("Nuevo estadio: ")

                peticion = """
                    UPDATE partidos
                    SET id_equipo_local = %s,
                        id_equipo_visitante = %s,
                        fecha_partido = %s,
                        hora_partido = %s,
                        jornada = %s,
                        goles_local = %s,
                        goles_visitante = %s,
                        estadio = %s
                    WHERE id_partido = %s
                """
                valores = (
                    nuevo_local,
                    nuevo_visitante,
                    nueva_fecha,
                    nueva_hora,
                    nueva_jornada,
                    nuevos_goles_local,
                    nuevos_goles_visitante,
                    nuevo_estadio,
                    id_partido
                )
                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Partido actualizado correctamente.")

            else:
                print("Actualización no implementada para esta tabla.")
        # ============ ELIMINAR ============
        elif opcion_crud == 4:
            print("\nELIMINAR en", tabla_elegida)

            # ELIMINAR EQUIPOS
            if tabla_elegida == "equipos":
                id_equipo = int(input("ID del equipo que quieres eliminar: "))

                peticion = "DELETE FROM equipos WHERE id_equipo = %s"
                valores = (id_equipo, )

                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Equipo eliminado (si no estaba referenciado por jugadores/partidos).")

            # ELIMINAR JUGADORES
            elif tabla_elegida == "jugadores":
                id_jugador = int(input("ID del jugador que quieres eliminar: "))

                peticion = "DELETE FROM jugadores WHERE id_jugador = %s"
                valores = (id_jugador, )

                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Jugador eliminado correctamente.")

            # ELIMINAR PARTIDOS
            elif tabla_elegida == "partidos":
                id_partido = int(input("ID del partido que quieres eliminar: "))

                peticion = "DELETE FROM partidos WHERE id_partido = %s"
                valores = (id_partido, )

                cursor.execute(peticion, valores)
                conexion.commit()
                print("✅ Partido eliminado correctamente.")

            else:
                print("Eliminación no implementada para esta tabla.")

        # ============ VOLVER A MENÚ DE TABLAS ============
        elif opcion_crud == 5:
            print("\nVolviendo al menú de selección de tabla...")
            break

        else:
            print("Opción no válida.")

conexion.close()