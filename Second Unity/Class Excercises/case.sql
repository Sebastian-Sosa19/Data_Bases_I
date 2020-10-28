
DROP DATABASE IF EXISTS AdvancedSQLProcedure;

CREATE DATABASE AdvancedSQLProcedure CHARACTER SET UTF8;
USE AdvancedSQLProcedure;

-- Se define una variable con el contenido de un caso de uso.
SET @sampleCategory = "folder";

-- Se aplica un caso de selección.
SELECT 
    CASE
        WHEN @sampleCategory = "folder" THEN "01f02"
        WHEN @sampleCategory = "file" THEN "01f03"
        ELSE "UNK000"
    END AS "Type of Item as a Code";

-- Se crea la tabla de cola de repetición.
DROP TABLE IF EXISTS RequestQueue;
CREATE TABLE RequestQueue(
    id INT AUTO_INCREMENT PRIMARY KEY,
    jso_request JSON NOT NULL COMMENT "Petición API en formato JSON",
    bit_read BIT NOT NULL COMMENT "Estado de la petición: atendida o no atendida"
) COMMENT "Tabla de peticiones de usuario en forma de cola";

INSERT INTO RequestQueue(jso_request, bit_read) VALUES
    ('{"service":"00f21X2","user":"bdi","command":"INBOX"}', 1),
    ('{"service":"00f21X2","user":"bdi","command":"TRASH"}', 0);

-- Selecione el último registro de petición no atendido. Almacene en un espacio de memoria temportal el valor resultante.
SET @lastRequest = (SELECT jso_request FROM RequestQueue WHERE bit_read = 0 ORDER BY id ASC LIMIT 1);

-- Obtener del último registro no atendido, el comando recibido.
SET @lastCommand = JSON_UNQUOTE(JSON_EXTRACT(@lastRequest, "$.command"));

-- Se demuestra que las variables contienen la información deseada.
SELECT @lastRequest AS "Úlima petición en Queue", @lastCommand AS "Último comando";

-- Se realiza un caso dependiendo del dato obtenido.

SELECT 
    @lastCommand AS "Último comando",
    CASE
        WHEN @lastCommand = "INBOX" THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN @lastCommand = "TRASH" THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción desconocida"
    END AS "Acción solicitada (=)",
    
    CASE
        WHEN @lastCommand LIKE "INBOX" THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN @lastCommand LIKE "TRASH" THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción Desconocida"
    END AS "Acción Solicitada (LIKE)",

    CASE
        WHEN STRCMP(@lastCommand,"INBOX") = 0 THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN STRCMP(@lastCommand, "TRASH") = 0 THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción Desconocida"
    END AS "Acción Solicitada (STRCMP)";

-- Se realiza un caso dependiendo del dato obtenido, limpiando las cadenas con TRIM.
SELECT 
    @lastCommand AS "Último comando",
    CASE
        WHEN TRIM(@lastCommand) = "INBOX" THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN TRIM(@lastCommand) = "TRASH" THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción desconocida"
    END AS "Acción solicitada (=)",
    
    CASE
        WHEN TRIM(@lastCommand) LIKE "INBOX" THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN TRIM(@lastCommand) LIKE "TRASH" THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción Desconocida"
    END AS "Acción Solicitada (LIKE)",

    CASE
        WHEN STRCMP(TRIM(@lastCommand), "INBOX") = 0 THEN "Solicitud de Inbox SMTP de la bandeja de entrada."
        WHEN STRCMP(TRIM(@lastCommand), "TRASH") = 0 THEN "Solicitud de Trash SMTP de la bandeja de entrada."
        ELSE "Instrucción Desconocida"
    END AS "Acción Solicitada (STRCMP)";


/*
    - Encapsular en un SP, los componentes núcleos de este ejercicio.
    - Aplicar la correcta implementación del método STRCMP.
*/


