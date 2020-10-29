
USE AdvancedSQLProcedure;

DROP TABLE IF EXISTS Months;

CREATE TABLE Months(
    id INT AUTO_INCREMENT PRIMARY KEY,
    var_month VARCHAR(25) NOT NULL
);

INSERT INTO Months(var_month) VALUES 
    ('Enero'), ('Febrero'), ('Marzo'), ('Abril'), ('Mayo'), ('Junio'), 
    ('Julio'), ('Agosto'), ('Septiembre'), ('Octubre'), ('Noviembre'), ('Diciembre');

DELIMITER $$

    DROP PROCEDURE IF EXISTS sp_showDate$$

    CREATE PROCEDURE sp_showDate(IN D INT, IN M INT, IN Y INT, OUT dat VARCHAR(50))

    BEGIN
        
        DECLARE month_name VARCHAR(15) DEFAULT 'NONE';

        DECLARE countr INT DEFAULT 0;
        DECLARE leap TINYINT DEFAULT 0;
        DECLARE i INT DEFAULT 0;

        -- Let's see if it is a leap year.
        REPEAT
            IF countr = Y THEN
                SET leap = 1;
            ELSE
                SET countr = countr + 4;
        
        SET i = i + 1;
        UNTIL i < 2501
        END REPEAT;

        IF Y > 0 AND Y < 10001 THEN
            IF M > 0 AND M < 13 THEN
                IF D > 0 AND D < 32 THEN
                    IF M IN (1, 3, 5, 7, 8, 10, 12) THEN
                        SET month_name = (SELECT var_month FROM Months WHERE id = M);
                    ELSEIF D > 0 AND D < 31 THEN
                        IF M IN (4, 6, 9, 11) THEN
                            SET month_name = (SELECT var_month FROM Months WHERE id = M);
                        END IF;
                    ELSEIF D > 0 AND D < 30 THEN
                            IF D < 29 THEN 
                                SET month_name = (SELECT var_month FROM Months WHERE id = 2);
                            ELSEIF D = 29 THEN 
                                SET month_name = (SELECT var_month FROM Months WHERE id = 2);
                            ELSE
                                SELECT 'Not valid date' AS 'Error';
                            END IF;
                    END IF;        
                ELSE
                   SELECT 'Not valid date' AS 'Error';
                END IF;
            END IF;
        END IF;

        IF leap = 1 THEN
            IF month_name = "NONE" THEN
                SELECT 'Not valid date' AS 'Error';
            ELSE
                SELECT CONCAT('¡Es año bisiesto! Es ', D, ' de ', month_name, ' de ', Y);
            END IF;
        
        ELSE
            IF month_name = "NONE" THEN
                SELECT 'Not valid date' AS 'Error';
            ELSE
                SELECT CONCAT('Es ', D, ' de ', month_name, ' de ', Y);
            END IF;
        
        END IF;

    END$$

DELIMITER ;





