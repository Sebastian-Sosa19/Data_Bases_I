
USE AdvancedSQLProcedure;

SET @student1 = '{
        "name":"Emilio Sosa",
        "subject":"Natural Science",
        "section" : "1500",
        "grade" : "72.00%"
    }';

SET @student2 = '{
        "name":"Lisa Sabala",
        "subject":"Calculous II",
        "section" : "0800",
        "grade" : "59.00%"
    }';

SET @student3 = '{
        "name":"Joseph Joestar",
        "subject":"Programming I",
        "section" : "1400",
        "grade" : "64.00%"
    }';

SET @student4 = '{
        "name":"Josuke Higashikata",
        "subject":"Basic Math",
        "section" : "1200",
        "grade" : "34.00%"
    }';

SET @student5 = '{
        "name":"Marion Chávez",
        "subject":"Theatre",
        "section" : "0700",
        "grade" : "98.02%"
    }';

SET @student6 = '{
        "name":"Trish Una",
        "subject":"Cultural Dancing",
        "section" : "0800",
        "grade" : "85.55%"
    }';

DROP TABLE IF EXISTS Students;
CREATE TABLE Students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    var_name VARCHAR(50) NOT NULL,
    var_subject VARCHAR(50) NOT NULL,
    var_section VARCHAR(25) NOT NULL,
    var_grade FLOAT NOT NULL
);

/*
    We will create a stored procedure to store new students into the Students table using a single JSON as a parameter, and extracting each of it's components in order to insert them into the table. 
*/

DELIMITER $$
    
    DROP PROCEDURE IF EXISTS sp_addStudent $$
    
    CREATE PROCEDURE sp_addStudent(IN studentInfo JSON)

    BEGIN 

    SET @name = JSON_UNQUOTE(JSON_EXTRACT(studentInfo, "$.name"));
    SET @subject = JSON_UNQUOTE(JSON_EXTRACT(studentInfo, "$.subject"));
    SET @section = JSON_UNQUOTE(JSON_EXTRACT(studentInfo, "$.section"));
    SET @grade = CAST((LEFT((JSON_UNQUOTE(JSON_EXTRACT(studentInfo, "$.grade"))), 2)) AS UNSIGNED);

    INSERT INTO Students(var_name, var_subject, var_section, var_grade) VALUES (@name, @subject, @section, @grade);

    END $$

DELIMITER ;

CALL sp_addStudent(@student1);
CALL sp_addStudent(@student2);
CALL sp_addStudent(@student3);
CALL sp_addStudent(@student4);
CALL sp_addStudent(@student5);
CALL sp_addStudent(@student6);

SELECT *
    FROM Students;

/* Now we'll do a query for all of the approved and failed students. 

We'll save all of the JSON student INFO in a single table.
*/

DROP TABLE IF EXISTS StudentsJSON;

CREATE TABLE StudentsJSON(
    id INT AUTO_INCREMENT PRIMARY KEY,
    json_student JSON NOT NULL
);

INSERT INTO StudentsJSON(json_student) VALUES
    (@student1), (@student2), (@student3), (@student4), (@student5), (@student6);

SELECT
    JSON_UNQUOTE(JSON_EXTRACT(json_student, "$.name")) AS "NAME",
    JSON_UNQUOTE(JSON_EXTRACT(json_student, "$.subject")) AS "SIGNATURE",
    CAST((LEFT((JSON_UNQUOTE(JSON_EXTRACT(json_student, "$.grade"))), 2)) AS UNSIGNED) AS "GRADE",
    CASE
        WHEN CAST((LEFT((JSON_UNQUOTE(JSON_EXTRACT(json_student, "$.grade"))), 2)) AS UNSIGNED) < 65 THEN "Failed"
        ELSE "Approved"
    END AS "App/Fai"
    FROM StudentsJSON;




