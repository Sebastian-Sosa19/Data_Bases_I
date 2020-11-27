DROP DATABASE IF EXISTS EXAMPLE;

CREATE DATABASE IF NOT EXISTS Example;

USE Example;

CREATE TABLE IF NOT EXISTS Measure(
    id INT(11) NOT NULL AUTO_INCREMENT,
    device INT(11) NOT NULL,
    temperature DECIMAL(10,4) DEFAULT NULL,
    tim_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(id)
);

TRUNCATE TABLE Measure;

INSERT INTO Measure(device, temperature, tim_date) VALUES
    (1,36.74, '2020-11-24 04:56:59'),
    (2,57.65, '2020-12-24 17:45:54'),
    (1,45.58, '2021-10-24 23:14:18'),
    (3,73.33, '2021-09-24 15:25:36'),
    (4,61.72, '2022-10-24 02:47:27'),
    (5,27.97, '2022-07-24 04:28:28'),
    (2,19.21, '2023-10-24 07:05:17'),
    (4,38.16, '2023-02-24 09:08:15'),
    (5,37.72, '2024-01-24 22:18:15'),
    (3,45.67, '2024-03-24 19:39:26'),
    (5,37.59, '2025-12-24 14:29:49'),
    (4,36.74, '2025-06-24 12:17:57'),
    (3,85.56, '2026-08-24 20:10:17'),
    (2,59.33, '2026-07-24 21:25:27'),
    (2,63.12, '2027-05-24 04:16:39'),
    (2,32.87, '2027-12-24 15:36:58'),
    (2,51.73, '2028-02-24 05:27:46'),
    (1,67.09, '2028-11-24 23:57:52'),
    (5,15.67, '2029-09-24 11:17:31'),
    (1,23.41, '2029-11-24 08:39:41');

DROP VIEW IF EXISTS FirstDeviceMeasureRecent;

CREATE VIEW FirstDeviceMeasureRecent AS
    SELECT *
        FROM Measure
        WHERE device = 1
        ORDER BY id DESC
        LIMIT 1000
    ;

SELECT "First Device Measure Recent" AS "View", COUNT(*) AS "COUNT"
    FROM FirstDeviceMeasureRecent;

/*
    1) Crear una vista que muestre la cantidad de registros por cada mes, para el año 2020 llamada "CountMonth2020".
*/

DROP VIEW IF EXISTS CountMonth2020;

CREATE VIEW CountMonth2020 AS
    SELECT MONTH(Measure.tim_date) AS "Month", COUNT(*) AS "COUNT"
        FROM Measure
        WHERE YEAR(Measure.tim_date) = 2020
        GROUP BY MONTH(Measure.tim_date)
        ORDER BY MONTH(Measure.tim_date);
    
SELECT * FROM CountMonth2020;

/*
    2) En el departamento de TI de una institución financiera, se desea registrar de forma permanente la consulta que gneera el informe de la cantidad de elementos de medición por hora del día, para el mes de noviembre de 2020. Esta consulta deberá guardarse como "CountByDayOnNovember"
*/

DROP VIEW IF EXISTS CountByDayOnNovember2020;

CREATE VIEW CountByDayOnNovember2020 AS
    SELECT HOUR(Measure.tim_date) AS "Hour", COUNT(*) AS "Count"
    FROM Measure
    WHERE MONTH(Measure.tim_date) = 11 AND
        YEAR(Measure.tim_date) = 2020
    GROUP BY HOUR(Measure.tim_date)
    ORDER BY HOUR(Measure.tim_date) ASC;

SELECT * FROM CountByDayOnNovember2020;

