

-- Creación de Base de datos.

CREATE DATABASE IF NOT EXISTS BDEnterprise;

-- Seleccionar base para usar.

USE BDEnterprise;

-- Se crean las tablas de la base de datos.

    CREATE TABLE IF NOT EXISTS Gerencia(
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre_gr VARCHAR(200) NOT NULL

    ) ;

    CREATE TABLE IF NOT EXISTS Departamento(
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_gr INT NOT NULL,
        nombre_dp VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Usuario(
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_dp INT NOT NULL,
        nombre_us VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Lista(
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_us INT NOT NULL,
        nombre_ls VARCHAR(200) NOT NULL,
        fecha_creacion TIMESTAMP DEFAULT NOW(),
        fecha_actualizacion TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
        estado ENUM('vigente', 'archivada', 'eliminada') DEFAULT "vigente"
    );

    CREATE TABLE IF NOT EXISTS Tarea(
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_ls INT NOT NULL,
        descripcion VARCHAR(200),
        fecha TIMESTAMP DEFAULT NOW(),
        estado ENUM('completada', 'no completada') DEFAULT "no completada"
    );

    





