-- Connect to database (MySQL only)
USE hospital_db;

-- OBJECTIVE 1: ENCOUNTERS OVERVIEW
SELECT * FROM ENCOUNTERS;
-- a. How many total encounters occurred each year?
SELECT YEAR(START) AS Year_Of_Encounter, count(ID) as Total_Encounters FROM encounters
GROUP BY Year_Of_Encounter;
-- b. For each year, what percentage of all encounters belonged to each encounter class
-- (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?
SELECT YEAR(START) AS Year_Of_Encounter,
SUM(CASE when ENCOUNTERCLASS='ambulatory' THEN 1 ELSE 0 END)/ count(*) *100 as ambulatory,
SUM(CASE when ENCOUNTERCLASS='outpatient' THEN 1 ELSE 0 END)/ count(*)*100 as outpatient,
SUM(CASE when ENCOUNTERCLASS='wellness' THEN 1 ELSE 0 END)/ count(*)*100 as wellness,
SUM(CASE when ENCOUNTERCLASS='urgentcare' THEN 1 ELSE 0 END)/ count(*)*100 as urgentcare,
SUM(CASE when ENCOUNTERCLASS='emergency' THEN 1 ELSE 0 END)/ count(*)*100 as emergency,
SUM(CASE when ENCOUNTERCLASS='inpatient' THEN 1 ELSE 0 END)/ count(*)*100 as inpatient,
count(*) as Total_Encounters
FROM encounters
GROUP BY Year_Of_Encounter
ORDER BY Year_Of_Encounter;
-- c. What percentage of encounters were over 24 hours versus under 24 hours?
SELECT 
SUM(CASE WHEN TIMESTAMPDIFF(HOUR, START, STOP)>=24 THEN 1 ELSE 0 END) / count(*) *100 as over_24_hours,
SUM(CASE WHEN TIMESTAMPDIFF(HOUR, START, STOP)<24 THEN 1 ELSE 0 END ) / count(*) *100 as under_24_hours
FROM encounters;


-- OBJECTIVE 2: COST & COVERAGE INSIGHTS
SELECT * FROM PAYERS;
-- a. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?
select 
sum(case when payer_coverage=0 then 1 else 0 end)/count(*) as zero_coverage_encounters,
count(*) as total_encounters,
sum(case when payer_coverage=0 then 1 else 0 end)/count(*) *100 as zero_coverage_percentage
from encounters;
-- b. What are the top 10 most frequent procedures performed and the average base cost for each?
select CODE,DESCRIPTION, count(*) as total, AVG(BASE_COST) as avgbase_cost from procedures
group by CODE,DESCRIPTION
ORDER BY total DESC
limit 10;
-- c. What are the top 10 procedures with the highest average base cost and the number of times they were performed?
select CODE,DESCRIPTION,  AVG(BASE_COST) as avgbase_cost, count(*) as num_procedures from procedures
group by CODE,DESCRIPTION
ORDER BY avgbase_cost DESC
limit 10;
-- d. What is the average total claim cost for encounters, broken down by payer?
SELECT P.NAME, avg(E.TOTAL_CLAIM_COST) as avg_total_claim_cost from payers P
left join encounters E on P.id=E.payer
group by P.NAME
order by avg_total_claim_cost desc;


-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS
-- a. How many unique patients were admitted each quarter over time?
SELECT year(start) as yr, quarter(START)as qtr, count(DISTINCT(PATIENT)) as num_patients FROM ENCOUNTERS
group by yr,qtr
order by yr,qtr;
-- b. How many patients were readmitted within 30 days of a previous encounter?
with cte as 
(SELECT PATIENT,START, STOP,
LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) as NEXT_START_DATE
FROM ENCOUNTERS
)
select  COUNT(DISTINCT patient) as Num_Patients from cte
where datediff(NEXT_START_DATE, STOP)<30;
-- c. Which patients had the most readmissions?
with cte as (SELECT PATIENT,START, STOP,
LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) as NEXT_START_DATE
FROM ENCOUNTERS
)
select  Patient,COUNT(*) as Num_Readmissions from cte
where datediff(NEXT_START_DATE, STOP)<30
group by Patient
order by Num_Readmissions DESC;