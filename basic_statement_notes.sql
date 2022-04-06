USE employees; 

SELECT *
FROM employees
LIMIT 100;

SELECT * FROM employees WHERE hire_date= '1985-01-01';

SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '1985-__-01';

SELECT DISTINCT * FROM employees WHERE hire_date LIKE '1985-%-01';

# % = any number of char can be wildcard vs. _ = only one char can be wildcard

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Baek')
AND emp_no < 20000;

SELECT first_name
FROM employees
WHERE first_name LIKE '%sus%';

SELECT DISTINCT first_name
FROM employees
WHERE first_name LIKE '%sus%';

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name = 'Baek';


# Using Comparison operators
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name = 'Baek';

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 10026;

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no <= 10026;

# Can use NULL and NOT NULL to see what is missing or take out anything missing.
SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;

#Chaining together WHERE clauses with others:
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber','Baek')
  AND emp_no < 20000;
  
#What if we get more techincal in details? How can we clarify things?
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar';
   
#Let's change the () to clarify what is wanted.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND (
      last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar'
);

SELECT emp_no, first_name, last_name
FROM employees
WHERE (emp_no < 20000
  AND 
      last_name IN ('Herber','Baek'))
   OR first_name = 'Shridhar'
;







