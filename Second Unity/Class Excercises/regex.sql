
USE AdvancedSQLProcedure;    

    -- Expresiones regulares.
    SET @record = '{"name":"María García","age":"20","uid":"0801200001011"}';
    SET @pattern = '^08\\d{11}$';
    select ('0801200001011' REGEXP '^08\\d{11}$') as test;

    SELECT 
        JSON_UNQUOTE(JSON_EXTRACT(@record,"$.uid")) AS "UID",
        CASE 
            WHEN ((JSON_UNQUOTE(JSON_EXTRACT(@record,"$.uid"))) REGEXP @pattern) = 0 THEN "FALSE"
            ELSE "TRUE"
        END AS "Cumple con el patrón.";
    
    -- Estudiantes con excelencia académica.
    DROP TABLE IF EXISTS Student;
    CREATE TABLE Student(
        id INT AUTO_INCREMENT PRIMARY KEY,
        jso_record JSON NOT NULL COMMENT "Documento con nombre, edad, e id."
    );

    /*
        Expresiones regulares para identificar las identidades que nos interesan.
        (1803200102022)|(0802199903033)|(0102199903033) ---> Menos óptima
        ((0[178])|(18))[0123456789]{11}
        ((01)|(07)|(08)|(18))\d{11}
        ((0[178])|(18))[0-9]{11}
        ((0[178])|(18))\d{11}
    */

    INSERT INTO Student(jso_record) VALUES
        ('{"name":"María García","age":"20","uid":"0301200001011"}'),
        ('{"name":"Enrique García","age":"20","uid":"0501200001011"}'),
        ('{"name":"Juan Almendarez","age":"20","uid":"1203200102022"}'),
        ('{"name":"Alejandra Almendarez","age":"20","uid":"1803200102022"}'),
        ('{"name":"Pedro Guillén","age":"19","uid":"0802199903033"}'),
        ('{"name":"Merced Guillén","age":"19","uid":"0102199903033"}');

    /*
        Se desea hacer un recorrido por ciertos departamentos del país para convencer a estudiantes para que hagan estudios sobre STEM (Science, Technology, Engineering, Mathematics). Para ello se requieren estudaintes de dichos departamentos.

        Se desea hacer una tabla que muestre claramente los estudiantes que e4starán involucrados en los siguientes recorridos:
            - Recorrido 1: Atlántida (01), El Paraíso (07), Francisco Morazán (08), y Yoro (18).
            - Recorrido 2: La Paz (12), Comayagua (03), y Cortéz (05).
    */

    SELECT 
        (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.name"))) AS "Nombre del Estudiante",
        CASE 
            WHEN (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.uid"))) REGEXP "^((0[178])|(18))\\d{11}$" THEN "Recorrido 1"
            WHEN (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.uid"))) REGEXP "^((0[35])|(12))\\d{11}$" THEN "Recorrido 2"
        END AS "Recorrido"
    FROM
        Student
    WHERE
        (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.uid"))) REGEXP "^((0[13578])|(1[28]))\\d{11}$"
    ORDER BY
        CASE 
            WHEN (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.uid"))) REGEXP "^((0[178])|(18))\\d{11}$" THEN "Recorrido 1"
            WHEN (JSON_UNQUOTE(JSON_EXTRACT(jso_record, "$.uid"))) REGEXP "^((0[35])|(12))\\d{11}$" THEN "Recorrido 2"
        END ASC;

    