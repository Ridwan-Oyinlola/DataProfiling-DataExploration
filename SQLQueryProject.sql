----Total number of records for both tables

--Select count (*)
--From ['Covid-Deaths$']
	
--Select count (*)
--From ['Covid-Vaccination$']


----To identify the presence of null values in columns with  in the Covid-Death table? 
----YES, there are.

-- Select *
--From ['Covid-Deaths$']
--Where  iso_code is null or 
--       continent  is null or	
--	   location is null or	
--       date is null or	
--	   population is null or
--	   total_cases	is null or
--	   new_cases is null or	
--	   new_cases_smoothed is null or
--	   total_deaths is null or
--	   new_deaths is null or
--	   new_deaths_smoothed is null or	
--	   total_cases_per_million is null or
--	   new_cases_per_million is null or
--	   new_cases_smoothed_per_million is null or
--	   total_deaths_per_million is null or	
--	   new_deaths_per_million	is null or
--	   new_deaths_smoothed_per_million is null or
--	   reproduction_rate is null or	
--	   icu_patients is null or
--	   icu_patients_per_million is null or
--	   hosp_patients is null or
--	   hosp_patients_per_million is null or	
--	   weekly_icu_admissions is null or
--	   weekly_icu_admissions_per_million is null or
--	   weekly_hosp_admissions  is null or	
--	   weekly_hosp_admissions_per_million is null 


----Aggregate Functions

--Select Min(total_cases) as Minimum_Total_Case, 
--       Max(total_cases) as Maximum_Total_Case,
--	   Avg (total_cases) as Average_Total_Case
--From ['Covid-Deaths$']
--Where continent ='Africa'

--Select Min(new_cases) as Minimum_New_Case, 
--      Max(new_cases) as Maximum_New_Case,
--	   Avg (new_cases) as Average_New_Case
--From ['Covid-Deaths$']
--Where continent ='Africa'



---- Total cases of covid  by continent

 --Select continent, sum(New_cases) as Totalcases 
 --       From ['Covid-Deaths$']
	--	where continent is not null
 --       Group by continent
 --       Order by Newcases desc

----The Total cases and deaths of covid in each Location 

  --Select  location, MAX(total_cases) as Totalcases, MAX(cast(total_deaths as int)) as Totaldeaths
  --    From ['Covid-Deaths$']
	 -- where  continent is not null
	 -- group by location
  --    Order by totalcases desc

---- The top 3 locations in the world | total cases of covid
	  
 --Select top (3) location,MAX(total_cases) as Totalcases,MAX(cast(total_deaths as int)) as Totaldeaths
 --     From ['Covid-Deaths$']
	--  where  continent is not null
	--  group by location
 --     Order by totalcases desc     


----The top 3 locations in Africa | total deaths from covid
	
--Select top (3) location,MAX(total_cases) as Totalcases,MAX(cast(total_deaths as int)) as Totaldeaths
--      From ['Covid-Deaths$']
--	  where  continent = 'africa'
--	  group by location
--      Order by Totaldeaths desc     


----Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Africa

--Select location,MAX(total_cases) as Totalcases,MAX(cast(total_deaths as int)) as Totaldeaths,
--       MAX(cast(total_deaths as int))/MAX(total_cases)*100 as DeathPercentage
--      From ['Covid-Deaths$']
--	  where  continent = 'africa'
--	  group by location 
--      Order by Totaldeaths desc     



----Total Cases of covid in each continent

 --Select continent, MAX(total_cases) as Totalcases 
 --       From ['Covid-Deaths$']
	--	where continent is not null
 --       Group by continent
 --       Order by Totalcases desc



----New Cases of covid in each continent

--Select location,population,new_cases
--      From ['Covid-Deaths$']
--	  Where continent is not null
--      Order by new_cases desc



----Shows likelihood of dying if you contract covid in Nigeria

--Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From ['Covid-Deaths$']
--Where location like '%igeria%'
--and continent is not null 
--order by 1,2


----Percentage of Nigeria population infected of covid

--Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
--From ['Covid-Deaths$']
--Where location like '%igeria%'
--order by 1,2

----Daily Percentage of each country population infected of covid

--Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
--From ['Covid-Deaths$']
--order by 1,2


----Percentage of each country population infected of covid

--Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
--From ['Covid-Deaths$']
----Where location like '%igeria%'
--Group by Location, Population
--order by PercentPopulationInfected desc


----Total Death count from covid | By Country

-- Select Location, SUM(cast(Total_deaths as int)) as TotalDeathCount
--From ['Covid-Deaths$']
----Where location like '%igeria%'
--Where continent is not null 
--Group by Location
--order by TotalDeathCount desc
     


----Total Death count from covid | By Continent

--Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
--From ['Covid-Deaths$']
----Where location like '%igera%'
--Where continent is not null 
--Group by continent
--order by TotalDeathCount desc


----LIKELIHOOD OF DEATH FROM COVID

--Select MAX(Total_cases) as total_cases, MAX(cast(Total_deaths as int)) as total_deaths, MAX(cast(total_deaths as int))/MAX(Total_Cases)*100 as DeathPercentage
--From ['Covid-Deaths$']
----Where location like '%states%'
--where continent is not null 
----Group By date
--order by 1,2


---- TOTAL POPULATION vs VACCINATIONS
---- Shows Percentage of Population that has recieved at least one Covid Vaccine
 
STEP 1
--Select  *
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date

STEP 2
--Select  dea.continent, dea.location,dea.date,population,vac.new_vaccinations
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date

STEP 3
--Select  dea.continent, dea.location,dea.date,population,vac.new_vaccinations
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--	where dea.continent is not null
--	order by 2,3

STEP 4
--Select  dea.continent, dea.location,dea.date,population,vac.new_vaccinations,
--        SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location )
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--	where dea.continent is not null
--	order by 2,3

STEP 5
--Select  dea.continent, dea.location,dea.date,population,vac.new_vaccinations,
--        SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date )
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--	where dea.continent is not null
--	order by 2,3



----New Vaccination vs New cases

Select  dea.continent, dea.location,dea.date,dea.new_cases,vac.new_vaccinations
        
From ['Covid-Deaths$'] dea
Join ['Covid-Vaccination$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3



---- Using CTE to perform Calculation on Partition By in previous query

--With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
--as
--(
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--From ['Covid-Deaths$'] dea
--Join ['Covid-Vaccination$'] vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null 

--)  

--Select *
-- From PopvsVac
 

------------------------------------------
 Create View TotalDeathCount as
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From ['Covid-Deaths$']
--Where location like '%igera%'
Where continent is not null 
Group by continent



 Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From ['Covid-Deaths$'] dea
Join ['Covid-Vaccination$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null