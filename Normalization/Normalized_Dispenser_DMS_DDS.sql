-- @author: lyraNoMilo_19
-- @date: October 15, 2020.

-- Dispenser, Product, Sale, Receipt.

DROP DATABASE IF EXISTS DispenserSale;

CREATE DATABASE DispenserSale;

USE DispenserSale;

CREATE TABLE Dispenser(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    enu_type ENUM('wdrinks', 'cdrinks','snacks') NOT NULL DEFAULT 'cdrinks',
    var_company VARCHAR(20) NOT NULL

);

CREATE TABLE Product(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    int_dispenserId INT NOT NULL,
    var_name VARCHAR(25) NOT NULL,
    enu_type ENUM('wdrinks', 'cdrinks','snacks') NOT NULL DEFAULT 'cdrinks',
    flo_price FLOAT NOT NULL,
    int_existences INT NOT NULL, 

    CHECK (flo_price > 0),
    CHECK (int_existences > 0),

    FOREIGN KEY (int_dispenserId)
        REFERENCES Dispenser(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

);

CREATE TABLE Sale(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    int_dispenserId INT NOT NULL,
    var_header VARCHAR(25) NOT NULL DEFAULT 'Dispenser Machine Sale',
    tim_issue TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (int_dispenserId)
        REFERENCES Dispenser(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

);

CREATE TABLE Receipt(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_sale INT NOT NULL,
    id_product INT NOT NULL,
    flo_price FLOAT NOT NULL, 
    flo_tax FLOAT DEFAULT 0.15,
    flo_bill FLOAT NOT NULL,
    flo_subtotal FLOAT AS (flo_bill * flo_tax),
    flo_total FLOAT AS (flo_subtotal + flo_price),
    flo_change FLOAT AS (flo_bill - flo_total),

    CHECK (flo_bill = 1.00 OR flo_bill = 2.00 OR flo_bill = 5.00 OR flo_bill = 10.00 OR flo_bill = 20.00 OR flo_bill = 50.00 OR flo_bill = 100.00 OR flo_bill = 500.00),

    FOREIGN KEY (id_sale)
        REFERENCES Sale(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (id_product)
        REFERENCES Product(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

);

INSERT INTO Dispenser(var_company) VALUES ('Pepsi');
INSERT INTO Dispenser(enu_type, var_company) VALUES ('wdrinks', 'Nestle');

INSERT INTO Product(int_dispenserId, var_name, enu_type, flo_price, int_existences) VALUES
            (1, 'Pepsi 600 Ml', 'cdrinks', 25.00, 25),
            (1, 'Pepsi 250 Ml', 'cdrinks', 15.00, 30),
            (1, 'Mirinda Uva 600 Ml', 'cdrinks', 25.00, 20),
            (1, 'Mirinda Naranja 600 Ml', 'cdrinks', 25.00, 20),
            (1, 'AMP 600 Ml', 'cdrinks', 30.00, 15),
            (1, 'Sprite 600 Ml', 'cdrinks', 25.00, 30),
            (1, 'Sprite 250 Ml', 'cdrinks', 15.00, 25),
            (1, 'Agua Azul 600 Ml', 'cdrinks', 15.00, 40),
            (2, 'Nescafe Normal 200 Ml', 'wdrinks', 45.00, 15),
            (2, 'Capuccino 150 Ml', 'wdrinks', 60.00, 10),
            (2, 'Latte 150 Ml', 'wdrinks', 75.00, 10),
            (2, 'Nescafe Normal 400 Ml', 'wdrinks', 85.00, 15);

INSERT INTO Sale(int_dispenserId) VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1);

/*
    We've used a Stored Procedure for:
    - Extract a product's price using a single value query inside the values of the INSERT clause.
    - We've made a table update for the Product whose ID is in the receipt, this product's existence will decrease one value. Since it's a Dispenser machine, products are selled one by one.
*/

DELIMITER //
CREATE PROCEDURE createReceipt(
    sale     INT, 
    product  INT,            
    bill     FLOAT)   
    
    BEGIN    

    INSERT INTO Receipt (id_sale, id_product, flo_price, flo_bill)
        VALUES (sale, product, 
        (SELECT PRO.flo_price FROM Product PRO WHERE PRO.id = product),
        bill);

    UPDATE Product PRO
        SET PRO.int_existences = (int_existences - 1)
        WHERE PRO.id = product;    

    END//

CALL createReceipt(1,1,50.00);
CALL createReceipt(2,1,50.00);
CALL createReceipt(3,8,100.00);
CALL createReceipt(4,9,100.00);
CALL createReceipt(5,10,500.00);
CALL createReceipt(6,5,100.00);
CALL createReceipt(7,6,50.00);
CALL createReceipt(8,1,50.00);
CALL createReceipt(9,12,100.00);
CALL createReceipt(10,4,100.00);
CALL createReceipt(11,3,100.00);
CALL createReceipt(12,12,500.00);


/*
    Queries to make:
    - Generated Receipts per product per hour a day.
    - Most used Bill by customers.
*/


SELECT MAX(Bill) 'MOST USED BILL'
    FROM (SELECT COUNT(flo_bill) 'Bill'
    FROM Receipt 
    GROUP BY flo_bill) AS T
    ;


