-------------------------------------------------------------
-- UNIDAD 002-003: Creación de bases de datos y uso
-------------------------------------------------------------

-- Creamos la base de datos
CREATE DATABASE liga_futbol;


-- Usamos la base de datos
USE liga_futbol;


-------------------------------------------------------------
-- UNIDAD 002-003: Creación de tablas (sin PK de momento)
-------------------------------------------------------------

-- Creamos la tabla de equipos SIN clave primaria ni autoincremento
CREATE TABLE equipos (
    id_equipo INT,
    nombre_equipo VARCHAR(80) NOT NULL,
    ciudad VARCHAR(50),
    estadio VARCHAR(80),
    fecha_fundacion DATE
);



-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE (modificación de estructuras)
-- UNIDAD 002-004: Definición de clave primaria
-------------------------------------------------------------

-- Añadimos clave primaria a la tabla equipos
ALTER TABLE equipos
ADD PRIMARY KEY (id_equipo);

-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE (cambiar tipo)
-- UNIDAD 002-003: Tipos de datos - AUTO_INCREMENT
-------------------------------------------------------------

-- Convertimos id_equipo en autoincremental
ALTER TABLE equipos
MODIFY id_equipo INT AUTO_INCREMENT;

-------------------------------------------------------------
-- UNIDAD 002-003: Creación de tablas (sin PK de momento)
-------------------------------------------------------------

-- Creamos la tabla de jugadores SIN clave primaria
CREATE TABLE jugadores (
    id_jugador INT,
    id_equipo INT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    dorsal INT,
    posicion VARCHAR(20),
    fecha_nacimiento DATE
);




-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE
-- UNIDAD 002-004: Definición de clave primaria
-------------------------------------------------------------
-- Añadimos clave primaria a la tabla jugadores
ALTER TABLE jugadores
ADD PRIMARY KEY (id_jugador);


-- Hacemos id_jugador autoincremental
-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE
-- UNIDAD 002-003: Tipos de datos (AUTO_INCREMENT)
-------------------------------------------------------------
ALTER TABLE jugadores
MODIFY id_jugador INT AUTO_INCREMENT;

-------------------------------------------------------------
-- UNIDAD 002-008: Definición de claves ajenas (FOREIGN KEY)
-- UNIDAD 004-002: Integridad referencial
-------------------------------------------------------------

-- Creamos la Foreign Key de jugadores → equipos
ALTER TABLE jugadores
ADD CONSTRAINT fk_jugadores_equipos
FOREIGN KEY (id_equipo)
REFERENCES equipos(id_equipo);




-------------------------------------------------------------
-- UNIDAD 004-001: Inserción de registros
-------------------------------------------------------------

-- Insertamos equipos de la liga española
INSERT INTO equipos (id_equipo, nombre_equipo, ciudad, estadio, fecha_fundacion)
VALUES
(1, 'FC Barcelona', 'Barcelona', 'Spotify Camp Nou', '1899-11-29'),
(2, 'Real Madrid', 'Madrid', 'Santiago Bernabéu', '1902-03-06'),
(3, 'Atlético de Madrid', 'Madrid', 'Cívitas Metropolitano', '1903-04-26'),
(4, 'Sevilla FC', 'Sevilla', 'Ramón Sánchez-Pizjuán', '1890-01-25'),
(5, 'Real Betis', 'Sevilla', 'Benito Villamarín', '1907-09-12'),
(6, 'Valencia CF', 'Valencia', 'Mestalla', '1919-03-18'),
(7, 'Villarreal CF', 'Villarreal', 'Estadio de la Cerámica', '1923-03-10'),
(8, 'Real Sociedad', 'San Sebastián', 'Reale Arena', '1909-09-07'),
(9, 'Athletic Club', 'Bilbao', 'San Mamés', '1898-01-01'),
(10, 'Getafe CF', 'Getafe', 'Coliseum Alfonso Pérez', '1983-03-08');




