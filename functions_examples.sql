USE employees;


SELECT * 
FROM employees;

--  CASE CONVERSION (lower vs. upper
SELECT lower(first_name), upper(last_name) 
FROM employees;

-- CONCAT
-- * takes in any number of strings/column names and pushes them together
SELECT CONCAT(first_name, last_name)
FROM employees;
-- can also add in other functions, like upper/lower case or even use AS to rename
SELECT lower(CONCAT(first_name, last_name)) 
AS username
FROM employees;

-- we can also concatenate columns with ohterh pieces of string
SELECT lower(CONCAT(first_name,'.', last_name, '@company.com')) 
AS email
FROM employees;

-- SUBSTRING: allows us to obtain parts of string
-- must supply the string we want to manipulate, the starting index (which char to start from), and the length (or # of char wanting to extract).alter
SELECT lower(CONCAT(substr(first_name,1,1), last_name))
AS username
FROM employees;

-- REPLACE: allows us to manipulate strings by replacing substring.
--  Looks like REPLACE('subject', 'search', 'replacement');
SELECT REPLACE('abcdefgabc', 'abc', '123');
-- _______________________________________________________________________________________________
-- DATETIME FUNCTIONS(multiple formats)

--  we can get the day or month name of the week from a date (or string that matches the date format)
SELECT dayname("1970-01-01");

-- CURRENT date/ time or timestamp
SELECT curdate();
SELECT current_time();
SELECT current_timestamp();

-- Examples:
-- How many years has it been since each employee's orginal hire date and today?
SELECT *, datediff(curdate(), hire_date)/365
AS tenure
FROM employees;

-- Unix times is the number of seconds since 1970-01-01
SELECT unix_timestamp('1971-01-01');

-- We can also add our function outputs as new columns onto existing output (e.g days someone was born)
SELECT *, dayname(birth_date)
AS day_of_birth
FROM employees;

-- ____________________________________________________________________________________
-- NUMERIC/AGGREGATE FUNCTIONS e.g min, max, avg, stddev, count, sum, etc
SELECT *
FROM salaries;

SELECT avg(salary), min(salary), max(salary), stddev(salary)
FROM salaries;

SELECT avg(salary)
FROM salaries
WHERE gender IS 'F';
