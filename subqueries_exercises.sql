USE employees;

-- 1) Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT hire_date
FROM employees 
	WHERE emp_no LIKE '%101010%'
;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = (SELECT hire_date
FROM employees 
	WHERE emp_no LIKE '%101010%') 
    ;
    
-- 2) Find all the titles ever held by all current employees with the first name Aamod.


SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
WHERE e.first_name = 'Aamod'
	AND de.to_date > CURDATE();
    
SELECT e.first_name, t.title
FROM titles as t
JOIN employees AS e ON (t.emp_no = e.emp_no)
WHERE e.first_name = 'Aamod' and to_date > now()
GROUP by title;

    
-- 3) How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT emp_no
FROM dept_emp
WHERE to_date > NOW();

SELECT COUNT(last_name) AS Past_Employees
FROM employees
WHERE emp_no NOT IN (SELECT emp_no
FROM dept_emp
WHERE to_date > NOW());#now write the outside query where it selects all of the employees who are NOT in the above list. 



-- 4) Find all the current department managers that are female. List their names in a comment in your code.

SELECT emp_no
FROM dept_manager
WHERE to_date > now();

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN (SELECT emp_no
FROM dept_manager
WHERE to_date > now()
AND gender = 'F');

/*'Isamu','Legleitner','F'
'Karsten','Sigstam','F'
'Leon','DasSarma','F'
'Hilary','Kambil','F'
 */
 
 -- 5) Find all the employees who currently have a higher salary than the companies overall, historical average salary.
 
SELECT AVG(salary)
FROM salaries;

SELECT e.first_name, e.last_name, s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE salary > (select avg(salary)
from salaries)
and s.to_date > NOW();

-- 6) How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
SELECT MAX(salary) - STDDEV(salary) FROM salaries
WHERE to_date > NOW();

use employees;

SELECT COUNT(*),
COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW()) * 100
FROM salaries
WHERE to_date >  NOW() AND salary > (SELECT MAX(salary) - STDDEV(salary) FROM salaries
WHERE to_date > NOW());






SELECT STDDEV(salary)
FROM salaries; #standard deviation of salary

-- What percentage of all salaries is this?

-- BONUS::::::
--  Find all the department names that currently have female managers.

SELECT
d.dept_name AS 'Department',
	CONCAT(e.first_name, " ", e.last_name) AS 'Manager'
FROM employees AS e
JOIN departments AS d ON (d.dept_no = e.emp_no)
JOIN dept_emp AS de ON (de.emp_no = e.emp_no)
WHERE emp_no IN (SELECT emp_no
FROM dept_manager
WHERE to_date > now()
AND gender = 'F');


-- Find the first and last name of the employee with the highest salary.









	