-- Insertamos jugadores de la liga española
-- UNIDAD 004-001: Inserción de registros
INSERT INTO jugadores (id_equipo, nombre, apellidos, dorsal, posicion, fecha_nacimiento)
VALUES
(1, 'Marc-André', 'Ter Stegen', 1, 'Portero', '1992-04-30'),
(1, 'Pedri', 'González López', 8, 'Centrocampista', '2002-11-25'),
(1, 'Robert', 'Lewandowski', 9, 'Delantero', '1988-08-21'),

(2, 'Thibaut', 'Courtois', 1, 'Portero', '1992-05-11'),
(2, 'Luka', 'Modrić', 10, 'Centrocampista', '1985-09-09'),
(2, 'Vinícius', 'Júnior', 7, 'Delantero', '2000-07-12'),

(3, 'Jan', 'Oblak', 13, 'Portero', '1993-01-07'),
(3, 'Koke', 'Resurrección', 6, 'Centrocampista', '1992-01-08'),
(3, 'Álvaro', 'Morata Martín', 9, 'Delantero', '1992-10-23'),

(4, 'Yassine', 'Bounou', 13, 'Portero', '1991-04-05'),
(4, 'Ivan', 'Rakitić', 10, 'Centrocampista', '1988-03-10'),
(4, 'Youssef', 'En-Nesyri', 15, 'Delantero', '1997-06-01'),

(5, 'Claudio', 'Bravo Muñoz', 1, 'Portero', '1983-04-13'),
(5, 'Nabil', 'Fekir', 8, 'Centrocampista', '1993-07-18'),
(5, 'Borja', 'Iglesias Quintas', 9, 'Delantero', '1993-01-17');




-- Ahora hacemos una consulta que junte jugadores con sus equipos.
-- UNIDAD 003-001: Proyección, selección y ordenación
-- UNIDAD 003-002: Condiciones en la cláusula WHERE
-- UNIDAD 003-005: Composiciones internas (JOIN)

SELECT
    j.id_jugador,
    j.nombre,
    j.apellidos,
    j.dorsal,
    j.posicion,
    e.nombre_equipo
FROM jugadores j
JOIN equipos e
    ON j.id_equipo = e.id_equipo;
    
    

-- Vamos a una vista de la consulta de los jugadores con su equipo
-------------------------------------------------------------
-- UNIDAD 003-005: Composiciones internas (JOIN)
-- UNIDAD 003-001: Proyección de columnas (SELECT)
-- UNIDAD 002-009: Creación de vistas
-------------------------------------------------------------

    
    

-- Hacemos una consulta de cuántos jugadores tiene cada equipo.
-------------------------------------------------------------
-- UNIDAD 003-003: Funciones de resumen (COUNT)
-- UNIDAD 003-004: Agrupación con GROUP BY y HAVING
-- UNIDAD 003-002: Condiciones con HAVING
-- UNIDAD 003-005: JOIN entre tablas
-------------------------------------------------------------
SELECT
    e.nombre_equipo,
    COUNT(j.id_jugador) AS total_jugadores
FROM equipos e
LEFT JOIN jugadores j
    ON e.id_equipo = j.id_equipo
GROUP BY e.nombre_equipo
HAVING COUNT(j.id_jugador) > 0;



-- Creamos la tabla partidos
-------------------------------------------------------------
-- UNIDAD 002-003: Creación de tablas (sin PK)
-------------------------------------------------------------
CREATE TABLE partidos (
    id_partido INT,
    id_equipo_local INT,
    id_equipo_visitante INT,
    fecha_partido DATE,
    hora_partido TIME,
    jornada INT,
    goles_local INT,
    goles_visitante INT,
    estadio VARCHAR(80)
);



