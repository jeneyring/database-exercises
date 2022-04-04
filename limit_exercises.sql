USE employees;
SELECT database();
SHOW tables;

SELECT DISTINCT title FROM titles;

-- 2) List the first 10 distinct last name sorted in descending order.

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;


-- 3) Find all previous or current employees hired in the 90s and born on Christmas. 

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '____-12-25';

-- Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 

SELECT first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '____-12-25'
ORDER BY hire_date ASC
LIMIT 5;

-- Write a comment in your code that lists the five names of the employees returned.
-- 'Alselm','Cappello','Utz','Mandell'
-- 'Bouchung','Schreiter'
-- 'Baocai','Kushner'
-- 'Petter','Stroustrup'

-- 4)Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. 
-- The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.

SELECT first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '____-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;
