DROP DATABASE IF EXISTS InformationTechnologies;

CREATE DATABASE InformationTechnologies;

USE InformationTechnologies;

CREATE TABLE PCInventory(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tex_name TEXT NOT NULL,
    cod_type ENUM('Laptop', 'Desktop', 'Tablet') NOT NULL DEFAULT 'Laptop',
    sma_ram SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    sma_ssd SMALLINT UNSIGNED NOT NULL DEFAULT 0
);

INSERT INTO PCInventory (tex_name, sma_ram, sma_ssd) VALUES 
    ("ACER P1020", 8, 32),
    ("ASUS P1021", 8, 32),
    ("HP P1022", 16, 64),
    ("HP P1023", 32, 512),
    ("Dell XPS 12", 32, 512),
    ("Dell XPS 17 1", 16, 2048),
    ("Dell XPS 17 2", 64, 2048),
    ("Dell XPS 17 3", 16, 128),
    ("Dell XPS 17 2", 128, 256),
    ("Dell XPS 17 4", 64, 256);

-- Listar todos los computadores del inventario.

SELECT COUNT(*) 'DISPOSITIVOS' 
    FROM PCInventory;

-- Listar los computadores que tienen 16 o 64 GB de RAM.

SELECT COUNT(*) 'DISPOSITIVOS' 
    FROM PCInventory 
    WHERE sma_ram IN (16, 64);

-- Listar todos los computadores que son de tipo XPS dentro del nombre "marca".

SELECT COUNT(*) 'DISPOSITIVOS' 
    FROM PCInventory 
    WHERE tex_name LIKE '%XPS%';

-- Listar cuantas computadoras hay por cantidad de RAM.

SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
    FROM PCInventory 
    GROUP BY sma_ram;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando los grupos donde hay dos o más dispositivos.

SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
    FROM PCInventory 
    GROUP BY sma_ram 
    HAVING COUNT(*)>=2;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando sólo tres registros de los grupos donde hay dos o más dispositivos.

SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
    FROM PCInventory 
    GROUP BY sma_ram 
    HAVING COUNT(*)>=2 LIMIT 3;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando sólo tres registros de los grupos donde hay dos o más dispositivos, ordenados de mayor a menor.

SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
    FROM PCInventory 
    GROUP BY sma_ram 
    HAVING COUNT(*)>=2 
    ORDER BY sma_ram 
    DESC LIMIT 3;

-- Listar las computadoras que pertenecen a los tres grupos mayores de RAM. Si una computadora pertenece a la 4ta mayor agrupación de RAM, dicha computadora no debe aparecer en la lista.

SELECT tex_name 'NOMBRE COMPUTADOR' 
    FROM PCInventory JOIN 
        (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
            FROM PCInventory 
            GROUP BY sma_ram 
            HAVING COUNT(*)>=2 
            ORDER BY sma_ram 
            DESC LIMIT 3) PCGROUP
    ON PCInventory.sma_ram = PCGROUP.`RAM`;

SELECT * 
    FROM PCInventory JOIN 
        (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
            FROM PCInventory 
            GROUP BY sma_ram 
            HAVING COUNT(*)>=2 
            ORDER BY sma_ram DESC 
            LIMIT 3) PCGROUP
    ON PCInventory.sma_ram = PCGROUP.`RAM`;

SELECT * 
    FROM PCInventory LEFT JOIN 
        (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
            FROM PCInventory 
            GROUP BY sma_ram 
            HAVING COUNT(*)>=2 
            ORDER BY sma_ram 
            DESC LIMIT 3) PCGROUP
    ON PCInventory.sma_ram = PCGROUP.`RAM`;

-- De las computadoras anteriores que pertenecen a los tres grupos mayores de RAM se desea ver de qué marca son. De forma anticipada, como empleados de la empresa sabemos que la marca de la computadora siempre es "la primer palabra" en el nombre de inventario.

    SELECT DISTINCT SUBSTRING_INDEX(tex_name, ' ', 1)
        FROM (SELECT tex_name 
                FROM PCInventory JOIN 
                    (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
                    FROM PCInventory 
                    GROUP BY sma_ram
                    HAVING COUNT(*)>=2 
                    ORDER BY sma_ram DESC 
                    LIMIT 3) PCGROUP
        ON PCInventory.sma_ram = PCGROUP.`RAM`) PCGroupBigRam;

-- Todas las marcas de computadoras en inventario que no pertenecen a las marcas de los tres grupos más grandes de RAM.

    SELECT DISTINCT SUBSTRING_INDEX(tex_name, ' ', 1) 'MARCA RESPUESTA 1' 
        FROM PCInventory 
        WHERE SUBSTRING_INDEX(tex_name, ' ', 1) NOT IN 
            (SELECT DISTINCT SUBSTRING_INDEX(tex_name, ' ', 1)
                FROM (SELECT tex_name 
                    FROM PCInventory JOIN 
                        (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
                        FROM PCInventory 
                        GROUP BY sma_ram 
                        HAVING COUNT(*)>=2 
                        ORDER BY sma_ram DESC 
                        LIMIT 3) PCGROUP
        ON PCInventory.sma_ram = PCGROUP.`RAM`) PCGroupBigRam);

-- Todas las marcas de computadoras en inventario que no pertenecen a las marcas de los tres grupos más grandes de RAM. Esta vez, sin usar el operador IN, y usar el JOIN para verificar la existencia de las listas.

SELECT Inventory.`Marca` 'Marca Respuesta 2' 
    FROM (SELECT DISTINCT SUBSTRING_INDEX(tex_name, ' ', 1) 'MARCA' 
            FROM PCInventory) AS Inventory LEFT JOIN 
                (SELECT SUBSTRING_INDEX(tex_name, ' ', 1) 'MARCA' 
                    FROM (SELECT tex_name 
                            FROM PCInventory JOIN 
                                (SELECT sma_ram 'RAM', COUNT(*) 'COMPUTADORES' 
                                    FROM PCInventory 
                                    GROUP BY sma_ram 
                                    HAVING COUNT(*)>=2 
                                    ORDER BY sma_ram 
                                    DESC LIMIT 3) PCGROUP
                                    ON PCInventory.sma_ram = PCGROUP.`RAM`) AS PCGroupBigRam) AS PCGroupBigRam
    ON Inventory.`Marca` = PCGroupBigRam.`Marca`
    WHERE PCGroupBigRam.`Marca` IS NULL;
    

