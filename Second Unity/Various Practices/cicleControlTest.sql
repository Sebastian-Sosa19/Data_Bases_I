
USE AdvancedSQLProcedure;

DELIMITER $$

    DROP PROCEDURE IF EXISTS testNestedIf $$

    CREATE PROCEDURE testNestedIf(IN i INT, IN i2 INT)

    BEGIN
        IF i > 0 THEN
            IF i2 > 0 THEN
                SELECT 'Ambos números son positivos' AS 'Resultado';
            ELSE 
                SELECT 'i es positivo, i2 es negativo' AS 'Resultado';
            END IF;
        ELSE
            IF i2 > 0 THEN
                SELECT 'i es negativo, i2 es positivo' AS 'Resultado';
            ELSE 
                SELECT 'Ambos números son negativos' AS 'Resultado';
            END IF;
        END IF;
    END $$

DELIMITER ;

-- CALL test (2, 3);

DELIMITER $$

    DROP PROCEDURE IF EXISTS testRepeat $$

    CREATE PROCEDURE testRepeat(IN i INT)

    BEGIN

        SET @countr = 0;
        REPEAT
            SET @countr = @countr + 1;
        UNTIL @countr > i END REPEAT;

        SELECT @countr AS "Result";
    END $$

DELIMITER ;

CALL testRepeat(10);