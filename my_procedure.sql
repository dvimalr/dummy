-- scripts/init.sql

CREATE TABLE IF NOT EXISTS table1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS table2 (
    id SERIAL PRIMARY KEY,
    table1_id INTEGER REFERENCES table1(id),
    description TEXT
);

-- Insert sample data into table1
INSERT INTO table1 (name) VALUES 
('Item A'), 
('Item B'), 
('Item C');

-- Insert sample data into table2
INSERT INTO table2 (table1_id, description) VALUES 
(1, 'Description for Item A'), 
(1, 'Another Description for Item A'),
(2, 'Description for Item B'), 
(3, 'Description for Item C');


-- my_procedure.sql

CREATE OR REPLACE PROCEDURE merge_tables()
LANGUAGE plpgsql AS $$
BEGIN
    -- Create a new table to store the merged results
    CREATE TABLE IF NOT EXISTS merged_table AS
    SELECT 
        t1.id AS table1_id,
        t1.name AS item_name,
        t2.id AS table2_id,
        t2.description
    FROM 
        table1 t1
    LEFT JOIN 
        table2 t2 ON t1.id = t2.table1_id; -- Assuming table2 has a foreign key reference to table1

    RAISE NOTICE 'Tables merged successfully!';
END;
$$;
