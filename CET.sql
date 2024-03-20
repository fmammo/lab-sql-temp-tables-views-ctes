-- Challenge

-- Step 1: Create a view
create view first_view as 
select count(rental.rental_id) as total_number_of_rentals,customer.customer_id,customer.first_name,customer.email from customer, rental
where customer.customer_id = rental.customer_id;

-- step 2. Create a temporary table
-- First try
with first_temp as( 
select  sum(amount) as total_paid, customer.customer_id from payment, customer
where payment.customer_id = customer.customer_id
group by customer_id )

select * from first_temp
where customer_id = 2;
-- Second try
with one_temp as( 
select  sum(amount) as total_paid, first_view.customer_id from payment, first_view
where payment.customer_id = first_view.customer_id
group by customer_id )

select * from one_temp; 

-- Step 3. Create CTE and the Customer Summery Report
-- First try
with CTE1 as (select count(rental.rental_id) as total_number_of_rentals,customer.first_name, customer.email from customer, rental
where customer.customer_id = rental.customer_id
group by rental_id)

select * from CTE1;

-- Second try
with CTE2 as (select one_temp.total_paid,first_view.total_number_of_rentals,first_view.first_name, first_view.email from one_temp,first_view
where first_view.customer_id = one_temp.customer_id
group by rental_id)

select * from CTE2;


