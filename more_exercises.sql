USE sakila;

SELECT * 
FROM actor;

SELECT last_name
FROM actor;

SELECT film_id, title, release_year
FROM film;

-- Select the title, description, rating, movie length columns from the films 
-- table that last 3 hours or longer.

/*SELECT *
FROM film
LIMIT 10;*/

SELECT title, description, rating, length
FROM film
WHERE length >= 180;


-- Select the payment id, amount, and payment date columns 
-- from the payments table 
-- for payments made on or after 05/27/2005.

SELECT * 
FROM payment
LIMIT 10;

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';


-- Select the primary key, amount, and payment date columns 
-- from the payment table for payments made on 05/27/2005.

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date = '2005-05-27';

-- Select all columns from the customer table for rows that have 
-- last names beginning with S and first names ending with N.

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%N'
	AND last_name LIKE 'S%';
    
-- Select all columns from the customer table for rows where 
-- the customer is inactive or has a last name beginning with "M".

SELECT * 
FROM customer
LIMIT 10;

SELECT *
FROM customer
WHERE active = 0
	OR last_name LIKE 'M%';
    
--  Select all columns from the category table for rows where the primary key 
-- is greater than 4 and the name field begins with either C, S or T.

SELECT *
FROM category
WHERE category_id > 4
	AND category.name LIKE 'C%'
		OR category.name LIKE 'S%' 
        OR category.name LIKE 'T%';
        
-- Select all columns minus the password column from the staff table 
-- for rows that contain a password.

DESCRIBE staff;
SELECT *, NULL AS
FROM staff;



USE category;
DESCRIBE category;

