-- 1. use sakila2;

SELECT * FROM actor;

-- 2. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 3. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

SELECT 
    *
FROM
    customer
WHERE
    (first_name = 'TAMMY')
        AND (last_name = 'SANDERS');

SELECT * FROM staff;

INSERT INTO staff(staff_id, first_name, last_name, address_id, email, store_id, active,username, password,last_update)
VALUES
(3,'TAMMY','SANDERS',79,'tammy.sanders@sakilastaff.com',2,1,'Tammy','newpassword','2006-02-15 03:57:16');

SELECT * FROM staff;

-- 4. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

SELECT 
    customer_id
FROM
    sakila.customer
WHERE
    first_name = 'CHARLOTTE'
        AND last_name = 'HUNTER';

-- Use similar method to get inventory_id, film_id, and staff_id.

SELECT * FROM inventory;

SELECT * FROM rental
WHERE inventory_id = '1';

SELECT * FROM rental
WHERE rental_date = '2005-08-21 21:27:43';

SELECT *
FROM inventory
WHERE inventory_id = '1';

SELECT * FROM rental
WHERE inventory_id = '1';

-- film_id = 1, staff_id = 1, inventory_id = 1
INSERT INTO rental(rental_date, inventory_id, customer_id, return_date, staff_id,last_update)
VALUES
('2005-05-26 06:52:36', 1, 130, '2005-06-09 01:19:28', 1, '2006-02-15 21:30:53');


SELECT 
    *
FROM
    sakila2.film f
        JOIN
    sakila2.inventory USING (film_id)
        JOIN
    sakila2.rental r USING (inventory_id)
WHERE
    r.inventory_id = 1;

SELECT * FROM rental;

-- other way maybe:
SELECT * FROM sakila2.rental;

SELECT 
    *
FROM
    sakila2.film
WHERE
    title = 'Academy Dinosaur';
-- '1', 'ACADEMY DINOSAUR', 'A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies', 2006, '1', NULL, '6', '0.99', '86', '20.99', 'PG', 'Deleted Scenes,Behind the Scenes', '2006-02-15 05:03:42'
-- film_id = 1
-- staff_id = 1
SELECT 
    customer_id
FROM
    sakila.customer
WHERE
    first_name = 'CHARLOTTE'
        AND last_name = 'HUNTER';
-- customer_id: 130
-- inventory_id: 1
SELECT 
    *
FROM
    sakila2.inventory
WHERE
    (film_id = '1') AND (store_id = '1');

SELECT CURDATE(); -- Output: 2021-04-05

INSERT INTO rental()
VALUES
(16050, '2021-04-05', 1, 130, NULL, 1, '2021-04-05');

SELECT 
    *
FROM
    sakila2.rental
WHERE
    rental_id = 16050;