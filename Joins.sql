USE sakila;

SELECT f.title AS 'film_title', COUNT(r.rental_date)
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
WHERE r.rental_date LIKE '%%2005-08%%'
GROUP BY f.title
ORDER BY f.title;

SELECT f.title AS 'film_title', f.rental_rate, f.rental_duration, f.length, f.rating, f.special_features, c.name AS 'category'
FROM sakila.film f
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
ORDER BY title;

