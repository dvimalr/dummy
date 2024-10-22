-- File: dummy_procedure.sql

-- Create a dummy table if it doesn't exist
CREATE TABLE IF NOT EXISTS dummy_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Define a procedure to insert a record into the dummy table
CREATE OR REPLACE PROCEDURE insert_dummy_record(IN input_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert a new record with the provided name
    INSERT INTO dummy_table (name)
    VALUES (input_name);

    -- Optionally, print a message
    RAISE NOTICE 'Record inserted with name: %', input_name;
END;
$$;

-- Call the procedure with a dummy name (optional; can be done via Python code as well)
CALL insert_dummy_record('TestName');
