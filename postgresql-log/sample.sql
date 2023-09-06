DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
    id SERIAL PRIMARY KEY,
    data TEXT
);

DO $$
DECLARE
  i INTEGER := 1;
BEGIN
  WHILE i <= 1000000 LOOP
    INSERT INTO t1 (data)
    VALUES (LPAD('', 8000, 'a'));
    i := i + 1;
  END LOOP;
END $$;
