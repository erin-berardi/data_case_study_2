-- Lab | SQL Subqueries 3.03

use sakila;

-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT * FROM film;
SELECT * FROM inventory;

SELECT 
    COUNT(film_id) AS count, film_id
FROM
    inventory
WHERE
    film_id = 439;

-- Output is 6.

-- trying with the subquery
SELECT 
    Amount_of_copies
FROM
    (SELECT 
        film_id, COUNT(inventory_id) AS Amount_of_copies
    FROM
        inventory
    GROUP BY film_id
    HAVING film_id = (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible')) sub2;

-- Output is 6. (same as above)

-- 2. List all films whose length is longer than the average of all the films.

SELECT 
    film_id, title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);

SELECT AVG(length) from film; -- Output: 115.2720

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
    
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));

SELECT * FROM film_actor;

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT * FROM film_category;

SELECT * FROM category;
-- category_id = 8, and name (of category) = Family

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));
-- returns 69 rows of film names (title)

SELECT * FROM film_category;
-- 5. Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.

-- USING JOIN
SELECT c.first_name, c.last_name, c.email 
FROM customer c
JOIN address a
ON (c.address_id = a.address_id)
JOIN city ct
ON (ct.city_id = a.city_id)
JOIN country co
ON (co.country_id = ct.country_id)
WHERE co.country= 'Canada';

-- Output: five rows of customers with first name, last name, and their email. (Derrick, Darrell, Loretta, Curtis, Troy)

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.


SELECT 
    a.first_name, a.last_name
FROM
    actor a
        JOIN
    film_actor fa USING (actor_id)
GROUP BY a.actor_id , a.first_name , a.last_name
LIMIT 1;
-- Output for sub : PENELOPE GUINESS
-- now adding the nested subquery

SELECT 
    film_id, title
FROM
    film_actor
        LEFT JOIN
    film USING (film_id)
WHERE
    actor_id = (SELECT 
            actor_id
        FROM
            (SELECT 
                actor_id, COUNT(film_id)
            FROM
                film_actor
            GROUP BY actor_id
            ORDER BY COUNT(film_id) DESC
            LIMIT 1) sub1);

-- 7.Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
-- ie the customer that has made the largest sum of payments

SELECT *
FROM payment;
SELECT *
FROM rental;
SELECT *
FROM inventory;
SELECT *
FROM film;
-- 
SELECT 
    inventory.film_id, film.title, customer_id
FROM
    rental
        LEFT JOIN
    inventory USING (inventory_id)
        LEFT JOIN
    film USING (film_id)
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            (SELECT 
                customer_id, SUM(amount)
            FROM
                payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1) sub1);
            
-- 45 rows returned
SELECT 
    title
FROM
    rental;
SELECT 
    customer_id
FROM
    (SELECT 
        customer_id, SUM(amount)
    FROM
        payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1) sub1;
-- most profitable customer: customer_id = 526

-- 8.Customers who spent more than the average payments.
SELECT 
    *
FROM
    customer;
SELECT 
    *
FROM
    payment;
-- doing the subquery now
SELECT 
    customer_id, SUM(amount) AS Total_amount_spent
FROM
    payment
GROUP BY customer_id
HAVING SUM(amount) > (SELECT 
        AVG(sum) AS Average
    FROM
        (SELECT 
            customer_id, SUM(amount) AS sum
        FROM
            payment
        GROUP BY customer_id) sub1);
-- 285 rows returned