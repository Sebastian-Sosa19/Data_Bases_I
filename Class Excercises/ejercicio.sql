-- October First 2020
-- Main Themes: Drop Tables, Integrity, Alter tables, Foreign Keys.

CREATE DATABASE IF NOT EXISTS GAME_CATALOGUE;

    CREATE TABLE IF NOT EXISTS PLAYER(
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        tex_name TEXT NOT NULL,
        cod_state ENUM('active','blocked','inactive') DEFAULT 'active',
        tim_creation TIMESTAMP DEFAULT NOW()
    );

    CREATE TABLE IF NOT EXISTS GAME(
        id NOT NULL AUTO_INCREMENT PRIMARY KEY,
        tex_name TEXT NOT NULL
    );

-- Apply referential integrity constraint.

    CREATE TABLE IF NOT EXISTS GAMEPLAYER(
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        id_player INT NOT NULL,
        id_game INT NOT NULL,
        tim_lastPlayed TIMESTAMP,
        cod_state ENUM('on-progress','not-played','beated') DEFAULT 'not-played'
    );

/*

    Things to do:
    - Create Diagram and ER Model.
    - Apply SQL integrity constraints with foreign keys.
    - Apply integrity cosntraints through ALTER TABLE and CREATE TABLE.

*/