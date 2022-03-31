USE employees;

SELECT * 
FROM employees;

# 2) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
##Enter a comment with the number of records returned.

SELECT COUNT(first_name)
FROM employees
WHERE first_name IN ('Irena', 'Vidya','Maya');

-- 709 records returned

# 3) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
## Enter a comment with the number of records returned. 
## Does it match number of rows from Q2? 

SELECT COUNT(first_name)
FROM employees
WHERE first_name = 'Irena' OR 'Vidya' OR 'Maya';

-- 241 records returned  

#vs. 

SELECT COUNT(first_name)
FROM employees
WHERE first_name = 'Irena' OR  first_name= 'Vidya' OR first_name= 'Maya';

-- 709 records returned 



#4) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
## Enter a comment with the number of records returned.

SELECT COUNT(first_name)
FROM employees
WHERE (first_name = 'Irena' OR first_name ='Vidya' OR first_name = 'Maya')
AND gender = 'M';

-- 441 records returned



#5) Find all current or previous employees whose last name starts with 'E'. 
## Enter a comment with the number of employees whose last name starts with E. 

SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE 'E%';
    
-- 7,330 records returned 


# 6) Find all current or previous employees whose last name starts or ends with 'E'. 
## Enter a comment with the number of employees whose last name starts or ends with E. 
## How many employees have a last name that ends with E, but does not start with E?

SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE 'E%'
        OR last_name LIKE '%E';

-- 30,723 records returned
 
SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    (last_name LIKE '%E'
        AND last_name != 'E%');

-- 24,292 records returned

# 7) Find all current or previous employees whose last name starts and ends with 'E'. 
## Enter a comment with the number of employees whose last name starts and ends with E. 
## How many employees' last names end with E, regardless of whether they start with E? 

SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    (last_name LIKE '%E'
        AND last_name LIKE 'E%');

--  899 records returned

SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE '%E';

-- 24,292 records returned 
 
 # 8) Find all current or previous employees hired in the 90s. 
 ## Enter a comment with the number of employees returned.
 
 SELECT COUNT(*)
 FROM employees 
 WHERE hire_date >= 1990
 OR hire_date <= 1999;
 
 -- 300,024 records returned
 
 # 9) Find all current or previous employees born on Christmas. 
 ## Enter a comment with the number of employees returned.
 
 SELECT COUNT(*)
 FROM employees
 WHERE birth_date LIKE '%-12-25';
 
 -- 842 records returned
 
 # 10) Find all current or previous employees hired in the 90s and born on Christmas. 
 ## Enter a comment with the number of employees returned.
 
 SELECT COUNT(*)
 FROM employees 
 WHERE (hire_date >= 1990
 OR hire_date <= 1999)
 AND birth_date LIKE '%-12-25';
 
 -- 842 records returned
 
 # 11) Find all current or previous employees with a 'q' in their last name. 
 ## Enter a comment with the number of records returned.
 
 SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE '%q%';
    
-- 1,873 records returned 



# 12) Find all current or previous employees with a 'q' in their last name but not 'qu'. 
## How many employees are found?

 SELECT 
    COUNT(last_name)
FROM
    employees
WHERE
    last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%';

-- 547 records returned  

