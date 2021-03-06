-- 2) In your script, use DISTINCT to find the unique titles in the titles table.
USE employees;

SELECT DISTINCT
    title
FROM
    titles;
--  How many unique titles have there ever been? 
-- ***ANSWER: 7 unique titles***


-- 3) Write a query to to find a list of all unique last names of all employees 
-- that start and end with 'E' using GROUP BY.

SELECT 
    last_name, COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY last_name;


-- 4)Write a query to to find all unique combinations of first and last names of all employees
--  whose last names start and end with 'E'.

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY first_name , last_name;


-- 5) Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.

SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND NOT last_name LIKE '%qu%'
GROUP BY last_name;


-- 6) Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT 
    last_name, COUNT(last_name) AS number_of_employees
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND NOT last_name LIKE '%qu%'
GROUP BY last_name;


-- 7) Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT 
    gender, first_name, COUNT(gender)
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender , first_name;


-- 8) Using your query that generates a username for all of the employees, 
-- generate a count employees for each unique username. 

SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
            count(*) as count_of_users
FROM employees
group by username;

-- Are there any duplicate usernames? 
SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
            count(*) as count_of_users
FROM employees
group by username
HAVING count_of_users > 1;



-- BONUS: How many duplicate usernames are there?

SELECT SUM(t.count_of_users) as 'total_duplicates',
count(t.count_of_users) as 'number_of_unique_duplicates'
FROM (SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
            count(*) as count_of_users
FROM employees
group by username
HAVING count_of_users > 1) AS t;


-- OR.....
SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
            count(*) as count_of_users, sum(count(*)) OVER () 
FROM employees
group by username
having count_of_users > 1;

-- ***ANSWER: 27,403 total_duplicates;....? 13,251 number_of_unique_duplicates***..? Q: what are unique_duplicates in this case?

-- 9) Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT AVG(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.