-- Declaramos la PK y que sea autoincremental
-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE (modificar estructura)
-- UNIDAD 002-004: Definición de clave primaria
-------------------------------------------------------------
ALTER TABLE partidos
ADD PRIMARY KEY (id_partido);
-------------------------------------------------------------
-- UNIDAD 004-003: ALTER TABLE
-- UNIDAD 002-003: Tipos de datos (AUTO_INCREMENT)
-------------------------------------------------------------
ALTER TABLE partidos
MODIFY id_partido INT AUTO_INCREMENT;



-- Creamos dos FK equipo local y equipo visitante
-------------------------------------------------------------
-- UNIDAD 002-008: Clave ajena
-- UNIDAD 004-003: ALTER TABLE
-------------------------------------------------------------
ALTER TABLE partidos
ADD CONSTRAINT fk_partidos_equipo_local
FOREIGN KEY (id_equipo_local)
REFERENCES equipos(id_equipo);

ALTER TABLE partidos
ADD CONSTRAINT fk_partidos_equipo_visitante
FOREIGN KEY (id_equipo_visitante)
REFERENCES equipos(id_equipo);



-- Insertamos una serie de partidos
-------------------------------------------------------------
-- UNIDAD 004-001: Inserción de registros en la tabla PARTIDOS
-------------------------------------------------------------
INSERT INTO partidos (
    id_equipo_local,
    id_equipo_visitante,
    fecha_partido,
    hora_partido,
    jornada,
    goles_local,
    goles_visitante,
    estadio
) VALUES
-- Jornada 1
(1, 2, '2025-08-20', '21:00:00', 1, 2, 1, 'Spotify Camp Nou'),          -- Barça vs Madrid
(3, 4, '2025-08-21', '20:30:00', 1, 1, 1, 'Cívitas Metropolitano'),      -- Atleti vs Sevilla
(5, 6, '2025-08-22', '19:30:00', 1, 0, 0, 'Benito Villamarín'),          -- Betis vs Valencia
(7, 8, '2025-08-23', '18:30:00', 1, 3, 2, 'Estadio de la Cerámica'),     -- Villarreal vs Real Sociedad
(9, 10, '2025-08-24', '17:00:00', 1, 1, 0, 'San Mamés'),                 -- Athletic vs Getafe

-- Jornada 2
(2, 1, '2025-08-27', '21:00:00', 2, 3, 0, 'Santiago Bernabéu'),          -- Madrid vs Barça
(4, 3, '2025-08-28', '20:30:00', 2, 2, 2, 'Ramón Sánchez-Pizjuán'),      -- Sevilla vs Atleti
(6, 5, '2025-08-29', '19:30:00', 2, 1, 2, 'Mestalla'),                   -- Valencia vs Betis
(8, 7, '2025-08-30', '18:30:00', 2, 0, 1, 'Reale Arena'),                -- Real Sociedad vs Villarreal
(10, 9, '2025-08-31', '17:00:00', 2, 0, 0, 'Coliseum Alfonso Pérez');    -- Getafe vs Athletic



-- Consulta para ver partidos de una jornada en concreta (Jornada 1)
-------------------------------------------------------------
-- UNIDAD 003-001: Selección de datos (SELECT, columnas)
-- UNIDAD 003-002: Condiciones con WHERE
-------------------------------------------------------------
SELECT
    id_partido,
    id_equipo_local,
    id_equipo_visitante,
    fecha_partido,
    hora_partido,
    jornada,
    goles_local,
    goles_visitante
FROM partidos
WHERE jornada = 1;



-- Consulta para ver los partidos con los nombres de los equipos
-------------------------------------------------------------
-- UNIDAD 003-005: Composiciones internas (JOIN entre tablas)
-- UNIDAD 003-001: Proyección de columnas
-------------------------------------------------------------
SELECT
    p.id_partido,
    el.nombre_equipo AS equipo_local,
    ev.nombre_equipo AS equipo_visitante,
    p.fecha_partido,
    p.hora_partido,
    p.jornada,
    p.goles_local,
    p.goles_visitante,
    p.estadio
