-- Shows different outputs depending on how you understand the question.

-- Eric's SQL Queries

-- 2.How many films (movies) are available for rent and how many films have been rented?
-- number of unique movies
SELECT COUNT(film_id) from sakila.film;
-- output : 1 000 movies
-- number of available movies including sometimes various copies of the same movie
SELECT COUNT(inventory_id) FROM sakila.inventory;
-- output : 4 581 DVD's
-- number of movies rented
SELECT COUNT(distinct(inventory_id)) FROM sakila.rental;
-- output : 4 580 unique DVD's have been rented

-- Tom's SQL Queries

--     How many films (movies) are available for rent (titles of physical copies?) and how many films have been rented (as of now or in total)?
SELECT COUNT(DISTINCT inventory_id) FROM inventory; -- Gives total physical copies
SELECT COUNT(DISTINCT film_id) FROM inventory; -- Gives total unique movie Titles
SELECT COUNT(rental_date) FROM rental; -- Gives total amount of rented out movies
SELECT COUNT(return_date) FROM rental; -- Gives total of returned movies. Difference is movies not yet returned (rented out)

-- Samet's Query
SELECT COUNT(*)
FROM sakila.rental
WHERE return_date is Null;

-- looking at RANK and DENSE_RANK outputs
SELECT title, length, RANK() OVER (ORDER BY length DESC) AS length_rank
FROM sakila.film
WHERE (length IS NOT NULL) AND (length != 0);

SELECT title, length, DENSE_RANK() OVER(ORDER BY length DESC) as 'Rank'
FROM film
WHERE length != 0 AND length IS NOT NULL;





-- Carlos' SQL Query Citing source
-- 7) https://www.geeksengine.com/database/single-row-functions/rank.php
SELECT title, length,
	DENSE_RANK() OVER (ORDER BY length DESC) as ranking
FROM sakila.film
WHERE length IS NOT NULL
ORDER BY length DESC;







SELECT fa.film_id, fa.actor_id AS aid
	FROM film_actor fa
	GROUP BY film_id, aid;
    
    
SELECT fa.actor_id, COUNT(*) Film_Amount 
	FROM sakila.film_actor fa
	GROUP BY fa.actor_id;
    

SELECT * 
	FROM
	(SELECT fa.film_id, fa.actor_id AS aid
	FROM film_actor fa
	GROUP BY film_id, aid) AS Table_2
	INNER JOIN    
	(SELECT fa.actor_id, COUNT(*) Film_Amount 
	FROM sakila.film_actor fa
	GROUP BY fa.actor_id) AS Table_1
    ON Table_2.aid = Table_1.actor_id;


SELECT Table_3.film_id, MAX(Table_3.Film_Amount)
FROM
	(SELECT * 
	FROM
	(SELECT fa.film_id, fa.actor_id AS aid
	FROM film_actor fa
	GROUP BY film_id, aid) AS Table_2
	INNER JOIN    
	(SELECT fa.actor_id, COUNT(*) Film_Amount 
	FROM sakila.film_actor fa
	GROUP BY fa.actor_id) AS Table_1
    ON Table_2.aid = Table_1.actor_id) AS Table_3
GROUP BY Table_3.film_id
HAVING MAX(Table_3.Film_Amount);















