--EXPLORATORY DATA ANALYSIS ON THE INCREASE OF NATURAL DISASTERS --
CREATE TABLE disaster_events (
    Entity VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    Disasters INT ) ;
COPY disaster_events (Entity,Year,Disasters) 
FROM 'D:\Program Files\pgAdmin 4\natural disaster sql\disaster-events new.csv'
DELIMITER ','
CSV HEADER ;
SELECT * FROM disaster_events ;

--clean the data --
--DELETE RECORDS WILL "ALL" FROM THE TABLE TO CLEAN THE DATA FOR ANALYSIS --
DELETE FROM disaster_events 
where Entity = 'All disasters' ;
DELETE FROM disaster_events 
where Entity = 'All disasters excluding earthquakes'  ;
DELETE FROM disaster_events 
where Entity = 'All disasters excluding extreme temperature'; 

-- counting the data --
select count(*) from disaster_events ; 
--770 rows are there --

--which year has the maximum DISASTER --
SELECT YEAR , MAX(ENTITY) AS MAXIMUM FROM disaster_events  group by  year order by MAXIMUM DESC LIMIT 2 ;

--Count the total number of disasters by type--
SELECT Entity, COUNT(*) as TotalDisasters
FROM disaster_events
GROUP BY Entity
ORDER BY TotalDisasters DESC;

-- Find the top 5 years with the most disasters--
select year , sum(disasters) as MOST_DISASTERS FROM disaster_events group by year order by MOST_DISASTERS DESC LIMIT 5 ;

-- find the top 5 entity with most disasters --
select entity , sum(disasters) as MOST_DISASTERS FROM disaster_events group by entity order by MOST_DISASTERS DESC LIMIT 5 ;

---Calculate the average number of floods per year--
select * from disaster_events ;
select avg(disasters) as Avg_disaster from disaster_events where entity='Flood';
--ANSWER IS 60.44 --

--List years where earthquakes exceeded 20--
select * from disaster_events ;
SELECT YEAR , ENTITY, disasters from disaster_events where entity = 'Earthquake' and disasters >20  ;

--Find the total number of disasters in the 21st century--
select * from disaster_events ;
select sum (disasters)as total_disaster_21stcentury from disaster_events where year>2000 ;
-- ANSWER= 9022--

--find the top 10 disaster of the pre  21st century --
select year, entity, disasters from disaster_events where year<2000 order by disasters desc limit 10 ;

--Find the number of distinct disaster types per year--
select year ,count (distinct entity) as distint_disaster_type from disaster_events group by year  order by year desc ;

--Calculate the cumulative number of earthquakes over time--
SELECT Year, Disasters, SUM(Disasters) OVER (ORDER BY Year) as CumulativeEarthquakes FROM disaster_events
WHERE Entity = 'Earthquake' ORDER BY Year; 

--Average number of disasters per year for each type--
SELECT Entity, AVG(Disasters) AS AverageDisasters FROM disaster_events GROUP BY Entity ORDER BY AverageDisasters DESC;

--Years with the highest number of disasters for each type--
SELECT Entity, Year, Disasters FROM disaster_events WHERE (Entity, Disasters) IN ( SELECT Entity, MAX(Disasters)  FROM disaster_events
    GROUP BY Entity) ORDER BY Entity, Year;

--Total number of disasters for each type--
Select entity,sum(disasters) as Total_disasters from disaster_events group by entity order by Total_disasters desc ;

--Total number of disasters each year --
select year , sum(disasters) as total_disasters from disaster_events group by year order by total_disasters asc ;

--Distribution of disaster events over the decades--
select (year/10)*10 as decade ,sum(disasters)as total_disaster ,entity  from disaster_events group by decade,entity order by decade,entity  ;

--the first year each disaster type has occured --
Select  Entity, min(Year) AS FirstYear From  disaster_events Group By Entity Order By FirstYear;

























