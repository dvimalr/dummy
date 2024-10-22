CREATE OR REPLACE FUNCTION hello_world() RETURNS void AS $$
BEGIN
    RAISE NOTICE 'Hello, world!';
END;
$$ LANGUAGE plpgsql;
