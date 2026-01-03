# ⚽ CRUD Liga Fútbol (Python + MySQL) — Gestión Multitabla

Programa en **Python** para gestionar la base de datos **`liga_futbol`** mediante un sistema de menús por consola. Permite seleccionar una tabla (por ejemplo: `equipos`, `jugadores`, `partidos`, etc.) y realizar operaciones **CRUD**: **Insertar, Listar, Actualizar y Eliminar**.

Este proyecto nace como **Ejercicio “Milla Extra”** integrando contenidos de **Programación** y **Bases de Datos**.

---

## 🧠 1. Introducción y contextualización

Este CRUD multitabla se conecta a MySQL y muestra al usuario las tablas disponibles dentro de la base de datos `liga_futbol`. Una vez elegida una tabla, se habilita un mini-menú CRUD para operar sobre ella.

✅ ¿Para qué sirve?

- Como **herramienta de administración** interna de una BD deportiva.
- Como base para evolucionar a una app **desktop** (Tkinter) o **web** (Flask/Django + frontend).

📚 Contenidos trabajados (enfoque académico):

- Estructura general de un programa: variables, tipos, literales, expresiones, operadores.
- Uso de `mysql.connector`: conexión, cursor, ejecución de sentencias y `commit()`.
- Control de flujo con `if/elif/else`, bucles `while` / `for` y uso de `break`.
- Entrada/salida por consola con `input()` y `print()`.

---

## ✅ 2. Desarrollo técnico correcto y preciso (según rúbrica)

El programa se estructura en bloques claros:

### 2.1 Conexión a la base de datos (MySQL)
Se realiza con `mysql.connector.connect()` y se crea un `cursor` para ejecutar SQL.

- Objeto `conexion` → gestiona la conexión con la BD.
- Objeto `cursor` → ejecuta consultas y obtiene resultados.

### 2.2 Menú principal: elección de tabla (multitabla)
Dentro de un `while True`:

- Se ejecuta `SHOW TABLES;` para listar tablas.
- Se construye una lista `tablas` con los resultados (`fetchall()`).
- Se muestran opciones numeradas y se permite salir del programa.

### 2.3 Menú CRUD por tabla (bucle anidado)
Una vez seleccionada una tabla, se accede a otro `while True` con las opciones:

1. Insertar  
2. Listar  
3. Actualizar  
4. Eliminar  
5. Volver (elegir otra tabla)

La opción elegida se maneja con `if/elif/else`.

### 2.4 Operaciones CRUD
- **Insertar (`INSERT`)**: pide campos por consola y guarda cambios con `conexion.commit()`.
- **Listar (`SELECT *`)**: consulta dinámica y muestra filas por consola.
- **Actualizar (`UPDATE`)**: pide el ID del registro y actualiza campos con parámetros.
- **Eliminar (`DELETE`)**: borra por ID.  
  En `equipos`, puede fallar si el equipo está referenciado por `jugadores` o `partidos` (integridad referencial).

---

## 🧩 3. Aplicación práctica (cómo ejecutar y usar)

### 📦 Requisitos

- **Python 3.x**
- **MySQL Server** (o MariaDB)
- Librería:
  ```bash
  pip install mysql-connector-python
  ```

### 🗄️ Crear la base de datos

En el repositorio se incluye el script:

* `creacion_bbdd.sql`

Ejecuta ese `.sql` en tu gestor (MySQL Workbench / phpMyAdmin / consola) para crear:

* Base de datos `liga_futbol`
* Tablas y relaciones necesarias

> Nota: Si tu script también crea usuario/permisos, perfecto. Si no, asegúrate de tener un usuario con permisos sobre `liga_futbol`.

### 🔧 Configuración de conexión

En el archivo principal:

* `crud_ligafutbol.py`

Revisa/ajusta estos datos según tu entorno:

* `host`
* `user`
* `password`
* `database`

Ejemplo típico:

```python
conexion = mysql.connector.connect(
    host="localhost",
    user="superfutbol",
    password="superfutbol",
    database="liga_futbol"
)
```

### ▶️ Ejecutar el programa

Desde la carpeta del proyecto:

```bash
python crud_ligafutbol.py
```

### 🕹️ Uso (flujo típico)

1. El programa muestra tablas disponibles (ej: `equipos`, `jugadores`, `partidos`...).
2. Seleccionas una por número.
3. Entras al menú CRUD de esa tabla.
4. Insertas / listas / actualizas / eliminas.
5. Vuelves al menú de tablas o sales.

Ejemplo rápido:

* Elegir `equipos`
* Opción `1` para insertar → escribir nombre/ciudad/estadio/fecha
* Opción `2` para listar → ver el registro insertado

---

## 🗂️ Estructura del repositorio

* `crud_ligafutbol.py` → script principal del CRUD por consola.
* `creacion_bbdd.sql` → creación de la base de datos y tablas.
* `iteracion/` → carpeta de iteraciones/avances del ejercicio (histórico o versiones).
* `README.md` → documentación del proyecto.

---

## ⚠️ Notas importantes (integridad y buenas prácticas)

* Si intentas **eliminar un equipo** que tiene jugadores o partidos asociados, MySQL puede lanzar error por claves foráneas (FK).
  Esto es parte natural del modelo relacional: protege la coherencia de datos.
* El proyecto usa consultas parametrizadas (`%s`) en operaciones principales, lo cual ayuda a evitar errores y mejora seguridad frente a inyecciones SQL.

---

## 🧾 4. Cierre / Conclusión

Este proyecto integra de manera práctica los contenidos de la evaluación:

* Estructura base de un programa en Python: variables, tipos, operadores y bloques.
* Uso de objetos de `mysql.connector` para conectar con una base de datos real.
* Construcción de menús con control de flujo mediante `if/elif/else`, `while`, `for` y `break`.
* Interacción por consola con `input()` y `print()` para una experiencia clara y funcional.

En conjunto, el programa demuestra cómo conectar **Programación** con **Bases de Datos** para crear una herramienta real de gestión multitabla.

---

## 👤 Autor

**Piero Olivares**
::contentReference[oaicite:0]{index=0}
```
