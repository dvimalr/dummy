CREATE OR REPLACE PROCEDURE merge_tables()
LANGUAGE plpgsql AS $$
BEGIN
    -- Drop the merged_table if it already exists
    DROP TABLE IF EXISTS merged_table;

    -- Create the merged_table
    CREATE TABLE merged_table AS
    SELECT 
        t1.id AS table1_id,
        t1.name,
        t2.description
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.id = t2.table1_id;

    RAISE NOTICE 'Tables merged successfully!';
END;
$$;
