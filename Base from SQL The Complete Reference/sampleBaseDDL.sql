

-- We create de Database if it does not exists

    CREATE TABLE IF NOT EXISTS orders (
        order_num INT PRIMARY KEY NOT NULL,
        cust INT NOT NULL,
        product VARCHAR(200) NOT NULL,
        qty INT NOT NULL,
        amount DECIMAL(10,2) NOT NULL,        
    );

    CREATE TABLE IF NOT EXISTS customers(
        cust_num INT PRIMARY KEY NOT NULL,
        company VARCHAR(200) NOT NULL,
        cust_rep INT NOT NULL,
        credit_limit DECIMAL(10,2) NOT NULL
    );

    CREATE TABLE IF NO EXISTS salesreps(
        sale_name VARCHAR(200) NOT NULL,
        rep_office VARCHAR(200),
        quota DECIMAL(10,2) NOT NULL,
        sales DECIMAL(10,2) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS offices(
        office_num INT PRIMARY KEY NOT NULL,
        city VARCHAR(200) NOT NULL,
        region VARCHAR(200) NOT NULL,
        otarget DECIMAL(10,2),
        sales DECIMAL(10,2) NOT NULL
    );

-- 