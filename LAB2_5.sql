-- 1. Select all the actors with the first name ‘Scarlett’.
select * from sakila.actor
where first_name = 'SCARLETT';


-- 2. How many films (movies) are available for rent
-- and how many films have been rented?
select count(*) from sakila.film;
select count(*) from sakila.rental;

-- 3. What are the shortest and longest movie duration?
-- Name the values max_duration and min_duration.
select max(rental_duration) as max_duration, min(rental_duration) as min_duration
from sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
select floor(avg(length) / 60) as hours, round(avg(length) % 60) as minutes
from sakila.film;

-- 5. How many distinct (different) actors' last names are there?
select count(distinct last_name)
from actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
select datediff(max(rental_date), min(rental_date)) as active_days
from rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
select *, date_format(rental_date, '%M') as month , date_format(rental_date, '%W') as weekday
from rental
limit 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday'
-- depending on the rental day of the week.

select *, case when date_format(rental_date, '%W') in ('Saturday', 'Sunday')
          then 'weekend'
          else 'workday' end as day_type
from rental;

-- 9. Get release years.
SELECT release_year, COUNT(*)
FROM sakila.film
GROUP BY release_year;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT *
FROM sakila.film
WHERE title LIKE ('%ARMAGEDDON%');

-- 11. Get all films which title ends with APOLLO.
SELECT *
FROM sakila.film
WHERE title LIKE ('%APOLLO');

-- 12. Get 10 of the longest films.
SELECT *
FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. Which films include Behind the Scenes content?
SELECT *
FROM sakila.film
WHERE special_features = 'Behind the Scenes';
