USE employees;

-- 1) Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT hire_date
FROM employees 
	WHERE emp_no LIKE '%101010%';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = (SELECT hire_date
FROM employees 
	WHERE emp_no LIKE '%101010%')
    ;
    


	