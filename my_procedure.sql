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
CREATE OR REPLACE PROCEDURE merge_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Create a temporary table to store the merged result
    CREATE TEMP TABLE temp_merged_table AS
    SELECT id, name FROM table1
    UNION ALL
    SELECT id, name FROM table2;
END;
$$;
