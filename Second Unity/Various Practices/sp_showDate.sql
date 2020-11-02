
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

    CREATE PROCEDURE sp_showDate(IN D INT, IN M INT, IN Y INT)

    BEGIN
        
        SET @month_name = 'NONE';
        
        SET @countr = 0;        
        SET @leap = 0;        
        SET @i = 0;

        -- Let's see if it is a leap year.
        REPEAT
            IF @countr = Y THEN
                SET @leap = 1;
            ELSE
                SET @countr = @countr + 4;
            END IF;
        
        SET @i = @i + 1;
        UNTIL @i = 2500 END REPEAT;

        IF Y BETWEEN 0 AND 10000 THEN
            IF M BETWEEN 1 AND 12 THEN
                IF D BETWEEN 1 AND 31 THEN
                    IF M IN (1, 3, 5, 7, 8, 10, 12) THEN
                        SET @month_name = (SELECT var_month FROM Months WHERE id = M);
                    ELSEIF D > 0 AND D < 31 THEN
                        IF M IN (4, 6, 9, 11) THEN
                            SET @month_name = (SELECT var_month FROM Months WHERE id = M);
                        END IF;
                    ELSEIF D > 0 AND D < 30 THEN
                            IF D < 29 THEN 
                                SET @month_name = (SELECT var_month FROM Months WHERE id = 2);
                            ELSEIF D = 29 THEN 
                                SET @month_name = (SELECT var_month FROM Months WHERE id = 2);
                            ELSE
                                SELECT 'Not valid date' AS 'Error';
                            END IF;
                    END IF;        
                ELSE
                   SELECT 'Not valid date' AS 'Error';
                END IF;
            END IF;
        END IF;

        IF @leap = 1 THEN
            IF @month_name = "NONE" THEN
                SELECT 'Not valid date' AS 'Error';
            ELSE
                SELECT CONCAT('¡Es año bisiesto! Es ', D, ' de ', @month_name, ' de ', Y) AS "Resultado";
            END IF;
        
        ELSE
            IF @month_name = "NONE" THEN
                SELECT 'Not valid date' AS 'Error';
            ELSE
                SELECT CONCAT('Es ', D, ' de ', @month_name, ' de ', Y) AS "Resultado";
            END IF;
        
        END IF;

    END$$

DELIMITER ;

CALL sp_showDate(19, 11, 2020);
