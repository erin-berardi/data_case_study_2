USE sakila;

-- 1. How many films are there for each of the categories in the category table.
-- Use appropriate join to write this query.
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.category;
SELECT * FROM sakila.film;

SELECT c.name as genre_name, COUNT(DISTINCT fc.film_id)
FROM sakila.film_category fc
JOIN sakila.category c
USING(category_id)
GROUP BY fc.category_id;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT * FROM sakila.payment;

SELECT SUM(amount) AS Sum_sales, staff_id 
FROM sakila.payment p
WHERE DATE(p.payment_date) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY p.staff_id;

-- 3. Which actor has appeared in the most films?
SELECT COUNT(film_id) AS nr_films, fa.actor_id as Actor_ID
FROM sakila.film_actor fa
GROUP BY fa.actor_id
ORDER BY nr_films DESC
LIMIT 1;

SELECT First_name, last_name, actor_id
FROM sakila.actor
WHERE actor_id = 107;

-- Output: actor_id 107 and number of films is 42.

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT * FROM sakila.rental;

SELECT COUNT(rental_id) as nr_rental, r.customer_id as customer_id
FROM sakila.rental r
GROUP BY r.customer_id
ORDER BY nr_rental DESC
LIMIT 1;

SELECT first_name, last_name, customer_id
FROM sakila.customer
WHERE customer_id = 148;


-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT s.first_name as first_name, s.last_name as last_name, a.address as address_line1, a.address2 as address_line2, a.district as district, a.postal_code as zipcode
FROM sakila.staff s
JOIN sakila.address a
USING(address_id);

-- 6. List each film and the number of actors who are listed for that film.

SELECT film_id, COUNT(actor_id) as nr_actors
FROM film_actor
GROUP BY film_id
ORDER BY nr_actors DESC;

-- OR, explicitly to get film_names
SELECT fa.film_id, f.title, COUNT(fa.actor_id) AS number_of_actors
FROM sakila.film_actor fa
JOIN sakila.film f
USING (film_id)
GROUP BY fa.film_id
ORDER BY number_of_actors DESC;

-- 7. Using the tables payment and customer and the JOIN command,
-- list the total paid by each customer. List the customers alphabetically by last name.

SELECT SUM(p.amount) as total_paid, c.last_name, c.customer_id
FROM sakila.payment p
JOIN sakila.customer c
USING(customer_id)
GROUP BY c.last_name, c.customer_id
ORDER BY c.last_name ASC;

-- 8. List number of films per category.

SELECT c.name as genre_name, COUNT(DISTINCT fc.film_id)
FROM sakila.film_category fc
JOIN sakila.category c
USING(category_id)
GROUP BY c.name
