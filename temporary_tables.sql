-- 1)Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name 
#for employees currently with that department.

USE jemison_1756;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT employees.first_name, employees.last_name, departments.dept_name
FROM employees.employees
JOIN employees.dept_emp ON(dept_emp.emp_no = employees.emp_no)
JOIN employees.departments ON(departments.dept_no=dept_emp.dept_no)
LIMIT 100;


-- # a) Add a column named full_name to this table. 
#It should be a VARCHAR whose length is the sum of the lengths of the 
#first name and last name columns.

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);


-- # b) Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);


-- # c) Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- # d) What is another way you could have ended up with this same table?

/*CREATE TEMPORARY TABLE employees_with_departments AS
SELECT CONCAT(employees.first_name, ' ', employees.last_name)AS full_name, departments.dept_name
FROM employees.employees
JOIN employees.dept_emp ON(dept_emp.emp_no = employees.emp_no)
JOIN employees.departments ON(departments.dept_no=dept_emp.dept_no)
LIMIT 100;*/

SELECT *
FROM employees_with_departments;


-- 2) Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE jemison_1756.sakila_payments AS
SELECT payment.payment_id, 
	payment.customer_id, 
	payment.staff_id, 
    payment.rental_id, 
    payment.amount, 
    payment.payment_date,
    payment.last_update
FROM sakila.payment
LIMIT 100;

SELECT * 
FROM jemison_1756.sakila_payments;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
#For example, 1.99 should become 199.

ALTER TABLE jemison_1756.sakila_payments
MODIFY amount  DECIMAL (6,2);

UPDATE jemison_1756.sakila_payments
SET amount = amount * 100;

ALTER TABLE jemison_1756.sakila_payments
MODIFY amount INTEGER;


SELECT * 
FROM jemison_1756.sakila_payments;

-- 3) Find out how the current average pay in each department compares 
#to the overall, historical average pay. 
##In order to make the comparison easier, you should use the Z-score for salaries. 

CREATE TEMPORARY TABLE jemison_1756.employees_payments AS
SELECT de.dept_name, 
	CONCAT(e.first_name, ' ', last_name),
    s.salary
JOIN departments AS de ON (de.emp_no = e.emp_no)
LIMIT 100;

#In terms of salary, what is the best department right now to work for? The worst?





