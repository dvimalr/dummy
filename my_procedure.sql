CREATE OR REPLACE PROCEDURE my_procedure_2(IN param1 INTEGER)
LANGUAGE plpgsql AS $$
BEGIN
    RAISE NOTICE 'Parameter: %', param1;
END;
$$;
