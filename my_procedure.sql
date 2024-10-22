CREATE OR REPLACE PROCEDURE hello_world() 
BEGIN
    RAISE NOTICE 'Hello, world!';
END;
$$ LANGUAGE plpgsql;
