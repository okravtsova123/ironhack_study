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

select * from countries;
-- adding Israel and Chech Republic to the table countries
INSERT INTO countries (Country, `Year`, rule_of_law, GDP_blnUSD,GDP_per_capita_tUSD,Population, Innovation_Score, Tax_Score)
VALUES ('Israel', 2022, 0.95, 522.033, 57.758, 9038309, 54.38, 78.2),
('Czech Republic',2022,0.73, 290, 27.533,10533000, 44.83,71.9);

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

-- checking joints
select startups.*, countries.*
from startups
left join countries on startups.country=countries.country;

-- getting csv for checking percentile on python
select count(country) from startups;

-- we checked quantiles in python IQL= 2.7 min_val= 0 max_val= 11.8 So now we clean the table

delete from startups
where Valuation_US_billions>11.8;

-- adding a column to identify clusters of the startups
ALTER TABLE startups
ADD COLUMN startup_group VARCHAR(45);

select * from startups;

DELETE from startups
where name='';


select startups.*, 
(case 
when Valuation_US_billions<1 then 'small'
when (Valuation_US_billions>=1 and Valuation_US_billions<1.87) then 'medium'
when (Valuation_US_billions>=1.87 and Valuation_US_billions<3.7) then 'large'
when Valuation_US_billions>=3.57 then 'huge'
END) as size_group
from startups;

select *
from startups_gr;

-- for the table that is with the size
ALTER TABLE startups_gr
add constraint fk_countries_1
FOREIGN KEY (Country) REFERENCES countries(Country);

select distinct size_group, avg(Valuation_US_billions) over (partition by size_group) as avg_valuation
from startups_gr
group by size_group, Valuation_US_billions;

select distinct size_group, count(size_group) over (partition by size_group) as number_companies, avg(population) over (partition by size_group) as avg_population, avg(rule_of_law) over (partition by size_group) as avg_law, avg(GDP_blnUSD) over (partition by size_group) as avg_gdp, avg(GDP_per_capita_tUSD) over (partition by size_group) as avg_gdp_per_capita,
 avg(Tax_score) over (partition by size_group) as avg_tax_index, avg(Innovation_score) over (partition by size_group) as avg_inn_score
from startups_gr
left join countries 
using (country);

select * from countries;

SET SQL_SAFE_UPDATES = 0;
delete from startups_gr
where size_group='small';

select distinct industry,  AVG(valuation_US_billions) over (partition by industry) as valuation_av
from startups_gr
group by Industry, valuation_US_billions
order by valuation_av desc
limit 10;

select distinct country, GDP_per_capita_tUSD, count(`name`) over (partition by country), avg(valuation_US_billions) over (partition by country) as av_valuation, max(valuation_US_billions) over (partition by country) as max_valuation
from startups_gr
left join countries
using (country)
group by country, valuation_US_billions, `name`, GDP_per_capita_tUSD
order by av_valuation desc
limit 10;

select c.country, count(s.name)
from startups_gr as s
left join countries as c
using (country)
where (Innovation_Score>=50 and Innovation_Score<52.1) and (GDP_per_capita_tUSD>39 and GDP_per_capita_tUSD>38)
group by c.country
order by count(s.name) desc;

select *
from countries
where innovation_score<15
order by innovation_score desc;

select distinct s.size_group, round(avg(c.gdp_per_capita_tUSD) over (partition by s.Size_group),2) as GDP_per_capita 
, round(avg(c.Innovation_Score) over (partition by s.size_group),2) as Innovation_score
, round(min(c.rule_of_law) over (partition by s.size_group),2) as justice_index
from startups_gr as s
left join countries as c
using (country);

-- filling null industries with 'not known'
UPDATE startups_gr
SET industry = COALESCE(Industry, 'Not known')
WHERE industry='';

UPDATE countries
SET rule_of_law= 0.58
WHERE country='Israel';

select s.*,c.*
from startups_gr as s
left join countries as c
using (country);