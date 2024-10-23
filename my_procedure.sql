CREATE TEMP TABLE table1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO table1 (name) VALUES ('Alice'), ('Bob'), ('Charlie');

CREATE TEMP TABLE table2 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO table2 (name) VALUES ('David'), ('Eve'), ('Frank');

-- Procedure to merge the tables
-- Procedure to merge the tables and return the result
-- Procedure to merge the tables and insert the result into a temporary table
-- Procedure to merge the tables and insert the result into a table
-- Procedure to merge the tables and insert the result into a table
CREATE OR REPLACE PROCEDURE merge_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Create the merged table if it doesn't already exist (without primary key constraint)
    CREATE TABLE IF NOT EXISTS merged_table (
        id INT,
        name VARCHAR(50)
    );

    -- Truncate the table first to avoid duplicate inserts
    TRUNCATE TABLE merged_table;

    -- Insert merged data from table1 and table2
    INSERT INTO merged_table (id, name)
    SELECT id, name FROM table1
    UNION ALL
    SELECT id, name FROM table2;
END;
$$;


