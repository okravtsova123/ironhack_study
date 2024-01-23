-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
USE sakila;
select title, `length` as min_duration
from film
where `length`=(
select min(`length`)
from film
)
;

select title, `length` as max_duration
from film
where `length`=(
select max(`length`)
from film
)
;

select title, floor(`length`/60) as hours, round((`length`/60-floor(`length`/60))*60) as mins
from film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

select DATEDIFF(max(rental_date),min(rental_date)) as days_of_operating from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, EXTRACT(month from rental_date) as month_of_rental_date, dayofweek(rental_date) as weekday_rental_date
from rental;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

select *, 
case
	when dayofweek(rental_date)>=1 and dayofweek(rental_date)<=5 then 'workday'
	else 'weekend'
end as day_type
from rental;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

select title, 
case
	when `length` is not null then `length`
    else 'Not Avalable'
end as duration
from film
order by length asc;


-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name and use their 
-- email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

select concat(first_name,' ',last_name) as full_name, left(email,3) as email_3_letters
from customer;

-- CHALLENGE 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(film_id) as released
from film;

-- 1.2 The number of films for each rating.
select distinct rating, count(film_id) over (partition by rating)
from film
group by rating, film_id;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

select distinct rating, count(film_id) over (partition by rating) as count_films
from film
group by rating, film_id
order by count_films desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

select distinct rating, format(avg(`length`) over (partition by rating),2) as mean_length
from film
group by rating, `length`
order by mean_length desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, mean_length
from 
(select distinct rating, format(avg(length) over (partition by rating),2) as mean_length
from film
group by rating, length
order by mean_length desc
) as t1
having mean_length-120>=0;

-- Bonus: determine which last names are not repeated in the table actor
-- need to rewrite the filter

select last_name
from actor
group by last_name
having count(last_name)=1;

