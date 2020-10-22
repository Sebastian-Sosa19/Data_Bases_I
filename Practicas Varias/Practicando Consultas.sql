-- @author: lyraNoMilo_19
-- @date: September 29, 2020.

-- Practicando consultas varias.

-- Base: BDEnterprise.
-- Consulta que devuelve el número de Tareas de cada usuario.
-- Obervaciones: ¿Por qué debo especificar un DISTINCT o de lo contrario me devuelve filas clonadas? ¿Cómo se influyen las clausulas WHERE y ON entre sí?
-- Saber que: la subconsulta devuelve un valor por la función agregada.
-- Captura: 001

SELECT DISTINCT Usuario.nombre_us AS "Usuarios", 
        (SELECT COUNT(*) FROM Tarea JOIN Lista ON Tarea.id_ls = Lista.id WHERE Lista.id_us = Usuario.id) AS "Tareas" 
    FROM Tarea JOIN Lista JOIN Usuario 
    ON Tarea.id_ls = Lista.id AND Lista.id_us = Usuario.id;

-- Base: BDSample.
-- Query to retrieve the number of companies that have a credit limit greater than 40000.00
-- All Good.
-- Capture : 002

SELECT COUNT(CUSTOMERS.COMPANY) AS 'COMPANIES WITH MORE THAN 40000' 
    FROM CUSTOMERS 
    WHERE CUSTOMERS.CREDIT_LIMIT > 40000;

-- Base: BDSample.
-- Rretrieve the products from Orders and count how many orders they belong to.
-- We can refer to different instances for the same table. The PRO alias goes by all of the elements in the table. Meanwhile, the ORD alias goes counting the elements in the subquery. So, for the nth PRO.PRODUCT, the subquery will count the all of the ORD.PRODUCT that match the PRO.PRODUCT.
-- Capture : 003

SELECT DISTINCT PRO.PRODUCT, 
        (SELECT DISTINCT COUNT(ORD.PRODUCT) FROM ORDERS ORD WHERE PRO.PRODUCT = ORD.PRODUCT) AS 'PRODUCT ORDERS AMOUNT'
    FROM ORDERS PRO;
    
-- Base DBSample
-- Show the names and total outstanding orders of customers with credit limits over 50000
-- The JOIN and ON in the main part of the query act in the general results. It's important to define here the general values that the query gotta match. Subquery, on it's part, puts condition ONLY IN THE COLUMN WHERE IT'S PLACED.
-- Capture : 004

SELECT DISTINCT CST.COMPANY, 
        (SELECT COUNT(ORD.CUST) FROM ORDERS ORD WHERE ORD.CUST = CST.CUST_NUM) AS 'TOTAL ORDERS'
    FROM CUSTOMERS CST JOIN ORDERS ORD
    ON CST.CUST_NUM = ORD.CUST AND CST.CREDIT_LIMIT > 50000;

-- Show the names of salesreps and their managers.
-- In this example, the table SALESREPS is referenced by to aliases of itself, EMP for selecting the employee's manager, and MGR for matching the manager's employee number.
-- Capture 005

SELECT EMP.NAME 'EMPLOYEE', MGR.NAME 'MANAGER'
    FROM SALESREPS EMP, SALESREPS MGR
    WHERE EMP.MANAGER = MGR.EMPL_NUM;

-- List the salespeople who have taken an order that represents more than 10 percent of their quota.
-- Here are two ways of making this query. The first one uses basic clauses. The second one, uses the ANY clause, wich returns the values that match the condition in the previous where clause.
-- Capture 006

SELECT SLP.NAME 'SALES PEOPLE WITH ORDERS GREATER THAN 10% QUOTA'
    FROM SALESREPS SLP, ORDERS ORD
    WHERE SLP.EMPL_NUM = ORD.REP AND ORD.AMOUNT > ((SLP.QUOTA)*0.10);

SELECT SLP.NAME 'NAME'
    FROM SALESREPS SLP
    WHERE (.1 * SLP.QUOTA) < ANY (SELECT AMOUNT FROM ORDERS WHERE REP = EMPL_NUM);

-- Retrieve the range of assigned quotas in each office.
-- Relating two tables and matching it's necessary values. Using JOIN and ON clause for the condition in the tables union. And finally using GRUOUP BY clause. Not much left to say.
-- Capture 007

SELECT CTY.CITY 'OFFICE', MIN(RPS.QUOTA) 'MIN QUOTA', MAX(RPS.QUOTA) 'MAX QUOTA'
    FROM SALESREPS RPS JOIN OFFICES CTY
    ON RPS.REP_OFFICE = CTY.OFFICE
    GROUP BY REP_OFFICE;

-- Show how many sales people are signed to each office.
-- Here are two forms of making this query. The first one uses a subquery in its third column, which will return the number of employees in each OFC.CITY. The second one uses an aggregated funcion, counts every element in REPSALES that match the WHERE clause.
-- Capture 008

