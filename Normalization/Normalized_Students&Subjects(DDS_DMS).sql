-- @author: lyraNoMilo_19
-- @date: October 15, 2020.

DROP DATABASE IF EXISTS COLLEGE;

CREATE DATABASE COLLEGE CHARACTER SET utf8;

USE COLLEGE;

CREATE TABLE Person(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    var_fname VARCHAR(25) NOT NULL,
    var_lname VARCHAR(25),
    var_flname VARCHAR(25) NOT NULL,
    var_slname VARCHAR(25),    
    enu_gender ENUM('F','M')
    dat_birthdate DATE,
    int_age (SELECT YEAR(NOW()) - YEAR(dat_birthdate)),
);

CREATE TABLE Student(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_person INT NOT NULL,
    int_semester INT NOT NULL,
    int_year INT NOT NULL,

    CHECK (int_semester IN (1,2,3)),

    FOREIGN KEY id_person
    REFERENCES Person(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Teacher(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_person INT NOT NULL,
    var_mail VARCHAR(30) NOT NULL,
    cha_startyear CHAR(4) NOT NULL,

    FOREIGN KEY id_person
    REFERENCES Person(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE    
);

CREATE TABLE Subjects(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    var_name VARCHAR(50) NOT NULL,
    int_vu INT NOT NULL   
    
);

/*
    - General History
    - Biology
    - Math
    - Physics
    - Music Appreciation
    - Spanish
    - Science
    - Physic Education
*/

INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('General History', 4);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Biology', 4);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Math', 5);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Physics', 5);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Music Appreciation', 3);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Spanish', 4);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Sciense', 5);
INSERT INTO Subjects(var_name, int_vu, var_section) VALUES ('Physic', 3);


CREATE TABLE GeneralHystoryStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 1,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE BiologyStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 2,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE MathStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 3,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PhysicsStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 4,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE MusicAppreciationStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 5,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE SpanishStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 6,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE ScienceStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 7,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PhysicEducationStudents(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_student INT NOT NULL,
    id_subject INT DEFAULT 8,    

    FOREIGN KEY id_student
    REFERENCES Student(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE GeneralHystoryTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 1,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE BiologyTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 2,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE MathTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 3,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PhysicsTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 4,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE MusicAppreciationTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 5,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE SpanishTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 6,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE ScienceTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 7,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PhysicEducationTeachers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_teacher INT NOT NULL,
    id_subject INT DEFAULT 8,    

    FOREIGN KEY id_teacher
    REFERENCES Teacher(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY id_subject
    REFERENCES Subjects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Person(
    var_fname,
    var_lname,
    var_flname,
    var_slname,    
    enu_gender
    dat_birthdate    
) VALUES 
    ('Leon', 'Scott', 'Kennedy', 'Sánchez', 'M', '1999-11-19'),
    ('Koichi', 'Gerardo', 'Horise', 'Aviléz', 'M', '1998-06-28'),
    ('Josuke', 'Mauricio', 'Higashigata', 'Ortez', 'M', '1999-07-18'),
    ('Melanie', 'Roberta', 'Martínez', 'Stiller', 'F', '1990-01-20'),
    ('Ada', 'Giorgina', 'Wong', 'Sagastume', 'F', '1991-05-15'),
    ('Carlos', 'Roberto', 'Sosa', 'Amador', 'M', '1989-04-13'),
    ('Emilio', 'Ricardo', 'Vallecillo', 'López', 'M', '1995-06-17'),
    ('Carlos', 'Fernando', 'Sosa', 'Ramos', 'M', '1998-09-13'),
    ('Fernanda', 'Axel', 'Villalvir', 'Flores', 'F', '1994-08-28'),
    ('Lourdes', 'Amparo', 'Amador', 'Amador', 'F', '1998-03-20'),

    ('Jotaro', 'Sebastián', 'Kujo', 'Sosa', 'M', '1970-10-31'),
    ('Erina', 'Evelyn', 'Joestar', 'Martínez', 'F', '1975-11-12'),
    ('Suzie', 'María', 'Q.', 'Sosa', 'F', '1960-11-16'),
    ('Lisa', 'Lisa', 'Joestar', 'Marsh', 'F', '1971-12-30'),
    ('José', 'Eduardo', 'Matute', 'Ortez', 'M', '1989-10-17'),
    ('Jennifer', 'Guadalupe', 'Obando', 'Ortez', 'F', '1988-07-06'),
    ('Jose', 'María', 'Calderón', 'Sosa', 'F', '1965-10-15'),
    ('Rita', 'Fernanda', 'Ramirez', 'Vicente', 'F', '1969-12-01');

INSERT INTO Student(id_person, int_semester, int_year) VALUES
    (1, 2, 2), (2, 2, 3), (3, 2, 3), (4, 2, 5), (5, 2, 6), (6, 2, 3), (7, 2, 2), (8, 2, 7),
    (17, 2, 3), (18, 2, 6);

INSERT INTO Teacher(id_person, var_mail, cha_startyear) VALUES
    (9, 'holi@gmail.com', '2010'), (10, 'jiji@gmail.com', '2009'),
    (11, 'wassaa@gmail.com', '2015'), (12, 'mymail@gmail.com', '2011'),
    (13, 'watamericopsu@yahoo.com', '2020'), (14, 'jasjjs@gmail.com', '2012'),
    (15, 'jojo@unah.hn', '2017'), (16, 'isdasd@gmail.com', '2014');

/*
    - General History
    - Biology
    - Math
    - Physics
    - Music Appreciation
    - Spanish
    - Science
    - Physic Education
*/

INSERT INTO GeneralHystoryTeachers(id_teacher) VALUES (1);
INSERT INTO BiologyTeachersTeachers(id_teacher) VALUES (2);
INSERT INTO MathTeachers(id_teacher) VALUES (3);
INSERT INTO PhysicsTeachers(id_teacher) VALUES (4);
INSERT INTO MusicAppreciationTeachers(id_teacher) VALUES (5);
INSERT INTO SpanishTeachers(id_teacher) VALUES (6);
INSERT INTO ScienceTeachers(id_teacher) VALUES (7);
INSERT INTO PhysicEducationTeachers(id_teacher) VALUES (8);

INSERT INTO GeneralHystoryStudents(id_student) VALUES (1),(3),(4),(5),(8), (9);
INSERT INTO BiologyStudents(id_student) VALUES (2),(1),(7),(8),(6),(10),(9);
INSERT INTO MathStudents(id_student) VALUES (3),(2),(5),(7),(4),(10);
INSERT INTO PhysicsStudents(id_student) VALUES (4),(5),(1),(6),(8),(9);
INSERT INTO MusicAppreciationStudents(id_student) VALUES (5),(2),(6),(5),(8),(10),(9);
INSERT INTO SpanishStudents(id_student) VALUES (6),(1),(2),(3),(7),(9);
INSERT INTO ScienceStudents(id_student) VALUES (7),(3),(1),(6),(5),(10);
INSERT INTO PhysicEducationStudents(id_student) VALUES (8),(7),(5),(3),(4),(10);




