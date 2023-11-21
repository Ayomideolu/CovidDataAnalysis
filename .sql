--creating a schema for the covid_data table
CREATE TABLE covid_data(
    sno INT,
    observationdate DATE,
    province VARCHAR(540),
    country VARCHAR(540),
    lastupdate VARCHAR(540),
    confirmed INT,
    deaths INT,
    recovered INT
);



--(Q1)
--Retrieve the total confirmed, death, and recovered cases.
SELECT confirmed,deaths,recovered FROM covid_data ORDER BY
recovered,confirmed,deaths ASC;
SELECT
   SUM(confirmed) total_confirmed,
   SUM(deaths) total_deaths,
   SUM(recovered) total_recovered
FROM covid_data;

--(Q2)
-- This query will give you the total confirmed, deaths, and recovered cases 
-- for the first quarter of each year of observation
SELECT 
    EXTRACT(YEAR FROM observationdate) AS observation_year,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM covid_data
WHERE EXTRACT(MONTH FROM observationdate) BETWEEN 1 AND 3
GROUP BY observation_year
ORDER BY observation_year;

-- (Q3)
-- Retrieve a summary of all the records. This should include the following
-- information for each country:
-- ● The total number of confirmed cases
-- ● The total number of deaths
-- ● The total number of recoveries
SELECT country,
   SUM(confirmed) AS total_confirmed_cases,
   SUM(deaths) AS total_deaths_cases,
   SUM(recovered) AS total_recoveries
FROM covid_data
     GROUP BY country;

--(Q4)
--Retrieve the percentage increase in the number of death cases from 2019 to 2020.
-- Calculate total deaths in 2019
WITH No_deaths_2019 AS (
SELECT
SUM(deaths) AS total_deaths_2019
FROM covid_data
WHERE EXTRACT(YEAR FROM observationdate) = 2019
)
-- Calculate total deaths in 2020
,No_deaths_2020 AS (
SELECT
SUM(deaths) AS total_deaths_2020
FROM covid_data
WHERE EXTRACT(YEAR FROM observationdate) = 2020
)
-- Calculate percentage increase
SELECT
    total_deaths_2019,
    total_deaths_2020,
    (total_deaths_2020 - total_deaths_2019) / total_deaths_2019 * 100 AS percentage_increase
FROM No_deaths_2019, No_deaths_2020;



--(Q5)
-- Retrieve information for the top 5 countries with the highest confirmed cases.
SELECT country,SUM(confirmed) AS total_confirmed 
FROM covid_data
GROUP BY country ORDER BY total_confirmed
DESC LIMIT 5;




--(Q6)
--Compute the total number of drop (decrease) or increase in the confirmed
--cases from month to month in the 2 years of observation.
WITH MonthlyChanges AS (
    SELECT
        EXTRACT(YEAR FROM observationdate) AS observation_year,
        EXTRACT(MONTH FROM observationdate) AS observation_month,
        LAG(SUM(confirmed)) OVER (ORDER BY EXTRACT(YEAR FROM observationdate),
	EXTRACT(MONTH FROM observationdate)) AS previous_month_confirmed,
        SUM(confirmed) AS current_month_confirmed
    FROM covid_data
    GROUP BY observation_year, observation_month
)

SELECT
    observation_year,
    observation_month,
    current_month_confirmed - COALESCE(previous_month_confirmed, 0) AS confirmed_change
FROM MonthlyChanges
ORDER BY observation_year, observation_month;
