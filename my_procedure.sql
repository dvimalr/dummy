-- Create the merged_table if it doesn't already exist
CREATE TABLE IF NOT EXISTS merged_table (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(50),
    user_age INT,
    user_email VARCHAR(100),
    product_name VARCHAR(100),
    product_price DECIMAL(10, 2),
    product_quantity INT
);

-- Create the procedure function to merge tables
CREATE OR REPLACE FUNCTION merge_tables()
RETURNS VOID AS $$
BEGIN
    -- Clear the merged_table before inserting new data
    TRUNCATE TABLE merged_table;

    -- Insert merged data into merged_table
    INSERT INTO merged_table (user_name, user_age, user_email, product_name, product_price, product_quantity)
    SELECT e.name, e.age, e.email, p.product_name, p.price, p.quantity
    FROM example_table e
    JOIN product_table p ON e.id % 50 = p.product_id % 50;  -- Adjust join condition as needed
END;
$$ LANGUAGE plpgsql;

-- Call the function to merge tables
CALL merge_tables();
