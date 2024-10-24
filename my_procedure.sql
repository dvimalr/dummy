-- Table 1: customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- Table 2: orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    amount DECIMAL(10, 2)
);

-- Create a new table to hold merged data
CREATE TABLE customer_order_summary (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    total_amount DECIMAL(10, 2)
);

-- Procedure to merge the customers and orders tables and call the merge automatically
CREATE OR REPLACE PROCEDURE merge_customers_and_orders()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Clear the customer_order_summary table
    TRUNCATE TABLE customer_order_summary;

    -- Merge customers and orders data into customer_order_summary
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

    -- After merging, call the procedure itself (optional if required)
    PERFORM merge_customers_and_orders();

END;
$$;

-- Call the procedure immediately after defining it
CALL merge_customers_and_orders();
