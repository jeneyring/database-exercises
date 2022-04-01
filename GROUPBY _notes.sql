-- GROUPBY

SELECT gender
FROM employees
GROUP BY gender;

SELECT first_name 
FROM employees
GROUP BY first_name;

--  GROUP BY can only contain the columns by which you group by + plus some aggregation of other variables & columns.

-- you can add more variables but be sure to include and use the group by variable.
SELECT emp_no, avg(salary)
FROM salaries
GROUP BY emp_no;


SELECT emp_no, avg(salary), min(to_date)
FROM salaries
GROUP BY emp_no;

-- EXAMPLE QUESTIONS:::
-- Is the avg salary different for the different genders?

SELECT 
    *
FROM
    employees;
--  We have to use a JOIN function since salaries is a different table (brought up later on...)
-- here it is:
SELECT 
    gender, AVG(salary), STDDEV(salary), COUNT(emp_no) AS 'number_of_employees'
FROM
    employees
        JOIN
    salaries USING (emp_no)
GROUP BY gender;

-- ___________________________________________________________________________
-- HAVING:::

SELECT * 
FROM employees
WHERE gender = 'F';
-- Let's add more here...


SELECT emp_no, avg(salary) AS avg_salary
FROM salaries
GROUP BY emp_no
HAVING avg_salary> 50000;

-- EXAMPLES::::
SELECT last_name, count(*) AS n_same_last_name
FROM employees
GROUP BY last_name
HAVING n_same_last_name < 150;

