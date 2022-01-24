USE sakila;
-- 1. How many films are there for each of the categories in the category table.
-- Use appropriate join to write this query.

SELECT c.name as genre_name, COUNT(DISTINCT fc.film_id)
FROM sakila.film_category fc
JOIN sakila.category c
USING(category_id)
GROUP BY fc.category_id;

-- 8. List number of films per category.

SELECT c.name as genre_name, COUNT(DISTINCT fc.film_id)
FROM sakila.film_category fc
JOIN sakila.category c
USING(category_id)
GROUP BY c.name;


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


