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
