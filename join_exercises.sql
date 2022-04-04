-- 1) Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT *
FROM users, roles;

-- 2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

-- INNER JOIN:
SELECT *
FROM users
JOIN roles on users.role_id=roles.id;


-- LEFT JOIN:
SELECT *
FROM users
LEFT JOIN roles on users.role_id=roles.id;

-- RIGHT JOIN:
SELECT *
FROM users
RIGHT JOIN roles on users.role_id=roles.id;


-- 3)Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
--  Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT roles.name AS role_name , COUNT(users.name) AS number_of_users
FROM users
RIGHT JOIN roles on users.role_id=roles.id
GROUP BY role_name;

USE employees;

-- 2) Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

SELECT CONCAT(first_name, ' ', last_name) AS name, departments.dept_name
FROM employees 
JOIN dept_manager AS manager
  ON employees.emp_no = manager.emp_no
JOIN departments 
  ON departments.dept_no = manager.dept_no;
  
#OR....
  
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
AND to_date > CURDATE()
JOIN departments AS d USING (dept_no) #USING is shorthand version of ON...only if name is on both tables...ex. 
#dept_no on both departments and dept_manager
ORDER BY dept_name;
  
  
-- 3) Find the name of all departments currently managed by women.

SELECT CONCAT(first_name, ' ', last_name) AS name, departments.dept_name
FROM employees 
JOIN dept_manager AS manager
  ON employees.emp_no = manager.emp_no
JOIN departments 
  ON departments.dept_no = manager.dept_no
  WHERE employees.gender = 'F';
  
#OR...
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
AND to_date > CURDATE()
AND gender = 'F'
JOIN departments AS d USING (dept_no) #USING is shorthand version of ON...only if name is on both tables...ex. 
#dept_no on both departments and dept_manager
ORDER BY dept_name;
  
-- 4) Find the current titles of employees currently working in the Customer Service department.

SELECT title.title, COUNT(*) 
FROM employees
JOIN titles as title
	ON title.emp_no = employees.emp_no
JOIN dept_emp
	ON dept_emp.emp_no = title.emp_no
WHERE title.to_date LIKE '9999%' AND dept_emp.to_date LIKE '9999%' AND dept_no = 'd009'
GROUP BY title.title;

#OR...

SELECT t.title, COUNT(t.title) AS Count
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
	AND t.to_date > CURDATE() #because this table has the to_date columns
	AND de.to_date > CURDATE() #because this table has the to_date columns
JOIN departments ON de.dept_no = departments.dept_no
	AND departments.dept_name = 'Customer Service'
GROUP BY t.title
ORDER BY t.title;

-- 5) Find the current salary of all current managers.

SELECT *
FROM salaries; #seeing what rows/variables are in this table

SELECT *
FROM dept_manager; #finding common variables in table

SELECT *
FROM employees; 

SELECT * 
FROM departments;

SELECT 
	d.dept_name,
    CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager,
    s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
	AND dm.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY dept_name;

-- 6) Find the number of current employees in each department.

SELECT *
FROM departments;
SELECT *
FROM dept_emp;
SELECT *
FROM employees;

SELECT de.dept_no, d.dept_name, SUM(e.emp_no) AS num_employees
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY de.dept_no;




-- 7) Which department has the highest average salary? Hint: Use current not historic information.
SELECT
d.dept_name, ROUND(AVG(salary), 2) AS average_salary
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
	AND de.to_date > CURDATE()
    AND s.to_date > CURDATE()
    
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8) Who is the highest paid employee in the Marketing department?
SELECT 
	e.first_name,
    e.last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date > CURDATE()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
	AND d.dept_name = 'Marketing'
ORDER BY s. salary DESC
LIMIT 1;


-- 9) Which current department manager has the highest salary?

-- 10)Determine the average salary for each department. Use all salary information and round your results.

-- 11) BONUS: Find the names of all current employees, their department name, and their current manager's name.
SELECT *
FROM employees
LIMIT 5;

SELECT *
FROM dept_emp
LIMIT 5;

SELECT *
FROM dept_manager;

SELECT * 
FROM departments;

SELECT
	dm.dept_no,
    CONCAT(e.first_name,' ',e.last_name) AS managers
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE();# can use this query and 'call' it to utilize in a new query. 
    
SELECT
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name'
    d.dept_name AS 'Department Name',
    m.managers AS 'Manager Name'
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
	AND de.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN (SELECT
	dm.dept_no,
    CONCAT(e.first_name,' ',e.last_name) AS managers
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE());

    
    
-- 12) BONUS: Who is the highest paid employee within each department.
