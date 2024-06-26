CREATE DATABASE lab9;

CREATE TABLE employee(
    id serial,
    name varchar,
    salary int,
    category varchar
);


INSERT INTO employee VALUES(1, 'ddad', 321, 'IT');

CREATE OR REPLACE FUNCTION increase_value(value integer, out value2 integer)
language plpgsql
as $$
BEGIN
    return value + 10;
end
    $$;

CREATE OR REPLACE FUNCTION compare_numbers(a integer, b integer, out varchar)
language plpgsql
as
$$
    BEGIN
    if a > b then
        return 'Greater';
    else if a < b then
        return 'Lower';
    else return 'Equal';
    end if;
    end if;
end
$$;

CREATE OR REPLACE FUNCTION number_series(n integer) returns anyarray
language plpgsql as
$$ DECLARE
    arr anyarray;
    i int;
    BEGIN
    for i in 1..n LOOP
        array_append(arr, i) = i;
        return array_append(n);
        end loop;
end
    $$;


CREATE OR REPLACE FUNCTION find_employee(name1 varchar)
    returns TABLE(p_id integer, p_name varchar, p_salary int)
language plpgsql as
$$  BEGIN
    RETURN QUERY SELECT q.id, q.name, q.salary FROM employee q WHERE name1 = name;
    end;
$$;

CREATE OR REPLACE FUNCTION list_products(p_category varchar) returns TABLE(id integer, name varchar, category varchar)
language plpgsql as
$$ BEGIN
    RETURN QUERY SELECT id, name, category FROM employee WHERE p_category = category;
end;
$$;

CREATE OR REPLACE FUNCTION calculate_bonus(bonus int) RETURNS integer
as $$
BEGIN
    return bonus + 20;
end;
$$
language plpgsql;

CREATE OR REPLACE PROCEDURE update_salary(new_salary integer, p_id int)
as $$
BEGIN
    UPDATE employee SET salary = calculate_bonus(new_salary) WHERE id = p_id;
end;
$$
language plpgsql;

DROP FUNCTION complex_calculation();
CREATE OR REPLACE PROCEDURE complex_calculation()
as $$DECLARE
    counter integer = 5;
    BEGIN
        RAISE NOTICE 'The current value % ', counter;
    DECLARE counter integer = 2;
    BEGIN
        RAISE NOTICE 'The current value % ', counter;
    END;
    DECLARE counter integer = 3;
    BEGIN
        RAISE NOTICE 'The current value % ', counter;
    END;
end
$$
language plpgsql;

SELECT increase_Value(10);
SELECT compare_numbers(15, 15);
SELECT number_series('');
SELECT find_employee('ddad');
SELECT list_products('IT');
CALL complex_calculation()

