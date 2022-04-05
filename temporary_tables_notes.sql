#USE my DB: jemison_1756

USE jemison_1756;

CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL
);

INSERT INTO my_numbers(n) VALUES (1), (2), (3), (4), (5);

SELECT * FROM my_numbers;
#CRUD operations: CREATE, READ, UPDATE, DELETE (data does more reading)

UPDATE my_numbers
set n = n * 10;

SELECT * FROM my_numbers;
#13:45:57	UPDATE my_numbers set n = n * 10	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.268 sec

Show tables;

-- If using own db, you need to prefix other tables with their db_name
-- critical of you'll see access denied errors or missing tables
-- ex: db_name.table_name
-- db_name.table_name.column_name
CREATE TEMPORARY TABLE short_employees AS
select *
FROM employees.employees limit 10;

SELECT *
FROM short_employees;

-- Another way of doing this: USE the db you're querying
-- Then prefix the db_name of YOUR db in from of the temporary table
-- so then we do not have to type employees in front of salaries, titles, etc...

USE employees;

CREATE TEMPORARY TABLE jemison_1756.employees_with_departments_with_salaries AS
SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN salaries using (emp_no)
JOIN dept_emp using (emp_no)
JOIN departments using (dept_no)
limit 50;

SELECT * FROM jemison_1756.employees_with_departments_with_salaries;

CREATE TEMPORARY TABLE example AS 
SELECT employees.emp_no as emp_no1, first_name, last_name, salaries.emp_no as emp_no2
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no;

SELECT *
FROM employees
JOIN salaries USING(emp_no) -- by using USING we collapse same name columns
LIMIT 20;

CREATE TEMPORARY TABLE example1 as
SELECT employees.emp_no as emp_no1, first_name, last_name, salaries.emp_no as emp_no2
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no;

SELECT *
FROM example1;

ALTER TABLE example1 DROP COLUMN emp_no1; #drop specific columns from the tables.
ALTER TABLE example1 DROP COLUMN emp_no2;

SELECT *
FROM example1;

ALTER TABLE example1 ADD email VARCHAR(100);#creating a new column/place holder

SELECT * from example1;

UPDATE example1
SET email = CONCAT(first_name, ' ', last_name, "@fancy_co.com"); #to update a column...

SELECT * FROM example1; #to check and see the new update.