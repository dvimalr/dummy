CREATE OR REPLACE PROCEDURE hello_world() LANGUAGE plpgsql AS $$
BEGIN
    RAISE NOTICE 'Hello, world!';
END;
$$;

CALL hello_world();
