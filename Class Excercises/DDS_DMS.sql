
DROP DATABASE IF EXISTS SQLTesting;

CREATE DATABASE SQLTesting CHARACTER SET utf8;

USE SQLTesting;

CREATE TABLE DataType(
    id INT AUTO_INCREMENT PRIMARY KEY,
    bit_active BIT NOT NULL,
    big_population BIGINT NOT NULL,
    tin_students TINYINT UNSIGNED NOT NULL,
    jso_graph JSON NOT NULL,
    dec_salary DECIMAL(8,2) NOT NULL,
    flo_bigNumberA FLOAT NOT NULL,
    dou_bigNumberB DOUBLE NOT NULL
);

INSERT INTO DataType(    
    bit_active,
    big_population,
    tin_students,
    jso_graph,
    dec_salary,
    flo_bigNumberA,
    dou_bigNumberB
) VALUES
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7),
    (0, 8000000000, 60, '{"vertex1":{"w":12.1, "edges":["vertex2"]}, "vertex2":{"w":1, "edges":[]}}', 0.7, 0.7, 0.7);

SELECT 
    source.id AS id,
    source.dec_salary AS salary,
    source.flo_bigNumberA AS bigA,
    source.dou_bigNumberB AS bigB

    FROM DataType AS source
    WHERE source.id BETWEEN 1 AND 8
    LIMIT 5,2;








