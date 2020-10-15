-- @author: lyraNoMilo_19
-- @date: October 2, 2020.

-- SQL file for integrity constraints.

CREATE TABLE GAMEPLAYER(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_player INT NOT NULL,
    id_game INT NOT NULL,
    tim_lastPlayed TIMESTAMP,
    cod_state ENUM('on-progress','not-played','beated') DEFAULT 'not-played',

    INDEX (id_player),
    INDEX (id_game),

    FOREIGN KEY (id_player)
        REFERENCES PLAYER(id),
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    
    FOREIGN KEY (id_game)
        REFERENCES GAME(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,        

);

-- Indexes son necesarios para apresurar la comprobación de llaves foráneas sin la necesidad de tener que hacer un escaneo de tabla al momento de recuperar los datos.

ALTER TABLE GamePlayer
    ADD
        INDEX (id_player),
        INDEX (id_game),

        FOREIGN KEY (id_player)
            REFERENCES PLAYER(id),
            ON DELETE RESTRICT ON UPDATE RESTRICT,
    
        FOREIGN KEY (id_game)
            REFERENCES GAME(id)
            ON DELETE RESTRICT ON UPDATE RESTRICT;
        


    

