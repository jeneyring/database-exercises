-- 1) Write a query that returns all employees, their department number,
# their start date, their end date, and a new column 'is_current_employee' 
#that is a 1 if the employee is still with the company and 0 if not.
USE employees;

SELECT 
	emp_no,
    dept_no,
    from_date,
    to_date,
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
    WHEN SUBSTR(last_name, 1) BETWEEN 'A' AND 'I' THEN 'A-H'
    WHEN SUBSTR(last_name, 1) BETWEEN 'I' AND 'R' THEN 'I-Q'
    WHEN SUBSTR(last_name, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
    ELSE 'R-Z'
END AS alpha_group
FROM employees;

-- 3) How many employees (current or previous) were born in each decade?

SELECT 
    COUNT(CASE WHEN birth_date LIKE '195%' THEN birth_date ELSE NULL END) AS 'Fifties',
    COUNT(CASE WHEN birth_date LIKE '196%' THEN birth_date ELSE NULL END) AS 'Sixties',
    COUNT(CASE WHEN birth_date LIKE '197%' THEN birth_date ELSE NULL END) AS 'Seventies',
    COUNT(CASE WHEN birth_date LIKE '198%' THEN birth_date ELSE NULL END) AS 'Eighties'
FROM employees;
#don't need GROUP BY for aggregator since data is only one row.

#OR 

SELECT CASE
	WHEN YEAR(birth_date) BETWEEN 1940 AND 1949 THEN '1940s'
    WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
    WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
    WHEN YEAR(birth_date) BETWEEN 1970 AND 1979 THEN '1970s'
    WHEN YEAR(birth_date) BETWEEN 1980 AND 1989 THEN '1980s'
    WHEN YEAR(birth_date) BETWEEN 1990 AND 1999 THEN '1990s'
    ELSE 'too young'
END AS 'decade_born', COUNT(*) AS decade_count
FROM employees
GROUP BY decade_born;

#OR

SELECT
	CONCAT(SUBSTR(birth_date,1,3),'0') as decade,
    COUNT(*)
FROM employees
GROUP BY decade;
#grabbing first 3 digits, adding a '0' and then counting it.
	
-- 4) What is the current average salary for each of the following department groups: 
#R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select dept_name,dept_no,count(emp_no) as CountStaff, avg(SALARY) as AVGSalary 
from departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
group by dept_name;

SELECT *
FROM departments;

SELECT
	CASE
		WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sale', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        WHEN d.dept_name IN ('Customer Service') THEN 'Customer Service'
END AS dept_group,
AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp AS de USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > NOW() AND de.to_date > now()
GROUP BY dept_group; 



