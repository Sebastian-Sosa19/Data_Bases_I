
-- En caso de no haberse creado nuevas tablas, se eliminarán los datos con el comando TRUNCATE.

TRUNCATE Gerencia;
TRUNCATE Departamento;
TRUNCATE Usuario;
TRUNCATE Lista;
TRUNCATE Tarea;

-- Se agregan nuevos datos a la Base de Datos.

INSERT INTO Gerencia(nombre_gr) VALUES
    ("Tecnologias de Informacion"),
    ("Mercadeo"),
    ("Ingenieria de Hardware"),
    ("Asesorías")
;

INSERT INTO Departamento(id_gr, nombre_dp) VALUES
    (1, "Desarrollo Web"),
    (1, "Desarrollo Movil"),
    (2, "Canales Digitales"),
    (3, "Importe de Componentes"),
    (4, "Capacitaciones Básicas")
;

INSERT INTO Usuario(id_dp, nombre_us) VALUES
    (1, "Jotaro Kujo"),
    (2, "Joseph Joestar"),
    (3, "Pavo Frio"),
    (4, "Giorno Giovanna"),
    (5, "Jose Inestroza")
;

INSERT INTO Lista(id_us, nombre_ls) VALUES
    (1, "Peces Carnivoros"),
    (2, "Escaleras Electricas Peligrosas"),
    (3, "Ataques eficientes"),
    (4, "Minas de Oro"),
    (5, "Deberes del período")
;

INSERT INTO Tarea(id_ls, descripcion) VALUES
    (1, "Investigar Peces chidos"),
    (1, "Visitar acurio"),
    (2, "Investigar escaleras peligrosas"),
    (2, "Encontrar metodos de precaución"),
    (3, "Averiguar buenos ataques"),
    (4, "Tener un sueño"),
    (4, "Detener a Diavolo"),
    (5, "Dar clases chidas")
;

-- Consultas

-- Clausula de actualización de una entidad con identidad n: 
-- UPDATE [Tabla a modificar] SET [Campo de tabla a modificar = nuevo valor] WHERE [identificador = n]
UPDATE Tarea SET estado = "completada" WHERE id = 1;

-- Subconsulta

SELECT Lista.id_us AS "Identificador de Usuario", 
        Tarea.estado AS "Estado de la tarea", 
        COUNT(*) AS "Cantidad de Tareas", 
        (SELECT COUNT(*) FROM Tarea JOIN Lista ON Tarea.id_ls = Lista.id WHERE Lista.id_us = Usuario.id) AS "Total tareas del Usuario",
        CONCAT(COUNT(*) / (SELECT COUNT(*) FROM Tarea JOIN Lista ON Tarea.id_ls = Lista.id WHERE Lista.id_us = Usuario.id)*100, " %") AS "Porcentaje"
    FROM Tarea JOIN Lista JOIN Usuario
    ON Tarea.id_ls = Lista.id AND Lista.id_us = Usuario.id
    GROUP BY Lista.id_us, Tarea.estado;

-- La subconsulta devuelve la cantidad total de tareas por usuario. Es una consulta de valor  único. 