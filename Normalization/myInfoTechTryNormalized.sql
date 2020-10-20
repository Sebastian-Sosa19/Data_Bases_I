-- @author: lyraNoMilo_19
-- @date: October 15, 2020.

DROP DATABASE IF EXISTS InformationTechnologies;

CREATE DATABASE InformationTechnologies;

USE InformationTechnologies;

CREATE TABLE PCInventory(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_brand INT NOT NULL COMMENT,
    id_ramConfig INT NOT NULL COMMENT,
    id_ssdConfig INT NOT NULL COMMENT,
    id_screenPanelConfig INT NOT NULL COMMENT,    
    tex_modelName TEXT NOT NULL COMMENT,
    tex_description TEXT NOT NULL COMMENT,
    num_amount INT NOT NULL DEFAULT 0 COMMENT
);

CREATE TABLE PartBrand(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tex_name TEXT NOT NULL COMMENT,
) COMMENT ;

CREATE TABLE PCSSDConfiguration(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_brand INT NOT NULL COMMENT,
    id_ssdType INT NOT NULL COMMENT,
    num_amount SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT,
    num_speed SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT
) COMMENT ;

CREATE TABLE PCRAMConfiguration(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_brand INT NOT NULL COMMENT,
    num_amount SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT,
    num_speed SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT
) COMMENT ;

CREATE TABLE PCSSDConfigurationType(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tex_type VARCHAR(20) NOT NULL COMMENT
) COMMENT ;

CREATE TABLE PCScreenPanelConfiguration(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_screenRatio INT NOT NULL COMMENT,
    id_panelType INT NOT NULL COMMENT,
    num_inches TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT
) COMMENT ;

CREATE TABLE PCScreenPanelConfigurationType(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_type VARCHAR(20) NOT NULL COMMENT
) COMMENT ;

CREATE TABLE PCScreenPanelConfigurationRatio(
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_width TINYINT NOT NULL DEFAULT 0 COMMENT,
    num_height TINYINT NOT NULL DEFAULT 0 COMMENT
) COMMENT ;

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
    SELECT tex_name 
        FROM PCInventory;

-- Listar los computadores que tienen 16 o 64 GB de RAM.

    SELECT tex_name 'Name', sma_ram 'RAM'
        FROM PCInventory
        WHERE sma_ram IN (16, 64)
        ORDER BY sma_ram;

-- Listar todos los computadores que son de tipo XPS dentro del nombre "marca".

    SELECT tex_name 'Name'
        FROM PCInventory
        WHERE tex_name LIKE '%XPS%';

-- Listar cuantas computadoras hay por cantidad de RAM.

    SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
        FROM PCInventory
        GROUP BY sma_ram;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando los grupos donde hay dos o más dispositivos.

    SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
        FROM PCInventory
        GROUP BY sma_ram
        HAVING COUNT(*) >= 2;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando sólo tres registros de los grupos donde hay dos o más dispositivos.

    SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
        FROM PCInventory
        GROUP BY sma_ram
        HAVING COUNT(*) >= 2
        LIMIT 3;

-- Listar cuantas computadoras hay por cantidad de RAM, mostrando sólo tres registros de los grupos donde hay dos o más dispositivos, ordenados de mayor a menor.

    SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
        FROM PCInventory
        GROUP BY sma_ram
        HAVING COUNT(*) >= 2
        ORDER BY sma_ram DESC
        LIMIT 3;

-- Listar las computadoras que pertenecen a los tres grupos mayores de RAM. Si una computadora pertenece a la 4ta mayor agrupación de RAM, dicha computadora no debe aparecer en la lista.

    SELECT tex_name 'COMPUTADOR'
    FROM PCInventory PC JOIN 
        (SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
            FROM PCInventory
            GROUP BY sma_ram
            HAVING COUNT(*) >= 2
            ORDER BY sma_ram
            LIMIT 3) PCRAM
    WHERE PC.sma_ram = PCRAM.`RAM`;

-- De las computadoras anteriores que pertenecen a los tres grupos mayores de RAM se desea ver de qué marca son. De forma anticipada, como empleados de la empresa sabemos que la marca de la computadora siempre es "la primer palabra" en el nombre de inventario.

    SELECT tex_name 'COMPUTADOR', SUBSTRING_INDEX(tex_name, ' ', 1)
    FROM PCInventory PC JOIN 
        (SELECT sma_ram 'RAM', COUNT(*) 'CANTIDAD'
            FROM PCInventory
            GROUP BY sma_ram
            HAVING COUNT(*) >= 2
            ORDER BY sma_ram
            LIMIT 3) PCRAM
    WHERE PC.sma_ram = PCRAM.`RAM`;

-- Todas las marcas de computadoras en inventario que no pertenecen a las marcas de los tres grupos más grandes de RAM.

-- Todas las marcas de computadoras en inventario que no pertenecen a las marcas de los tres grupos más grandes de RAM. Esta vez, sin usar el operador IN, y usar el JOIN para verificar la existencia de las listas.
    

