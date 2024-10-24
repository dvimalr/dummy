DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customer_order_summary CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date DATE,
    amount DECIMAL(10, 2)
);

CREATE TABLE customer_order_summary (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    total_amount DECIMAL(10, 2)
);

CREATE OR REPLACE PROCEDURE merge_customers_and_orders()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE customer_order_summary;

    INSERT INTO customer_order_summary (customer_id, first_name, last_name, email, total_amount)
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        COALESCE(SUM(o.amount), 0) AS total_amount
    FROM 
        customers c
    LEFT JOIN 
        orders o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name, c.email;

END;
$$;

CALL merge_customers_and_orders();

INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com');

INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2024-01-10', 100.50),
(1, '2024-02-15', 250.00),
(2, '2024-01-22', 300.75);

CALL merge_customers_and_orders();

SELECT * FROM customer_order_summary;
