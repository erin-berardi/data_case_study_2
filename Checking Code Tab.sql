select title, length,
       rank() over (
              order by length desc) as 'rank'
from sakila.film
where not (length is null) and
      (length > 0)
order by length desc;

SELECT *, DATE_FORMAT(rental_date, '%M') AS 'month',  DATE_FORMAT(rental_date, '%W') AS 'weekday'
from sakila.rental
limit 20;

SELECT title, length, RANK() OVER (ORDER BY length DESC) AS length_rank
FROM sakila.film
WHERE (length IS NOT NULL) AND (length != 0);


SELECT DAYOFMONTH(CURDATE());
SELECT WEEKDAY(CURDATE());

SELECT rental_id, 
			rental_date, date_format(CONVERT(rental_date,DATE), '%M-%W') AS 'RtlD_m_wd',
            WEEKDAY(rental_date) AS 'weekday',
CASE
WHEN WEEKDAY(rental_date) >= 0 AND WEEKDAY(rental_date) < 5 THEN 'workday'
ELSE 'WEEKEND'
END AS 'week_status' 
FROM sakila.rental;


SELECT   title, length, RANK() 
OVER     (ORDER BY length DESC) as 'rank'
FROM     sakila.film
WHERE length IS NOT null AND length > 0
ORDER BY length DESC;

SELECT *, weekday(rental_date) as day_of_rental, month(rental_date) as day_type, 
case
when weekday(rental_date)<3 then "workday"
else "weekend"
end as End_of_Week
from sakila.rental;

SELECT A.first_name, A.last_name, COUNT(F.film_id) AS number_of_films
FROM sakila.actor A
INNER JOIN sakila.film_actor F
USING(actor_id)
GROUP BY A.actor_id
ORDER BY COUNT(F.film_id) DESC
LIMIT 1;

SELECT fa1.film_id, a1.last_name AS "First Actor", a2.last_name AS "Second Actor"
FROM sakila.film
JOIN sakila.film_actor fa1
ON film.film_id = fa1.film_id
JOIN sakila.actor a1
ON fa1.actor_id = a1.actor_id
JOIN sakila.film_actor fa2
ON film.film_id = fa2.film_id
JOIN sakila.actor a2
ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id <> a2.actor_id
GROUP BY a1.actor_id, fa1.film_id,a2.last_name
ORDER BY film.film_id;

select c1.first_name, c1.last_name,
       c2.first_name, c2.last_name,
       count(i1.film_id)
from sakila.inventory i1
join sakila.rental r1
using(inventory_id)
join sakila.customer c1
using (customer_id)
join sakila.inventory i2
on i1.film_id = i2.film_id
join sakila.rental r2
on r2.inventory_id = i2.inventory_id
join sakila.customer c2
on c2.customer_id=r2.customer_id
where c1.customer_id<c2.customer_id
group by c1.customer_id,c2.customer_id
having count(i1.film_id)>3;


SELECT CONCAT(A1.first_name, ' ', A1.last_name) AS actor1, CONCAT(A2.first_name, ' ', A2.last_name) AS actor2
FROM sakila.film_actor FA1
JOIN sakila.actor A1 USING(actor_id)
JOIN sakila.film_actor FA2 ON (FA1.actor_id <> FA2.actor_id) AND (FA1.film_id = FA2.film_id)
JOIN sakila.actor A2 ON A2.actor_id = FA2.actor_id
GROUP BY FA1.actor_id, A1.first_name, A1.last_name, A2.first_name, A2.last_name
ORDER BY A1.first_name, A2.first_name ASC;

SELECT FA.film_id, CONCAT(A.first_name, ' ', A.last_name) AS actor
FROM sakila.film_actor FA
JOIN sakila.actor A USING(actor_id)
ORDER BY FA.film_id;

-- Q8
select c1.first_name, c1.last_name,
       c2.first_name, c2.last_name,
       count(i1.film_id)
from sakila.inventory i1
join sakila.rental r1
using(inventory_id)
join sakila.customer c1
using (customer_id)
join sakila.inventory i2
on i1.film_id = i2.film_id
join sakila.rental r2
on r2.inventory_id = i2.inventory_id
join sakila.customer c2
on c2.customer_id=r2.customer_id
where c1.customer_id<c2.customer_id
group by c1.customer_id,c2.customer_id
having count(i1.film_id)>3;

-- Q9
select  f.film_id, f.title, acc.first_name, acc.last_name, acc.number_of_roles
from 
(select fa.actor_id, a.first_name, a.last_name, count(fa.film_id) as 'number_of_roles'
from sakila.film_actor fa
join sakila.actor a
using (actor_id)
group by actor_id) acc
join sakila.film_actor fa
using (actor_id)
join sakila.film f
using (film_id)
group by film_id, f.title, acc.first_name, acc.last_name, acc.number_of_roles
having acc.number_of_roles=max(acc.number_of_roles);




-- Q9

SELECT fa3.film_id, t1.actor_id, t1.af AS "acted_films"
FROM sakila.film_actor fa3
JOIN (
		SELECT fa1.actor_id, COUNT(fa1.film_id) as af
		FROM sakila.film_actor fa1
		GROUP BY fa1.actor_id
		HAVING COUNT(fa1.film_id) > 1 ) AS t1
ON fa3.actor_id = t1.actor_id
JOIN (
		SELECT fa2.film_id, COUNT(fa2.actor_id)
		FROM sakila.film_actor fa2
		GROUP BY fa2.film_id
		HAVING COUNT(fa2.actor_id) IS NOT NULL ) AS t2
ON fa3.film_id = t2.film_id;


-- t1 list actors acted films
SELECT fa1.actor_id, COUNT(fa1.film_id) as af
FROM sakila.film_actor fa1
GROUP BY fa1.actor_id
HAVING COUNT(fa1.film_id) > 1 ;

-- t2 check for table of film_actor if each film has an actor
SELECT fa2.film_id, COUNT(fa2.actor_id)
FROM sakila.film_actor fa2
GROUP BY fa2.film_id
HAVING COUNT(fa2.actor_id) IS NOT NULL;



