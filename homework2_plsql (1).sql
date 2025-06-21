-- Homework #2 - PL/SQL Programming
-- Student: [ibrahim mashhour ismail]
-- University ID: [202311475]

-- ===============================
-- Q1.1 – Add a declarative section
-- ===============================
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

-- Modified block with declarative section
DECLARE
    TODAY DATE := SYSDATE;
    TOMORROW TODAY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
    TOMORROW := TODAY + 1;
    DBMS_OUTPUT.PUT_LINE('Today is: ' || TO_CHAR(TODAY, 'Month DD, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Tomorrow is: ' || TO_CHAR(TOMORROW, 'Month DD, YYYY'));
END;
/

-- ======================================
-- Q1.3 – Date formatting and last of month
-- ======================================
DECLARE
    my_date DATE := SYSDATE;
    v_last_day DATE;
BEGIN
    v_last_day := LAST_DAY(my_date);
    DBMS_OUTPUT.PUT_LINE('Today is: ' || TO_CHAR(my_date, 'Month DD, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Last day of this month is: ' || TO_CHAR(v_last_day, 'Month DD, YYYY'));
END;
/

-- =======================================================
-- Q1.4 – Add 45 days and calculate months between dates
-- =======================================================
DECLARE
    my_date DATE := SYSDATE;
    v_last_day DATE;
    v_new_date DATE;
    v_months_between NUMBER;
BEGIN
    v_last_day := LAST_DAY(my_date);
    v_new_date := my_date + 45;
    v_months_between := MONTHS_BETWEEN(v_new_date, my_date);

    DBMS_OUTPUT.PUT_LINE('Today is: ' || TO_CHAR(my_date, 'Month DD, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Date after 45 days is: ' || TO_CHAR(v_new_date, 'Month DD, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Months between today and the new date: ' || v_months_between);
END;
/

-- ===========================
-- Q2 – Table creation & cursor
-- ===========================
-- Create table and insert data
CREATE TABLE countries (
    country_name VARCHAR2(50),
    median_age NUMBER(6, 2)
);

INSERT INTO countries VALUES ('Japan', 48.4);
INSERT INTO countries VALUES ('Jordan', 23.8);
INSERT INTO countries VALUES ('USA', 38.5);

COMMIT;

-- Rewritten block using %TYPE and explicit cursor
DECLARE
    CURSOR c_country IS
        SELECT country_name, median_age FROM countries WHERE country_name = 'Japan';

    v_country countries.country_name%TYPE;
    v_age countries.median_age%TYPE;
BEGIN
    OPEN c_country;
    FETCH c_country INTO v_country, v_age;
    IF c_country%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('The median age in ' || v_country || ' is ' || v_age || '.');
    END IF;
    CLOSE c_country;
END;
/
