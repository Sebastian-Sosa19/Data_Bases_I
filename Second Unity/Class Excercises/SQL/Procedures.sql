DROP DATABASE IF EXISTS AdvancedSQLProcedures;

CREATE DATABASE AdvancedSQLProcedures;

USE AdvancedSQLProcedures;

DELIMITER $$
    SET @@SESSION.max_sp_recursion_depth = 25$$

    DROP PROCEDURE IF EXISTS sp_factorial$$

    CREATE PROCEDURE sp_factorial(IN N VARCHAR(25), OUT FACT INT)
    BEGIN

        SELECT CAST(N AS SIGNED);

        IF N = 1 AND 1<2 THEN
            SELECT 1 INTO FACT;
        ELSE
            CALL sp_factorial(N-1, @TEMP);
            SET FACT = N*@TEMP;
        END IF;
    
    END$$

DELIMITER ;

SET @fact = 0;
CALL sp_factorial(5, @fact);
SELECT @fact AS "Factorial de 5";

