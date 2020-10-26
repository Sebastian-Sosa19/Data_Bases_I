-- @author: lyraNoMilo_19
-- @date: October 2, 2020.

DROP DATABASE IF EXISTS COLLEGE;

CREATE DATABASE COLLEGE CHARACTER SET utf8;

USE COLLEGE;

CREATE TABLE STUDENT(
    id INT AUTO_INCREMENT PRIMARY KEY,
    var_fname VARCHAR(150) NOT NULL,
    var_sname VARCHAR(150) NOT NULL,
    var_flname VARCHAR(150) NOT NULL,
    var_slname VARCHAR(150) NOT NULL,
    enu_sex ENUM('M','F'),
    tin_age TINYINT NOT NULL,
    int_syear INT NOT NULL,
    int_semester INT NOT NULL,

    CHECK (int_semester BETWEEN 1 AND 3)
);

CREATE TABLE TEACHER(
    id INT AUTO_INCREMENT PRIMARY KEY,
    var_fname VARCHAR(150) NOT NULL,
    var_sname VARCHAR(150) NOT NULL,
    var_flname VARCHAR(150) NOT NULL,
    var_slname VARCHAR(150) NOT NULL,
    enu_sex ENUM('M','F'),
    tin_age TINYINT NOT NULL
);

CREATE TABLE SUBJECTS(
    id INT AUTO_INCREMENT PRIMARY KEY,
    int_student_id INT NOT NULL,
    int_teacher_id INT NOT NULL,    
    var_name VARCHAR(150) NOT NULL,
    int_vu INT NOT NULL,
    cha_section CHAR(4),

    CHECK (int_vu > 0 AND int_vu <= 5),    
    
    FOREIGN KEY (int_student_id)
        REFERENCES STUDENT(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (int_teacher_id)
        REFERENCES TEACHER(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO STUDENT (    
    var_fname,
    var_sname,
    var_flname,
    var_slname,
    enu_sex,
    tin_age,
    int_syear,
    int_semester
) VALUES
    ('Leon', 'Scott', 'Kennedy', 'Sánchez', 'M', 25, 3, 2),
    ('Koichi', 'Gerardo', 'Horise', 'Aviléz', 'M', 17, 1, 1),
    ('Josuke', 'Mauricio', 'Higashigata', 'Ortez', 'M', 18, 2, 2),
    ('Melanie', 'Roberta', 'Martínez', 'Stiller', 'F', 19, 2, 2),
    ('Ada', 'Giorgina', 'Wong', 'Sagastume', 'F', 21, 3, 1),
    ('Carlos', 'Roberto', 'Sosa', 'Amador', 'M', 25, 3, 2),
    ('Emilio', 'Ricardo', 'Vallecillo', 'López', 'M', 17, 1, 1),
    ('Carlos', 'Fernando', 'Sosa', 'Ramos', 'M', 18, 2, 2),
    ('Fernanda', 'Axel', 'Villalvir', 'Flores', 'F', 19, 2, 2),
    ('Lourdes', 'Amparo', 'Amador', 'Amador', 'F', 21, 3, 1);

INSERT INTO TEACHER (    
    var_fname,
    var_sname,
    var_flname,
    var_slname,
    enu_sex,
    tin_age
) VALUES 
    ('Jotaro', 'Sebastián', 'Kujo', 'Sosa', 'M', 35),
    ('Erina', 'Evelyn', 'Joestar', 'Martínez', 'F', 28),
    ('Suzie', 'María', 'Q.', 'Sosa', 'F', 36),
    ('Lisa', 'Lisa', 'Joestar', 'Marsh', 'F', 50),
    ('José', 'Eduardo', 'Matute', 'Ortez', 'M', 35),
    ('Jennifer', 'Guadalupe', 'Obando', 'Ortez', 'F', 28),
    ('Jose', 'María', 'Calderón', 'Sosa', 'F', 36),
    ('Rita', 'Fernanda', 'Ramirez', 'Vicente', 'F', 50);

INSERT INTO SUBJECTS(
    int_student_id,
    int_teacher_id,    
    var_name,
    int_vu,
    cha_section
) VALUES
    (1, 2, 'General History', 4, '1100'),
    (2, 2, 'General History', 4, '1100'),
    (3, 2, 'General History', 4, '1100'),
    (4, 2, 'General History', 4, '1100'),
    (5, 1, 'Biology', 5, '1300'),
    (6, 1, 'Biology', 5, '1300'),
    (7, 1, 'Biology', 5, '1300'),
    (8, 3, 'Math', 5, '1000'),
    (9, 3, 'Math', 5, '1000'),
    (10, 3, 'Math', 5, '1000'),
    (1, 4, 'Physics', 5, '1200'),
    (2, 4, 'Physics', 5, '1200'),
    (3, 4, 'Physics', 5, '1200'),
    (4, 5, 'Music Apreciation', 4, '0700'),
    (5, 5, 'Music Apreciation', 4, '0700'),
    (6, 5, 'Music Apreciation', 4, '0700'),
    (7, 5, 'Music Apreciation', 4, '0700'),
    (8, 6, 'Spanish', 4, '1800'),
    (9, 6, 'Spanish', 4, '1800'),
    (10, 6, 'Spanish', 4, '1800'),
    (1, 6, 'Spanish', 4, '1800'),
    (2, 7, 'Science', 5, '0800'),
    (3, 7, 'Science', 5, '0800'),
    (4, 7, 'Science', 5, '0800'),
    (5, 8, 'Physic Education', 3, '0900'),
    (6, 8, 'Physic Education', 3, '0900'),
    (7, 8, 'Physic Education', 3, '0900'),
    (8, 8, 'Physic Education', 3, '0900'),
    (9, 1, 'Biology', 5, '1300'),
    (10, 1, 'Biology', 5, '1300'),
    (1, 1, 'Biology', 5, '1300'),
    (5, 2, 'General History', 4, '1100'),
    (6, 2, 'General History', 4, '1100'),
    (7, 2, 'General History', 4, '1100'),
    (8, 2, 'General History', 4, '1100'),
    (1, 8, 'Physic Education', 3, '0900'),
    (2, 8, 'Physic Education', 3, '0900'),
    (3, 8, 'Physic Education', 3, '0900'),
    (4, 8, 'Physic Education', 3, '0900'),
    (1, 6, 'Spanish', 4, '1800'),
    (2, 6, 'Spanish', 4, '1800'),
    (3, 6, 'Spanish', 4, '1800'),
    (5, 2, 'General History', 4, '1100'),
    (6, 2, 'General History', 4, '1100'),
    (7, 2, 'General History', 4, '1100'),
    (8, 2, 'General History', 4, '1100'),
    (7, 4, 'Physics', 5, '1200'),
    (8, 4, 'Physics', 5, '1200'),
    (9, 4, 'Physics', 5, '1200'),
    (1, 5, 'Music Apreciation', 4, '0700'),
    (2, 5, 'Music Apreciation', 4, '0700'),
    (3, 5, 'Music Apreciation', 4, '0700'),
    (10, 5, 'Music Apreciation', 4, '0700'),
    (5, 6, 'Spanish', 4, '1800'),
    (6, 6, 'Spanish', 4, '1800'),
    (7, 6, 'Spanish', 4, '1800');

SELECT STU.id 'ID', 
        (SELECT COUNT(*) FROM SUBJECTS WHERE SUBJECTS.int_student_id = STU.id) AS 'SIGNATURES'
    FROM SUBJECTS SUB, STUDENT STU
    WHERE SUB.id = STU.id
    ;

SELECT TEA.id 'ID', 
        (SELECT COUNT(*) FROM SUBJECTS WHERE SUBJECTS.int_teacher_id = TEA.id) AS 'SIGNATURES'
    FROM SUBJECTS SUB, TEACHER TEA
    WHERE SUB.id = TEA.id
    ;

SELECT (SELECT COUNT(*) FROM SUBJECTS)/(SELECT COUNT(*) FROM STUDENT) 'AVG CLASS PER STUDENT';


SELECT (SELECT COUNT(*) FROM SUBJECTS)/(SELECT COUNT(*) FROM TEACHER) 'AVG CLASS PER TEACHER';

SELECT AVG(SIGNATURES) AS 'AVG CLASS PER STUDENT'
    FROM (SELECT STU.id 'ID', 
        (SELECT COUNT(*) int_student_id FROM SUBJECTS WHERE SUBJECTS.int_student_id = STU.id) AS 'SIGNATURES'
        FROM SUBJECTS SUB, STUDENT STU
        WHERE SUB.id = STU.id    
    ) AS T;

SELECT AVG(SIGNATURES) AS 'AVG CLASS PER TEACHER'
    FROM(SELECT TEA.id 'ID', 
        (SELECT COUNT(*) FROM SUBJECTS WHERE SUBJECTS.int_teacher_id = TEA.id) AS 'SIGNATURES'
        FROM SUBJECTS SUB, TEACHER TEA
        WHERE SUB.id = TEA.id
    ) AS T;

SELECT AVG(SIGNATURES_PER_STUDENT) 
    FROM (SELECT COUNT(*) 'SIGNATURES_PER_STUDENT'
        FROM SUBJECTS
        GROUP BY int_student_id) AS T;

SELECT AVG(SIGNATURES_PER_TEACHER)
    FROM (SELECT COUNT(*) 'SIGNATURES_PER_TEACHER'
        FROM SUBJECTS
        GROUP BY int_teacher_id) AS T;
