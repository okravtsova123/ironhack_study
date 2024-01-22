-- seeding cars table
INSERT INTO cars (VIN, manufacturer, model, year, color) 
VALUES ('3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue'),
       ('ZM8G7BEUQZ97IH46V',  'Peugeot', 'Rifter', 2019, 'Red'),
       ('RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White'),
       ('HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver'),
       ('DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray');
       
-- checking the table
select * from cars;

-- seeding customers table
INSERT INTO customers (customer_id, name, phone_number, email, adress, city, state, country, postal_code)
VALUES (10001, 'Pablo Picasso', '+34 636 17 63 82', '', 'Paseo de la Chopera, 14','Madrid','Madrid', 'Spain', '28045')
, (20001, 'Abraham Lincoln', '+1 305 907 7086', '', '120 SW 8th St', 'Miami', 'Florida', 'United States', '33130')
, (30001, 'Napoléon Bonaparte', '+33 1 79 75 40 00', '', '40 Rue du Colisée', 'Paris', 'Île-de-France', 'France', '75008');

-- checking the table
select * from customers;

-- seeding salesperson table
INSERT INTO salesperson (staff_id, staff_name,store)
VALUES (00001, 'Petey Cruiser', 'Madrid')
, (00002, 'Anna Sthesia', 'Barcelona')
, (00003, 'Paul Molive', 'Berin')
, (00004, 'Gail Forcewind', 'Paris')
, (00005, 'Paige Turner', 'Mimia')
, (00006, 'Bob Frapples', 'Mexico City')
, (00007, 'Walter Melon', 'Amsterdam')
, (00008, 'Shonda Leer', 'São Paulo');

-- checking the table
select * from salesperson;

-- seeding Invoices
INSERT INTO invoices (invoice_id, date, customer_id, staff_id, VIN)
VALUES (852399038, '2018-08-22', 10001, 00003,'3K096I98581DHSNUP')
, (731166526, '2018-12-31', 30001, 00005, 'RKXVNNIHLVVZOUB4M')
, (271135104, '2019-01-22', 20001, 00007, 'ZM8G7BEUQZ97IH46V');

-- checking the table
select * from invoices;