FROM partidos p
JOIN equipos el ON p.id_equipo_local = el.id_equipo
JOIN equipos ev ON p.id_equipo_visitante = ev.id_equipo;



-------------------------------------------------------------
-- UNIDAD 003-005: Composiciones internas (JOIN)
-- UNIDAD 003-001: Proyección de columnas (SELECT)
-- UNIDAD 002-009: Creación de vistas
-------------------------------------------------------------
-- Creamos una vista para ver los partidos completos con los nombres de los equipos
CREATE VIEW vista_partidos_completa AS
SELECT
    p.id_partido,
    el.nombre_equipo AS equipo_local,
    ev.nombre_equipo AS equipo_visitante,
    p.fecha_partido,
    p.hora_partido,
    p.jornada,
    p.goles_local,
    p.goles_visitante,
    p.estadio
FROM partidos p
JOIN equipos el ON p.id_equipo_local = el.id_equipo
JOIN equipos ev ON p.id_equipo_visitante = ev.id_equipo;




-- Consulta goles total por jornada
-------------------------------------------------------------
-- UNIDAD 003-003: Funciones de resumen (SUM)
-- UNIDAD 003-004: Agrupar con GROUP BY
-------------------------------------------------------------
SELECT
    jornada,
    SUM(goles_local + goles_visitante) AS goles_totales_jornada
FROM partidos
GROUP BY jornada;



-- Media de goles por partido
-------------------------------------------------------------
-- UNIDAD 003-003: Funciones de resumen (AVG)
-------------------------------------------------------------
SELECT
    AVG(goles_local + goles_visitante) AS media_goles_por_partido
FROM partidos;


-- Consulta simple: Jugador + Equipo + Partidos donde participa su equipo
-------------------------------------------------------------
-- UNIDAD 003-005: JOIN entre varias tablas
-- UNIDAD 003-001: Alias en tablas y columnas
-------------------------------------------------------------
SELECT
    j.nombre AS jugador,
    eq.nombre_equipo AS equipo,
    p.id_partido,
    el.nombre_equipo AS local,
    ev.nombre_equipo AS visitante,
    p.jornada
FROM jugadores j
JOIN equipos eq 
    ON j.id_equipo = eq.id_equipo
JOIN partidos p
    ON p.id_equipo_local = eq.id_equipo
     OR p.id_equipo_visitante = eq.id_equipo
JOIN equipos el 
    ON p.id_equipo_local = el.id_equipo
JOIN equipos ev 
    ON p.id_equipo_visitante = ev.id_equipo;




-------------------------------------------------------------
-- UNIDAD 004-001: Modificación de registros (UPDATE)
-------------------------------------------------------------
UPDATE partidos
SET goles_local = 4, goles_visitante = 0
WHERE id_partido = 1;   -- ajustas el resultado del primer partido



-------------------------------------------------------------
-- UNIDAD 004-001: Borrado de registros (DELETE)
-------------------------------------------------------------
DELETE FROM partidos
WHERE id_partido = 10;  -- eliminas un partido concreto



-- Por ultimo le damos todos los privilegios a superfutbol
-------------------------------------------------------------
-- UNIDAD 002-010: Gestión de usuarios y privilegios
-------------------------------------------------------------

-- Crear el usuario 'superfutbol' con contraseña 'superfutbol'
CREATE USER 'superfutbol'@'localhost' IDENTIFIED BY 'superfutbol';

-- Conceder TODOS los privilegios sobre la base de datos liga_futbol
GRANT ALL PRIVILEGES ON liga_futbol.* TO 'superfutbol'@'localhost';

FLUSH PRIVILEGES;



-- Y vemos las tablas creadas con las dos vistas 
-------------------------------------------------------------
-- UNIDAD 002-003: Comprobación de las tablas creadas
-------------------------------------------------------------
SHOW TABLES;

