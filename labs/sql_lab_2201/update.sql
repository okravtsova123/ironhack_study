-- updating emails
UPDATE customers SET email='ppicasso@gmail.com' where customer_id=10001;
UPDATE customers SET email='lincoln@us.gov' where customer_id=20001;
UPDATE customers SET email='hello@napoleon.me' where customer_id=30001;

-- checking the table
select * from customers;