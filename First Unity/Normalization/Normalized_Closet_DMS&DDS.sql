-- author: @lyraNoMilo_19
-- date: October 19, 2020

DROP DATABASE IF EXISTS ClosetDB;

CREATE DATABASE ClosetDB;

USE ClosetDB;

CREATE TABLE Country(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_name VARCHAR(25) NOT NULL,
    tex_continent VARCHAR(25) NOT NULL
);

CREATE TABLE ClosetDimensions(
    id INT AUTO_INCREMENT PRIMARY KEY,
    flo_height FLOAT NOT NULL,
    flo_width FLOAT NOT NULL,
    flo_depth FLOAT NOT NULL
);

CREATE TABLE ClosetMaterial(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_name VARCHAR(15) NOT NULL
);

CREATE TABLE ClosetBuilder(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_country INT NOT NULL,
    tex_name VARCHAR(25) NOT NULL,

    FOREIGN KEY (id_country)
        REFERENCES Country(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Closet(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_dimensions INT NOT NULL,
    id_builder INT NOT NULL,
    id_material INT NOT NULL,
    tex_description VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_dimensions)
        REFERENCES ClosetDimensions(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_builder)
        REFERENCES ClosetBuilder(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_material)
        REFERENCES ClosetMaterial(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);

CREATE TABLE ClotheType(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_type VARCHAR(30) NOT NULL
);

CREATE TABLE ClotheSize(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_size VARCHAR(25) NOT NULL,

    CHECK (tex_size IN ('XS','S','M','L','XL'))
    
);

CREATE TABLE ClotheGender(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_gender VARCHAR(25) NOT NULL,

    CHECK (tex_gender IN ('M','F','U'))
);

CREATE TABLE ClotheAge(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_age VARCHAR(25) NOT NULL,

    CHECK (tex_age IN ('kid','teen','adult'))
);

CREATE TABLE ClotheMaterial(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tex_material VARCHAR(15) NOT NULL
);

CREATE TABLE ClotheBrand(

    id INT AUTO_INCREMENT PRIMARY KEY,
    id_country INT NOT NULL,
    tex_name VARCHAR(25) NOT NULL,

    FOREIGN KEY (id_country)
        REFERENCES Country(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);

CREATE TABLE Clothes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_closet INT NOT NULL,
    id_type INT NOT NULL,
    id_size INT NOT NULL,
    id_gender INT NOT NULL,
    id_age INT NOT NULL,
    id_brand INT NOT NULL,
    id_material INT NOT NULL,
    tex_description VARCHAR(50) NOT NULL,

    FOREIGN KEY (id_closet)
        REFERENCES Closet(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_type)
        REFERENCES ClotheType(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_size)
        REFERENCES ClotheSize(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    FOREIGN KEY (id_gender)
        REFERENCES ClotheSize(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_age)
        REFERENCES ClotheAge(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,    

    FOREIGN KEY (id_brand)
        REFERENCES ClotheBrand(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_size)
        REFERENCES ClotheSize(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Country(tex_name, tex_continent) 
    VALUES ('Germany','Europe'),('Japan','Asia'),('Brazil','South America'),('US','North America'),('Australia','Oceania'),('Italy','Europe'),('Spain','Europe'),('France','Europe');

INSERT INTO ClosetDimensions(flo_height, flo_width, flo_depth) 
    VALUES (2.5, 1, 2), (3, 1.5, 2), (2.5, 1.5, 1.5);

INSERT INTO ClosetBuilder(id_country, tex_name) 
    VALUES (1,'Gute Weke Inc.'),(2,'Gutto Woruko Inc.'),(3, 'Bom Trabalho Inc.'),(4, 'Good works Inc.');

INSERT INTO ClosetMaterial(tex_name) VALUES ('Mahogany'),('Fir'),('Birch'),('Oak');

INSERT INTO ClotheType(tex_type) 
    VALUES ('shirt'),('jeans'),('sweater'),('blouse'),('dress'),('pants');

INSERT INTO ClotheSize(tex_size) VALUES ('XS'),('S'),('M'),('L'),('XL');

INSERT INTO ClotheGender(tex_gender) VALUES ('M'),('F'),('U');

INSERT INTO ClotheAge(tex_age) VALUES ('kids'),('teen'),('adult');

INSERT INTO ClotheBrand(id_country, tex_name) 
    VALUES (7, 'Zara'),(6, 'Gucci'),(4, 'Nike'),(1, 'Adidas'),(4,'Ralph Lauren'),(8,'Lacoste');

INSERT INTO ClotheMaterial(tex_material) VALUES ('Cloth'),('Wool'),('Polyester'),('leather');

INSERT INTO Closet(id_dimensions, id_builder, id_material, tex_description)
    VALUES (1, 2, 4, 'Big Oak Closet'), (3, 3, 1, 'Pretty Mahogany Closet'),
            (2, 4, 2, 'Traditional Birch Closet');

INSERT INTO Clothes(id_closet, id_type, id_size, id_gender, id_age, id_brand, id_material, tex_description)
    VALUES
    (1, 3, 2, 1, 2, 1, 4, 'Leather Jacket for young boys'), 
    (2, 5, 3, 2, 2, 2, 1, 'Pretty dress'),
    (3, 4, 2, 2, 3, 1, 2, 'Casual Blouses for young women'), 
    (1, 2, 4, 1, 3, 5, 1, 'Casual Jeans'),
    (1, 2, 3, 2, 2, 6, 2, 'Nice wool pants for ladies'), 
    (1, 3, 2, 3, 2, 3, 3, 'Sport Sweaters'),
    (1, 1, 5, 1, 2, 6, 1, 'Big pants for big bois'), 
    (1, 2, 3, 2, 2, 5, 3, 'Jeans for ladies'),
    (1, 4, 3, 2, 3, 2, 1, 'Casual Sweater for ladies'),
    (1, 1, 3, 1, 1, 1, 3, 'Shirts for little kids'),
    (1, 5, 2, 2, 1, 1, 1, 'Dresses for little girls'),
    (1, 3, 2, 2, 1, 5, 1, 'Jeans for little girls');

SELECT ty.tex_type 'Type', si.tex_size 'Size', ge.tex_gender 'Gender', ag.tex_age 'Age', br.tex_name 'Brand', ma.tex_material 'Material', cl.tex_description 'Description'
    FROM ClotheType ty JOIN ClotheSize si JOIN ClotheGender ge JOIN ClotheAge ag JOIN ClotheBrand br JOIN ClotheMaterial ma JOIN Clothes cl
    WHERE
        ty.id = cl.id_type AND
        si.id = cl.id_size AND
        ge.id = cl.id_gender AND 
        ag.id = cl.id_age AND
        br.id = cl.id_brand AND
        ma.id = cl.id_material;

-- Show the amount of each type of stored clothes.        
SELECT T.`Type`, COUNT(Type) 'Type Count'
    FROM (SELECT ty.tex_type 'Type', si.tex_size 'Size', ge.tex_gender 'Gender', ag.tex_age 'Age', br.tex_name 'Brand', ma.tex_material 'Material', cl.tex_description 'Description'
    FROM ClotheType ty JOIN ClotheSize si JOIN ClotheGender ge JOIN ClotheAge ag JOIN ClotheBrand br JOIN ClotheMaterial ma JOIN Clothes cl
    WHERE
        ty.id = cl.id_type AND
        si.id = cl.id_size AND
        ge.id = cl.id_gender AND 
        ag.id = cl.id_age AND
        br.id = cl.id_brand AND
        ma.id = cl.id_material) AS T
    GROUP BY T.`Type`;

SELECT T.`Type`, COUNT(Type) 'Type Count'
    FROM (SELECT ty.tex_type 'Type', cl.tex_description 'Description'
    FROM ClotheType ty JOIN Clothes cl
    WHERE
        ty.id = cl.id_type) AS T
    GROUP BY T.`Type`;

-- Total amount of types stored.
SELECT COUNT(DISTINCT Type) 'Type Count'
    FROM (SELECT ty.tex_type 'Type', cl.tex_description 'Description'
    FROM ClotheType ty JOIN Clothes cl
    WHERE
        ty.id = cl.id_type) AS T
    ;


    

