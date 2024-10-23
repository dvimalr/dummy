-- CREATE TABLE
CREATE TABLE IF NOT EXISTS my_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PROCEDURE
CREATE OR REPLACE FUNCTION my_procedure() RETURNS VOID AS $$
BEGIN
    -- Procedure logic here
    INSERT INTO my_table (name) VALUES ('Example Name');
END;
$$ LANGUAGE plpgsql;
