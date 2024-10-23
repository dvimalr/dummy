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
CREATE OR REPLACE PROCEDURE merge_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Perform the merge operation
    PERFORM * FROM (
        SELECT id, name FROM table1
        UNION ALL
        SELECT id, name FROM table2
    ) AS merged_table;
END;
$$;
