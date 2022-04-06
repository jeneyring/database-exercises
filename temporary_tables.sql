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

ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);

describe employees_with_departments; #shows that first_name is varchar(14) and last_name is (16). add in the space between too when adding up characters.


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

USE jemison_1756;

CREATE TEMPORARY TABLE jemison_1756.average_table AS
SELECT d.dept_name, AVG(s.salary)AS historical_avg
FROM employees.employees
	JOIN employees.dept_emp AS de USING(emp_no)
	JOIN employees.salaries AS s USING(emp_no)
	JOIN employees.departments AS d USING(dept_no)
GROUP BY d.dept_name;

ALTER TABLE jemison_1756.average_table MODIFY historical_average INT;
ALTER TABLE jemison_1756.average_table ADD current_average INT;
ALTER TABLE jemison_1756.average_table ADD current_dept_average INT;

UPDATE jemison_1756.average_table
SET current_average = (select avg(salary) FROM employees.salaries WHERE to_date > now());



SELECT * from jemison_1756.average_table;


USE employees;
SELECT emp_no, AVG(salary) AS 'current_avg'
FROM salaries
WHERE to_date > now()
GROUP BY emp_no
;

-- class example:
SELECT AVG(salary), std(salary) from employees.salaries;  
-- 63,810
-- 16,904

CREATE TEMPORARY TABLE jemison_1756.historic_aggregates AS(
	SELECT AVG(salary) AS avg_salary, std(salary) AS std_salary
    FROM employees.salaries
    );

-- Let's check by each department.

SELECT dept_name, AVG(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > now()
and employees.salaries.to_date > now()
group by dept_name;

CREATE TEMPORARY TABLE jemison_1756.current_info as(
SELECT dept_name, AVG(salary) as department_current_average
from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
where employees.dept_emp.to_date > now()
	and employees.salaries.to_date > now()
group by dept_name);

SELECT * 
FROM current_info;

-- add on all columns what we will need:
alter table current_info add historic_avg float(10,2);
alter table current_info add historic_std float(10,2);
alter table current_info add zscore float(10,2);

update current_info set historic_avg = (select avg_salary from jemison_1756.historic_aggregates);
#In terms of salary, what is the best department right now to work for? The worst?

update current_info set historic_std = (select std_salary from jemison_1756.historic_aggregates);

update current_info set zscore = (department_current_average - historic_avg) / historic_std;

SELECT *
FROM current_info;


/*NOTES TO HELP SOLVE:::::*/
USE employees;

-- show current salary for employees
select emp_no, salary
from salaries
where to_date > now()
limit 10;

-- 72012

select avg(salary), max(salary), min(salary), std(salary)
from salaries
where to_date > now ()
limit 10;

-- Let's create a temp table of the above
CREATE TEMPORARY TABLE jemison_1756.salary_info AS
select emp_no, salary
from salaries
where to_date > now()
limit 10;

SELECT * FROM jemison_1756.salary_info;
-- If I need avg those are single #s.

ALTER TABLE jemison_1756.salary_info ADD avg_salary INT;
ALTER TABLE jemison_1756.salary_info ADD min_salary INT;
ALTER TABLE jemison_1756.salary_info ADD max_salary INT;

UPDATE jemison_1756.salary_info
SET avg_salary = (select avg(salary) FROM salaries WHERE to_date > now());

SELECT * FROM jemison_1756.salary_info2;

CREATE TEMPORARY TABLE jemison_1756.salary_info2 AS
SELECT emp_no, salary > avg_salary as "greater", salary, avg_salary
FROM jemison_1756.salary_info;


SELECT sum(greater) from jemison_1756.salary_info2;

SELECT abs(salary - avg_salary) as diff
FROM jemison_1756.salary_info2;

alter table jemison_1756.salary_info2 add diff INT;

update jemison_1756.salary_info2
set diff = abs(salary-avg_salary);

select * from jemison_1756.salary_info2 order by greater desc, diff desc;

-- join to find names of employees....
select * from jemison_1756.salary_info2
JOIN employees using(emp_no)
order by greater desc, diff desc;