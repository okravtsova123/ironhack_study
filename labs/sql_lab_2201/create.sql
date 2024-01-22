CREATE DATABASE IF NOT EXISTS lab_mysql;
USE lab_mysql;

DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
VIN VARCHAR(45) unique not null, manufacturer VARCHAR(45), model VARCHAR(45), year INT, color VARCHAR(45),
PRIMARY KEY (VIN)
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
customer_id INT unique not null
, name VARCHAR(45)
, phone_number VARCHAR(45)
, email VARCHAR(45)
, adress VARCHAR(45)
, city VARCHAR(45)
, state VARCHAR(45)
, country VARCHAR(45)
, postal_code VARCHAR(45)
, primary key (customer_id) );

DROP TABLE IF EXISTS salespersons;
CREATE TABLE salespersons (
staff_id INT unique not null
, staff_name VARCHAR(45)
, store VARCHAR(45)
, primary key (staff_id)
);

DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices (
invoice_id INT unique not null
, date date
, customer_id INT
, staff_id int
, VIN VARCHAR(45)
, primary key (staff_id)
, constraint fk_cust_id FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
, constraint fk_staff_id FOREIGN KEY (staff_id) REFERENCES salesperson (staff_id)
, constraint fk_vin FOREIGN KEY (VIN) REFERENCES cars (VIN)
);

