use world;

/*======================================================================================================================================================================
Question 1 : Count how many cities are there in each country?
====================================================================================================================================================================== */

# Ans
select
CountryCode,
Country_Name,
count(City_name) No_Of_Cities
from City c
left Join Country Cn
on c.Countrycode = Cn.Country_code
Group by CountryCode;


/*=========================================================================================================================================================================
Question 2 : Display all continents having more than 30 countries
========================================================================================================================================================================= */

# Ans
select
Continent,
count(Country_Name) No_of_Countries
from Country
group by Continent
having No_of_Countries > 30;

/*=========================================================================================================================================================================
Question 3 : List regions whose total population exceeds 200 million
========================================================================================================================================================================= */

# Ans
select Region,
round(Population/1000000, 2 )as World_POP
from country
where Population > 200000000;

/*========================================================================================================================================================================
Question 4 : Find the top 5 continents by average GNP per country.
========================================================================================================================================================================= */

# Ans

select
Continent,
round(Avg(GNP),2) as Avg_GNP
from country
group by Continent
Order by Avg_GNP desc
Limit 5;


/*==================================================================================================================================================================================================================
Question 5 : Find the total number of official languages spoken in each continent.
========================================================================================================================================================================== */

# Ans 

select 
Continent,
Count(distinct language) Official_Languages
from languages L 
left join Country C 
on C.Country_Code = L.CountryCode
where IsOfficial = "T"
group by Continent 
order by Official_languages desc;


/*==========================================================================================================================================================================
Question 6 : Find the maximum and minimum GNP for each continent.
========================================================================================================================================================================= */

# Ans

Select
Continent,
max(GNP) as Max_GNP,
min(GNP) as Min_GNP
from country
group by continent
order by Max_GNP desc ;

/*==========================================================================================================================================================================
Question 7 : Find the country with the highest average city population.
======================================================================================================================================================================== */

# Ans

select 
Country_Name,
Avg(CT.Population) as Avg_City_Pop
from City CT
Left Join Country C 
on CT.CountryCode = C.Country_Code
group by Country_Name
order by Avg_City_Pop desc
Limit 1;

/*========================================================================================================================================================================
Question 8 : List continents where the average city population is greater than 200,000.
======================================================================================================================================================================= */

# Ans

select
Continent,
Round(Avg(CT.Population),2) as Avg_City_Pop
from City CT
left join Country C 
on C.Country_Code = CT.CountryCode
group by Continent
having Avg_City_Pop > 200000
order by Avg_City_Pop desc;

/*==========================================================================================================================================================================
Question 9 : Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.
========================================================================================================================================================================= */

# Ans

Select
Continent,
Round(sum(Population/1000000),2) as Total_Population,
Round(Avg(LifeExpectancy),0) as Avg_LifeExpectancy
From Country 
Group by Continent
order by Avg_LifeExpectancy desc;

/*=========================================================================================================================================================================
Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million.
========================================================================================================================================================================= */

#Ans

Select
Continent,
Round(sum(Population/1000000),2) as Total_Population,
Round(Avg(LifeExpectancy),0) as Avg_LifeExpectancy
From Country 
Group by Continent
Having Total_Population > 200 
Order by Avg_LifeExpectancy desc
Limit 3;



