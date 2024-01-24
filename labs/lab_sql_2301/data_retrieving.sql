use sakila;

-- Display all available tables in the Sakila database
-- schema

-- Retrieve all the data from the tables actor, film and customer
select * from actor;
select * from film;
select * from customer;

-- Retrieve the following columns from their respective tables:
-- 3.1 Titles of all films from the film table
-- 3.2 List of languages used in films, with the column aliased as language from the language table
-- 3.3 List of first names of all employees from the staff table

select title
from film;

select film.title, language.name
from film
left join language on film.language_id=language.language_id;

select first_name from staff;

-- Retrieve unique release years.

select distinct release_year
from film;

-- Counting records for database insights:
-- 5.1 Determine the number of stores that the company has.
-- 5.2 Determine the number of employees that the company has.
-- 5.3 Determine how many films are available for rent and how many have been rented.
-- 5.4 Determine the number of distinct last names of the actors in the database.

select count(store_id) as number_of_stores
from store;

select count(staff_id) as number_employees
from staff;

select count(film_id) as available_films
from film;

select count(distinct film_id) as rentend_number_films
from
(select rental.rental_id, rental.inventory_id, inventory.film_id
from rental
left join inventory on rental.inventory_id=inventory.inventory_id
) as table1;

select * from rental;
-- Determine the number of distinct last names of the actors in the database
select count(distinct last_name) as unique_last_names
from actor;

-- Retrieve the 10 longest films.
select film_id, title, `length`
from film
order by `length` desc
limit 10;

-- Use filtering techniques in order to:
-- 7.1 Retrieve all actors with the first name "SCARLETT".
select *
from actor
where first_name='SCARLETT';

-- BONUS:
-- 7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.

SELECT *
FROM film
WHERE title LIKE '%ARMAGEDDON%'
AND `length`>100;

-- 7.3 Determine the number of films that include Behind the Scenes content
select film_id, title, special_features
from film
where special_features like '%Behind the Scenes%';