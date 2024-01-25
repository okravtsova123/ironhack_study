-- Step 1: Create a View
-- First, create a view that summarizes rental information for each customer. 
-- The view should include the customer's ID, name, email address, and total number of rentals (rental_count).

use sakila;

create view rental_info as
select c.customer_id, c.first_name, c.last_name, c.email, count(rental_id) as rental_count
from customer as c
left join rental as r
using (customer_id)
group by c.customer_id, c.first_name, c.last_name, c.email;

-- Step 2: Create a Temporary Table
-- Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
-- The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate the total amount paid by each customer.
select * from payment;
select * from rental_info ;

create temporary table total_amount as
select r.customer_id, sum(amount) as total_paid
from rental_info as r
join payment as p
using (customer_id)
group by r.customer_id;

-- Step 3: Create a CTE and the Customer Summary Report
-- Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. 
-- The CTE should include the customer's name, email address, rental count, and total amount paid.

select * from total_amount;

with new_cte as (select r.*, t.total_paid
				from rental_info as r
                join total_amount as t
                using(customer_id))
select *
from new_cte;

-- Next, using the CTE, create the query to generate the final customer summary report, 
-- which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, 
-- this last column is a derived column from total_paid and rental_count.

with new_cte_final as (select r.*, t.total_paid
				from rental_info as r
                join total_amount as t
                using(customer_id))
select *, round(total_paid/rental_count,2) as average_payment_per_rental
from new_cte_final;