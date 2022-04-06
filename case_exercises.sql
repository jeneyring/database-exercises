-- 1) Write a query that returns all employees, their department number,
# their start date, their end date, and a new column 'is_current_employee' 
#that is a 1 if the employee is still with the company and 0 if not.
USE employees;

SELECT 
	emp_no,
    dept_no,
    from_date,
    IF (to_date = '9999-01-01', True, False) AS is_current_employee
FROM dept_emp;

/*SELECT *
FROM dept_emp;*/


-- 2) Write a query that returns all employee names (previous and current), 
# and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
# depending on the first letter of their last name.
SELECT 
	first_name,
    last_name,
    CASE
    WHEN SUBSTR(last_name, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
    WHEN SUBSTR(last_name, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
    WHEN SUBSTR(last_name, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
END AS alpha_group
FROM employees;

-- 3) How many employees (current or previous) were born in each decade?

SELECT 
    COUNT(CASE WHEN birth_date LIKE '195%' THEN 1950 ELSE NULL END) AS 'Fifties',
    COUNT(CASE WHEN birth_date LIKE '196%' THEN 1960 ELSE NULL END) AS 'Sixties',
    COUNT(CASE WHEN birth_date LIKE '197%' THEN 1970 ELSE NULL END) AS 'Seventies',
    COUNT(CASE WHEN birth_date LIKE '198%' THEN 1980 ELSE NULL END) AS 'Eighties'
FROM employees;


-- 4) 






--  3) How many employees (current or previous) were born in each decade?



--  4) What is the current average salary for each of the following department groups:
# R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

