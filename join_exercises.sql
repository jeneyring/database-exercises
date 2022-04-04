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

SELECT t.title, COUNT(de.emp_no) AS Count
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
AND t.to_date > CURDATE()
AND de.to_day > CURDATE()

JOIN departments AS 

-- 5) Find the current salary of all current managers.
SELECT departments.dept_name, CONCAT(first_name, ' ', last_name) AS name, salaries.salary
FROM employees 
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN dept_manager

-- 6) Find the number of current employees in each department.
SELECT dept_emp.dept_no, departments.dept_name, SUM(emp.num_employees)
FROM employees;

-- 7) Which department has the highest average salary? Hint: Use current not historic information.

-- 8) Who is the highest paid employee in the Marketing department?

-- 9) Which current department manager has the highest salary?

-- 10)Determine the average salary for each department. Use all salary information and round your results.

-- 11) BONUS: Find the names of all current employees, their department name, and their current manager's name.

-- 12) BONUS: Who is the highest paid employee within each department.
