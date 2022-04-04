-- 1) Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT *
FROM users, roles;

-- 2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

-- INNER JOIN:
SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles on users.role_id=roles.id;

-- LEFT JOIN:
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles on users.role_id=roles.id;

-- RIGHT JOIN:
SELECT users.name AS user_name, roles.name AS role_name
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
  
  
-- 3) Find the name of all departments currently managed by women.

SELECT CONCAT(first_name, ' ', last_name) AS name, departments.dept_name
FROM employees 
JOIN dept_manager AS manager
  ON employees.emp_no = manager.emp_no
JOIN departments 
  ON departments.dept_no = manager.dept_no
  WHERE employees.gender = 'F';
  
-- 4) Find the current titles of employees currently working in the Customer Service department.

SELECT title.title, COUNT(*) 
FROM employees
JOIN titles as title
ON title.emp_no = employees.emp_no
JOIN dept_emp
ON dept_emp.emp_no = title.emp_no
WHERE title.to_date LIKE '9999%' AND dept_emp.to_date LIKE '9999%' AND dept_no = 'd009'
GROUP BY title.title;

