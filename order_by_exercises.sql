-- NOTES:
USE employees;

-- Can order by alphabetical/numerical with DESC or ASC 
SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC;

--  and can also order by two different columns 
SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC, first_name ASC;

-- ___________________________________________________________________________
-- EXERCISES:


-- 2) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 

SELECT *
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
    OR first_name = 'Maya'
ORDER BY first_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- # Irena Reutenauer

-- What was the first and last name of the last person in the table?
--  # Vidya Awdeh


-- 3) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
    OR first_name = 'Maya'
ORDER BY first_name, last_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- # Irena Acton

-- What was the first and last name of the last person in the table?
-- #Vidya Zweizig


-- 4) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
SELECT last_name,first_name
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
    OR first_name = 'Maya'
ORDER BY last_name, first_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- #Acton, Irena

-- What was the first and last name of the last person in the table?
-- # Zyda, Maya


 -- 5) Write a query to to find all employees whose last name starts and ends with 'E'. 
 -- Sort the results by their employee number. 
 
 SELECT emp_no, first_name, last_name
 FROM employees
 WHERE last_name LIKE 'E%E'
 ORDER BY emp_no;
 
 -- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
-- # 899 employees returned
-- # 10021: Ramzi Erde
-- # 499648: Tadahiro Erde


-- 6) Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first.

SELECT hire_date, first_name, last_name
 FROM employees
 WHERE last_name LIKE 'E%E'
 ORDER BY hire_date DESC;
 
--  Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
-- # 899 employees returned
-- # Teiji Eldridge
-- # Sergi Erde


-- 7)Find all employees hired in the 90s and born on Christmas. 

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '____-12-25';

-- Sort the results so that the oldest employee who was hired last is the first result. 

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '____-12-25'
ORDER BY birth_date ASC, hire_date DESC;

-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
-- # 362 employees returned
-- # oldest & hired last: Khun Bernini
-- # youngest & hired first: Douadi Pettis


-- 