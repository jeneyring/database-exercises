SELECT * FROM mysql.user;
SELECT user, host FROM mysql.user;
SELECT * FROM mysql.help_topic;
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;

USE fruits_db;

SELECT *
FROM fruits;

SELECT 
    name, quantity
FROM
    fruits;
    
#distinct is used when duplicates my occur in columns. it will remove any duplicates.
SELECT DISTINCT *
FROM fruits;

SELECT *
FROM fruits
WHERE name = 'apple';
#Where returns the row where the column item is at

SELECT *
FROM fruits
WHERE id > 5;
#other operators can be used too (ex: =, <, >=, !=, etc)

SELECT *
FROM fruits
WHERE name > 'banana';
#SQL grabs things alphabetically

SELECT *
FROM fruits;

SELECT 
    id, name, quantity AS 'count'
FROM
    fruits;
#AS allows you to change the title of the column

SELECT 
    id, 
    name AS low_quantity_fruit, 
    quantity AS inventory
FROM
    fruits
WHERE
    quantity < 4;