SELECT DISTINCT OFC.CITY 'OFFICE', SLP.REP_OFFICE 'OFFICE CODE',
    (SELECT COUNT(SLP.EMPL_NUM) FROM SALESREPS SLP WHERE OFC.OFFICE = SLP.REP_OFFICE) AS 'NUMBER OF EMPLOYEES'
    FROM OFFICES OFC JOIN SALESREPS SLP    
    ON OFC.OFFICE = SLP.REP_OFFICE;

SELECT OFC.CITY AS 'CITY', REP_OFFICE AS 'OFFICE CODE', COUNT(*) AS 'PEOPLE SIGNED'
    FROM SALESREPS, OFFICES OFC
    WHERE OFC.OFFICE = SALESREPS.REP_OFFICE
    GROUP BY REP_OFFICE;

-- Retrieve all the orders from year 2007.
-- We use the BETWEEN clause in the WHERE clause so we can specify the major and lower bounds so the filter can find the register dates from year 2007.
-- Capture 009
SELECT ORD.ORDER_NUM 'ORDER'
    FROM ORDERS ORD
    WHERE ORD.ORDER_DATE BETWEEN '2007-01-01' AND '2007-12-31';

/*
    Base: BDSample
    Retrieve the quantity of orders per product in the ORDERS table with the product's description.
    We simply count the products matching with each PRODUCT_ID with a subquery.
    Capture : 010

*/

SELECT PRO.DESCRIPTION 'DESCRIPTION', 
        (SELECT COUNT(PRODUCT) FROM ORDERS WHERE PRODUCT = PRO.PRODUCT_ID) 'TIMES ORDERED'
    FROM PRODUCTS PRO;

SELECT COUNT(*) 
    FROM ORDERS
    GROUP BY PRODUCT;

/*
    Retrieve the average sales per client ordering from max to min.
    AVG Function receives a specific column always.
    In this case, we specify we want the AMOUNT average, and all of these averages must be grouped by CUST codes. To include companies names we must asure that customers CUST_NUM match the CUST in orders, that way every average value can go along with each company name.
    Capture : 011

*/

SELECT CUS.COMPANY, AVG(AMOUNT)
    FROM ORDERS JOIN CUSTOMERS CUS
    ON ORDERS.CUST = CUS.CUST_NUM
    GROUP BY CUST
    ORDER BY AVG(AMOUNT) DESC;

/*
    Retrieve the max amount of each customer in an order.
    Same idea as the previous query.
    Capture : 012
*/

SELECT CUS.COMPANY, MAX(AMOUNT)
    FROM ORDERS JOIN CUSTOMERS CUS
    ON ORDERS.CUST = CUS.CUST_NUM
    GROUP BY CUST
    ORDER BY MAX(AMOUNT) DESC;

/* 
    Create a new user named Lynda, grant only Insert and Delete privileges for all databases, with password notLynda.
*/

CREATE USER 'lynda'@'localhost' IDENTIFIED BY 'notlynda';

GRANT INSERT, DELETE ON *.* TO 'lynda'@'localhost';

/*
    Give Lynda all privileges on all tables.
*/

GRANT ALL PRIVILEGES ON *.* TO 'lynda'@'localhost';

/*
    Take away all of Lynda's privileges.
*/

REVOKE ALL PRIVILEGES ON *.* TO 'lynda'@'localhost';

/*
    Get rid of Lynda user.
*/

DROP USER 'lynda'@'localhost';

/*
    Retrieve the average amount of orders per each customer with sellers in New York, Chicago and Atlanta Offices.
    We made a sub query to retrieve the salesreps from the specified offices, then we just inserted that sub query as a table in the from clause of the main query, and matching the corresponing attributes.
    I must remember everytime I make a JOIN clause the ON condition must be made in order to relate the three tables in a specific rule.
    Capture : 013

*/

SELECT EMP.EMPL_NUM 'EMPLOYEE' 
    FROM SALESREPS EMP JOIN OFFICES
    ON EMP.REP_OFFICE = OFFICES.OFFICE
    WHERE OFFICES.OFFICE IN (11, 12, 13);

SELECT CUST.COMPANY 'CUSTOMER', AVG(ORDERS.AMOUNT)
    FROM CUSTOMERS CUST JOIN ORDERS JOIN
        (SELECT EMP.EMPL_NUM EMPLOYEE
        FROM SALESREPS EMP JOIN OFFICES
        ON EMP.REP_OFFICE = OFFICES.OFFICE
        WHERE OFFICES.OFFICE IN (11, 12, 13)) AS SELLERS
    ON ORDERS.REP = SELLERS.`EMPLOYEE` AND
        ORDERS.CUST = CUST.CUST_NUM
    GROUP BY CUST.COMPANY;

/*
    Retrieve all the customers whose average amount is greater than their credit limit, and also whose employee's sales are greater than their quota.
    We first make two queries to construct the tables due the conditions for the main query. Then we just join them along with ORDERS and CUSTOMERS to make the correct matches in the main query.
    Capture : 014
*/

