-- SUBQUERIES::::::::NOTES....

-- Subqueries are nested queries that are within another queried expression.
-- they can return a scalar (single value), a single row, a single column, etc
-- note: the Inner Query is evaluated first and is used to determine the result of the outer query.


-- EXAMPLE: Which empolyees have a higher salary?

-- first we would find an avg(salary)
#SELECT avg(salary) from salaries;
-- This would become our inner query.

-- THEN...
#SELECT emp_no from salaries
-- WHERE salary > (SELECT avg(salary) from salaries);

-- EXAMPLE: Get names of all current managers

#SELECT emp_no FROM dept_manager
#WHERE dept_manager.to_date > now()

-- THEN...
#SELECT first_name, last_name
#FROM employees
#WHERE emp_no IN(SELECT emp_no FROM dept_manager
#WHERE dept_manager.to_date > now();
-- _____________________________________________
-- We can also use this to return an entire table but we must remember to create an alias for the table. 


-- scalar examples:

-- what is the overall salary average?

select avg(salary)
from salaries;

-- find all employees whose current salary > overal average salary..
SELECT * 
FROM salaries
JOIN employees using (emp_no)
WHERE salary > (select avg(salary)
from salaries)
and salaries.to_date > NOW();

#Find all the current department managers' names and birth dates
#get emp_no for dept_manager

SELECT emp_no
FROM dept_manager
WHERE to_date > now();

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (SELECT emp_no
FROM dept_manager
WHERE to_date > now());


-- EX: of where to use a subquery for an entire table...alter
#Final all employees with first name starint with 'geor".
#Then join with salary table and list first_name, last_name and salary

SELECT * 
FROM employees
WHERE first_name LIKE 'geor%';

SELECT table1.first_name, table1.last_name, salary
FROM(SELECT * 
FROM employees
WHERE first_name LIKE 'geor%') AS table1
JOIN salaries USING (emp_no);

-- ___________________________________________

SELECT *, (select avg(salary) from salaries where to_date > now())
FROM salaries;








