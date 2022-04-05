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
WHERE payment_date >= '2005-05-27';