SELECT CUST.CUST_NUM 'CUST_ID', AVG(ORD.AMOUNT) 'AVG'
    FROM ORDERS ORD JOIN CUSTOMERS CUST
    ON ORD.CUST = CUST.CUST_NUM
    WHERE ORD.AMOUNT > CUST.CREDIT_LIMIT
    GROUP BY CUST.CUST_NUM;

SELECT EMPL_NUM 
    FROM SALESREPS
    WHERE SALES > QUOTA;

SELECT CUST.COMPANY 'COMPANY', AVERAGE.`AVG`
    FROM CUSTOMERS CUST JOIN ORDERS ORDR JOIN
        (SELECT CUST.CUST_NUM 'CUST_ID', AVG(ORD.AMOUNT) 'AVG'
            FROM ORDERS ORD JOIN CUSTOMERS CUST
            ON ORD.CUST = CUST.CUST_NUM
            WHERE ORD.AMOUNT > CUST.CREDIT_LIMIT
            GROUP BY CUST.CUST_NUM) AVERAGE JOIN
        (SELECT EMPL_NUM 'EMPLOYEE'
            FROM SALESREPS
            WHERE SALES > QUOTA) AS EMPLOYEES
    ON CUST.CUST_NUM = AVERAGE.`CUST_ID` AND CUST.CUST_NUM = ORDR.CUST AND ORDR.REP = EMPLOYEES.`EMPLOYEE`;

/*
    Retrieve the number of orders assigned to each employee, also the average amount of their respective orders.
    Here are three ways for resolving this query.
    In the first one, the subquery returns a value in the select list, a value that must match the employee number in the same select list, and must be grouped by the same value. In the second one, we use two subqueries in the from clause, one that retrieves the number of customers per employee, and other that retrieves the average amount for the sum of all the customers of each employees. The last one is a lighter form of the second one, since we don't complicate too much in the first subquery.
    Cap: 015
*/

SELECT EMP.EMPL_NUM 'EMPLOYEE', COUNT(ORD.CUST) 'ORDERS', (SELECT AVG(FORD.AMOUNT) 'AVG_AMOUNT'
        FROM ORDERS FORD
        WHERE FORD.REP = EMP.EMPL_NUM
        GROUP BY FORD.REP) 'AVG'
    FROM SALESREPS EMP JOIN ORDERS ORD
    ON EMP.EMPL_NUM = ORD.REP
    GROUP BY EMP.EMPL_NUM;

SELECT REPS.EMPL_NUM EMPLOYEES, AVG_AMT.`AVG_AMOUNT` AVG_AMNT, CUST_PER_EMP.`ORDERS`
    FROM SALESREPS REPS JOIN
        (SELECT EMP.EMPL_NUM 'EMPLOYEE', COUNT(ORD.CUST) 'ORDERS'
            FROM SALESREPS EMP JOIN ORDERS ORD
            ON EMP.EMPL_NUM = ORD.REP
            GROUP BY EMP.EMPL_NUM) CUST_PER_EMP JOIN
        (SELECT REP, AVG(AMOUNT) AVG_AMOUNT
            FROM ORDERS
            GROUP BY REP) AVG_AMT
    ON REPS.EMPL_NUM = AVG_AMT.`REP` AND REPS.EMPL_NUM = CUST_PER_EMP.`EMPLOYEE`;

SELECT REPS.EMPL_NUM EMPLOYEES, AVG_AMT.`AVG_AMOUNT` AVG_AMNT, CUST_PER_EMP.`ORDERS`
    FROM SALESREPS REPS JOIN
        (SELECT REP, COUNT(CUST) 'ORDERS'
            FROM ORDERS            
            GROUP BY REP) CUST_PER_EMP JOIN
        (SELECT REP, AVG(AMOUNT) AVG_AMOUNT
            FROM ORDERS
            GROUP BY REP) AVG_AMT
    ON REPS.EMPL_NUM = AVG_AMT.`REP` AND REPS.EMPL_NUM = CUST_PER_EMP.`REP`;

/*
    Repeat the last query but display the employee names.
    We must only change a single parameter in the select list.
*/
    
SELECT EMP.NAME 'EMPLOYEE', COUNT(ORD.CUST) 'ORDERS', (SELECT AVG(FORD.AMOUNT) 'AVG_AMOUNT'
        FROM ORDERS FORD
        WHERE FORD.REP = EMP.EMPL_NUM
        GROUP BY FORD.REP) 'AVG AMOUNT'
    FROM SALESREPS EMP JOIN ORDERS ORD
    ON EMP.EMPL_NUM = ORD.REP
    GROUP BY EMP.EMPL_NUM;

/*
    
*/

SELECT SALE.EMPL_NUM
    FROM SALESREPS SALE OUTER JOIN OFFICES
    ON SALE.REP_OFFICE = OFFICE;