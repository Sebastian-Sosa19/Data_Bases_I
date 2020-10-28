
USE AdvancedSQLProcedure;

-- Pasar el last request como parametro json en el sp.

DROP TABLE IF EXISTS RequestQueue;
CREATE TABLE RequestQueue(
    id INT AUTO_INCREMENT PRIMARY KEY,
    jso_request JSON NOT NULL COMMENT "Petición API en formato JSON",
    bit_read BIT NOT NULL COMMENT "Estado de la petición: atendida o no atendida"
) COMMENT "Tabla de peticiones de usuario en forma de cola";

INSERT INTO RequestQueue(jso_request, bit_read) VALUES
    ('{"service":"00f21X2","user":"bdi","command":"INBOX"}', 1),
    ('{"service":"00f21X2","user":"bdi","command":"TRASH"}', 0);

DELIMITER $$

    DROP PROCEDURE IF EXISTS sp_case $$

    CREATE PROCEDURE sp_case(IN c_json JSON, IN key_json VARCHAR(20))

    BEGIN
        
        SET @lastCommand = SELECT JSON_VALUE(c_json, CONCAT('"$.'+key_json+'"'));

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
            
    END $$

DELIMITER ;

SET @lastRequest = (SELECT jso_request FROM RequestQueue WHERE bit_read = 0 ORDER BY id ASC LIMIT 1);

CALL sp_case(@lastRequest, "command");

