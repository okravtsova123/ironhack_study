-- created database

CREATE DATABASE IF NOT EXISTS quest;
use quest;
drop table unicorns;
create table unicorns (
num INT UNIQUE Not null Primary Key
,Company VARCHAR(45)
,Valuation_US$_bln VARCHAR(45)
,Valuation_date VARCHAR(45)
,Industry VARCHAR(45)
,Country VARCHAR(45)
,Founder VARCHAR(45)
);

USE quest;

-- deleting column Founders
ALTER TABLE quest.unicorns
DROP COLUMN Founders;

drop table countries;

-- adding Israel and Chech Republic to the table countries
INSERT INTO countries (Country, `Year`, rule_of_law, GDP_blnUSD,GDP_per_capita_tUSD,Population)
VALUES ('Israel', 2022, 0.95, 522.033, 57.758, 9038309),
('Czech Republic',2022,0.73, 290, 27.533,10533000);

select count(country) from countries; 

-- changing names in startups so they match with countries and dop those we have no info for
select *
from startups
where country='USA';

UPDATE startups
SET Country='US'
WHERE name='Jokr';

select *
from startups
where country='Brazil ';

UPDATE startups
SET Country='US'
WHERE name='Gympass';

select *
from startups
where country='Switzerland' or country='Seychelles' or country='Armenia'; -- not a big share

DELETE FROM startups
WHERE country='Switzerland' or country='Seychelles' or country='Armenia';

-- creating foreign key
ALTER TABLE startups
add constraint fk_countries
FOREIGN KEY (Country) REFERENCES countries(Country);